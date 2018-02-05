Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2279esB55IpOKKUkogBlbhGOFcK6zlfv0fMriKQoN4pufu+8uUX0jZjAVXMXsXZTRm6aAkO+
ARC-Seal: i=1; a=rsa-sha256; t=1517855069; cv=none;
        d=google.com; s=arc-20160816;
        b=ed3O7VjU2JV0v8LTsAekOl88Bq7mgxjQHr9PdaQxvIQqsxRtJFTONevHpHVHg8oOdA
         u/t22WlTCftMf/hbpn/eo0odk7j1y6208vYoWccOIRP3lXfKg48bPyU4nDoM/6oErDZC
         siutHEOgq+lmeM7NGAEM7CSD6NhkgMe5NVdRI04qqR+iU4qVsDet5U3HKtIMO1rL2n0P
         sttGT+1GG+xSTvHNIGnc0KNQgCF/I2/OFVmFr7s8My+LJc3o44UdKcNGZGTNq5LKLQ7s
         kV1n8z+pt+wOdm13ji683b5VmHTxYliCUJddwlCT7BkTS73VGkeZxuyVN6QGqMoFI1uy
         AajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9Kd1bzbjlsoYT/osBAnMb48Qs2UHPOvsIDlexLLBObU=;
        b=BqH3hWOOgN5+Z8NMC/pr/n8Kt0FRTqz/OmS/m+HCkCk/LIPSBEMuUccQMzYNFKU/MJ
         KE00RR/yCIfF24HVDuALPOXemi1xgJmGzE5yi+R3laU4+7smJ+gdl/XIuXwKOWF2cGCl
         +XJopORH5QsginaFRNUyAriTm6vyxaF7W1ZFcZbE+Mecs9BNh3B1gTDL5UaMsaWmsy1d
         e9lOtrsvpuESgrcO36qK7MWzygEgsMUpSH9Vndtlu1QuRHYWZlmlE7x4J0Nym+Cl7Y18
         YRMA/SvxZW90weuQvZTkw/jPJi1pKxGEWtqKU+LUBl1IW1h415GRI2kBOPa6hs0xFm0E
         wrPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Honig <ahonig@google.com>,
	kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>
Subject: [PATCH 4.14 53/64] x86/kvm: Update spectre-v1 mitigation
Date: Mon,  5 Feb 2018 10:23:12 -0800
Message-Id: <20180205182140.750888842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586397531707333?=
X-GMAIL-MSGID: =?utf-8?q?1591586397531707333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams dan.j.williams@intel.com

commit 085331dfc6bbe3501fb936e657331ca943827600

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kvm/vmx.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -34,6 +34,7 @@
 #include <linux/tboot.h>
 #include <linux/hrtimer.h>
 #include <linux/frame.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "x86.h"
 
@@ -887,21 +888,18 @@ static const unsigned short vmcs_field_t
 
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
