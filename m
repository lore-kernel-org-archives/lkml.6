Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtK3kXYdoWmjwnSX3JXciHgruQqChHAb3EjnBbUIfIaTrRy8geeSMIFWtIQs6xhUyW+x0V1
ARC-Seal: i=1; a=rsa-sha256; t=1519981240; cv=none;
        d=google.com; s=arc-20160816;
        b=RdoL3cDheE/SC2ksXK8egY+weT1D31MiE8HqIYTOaHHTlpGtProBSo8zQDVJhQuXTa
         SXtMimDtdFR1Un82DR3OVCdlneREqgsyfaU6Bo0ZX1l8bT6HIdwVxhVX7uSn0dodFXTn
         zyiHCUXXImaMxwDVaV0encS0M5qJfCRjPVYVbitF/bIR1qVgrLagk8FrqsbFKBCVU/B+
         Y3ygNZZkKymU48ATmitsgsRzvrv7J2MZOOjWjRa25CfuA6NCNL5ypNp9+/ozrDJoMpYh
         Q6siIuhziBqLGFkaDI5q9GaoNe/9YC1ycvTEshE9UXWFMPP3uJXxSt5alBBCZinF1KVw
         ECiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=37NjCwM9eopXVLx0gTtgvO33Pd1jCT5IoxVAvatNS0I=;
        b=Uu1TATJ0c5+asDoyvjNTSUlFwDfCgNNkJKkB0ik4BrUDQFyHd5CJvB/nFxLeH0GNl1
         VD3COyIoCKPcGJ4lpez730E7zuh00zWGoBeEAHgWN4ZQ3uvRK9yUmLUn9EWWXCZI+/lc
         /Ob7As/WAotVcrH8z9Id3AQxvRzPHyXTPX8j5tUo2xQBFU+UGeToAsGewNHKp3n5i7Yt
         GHNwPWDr3o5WKaiqxmKLlDJ2KyaVgmQe5yx6169e7ld8al/h4Ad+ZtvxUaa9VCqoI15f
         lKf31r3uIEqo3MOX7okpXvmKmXLlk17dFfntDNQUoft/VdqziP+LrDrpJbt3ZZzkoPdZ
         3G/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 033/115] ip_gre: remove the incorrect mtu limit for ipgre tap
Date: Fri,  2 Mar 2018 09:50:36 +0100
Message-Id: <20180302084505.214969401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815848700955353?=
X-GMAIL-MSGID: =?utf-8?q?1593815848700955353?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit cfddd4c33c254954927942599d299b3865743146 ]

ipgre tap driver calls ether_setup(), after commit 61e84623ace3
("net: centralize net_device min/max MTU checking"), the range
of mtu is [min_mtu, max_mtu], which is [68, 1500] by default.

It causes the dev mtu of the ipgre tap device to not be greater
than 1500, this limit value is not correct for ipgre tap device.

Besides, it's .change_mtu already does the right check. So this
patch is just to set max_mtu as 0, and leave the check to it's
.change_mtu.

Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1274,6 +1274,7 @@ static const struct net_device_ops erspa
 static void ipgre_tap_setup(struct net_device *dev)
 {
 	ether_setup(dev);
+	dev->max_mtu = 0;
 	dev->netdev_ops	= &gre_tap_netdev_ops;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags	|= IFF_LIVE_ADDR_CHANGE;
