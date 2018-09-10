Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD553C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAF42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAF42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbeIJUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:22:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:16003 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeIJUWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:22:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 08:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="72050113"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2018 08:28:17 -0700
Message-ID: <1536593297.11460.72.camel@intel.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock
 data when SEV is active
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date:   Mon, 10 Sep 2018 08:28:17 -0700
In-Reply-To: <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
         <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
         <20180910122727.GE21815@zn.tnic>
         <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
         <1536586152.11460.40.camel@intel.com>
         <097eb5f5-2cd9-8b08-32c5-d90c8e0cbb6d@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 10:10 -0500, Brijesh Singh wrote:
> 
> On 09/10/2018 08:29 AM, Sean Christopherson wrote:
> ...
> 
> > > > > + */
> > > > > +static struct pvclock_vsyscall_time_info
> > > > > +			hv_clock_aux[NR_CPUS] __decrypted_aux;
> > > > Hmm, so worst case that's 64 4K pages:
> > > > 
> > > > (8192*32)/4096 = 64 4K pages.
> > > We can minimize the worst case memory usage. The number of VCPUs
> > > supported by KVM maybe less than NR_CPUS. e.g Currently KVM_MAX_VCPUS is
> > > set to 288
> > KVM_MAX_VCPUS is a property of the host, whereas this code runs in the
> > guest, e.g. KVM_MAX_VCPUS could be 2048 in the host for all we know.
> > 
> 
> IIRC, during guest creation time qemu will check the host supported
> VCPUS count. If count is greater than KVM_MAX_VCPUS then it will
> fail to launch guest (or fail to hot plug vcpus). In other words, the
> number of vcpus in a KVM guest will never to > KVM_MAX_VCPUS.
> 
> Am I missing something ?

KVM_MAX_VCPUS is a definition for use in the *host*, it's even defined
in kvm_host.h.  The guest's pvclock code won't get magically recompiled
if KVM_MAX_VCPUS is changed in the host.  KVM_MAX_VCPUS is an arbitrary
value in the sense that there isn't a fundamental hard limit, i.e. the
value can be changed, either for a custom KVM build or in mainline,
e.g. it was bumped in 2016:

commit 682f732ecf7396e9d6fe24d44738966699fae6c0
Author: Radim Krčmář <rkrcmar@redhat.com>
Date:   Tue Jul 12 22:09:29 2016 +0200

    KVM: x86: bump MAX_VCPUS to 288
    
    288 is in high demand because of Knights Landing CPU.
    We cannot set the limit to 640k, because that would be wasting space.
    
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 074b5c760327..21a40dc7aad6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -34,7 +34,7 @@
 #include <asm/asm.h>
 #include <asm/kvm_page_track.h>
 
-#define KVM_MAX_VCPUS 255
+#define KVM_MAX_VCPUS 288
 #define KVM_SOFT_MAX_VCPUS 240
 #define KVM_USER_MEM_SLOTS 509
 /* memory slots that are not exposed to userspace */
