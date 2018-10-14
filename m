Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E3120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E3120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeJNXeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37444 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbeJNXeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:02 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM8-0004cI-1v; Sun, 14 Oct 2018 16:31:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000Hz-2s; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.475852895@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 109/366] ipv6: sit: better validate user provided
 tunnel names
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit b95211e066fc3494b7c115060b2297b4ba21f025 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/sit.c | 8 +++++---
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
 	dev = alloc_netdev(sizeof(*t), name, ipip6_tunnel_setup);
 	if (dev == NULL)
 		return NULL;

