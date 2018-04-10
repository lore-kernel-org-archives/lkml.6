Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aoL7OOrjSHvOAsgLwlHyd9Vw5/UMePzcrD4oFmdRl+vCcw6EFXAwWFO92Hi73/MRmTICT
ARC-Seal: i=1; a=rsa-sha256; t=1523399942; cv=none;
        d=google.com; s=arc-20160816;
        b=pR3A1spbfoebF3E4dozN2la55DQDLWdaW3Dc2+oyVGojXNdPUb5VXBTi1W3bWhe04Q
         8qZixAoc21c9aFOUGhRHC9wgJRxGjoZ2Xdu/BRzVdm0FJOfMlzrtw7pedk3N8rYHJX4t
         5X4y1bZxK04sSx92YKYcUjPbRllZWLiBe2VvJCcAAu12vfN+rd9luaNSbnZ7R/mkU0Sf
         TPtfZoSwQe8pMFL2D3nvJxxhon/k73Oq/bZDEydwreyT8gLkEyF6mDiw8pSgNazzMFIp
         nXEhtfRwNkYLrq5SKPJT2RTDEwTBbOLZU4ZDW3MpjesJ1vwF0Y8Fp5acyXWKBayKxGMj
         nz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VYVl0ojcw+c7yjNM1KkxIpSPK8ykX+FqzD8AZcKvRNQ=;
        b=Jc1ARU1BFR69+WP3/RwCuSpeauC3fWB17uMDrnsbuX0QSE3so6xitryjN2mLqxtzO6
         aQYM9j7dUaPOXLqZvkajX3tdx+U4Zm41NJctuzQr7Qgse07p110yBboCSpshJ0eCHs68
         2eS/In6gZkJDWbk8OlTQJyiKuEm8zKafipjXT+w65ovEwhZicSVAhmfwvEj9Uih+hUn4
         +Ho/J3rDuGfW6NWFf7fvZig0MUrmvMQYFsxFIxqBs0bvhXrrp6AASLUsXgGQitOHFK42
         ZygDCdEoghnyzVIpHdh0PXa77Hmsl2Rpnu+1CBflRbPDKGXvJFto9lhhuMgJf1YPp2pH
         Cx2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 119/138] ipv6: sit: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 00:25:09 +0200
Message-Id: <20180410212915.996718567@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399724483027149?=
X-GMAIL-MSGID: =?utf-8?q?1597400618158419523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit b95211e066fc3494b7c115060b2297b4ba21f025 ]

Use dev_valid_name() to make sure user does not provide illegal
device name.

syzbot caught the following bug :

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300 [inline]
BUG: KASAN: stack-out-of-bounds in ipip6_tunnel_locate+0x63b/0xaa0 net/ipv6/sit.c:254
Write of size 33 at addr ffff8801b64076d8 by task syzkaller932654/4453

CPU: 0 PID: 4453 Comm: syzkaller932654 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x1b9/0x29f lib/dump_stack.c:53
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
 memcpy+0x37/0x50 mm/kasan/kasan.c:303
 strlcpy include/linux/string.h:300 [inline]
 ipip6_tunnel_locate+0x63b/0xaa0 net/ipv6/sit.c:254
 ipip6_tunnel_ioctl+0xe71/0x241b net/ipv6/sit.c:1221
 dev_ifsioc+0x43e/0xb90 net/core/dev_ioctl.c:334
 dev_ioctl+0x69a/0xcc0 net/core/dev_ioctl.c:525
 sock_ioctl+0x47e/0x680 net/socket.c:1015
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 SYSC_ioctl fs/ioctl.c:708 [inline]
 SyS_ioctl+0x24/0x30 fs/ioctl.c:706
 do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -244,11 +244,13 @@ static struct ip_tunnel *ipip6_tunnel_lo
 	if (!create)
 		goto failed;
 
-	if (parms->name[0])
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else
+	} else {
 		strcpy(name, "sit%d");
-
+	}
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ipip6_tunnel_setup);
 	if (!dev)
