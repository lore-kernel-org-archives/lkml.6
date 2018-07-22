Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7E5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E51120858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 14:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E51120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbeGVPEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 11:04:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50154 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeGVPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 11:04:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fhF0x-000614-Iz; Sun, 22 Jul 2018 14:07:11 +0000
Date:   Sun, 22 Jul 2018 15:07:11 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        linux-alpha@vger.kernel.org
Subject: [PATCH] fix osf_wait4() breakage
Message-ID: <20180722140711.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel_wait4() expects a userland address for status - it's only
rusage that goes as a kernel one (and needs a copyout afterwards)

Fixes: "osf_wait4: switch to kernel_wait4()"
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 6e921754c8fc..c210a25dd6da 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1180,13 +1180,10 @@ SYSCALL_DEFINE2(osf_getrusage, int, who, struct rusage32 __user *, ru)
 SYSCALL_DEFINE4(osf_wait4, pid_t, pid, int __user *, ustatus, int, options,
 		struct rusage32 __user *, ur)
 {
-	unsigned int status = 0;
 	struct rusage r;
-	long err = kernel_wait4(pid, &status, options, &r);
+	long err = kernel_wait4(pid, ustatus, options, &r);
 	if (err <= 0)
 		return err;
-	if (put_user(status, ustatus))
-		return -EFAULT;
 	if (!ur)
 		return err;
 	if (put_tv_to_tv32(&ur->ru_utime, &r.ru_utime))
