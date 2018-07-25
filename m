Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC0CC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B731920671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B731920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeGYIom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:44:42 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:47028 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYIom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:44:42 -0400
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jul 2018 04:44:38 EDT
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EA495FC2ED22AC70BA5F;
        Wed, 25 Jul 2018 15:18:15 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6P7I1MW093067;
        Wed, 25 Jul 2018 15:18:01 +0800 (GMT-8)
        (envelope-from yang.yi@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072515180718-1721888 ;
          Wed, 25 Jul 2018 15:18:07 +0800 
From:   Yang Yi <yang.yi@zte.com.cn>
To:     ralf@linux-mips.org, jhogan@kernel.org
Cc:     linux-kernel@vger.kernel.org, liu.hailong6@zte.com.cn,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn,
        Yang Yi <yang.yi@zte.com.cn>
Subject: [PATCH] mips/mm/mmap: fix the wrong return value from  syscall mmap() on mips architecture
Date:   Wed, 25 Jul 2018 15:16:27 +0800
Message-Id: <1532502987-97496-1-git-send-email-yang.yi@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-25 15:18:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-25 15:17:53,
        Serialize complete at 2018-07-25 15:17:53
X-MAIL: mse01.zte.com.cn w6P7I1MW093067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the latest POSIX standard defined in IEEE Std 1003.1-2017,
the errno should be set to ENOMEM instead of EINVAL when mmap into 
high region address which exceeds the address boundary of a process.

The corresponding description of IEEE Std 1003.1-2017 is as follows:

ERRORS
	The mmap() function shall fail if:
	......
	[ENOMEM]
		MAP_FIXED was specified, and the range [addr,addr+len) 
		exceeds that allowed for the address space of a process; 
		or, if MAP_FIXED was not specified and there is insufficient
		room in the address space to effect the mapping.
	......
		
Signed-off-by: Yang Yi <yang.yi@zte.com.cn>
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/mips/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 2f616eb..c47059c 100755
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -69,7 +69,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	if (flags & MAP_FIXED) {
 		/* Even MAP_FIXED mappings must reside within TASK_SIZE */
 		if (TASK_SIZE - len < addr)
-			return -EINVAL;
+			return -ENOMEM;

 		/*
 		 * We do not accept a shared mapping if it would violate
--
2.1.0.GIT

