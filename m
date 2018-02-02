Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeBBAvZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:51:25 -0500
Received: from ozlabs.org ([103.22.144.67]:40777 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeBBAvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:51:16 -0500
Date: Fri, 2 Feb 2018 11:51:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: linux-next: manual merge of the kvm tree with the tip tree
Message-ID: <20180202115113.1bcc04be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  085331dfc6bb ("x86/kvm: Update spectre-v1 mitigation")

from the tip tree and commit:

  58e9ffae5efd ("kvm: vmx: Reduce size of vmcs_field_to_offset_table")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/vmx.c
index 28942823cc3a,bb5b4888505b..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -899,18 -856,25 +857,22 @@@ static const unsigned short vmcs_field_
  
  static inline short vmcs_field_to_offset(unsigned long field)
  {
 +	const size_t size = ARRAY_SIZE(vmcs_field_to_offset_table);
 +	unsigned short offset;
+ 	unsigned index;
  
- 	BUILD_BUG_ON(size > SHRT_MAX);
- 	if (field >= size)
+ 	if (field >> 15)
  		return -ENOENT;
  
- 	field = array_index_nospec(field, size);
- 	offset = vmcs_field_to_offset_table[field];
+ 	index = ROL16(field, 6);
 -	if (index >= ARRAY_SIZE(vmcs_field_to_offset_table))
++	if (index >= size)
+ 		return -ENOENT;
+ 
 -	/*
 -	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
 -	 * generic mechanism.
 -	 */
 -	asm("lfence");
 -
 -	if (vmcs_field_to_offset_table[index] == 0)
++	index = array_index_nospec(index, size);
++	offset = vmcs_field_to_offset_table[index];
 +	if (offset == 0)
  		return -ENOENT;
 -
 -	return vmcs_field_to_offset_table[index];
 +	return offset;
  }
  
  static inline struct vmcs12 *get_vmcs12(struct kvm_vcpu *vcpu)
