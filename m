Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBAKGF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:06:05 -0500
Received: from terminus.zytor.com ([65.50.211.136]:59023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeBAKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:06:04 -0500
Date: Thu, 1 Feb 2018 02:03:50 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-085331dfc6bbe3501fb936e657331ca943827600@git.kernel.org>
Cc: ahonig@google.com, mingo@kernel.org, jmattson@google.com,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        dan.j.williams@intel.com, tglx@linutronix.de
Reply-To: ahonig@google.com, mingo@kernel.org, jmattson@google.com,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, hpa@zytor.com
In-Reply-To: <151744959670.6342.3001723920950249067.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151744959670.6342.3001723920950249067.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/kvm: Update spectre-v1 mitigation
Git-Commit-ID: 085331dfc6bbe3501fb936e657331ca943827600
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  085331dfc6bbe3501fb936e657331ca943827600
Gitweb:     https://git.kernel.org/tip/085331dfc6bbe3501fb936e657331ca943827600
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Wed, 31 Jan 2018 17:47:03 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Feb 2018 10:59:10 +0100

x86/kvm: Update spectre-v1 mitigation

Commit 75f139aaf896 "KVM: x86: Add memory barrier on vmcs field lookup"
added a raw 'asm("lfence");' to prevent a bounds check bypass of
'vmcs_field_to_offset_table'.

The lfence can be avoided in this path by using the array_index_nospec()
helper designed for these types of fixes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Honig <ahonig@google.com>
Cc: kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Link: https://lkml.kernel.org/r/151744959670.6342.3001723920950249067.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/kvm/vmx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a8b96dc..2894282 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -34,6 +34,7 @@
 #include <linux/tboot.h>
 #include <linux/hrtimer.h>
 #include <linux/frame.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "x86.h"
 
@@ -898,21 +899,18 @@ static const unsigned short vmcs_field_to_offset_table[] = {
 
 static inline short vmcs_field_to_offset(unsigned long field)
 {
-	BUILD_BUG_ON(ARRAY_SIZE(vmcs_field_to_offset_table) > SHRT_MAX);
+	const size_t size = ARRAY_SIZE(vmcs_field_to_offset_table);
+	unsigned short offset;
 
-	if (field >= ARRAY_SIZE(vmcs_field_to_offset_table))
+	BUILD_BUG_ON(size > SHRT_MAX);
+	if (field >= size)
 		return -ENOENT;
 
-	/*
-	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
-	 * generic mechanism.
-	 */
-	asm("lfence");
-
-	if (vmcs_field_to_offset_table[field] == 0)
+	field = array_index_nospec(field, size);
+	offset = vmcs_field_to_offset_table[field];
+	if (offset == 0)
 		return -ENOENT;
-
-	return vmcs_field_to_offset_table[field];
+	return offset;
 }
 
 static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
