Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fU4gcEI3uswjSGe6oI4RrkX5fHxNdziwkE0U1fvAS9KwleTrJ30aBaOMPlEJ1QV3je8tI
ARC-Seal: i=1; a=rsa-sha256; t=1519411289; cv=none;
        d=google.com; s=arc-20160816;
        b=jjMo+HxUKkrC2EbMj6RTN45iwhPTUF5I3+edRltwVrGa6rgQBX6PxpV1CS2wOOSu89
         UGmUb3n6rEj0BGzyRU0CdEp214UApZ3YPMr/jt8LzeIOro0awHQDu3exsnJwxkdA8tme
         tkbUOfxUrca2gv8/+VSsbBqC2ZSdNgbvPqEohiI6G72CzBybTyFFyaY2NTHzLI3IUTyO
         v65xEh5c4sr6DYX9e2Zd/g32uoFTlHD0Qai0AS6ON/MTD2TdtisrpLxhY/gWipEdRCBl
         KeaVpcofRFwU57fXrfnW0ioI1Db8AtCxHnjwpkEXNq9MfiCGgT0B7dSMoJODl2QuIhEj
         n3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e0CorWlEMDv6yqr8x/aS7JKis/FhyCmFspzUEHbrjR4=;
        b=tsI4Eph2cswrCRtmV2wKZs3a6+rNceZAwccxy02KCr/6wJgMZDYdqp2owgNI78HeZd
         3SNfuYrobd4/crlM31G1h968NBArzxXzCqhzvhJj8U0HFtdZbB+zQXYYorytnEx0Teb+
         aoFL+umJuqAvwZLrG7BIchbhyzzD6v+LuxXZfVf/j1GTcSUbY+bu+BNfKQxFhHMWTAoz
         FgSfoUMtpKAHy3/NynVMOeutmlb+kRsz5m0QUYTLuOWcImBccs/GmvvfaX+F5QTnU5Qc
         YtVSP8Nz9abPLvejAyA9PZ5oWL2o4ax9W3bevQsZsLxz38gYwiJq9Bydhyfy8jg+gQVF
         fkig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Honig <ahonig@google.com>,
	kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 184/193] x86/kvm: Update spectre-v1 mitigation
Date: Fri, 23 Feb 2018 19:26:57 +0100
Message-Id: <20180223170355.027164348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218212753078666?=
X-GMAIL-MSGID: =?utf-8?q?1593218212753078666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

(cherry picked from commit 085331dfc6bbe3501fb936e657331ca943827600)

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/hrtimer.h>
+#include <linux/nospec.h>
 #include "kvm_cache_regs.h"
 #include "x86.h"
 
@@ -827,21 +828,18 @@ static const unsigned short vmcs_field_t
 
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
