Return-Path: <jelsasser@appneta.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520919268; cv=none;
        d=google.com; s=arc-20160816;
        b=l4/BmJolisrNBHkLymfwNUbWCKn6H1nLyFDPa1XTDU7hQr0ZHoukVoonk7A7cnJ3Ua
         NQZrSPxndpzYhKadQqwt1qLLBhonvQx0hJOXd3foqjJc2JBgPlK9/ys5xiumuPsTcBkL
         jBunKEu0+szk8b3EjQDGZfJ/dvSLn9/1A+9Yf32Wui6AY6XSs8NDb0c/jebriHc35z9L
         N0kM4+aPM9cMgLMHeCLkffQjoN7F05MMBWAFKfCcOVTX6XQkRmnGMEfv60xQQuBptjV+
         C4CmBNO5tlD1FqaYCGnRNkCtsdnTuCqVa+L1ZOoPRQ/LV5py7/MN8YMFkxEbtA5ni61Q
         49Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=Z0JucVFm4WV/JHg4+hrfKdoKq8m9tzvF6B+Bu2p/5C0=;
        b=p0oVbwVBm/b3/+dXCl6mbTv+Voq/PLdO5IKlivwgRiKTc/8PX35/VPE47liFdTdMmT
         z7OsETk8tL/K/2moc8V+8JHnaCZ6RsrKMDL/uzcD8DYU9d60aWHzyDxsi+gW7r+auScf
         YPhreMqYG8gK6Bx4H50inUDwe0tAPjzZFZcRxlQCxaBP/59SrosamcoMAMaFBH0/R8Ug
         YlRJnaNiHHbXTAQdO/VzCpeX7WPvW/pr78biBeKIJt8ljJ1vzgglLRFh3PtWUhO8SMBu
         3NlCtyDSQYaCE7yYoerK3wOeWmjBWyWmQmJOLslz0vsacuj258HNoq9L1H3DmWUh6opb
         dasw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=OUIwOXqX;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=OUIwOXqX;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
X-Google-Smtp-Source: AG47ELtdbm21lECm1G4fV+mALb+zAxJezZeysjE8qYnA+P9yOR9NaYOuk0gP7P9SZ06p0JXihOQPgQ==
From: Josh Elsasser <jelsasser@appneta.com>
To: davem@davemloft.net
Cc: Josh Elsasser <jelsasser@appneta.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	=?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
	Vlad Yasevich <vyasevich@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] net: avoid a kernel panic during sk_busy_loop
Date: Mon, 12 Mar 2018 22:31:59 -0700
Message-Id: <20180313053248.13654-1-jelsasser@appneta.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594799443655950888?=
X-GMAIL-MSGID: =?utf-8?q?1594799443655950888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

V2: just check napi->dev->netdev_ops instead of getting clever with the
netdev registration state.

Original cover letter:

Hi Dave,

I stumbled across a reproducible kernel panic while playing around with
busy_poll on a Linux 4.9.86 kernel. There's an unfortunate interaction
between init_dummy_netdev, which doesn't bother to fill in netdev_ops, and
sk_busy_loop, which assumed netdev_ops is a valid pointer.

To reproduce on the device under test (DUT), I did:

  $ ip addr show dev wlan0
  8: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq [...]
      inet 172.16.122.6/23 brd 172.16.123.255 scope global wlan0
  $ sysctl -w net.core.busy_read=50
  $ nc -l 172.16.122.6 5001

Then transmitted some data to this socket from a second host:

  $ echo "foo" | nc 172.16.122.6 5001

The DUT immediately hits a kernel panic.

I've attached a patch that applies cleanly to the 4.9.87 stable release.
This fix isn't necessary for net/net-next (ndo_busy_poll was removed in
linux-4.11), but a further backport of this commit is likely required for
any stable releases older than linux-4.5.

I hope this is the right way to raise something like this. I couldn't find
a clear answer from the -stable and netdev on how to handle bugs in features
that no longer exist in mainline.

Thanks,
    Josh
