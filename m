Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1841C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A6825C8F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A6825C8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030475AbeGBLFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:05:11 -0400
Received: from foss.arm.com ([217.140.101.70]:57608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030417AbeGBLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:05:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A06E19F6;
        Mon,  2 Jul 2018 04:05:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 495D73F5BA;
        Mon,  2 Jul 2018 04:05:00 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 14/19] kernel: add kcompat_sys_{f,}statfs64()
Date:   Mon,  2 Jul 2018 12:04:10 +0100
Message-Id: <20180702110415.10465-15-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
mangling in arm64's compat handling.

Following the example of ksys_* functions, kcompat_sys_* functions are
intended to be a drop-in replacement for their compat_sys_*
counterparts, with the same calling convention.

This is necessary to enable conversion of arm64's syscall handling to
use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/statfs.c            | 14 ++++++++++++--
 include/linux/compat.h | 11 +++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..f0216629621d 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -335,7 +335,7 @@ static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstat
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -349,7 +349,12 @@ COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, s
 	return error;
 }
 
-COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_statfs64(pathname, sz, buf);
+}
+
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -363,6 +368,11 @@ COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct co
 	return error;
 }
 
+COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_fstatfs64(fd, sz, buf);
+}
+
 /*
  * This is a copy of sys_ustat, just dealing with a structure layout.
  * Given how simple this syscall is that apporach is more maintainable
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c68acc47da57..43f4ed44c5d5 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -1028,6 +1028,17 @@ static inline struct compat_timeval ns_to_compat_timeval(s64 nsec)
 	return ctv;
 }
 
+/*
+ * Kernel code should not call compat syscalls (i.e., compat_sys_xyzyyz())
+ * directly.  Instead, use one of the functions which work equivalently, such
+ * as the kcompat_sys_xyzyyz() functions prototyped below.
+ */
+
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
+		     struct compat_statfs64 __user * buf);
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
+			  struct compat_statfs64 __user * buf);
+
 #else /* !CONFIG_COMPAT */
 
 #define is_compat_task() (0)
-- 
2.11.0

