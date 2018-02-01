Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeBAB4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:56:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:53476 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeBAB4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:56:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,442,1511856000";
   d="scan'208";a="200406313"
Subject: [PATCH] x86/kvm: Update spectre-v1 mitigation
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de
Cc: Andrew Honig <ahonig@google.com>, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 Jan 2018 17:47:03 -0800
Message-ID: <151744959670.6342.3001723920950249067.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 75f139aaf896 "KVM: x86: Add memory barrier on vmcs field lookup"
added a raw 'asm("lfence");' to prevent a bounds check bypass of
'vmcs_field_to_offset_table'. We can save an lfence in this path and
just use the common array_index_nospec() helper designed for these types
of fixes.

Cc: Andrew Honig <ahonig@google.com>
Cc: Jim Mattson <jmattson@google.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Thomas,

Here's that KVM patch rebased on latest tip/x86/pti.

 arch/x86/kvm/vmx.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a8b96dc4cd83..28942823cc3a 100644
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
