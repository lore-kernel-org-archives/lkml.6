Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC23C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F0C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeIJSXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:23:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:49951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbeIJSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:23:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 06:29:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="255948354"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2018 06:29:12 -0700
Message-ID: <1536586152.11460.40.camel@intel.com>
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
Date:   Mon, 10 Sep 2018 06:29:12 -0700
In-Reply-To: <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
         <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
         <20180910122727.GE21815@zn.tnic>
         <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 08:15 -0500, Brijesh Singh wrote:
> 
> On 9/10/18 7:27 AM, Borislav Petkov wrote:
> > 
> > On Fri, Sep 07, 2018 at 12:57:30PM -0500, Brijesh Singh wrote:
> > > 
> > > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > > index 376fd3a..6086b56 100644
> > > --- a/arch/x86/kernel/kvmclock.c
> > > +++ b/arch/x86/kernel/kvmclock.c
> > > @@ -65,6 +65,15 @@ static struct pvclock_vsyscall_time_info
> > >  static struct pvclock_wall_clock wall_clock __decrypted;
> > >  static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
> > >  
> > > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > +/*
> > > + * The auxiliary array will be used when SEV is active. In non-SEV case,
> > > + * it will be freed by free_decrypted_mem().
> > > + */
> > > +static struct pvclock_vsyscall_time_info
> > > +			hv_clock_aux[NR_CPUS] __decrypted_aux;
> > Hmm, so worst case that's 64 4K pages:
> > 
> > (8192*32)/4096 = 64 4K pages.
> We can minimize the worst case memory usage. The number of VCPUs
> supported by KVM maybe less than NR_CPUS. e.g Currently KVM_MAX_VCPUS is
> set to 288

KVM_MAX_VCPUS is a property of the host, whereas this code runs in the
guest, e.g. KVM_MAX_VCPUS could be 2048 in the host for all we know.

> (288 * 64)/4096 = 4 4K pages.
> 
> (pvclock_vsyscall_time_info is cache aligned so it will be 64 bytes)

Ah, I was wondering why my calculations were always different than
yours.  I was looking at struct pvclock_vcpu_time_info, which is 32
bytes.

> #if NR_CPUS > KVM_MAX_VCPUS
> #define HV_AUX_ARRAY_SIZE  KVM_MAX_VCPUS
> #else
> #define HV_AUX_ARRAY_SIZE NR_CPUS
> #endif
> 
> static struct pvclock_vsyscall_time_info
>                         hv_clock_aux[HV_AUX_ARRAY_SIZE] __decrypted_aux;

