Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3105817-1517855171-2-9569527547783498979
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855170; b=uJLUe6rQB1L00JwgRwJ4j8FKTM9MVqKlVltnorX8ybjWgGC
    ehgHP7/MqBS+0IGpnAR0bRaCbNV8u9IBU8XsZzeIIDLJvPUoPy/P+91I6AGZg3IJ
    ZLur8XazKJExtPrx6YxALY2qOMo2N5dgflkoekZ1D36JmKFfVyCyXATHaxHeNkVX
    wJeFadtzPE0i8GiSzqtGNJrX1NaFgpUW3RqryJPJpZ6OadwWN/A0K82QK7y7xYQa
    1OcvI+VpYL9c7Eia6RRqPS8oN79r10F6/HVT0aufGOWS2OUtMV8IF62UXLeYzPZF
    RIJacPmHbkpop+/Dbkw0bsWZ2ToKF6titUbraGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855170; bh=Y16dwcD1cbS4DU/rJguSjJTcl/
    zDq9J6t1HAvLj7KH8=; b=wZURiZQQfZIuJxYUaabAaQ1OTOR7/rNrUXdwQBFDyK
    r3OBBG1pIO7G8ZNKLvR7PxEqsZcuZowxm+jl2wWbkWoadf/xdrSMKnqlUpEjYnop
    7FFezEYZ2DhrSi4KMh3d3ILFrYTmI1F4yLPRoVW5VAz8O5Pe1zRJGT27BlayBA/e
    vIQXI8sQtsG17CwSair2QOM3poVylJZPIP4paIOXDOJsgdr+6dOCaj1zijN55QYv
    6Kpy4ke0SAaO+E18UGiFLLp7ACl7FNrQ+Bn8732M2OqRtAh+K2PwZWuyGu0+acDC
    0c6gBxVNJGq+pzKCKrUnglJ6XEHF6aMnNn82Xo+OtRhw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbeBES0A (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:26:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbeBESZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:25:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Honig <ahonig@google.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 4.15 49/60] x86/kvm: Update spectre-v1 mitigation
Date: Mon,  5 Feb 2018 10:23:22 -0800
Message-Id: <20180205182216.252016631@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -898,21 +899,18 @@ static const unsigned short vmcs_field_t
 
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
