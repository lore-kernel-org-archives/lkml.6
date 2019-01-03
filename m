Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B798C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C5820896
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fPC/Ugby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfACHqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:46:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40902 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfACHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:46:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so15561184plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZyVPDcuIHzUbEPySa+rOarYwWqnomdmWUj5ysGa47Y=;
        b=fPC/UgbyuvbCL/hAZlFV1Ol29Fut22cOieFeUzWZrmgm5KjQsIzj4KBNDKHdeeFZkY
         56Voxg+Rj8irow1ZTOemIC7faMEb6RhR6Usxd5aE+KsC0Ag7LKGyL4KyLNuOXPZPxlrI
         PfJJdy6povcMowQwG5ydj3HwdJxzipbWSR3uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZyVPDcuIHzUbEPySa+rOarYwWqnomdmWUj5ysGa47Y=;
        b=GEb/BEj2q3Xbn7b4F2xO4I9pugbDhurcUhuk38vHC3bPMJcsyyZell4vDpZFbonNiu
         gqXUtnrjNogZDdQUvXPdZ2B05seuGCpDs7OpbTuYnrZvjhYlQdxhlWcEsSjdLge1NXyT
         u7kKavYOSTDs+O0orB9FsKyJGsPrD/XE59s+HJxBdAZd6o02XSRENNpP11SIsWNvDF4p
         eHVd1hDkeIQ7KWAGdTmRxDjWFRF7S3g+Q2d/CvWzV8Q0IN0VZQJDPdBWkiUXGX5Fmm2Q
         vkYlNSePZ3XvU912drSiXOJeXxOPDrQwRCfIcprlKdVhR/vuFiqP6pPO07JrPb2KcwRB
         cwpw==
X-Gm-Message-State: AJcUukdkO/mPvZZjigAZ0u9WBBmg+8r3iMdKVys+hUGG1ZgvHscUZm13
        zh2HwUMpYKSBqu6+OB3u64GnOQ==
X-Google-Smtp-Source: ALg8bN7d/ohzkjzL9CO9xMIMV/JusJ+9BFh39i6/ij+ocb0v5Qhpq0kVP3LmPXVnmxkhMgUkBWCzsA==
X-Received: by 2002:a17:902:9045:: with SMTP id w5mr44213463plz.32.1546501577642;
        Wed, 02 Jan 2019 23:46:17 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id t5sm82569539pfb.60.2019.01.02.23.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 23:46:16 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Dave Martin <dave.martin@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Mirror arm for small unimplemented compat syscalls
Date:   Thu,  3 Jan 2019 15:45:47 +0800
Message-Id: <20190103074550.217421-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For syscall number smaller than 0xf0000, arm calls sys_ni_syscall
instead of arm_syscall in arch/arm/kernel/entry-common.S, which returns
-ENOSYS instead of raising SIGILL. Mirror this behavior for compat
syscalls in arm64.

Fixes: 532826f3712b607 ("arm64: Mirror arm for unimplemented compat
syscalls")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 arch/arm64/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 8f3371415642ad..95fd8c7ec8a171 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -21,7 +21,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_COMPAT
 	long ret;
-	if (is_compat_task()) {
+	if (is_compat_task() && regs->regs[7] >= __ARM_NR_COMPAT_BASE) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
-- 
2.20.1.415.g653613c723-goog

