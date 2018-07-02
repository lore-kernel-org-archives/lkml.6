Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26801C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5A425CCB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5A425CCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeGBLHm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:07:42 -0400
Received: from foss.arm.com ([217.140.101.70]:57600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030389AbeGBLE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21A01529;
        Mon,  2 Jul 2018 04:04:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1A3A3F5BA;
        Mon,  2 Jul 2018 04:04:56 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 13/19] kernel: add ksys_personality()
Date:   Mon,  2 Jul 2018 12:04:09 +0100
Message-Id: <20180702110415.10465-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the
sys_personality() syscall. The ksys_ prefix denotes that this function
is meant as a drop-in replacement for the syscall. In particular, it
uses the same calling convention as sys_personality().

Since ksys_personality is trivial, it is implemented directly in
<linux/syscalls.h>, as we do for ksys_close() and friends.

This helper is necessary to enable conversion of arm64's syscall
handling to use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dave Martin <dave.martin@arm.com>
---
 include/linux/syscalls.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a368a68cb667..abfe12d8a9c5 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -80,6 +80,7 @@ union bpf_attr;
 #include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
+#include <linux/personality.h>
 #include <trace/syscall.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -1281,4 +1282,14 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
 	return do_sys_truncate(pathname, length);
 }
 
+static inline unsigned int ksys_personality(unsigned int personality)
+{
+	unsigned int old = current->personality;
+
+	if (personality != 0xffffffff)
+		set_personality(personality);
+
+	return old;
+}
+
 #endif
-- 
2.11.0

