Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeFALZV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:25:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeFALZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:25:14 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Martin <dave.martin@arm.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCHv2 13/19] kernel: add ksys_personality()
Date: Fri,  1 Jun 2018 12:24:35 +0100
Message-Id: <20180601112441.37810-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601112441.37810-1-mark.rutland@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 70fcda1a9049..652e166deb64 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -79,6 +79,7 @@ union bpf_attr;
 #include <linux/unistd.h>
 #include <linux/quota.h>
 #include <linux/key.h>
+#include <linux/personality.h>
 #include <trace/syscall.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -1268,4 +1269,14 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
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
