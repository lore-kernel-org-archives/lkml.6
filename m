Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CD0206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864497;
	bh=8KQogxFP39+R1Kl50BMe76xNuRga4aDPyUuSUpQjXGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OGLqaUZbijPcFeZzmz1iSN4WJAty5iUQGZM4uqcGLeBjII50ZPkfhFG1mkCyPXvRe
	 /W/XVf2CuUADhlQCeSPQT3i/WBPRB+f8iCJwjXsHLQV6LV78i19IwiQex1CoQBiO4H
	 gvTHBvKkIQmQBPS7VOmWQaTmnuyE98KFW6ikXi2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAGMe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfAGMex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C952206BB;
        Mon,  7 Jan 2019 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864492;
        bh=8KQogxFP39+R1Kl50BMe76xNuRga4aDPyUuSUpQjXGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHACS8E5AhFRN2SrftXV8c41xz556xdRdz8ta76mR7NXIpGL4kDF1Th5z4qNmiF2w
         WUbk984mPZ/xuPkUIR3zZuW+2oDJfrE5tNUdMy0W/jL/piVJNzWAiFJrCmSQmW+8vM
         MdpzoWbG6uFsgYOXpPIwV780ggp8IHc9oeNaXh/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 012/145] isdn: fix kernel-infoleak in capi_unlocked_ioctl
Date:   Mon,  7 Jan 2019 13:30:49 +0100
Message-Id: <20190107104438.927181523@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d63967e475ae10f286dbd35e189cb241e0b1f284 ]

Since capi_ioctl() copies 64 bytes after calling
capi20_get_manufacturer() we need to ensure to not leak
information to user.

BUG: KMSAN: kernel-infoleak in _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
CPU: 0 PID: 11245 Comm: syz-executor633 Not tainted 4.20.0-rc7+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x12e/0x2a0 mm/kmsan/kmsan.c:613
 kmsan_internal_check_memory+0x9d4/0xb00 mm/kmsan/kmsan.c:704
 kmsan_copy_to_user+0xab/0xc0 mm/kmsan/kmsan_hooks.c:601
 _copy_to_user+0x16b/0x1f0 lib/usercopy.c:32
 capi_ioctl include/linux/uaccess.h:177 [inline]
 capi_unlocked_ioctl+0x1a0b/0x1bf0 drivers/isdn/capi/capi.c:939
 do_vfs_ioctl+0xebd/0x2bf0 fs/ioctl.c:46
 ksys_ioctl fs/ioctl.c:713 [inline]
 __do_sys_ioctl fs/ioctl.c:720 [inline]
 __se_sys_ioctl+0x1da/0x270 fs/ioctl.c:718
 __x64_sys_ioctl+0x4a/0x70 fs/ioctl.c:718
 do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:291
 entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440019
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdd4659fb8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440019
RDX: 0000000020000080 RSI: 00000000c0044306 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004018a0
R13: 0000000000401930 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----data.i@capi_unlocked_ioctl
Variable was created at:
 capi_ioctl drivers/isdn/capi/capi.c:747 [inline]
 capi_unlocked_ioctl+0x82/0x1bf0 drivers/isdn/capi/capi.c:939
 do_vfs_ioctl+0xebd/0x2bf0 fs/ioctl.c:46

Bytes 12-63 of 64 are uninitialized
Memory access of size 64 starts at ffff88807ac5fce8
Data copied to user address 0000000020000080

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Karsten Keil <isdn@linux-pingi.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/capi/kcapi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -852,7 +852,7 @@ u16 capi20_get_manufacturer(u32 contr, u
 	u16 ret;
 
 	if (contr == 0) {
-		strlcpy(buf, capi_manufakturer, CAPI_MANUFACTURER_LEN);
+		strncpy(buf, capi_manufakturer, CAPI_MANUFACTURER_LEN);
 		return CAPI_NOERROR;
 	}
 
@@ -860,7 +860,7 @@ u16 capi20_get_manufacturer(u32 contr, u
 
 	ctr = get_capi_ctr_by_nr(contr);
 	if (ctr && ctr->state == CAPI_CTR_RUNNING) {
-		strlcpy(buf, ctr->manu, CAPI_MANUFACTURER_LEN);
+		strncpy(buf, ctr->manu, CAPI_MANUFACTURER_LEN);
 		ret = CAPI_NOERROR;
 	} else
 		ret = CAPI_REGNOTINSTALLED;


