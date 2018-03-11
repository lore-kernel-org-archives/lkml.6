Return-Path: <jelsasser@appneta.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520796287; cv=none;
        d=google.com; s=arc-20160816;
        b=n6aT10W3KdvL+Eyfb4yUNlNFOlFt6OeceVg0rvqR53k8bfUUUl5RonOoA3lqOUbivC
         x4ZNK9fixO3XPkoadfeEr3inr5JIfvw+FhT0GvsYRgHU+qiNW7uO+GlFmT0LZRQDqo/7
         S11789VC8WhEeHbUcRvtC71DGH3QtYBUKOID92G/x79vPmsYkICUs/ssHxDf7m7VUuXz
         rpgo/LLxAJCun7fHrdYJhM3sCQJuvvfaDmv0Zq32gyijGLLWYfOv8DNtu6drha32pWV0
         C7XhBLlUbVAmGnVgJ0vg4Rx4qM/FspH22YgrBnUDl5FzzW5m+oAh3vGgHAngfSJVW+6O
         rskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7F0cSAct/NcVJQUTb7D9RJzQN5Msr9Q2K4iYF0AqccQ=;
        b=Lgsp5YPxCgIZjsm8+E2bV3qlv/J/AOeXU3zD5D/ASUJacb+twD3tcVDjsHaMFponWj
         6ZWjzJtl/VU5CLKuMQdE492DLFM8bBvs1oe7vFZBN0cXzSglinzoKBpQjvKqK1asXHJX
         H0pbUYKZb8FhD8lKn0KBfOAOhunTPDm1rPOwu59OBZ52qGYaOjaixePg4OQxFbTr3Rwo
         9j4i+TSG+UhQYliJcOKsmQcMa61iD8qcvbRlh2NuT7ZCshkM8tduHLL8xITpg7In714E
         xcq4OjZBgmyVpmPkBEUgU9oqx0pCTlNyfWIRcGhkYJpAuJkSGmFVkk8kkL8yCs0tQw+B
         kLXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=QKnSKm+W;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@appneta.com header.s=google header.b=QKnSKm+W;
       spf=pass (google.com: domain of jelsasser@appneta.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jelsasser@appneta.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=appneta.com
X-Google-Smtp-Source: AG47ELsLHEq9Q6fL9i6rRjWVz7FdIg1kBcgNc5lZqw2ZMLCToApmHxyfU51JpBdsnd3UbzucteAkxQ==
From: Josh Elsasser <jelsasser@appneta.com>
To: davem@davemloft.net
Cc: Josh Elsasser <jelsasser@appneta.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Sasha Levin <alexander.levin@verizon.com>,
	Willem de Bruijn <willemb@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Myungho Jung <mhjungk@gmail.com>,
	=?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] net: avoid a kernel panic during sk_busy_loop
Date: Sun, 11 Mar 2018 12:22:54 -0700
Message-Id: <20180311192322.101598-1-jelsasser@appneta.com>
X-Mailer: git-send-email 2.11.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594670487609907296?=
X-GMAIL-MSGID: =?utf-8?q?1594670487609907296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dave,

I stumbled across a reproducible kernel panic while playing around with
busy_poll on a Linux 4.9.86 kernel. There's an unfortunate interaction
between init_dummy_netdev, which doesn't bother to fill in netdev_ops, and
sk_busy_loop, which assumes netdev_ops is a valid pointer.

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
a clear answer from the -stable and netdev howtos for bugs against features
that no longer exist in mainline.

Thanks,
Josh
