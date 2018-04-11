Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx480dwcYJBLU7DuYOlr5SE+cRZzt8D297fNgq6KPRDE0ulXftk3A7az0r2ExNX1t1lPHLswe
ARC-Seal: i=1; a=rsa-sha256; t=1523472668; cv=none;
        d=google.com; s=arc-20160816;
        b=mT5gr3dAmfsOo5uTXIYlF16czVMaWnAeIF7XaxCHU0mrs7sePVljHCDPHEyuRiSArP
         kPwOb694OYWStd9FGcDNdEUCxR+QRXySMIYA9O7lwXW0SYmlcwUSk71iUT/7XgZVmcu6
         qvscVcxmIABtNAIPLFwFtAxPoA/whKJAYSIv7uVdRh1Yl7emCWL1ypFdeEg7JMfcHjPM
         ajKIj5BZN3wHWUk+qHUZxgH818ss7WJWOdC0yZNuZm8zx9boZd6HtJ7KF/2+Vrnhj6HW
         FEGgh8MadHj0KWyJ9AiQaNbv5wz8Ba/4BoVCxVqqUitB/v1mw5H2G47nSUAAQ9+Ed96k
         nLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xGvUeP7aY/QF1gZyvZndSZg1Q7PbkwDE7BoNWYRbYcE=;
        b=FGFP1ljONyAZYU3KkBkt7hAWyEEj0laHGZgtqYIINwpuVzvLq8D3IDg6uxjrAnXfWL
         F6LHrYO2sKe9RIVbqVl+3U97sVRzf5CcbjP5GmJVOjQ83jRDrGQo1Rqa5ztUe6q/eMte
         Ms1w3ifb7jxu27QVhrUZf0Ezry8sUR7enJE8FVgbfAwxJDlfZb4FFgyEJywsbTSZL8kG
         3XHTfFbQ/6mz83NI31eWxnyTQBSclP7GSTLLEbEURibWuLrG78fIID+4JEYQRtWFgYbY
         C/fkmQPZJfYNCVzbADgWUMnaStLkdmnCxCdN8qqc6+CumLVAhfoJNoM19BXYDnWUv6xH
         XFdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"Reported-by: syzbot" <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 167/190] net: fix possible out-of-bound read in skb_network_protocol()
Date: Wed, 11 Apr 2018 20:36:53 +0200
Message-Id: <20180411183602.270099117@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476325859430783?=
X-GMAIL-MSGID: =?utf-8?q?1597476876831290466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 1dfe82ebd7d8fd43dba9948fdfb31f145014baa0 ]

skb mac header is not necessarily set at the time skb_network_protocol()
is called. Use skb->data instead.

BUG: KASAN: slab-out-of-bounds in skb_network_protocol+0x46b/0x4b0 net/core/dev.c:2739
Read of size 2 at addr ffff8801b3097a0b by task syz-executor5/14242

CPU: 1 PID: 14242 Comm: syz-executor5 Not tainted 4.16.0-rc6+ #280
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x24d lib/dump_stack.c:53
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23c/0x360 mm/kasan/report.c:412
 __asan_report_load_n_noabort+0xf/0x20 mm/kasan/report.c:443
 skb_network_protocol+0x46b/0x4b0 net/core/dev.c:2739
 harmonize_features net/core/dev.c:2924 [inline]
 netif_skb_features+0x509/0x9b0 net/core/dev.c:3011
 validate_xmit_skb+0x81/0xb00 net/core/dev.c:3084
 validate_xmit_skb_list+0xbf/0x120 net/core/dev.c:3142
 packet_direct_xmit+0x117/0x790 net/packet/af_packet.c:256
 packet_snd net/packet/af_packet.c:2944 [inline]
 packet_sendmsg+0x3aed/0x60b0 net/packet/af_packet.c:2969
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xca/0x110 net/socket.c:639
 ___sys_sendmsg+0x767/0x8b0 net/socket.c:2047
 __sys_sendmsg+0xe5/0x210 net/socket.c:2081

Fixes: 19acc327258a ("gso: Handle Trans-Ether-Bridging protocol in skb_network_protocol()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Pravin B Shelar <pshelar@ovn.org>
Reported-by: Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2515,7 +2515,7 @@ __be16 skb_network_protocol(struct sk_bu
 		if (unlikely(!pskb_may_pull(skb, sizeof(struct ethhdr))))
 			return 0;
 
-		eth = (struct ethhdr *)skb_mac_header(skb);
+		eth = (struct ethhdr *)skb->data;
 		type = eth->h_proto;
 	}
 
