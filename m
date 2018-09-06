Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8821C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BA220844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BA220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeIFS0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:26:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:46434 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbeIFS0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:26:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 06:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="86534589"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2018 06:50:41 -0700
Date:   Thu, 6 Sep 2018 06:50:41 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180906135041.GB32336@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906122423.GA11144@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:24:23PM +0200, Borislav Petkov wrote:
> On Thu, Sep 06, 2018 at 06:43:02AM -0500, Brijesh Singh wrote:
> > Currently, the per-cpu pvclock data is allocated dynamically when
> > cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
> > shared between the guest and the hypervisor hence it must be mapped as
> > unencrypted (ie. C=0) when SEV is active.
> > 
> > When SEV is active, we will be wasting fairly sizeable amount of memory
> > since each CPU will be doing a separate 4k allocation so that it can clear
> > C-bit. Let's define few extra static page sized array of pvclock data.
> > In the preparatory stage of CPU hotplug, use the element of this static
> > array to avoid the dynamic allocation. This array will be put in
> > the .data..decrypted section so that its mapped with C=0 during the boot.
> > 
> > In non-SEV case, this static page will unused and free'd by the
> > free_decrypted_mem().
> > 
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: kvm@vger.kernel.org
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: kvm@vger.kernel.org
> > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > ---
> >  arch/x86/include/asm/mem_encrypt.h |  4 ++++
> >  arch/x86/kernel/kvmclock.c         | 22 +++++++++++++++++++---
> >  arch/x86/kernel/vmlinux.lds.S      |  3 +++
> >  arch/x86/mm/init.c                 |  3 +++
> >  arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
> >  5 files changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> > index 802b2eb..aa204af 100644
> > --- a/arch/x86/include/asm/mem_encrypt.h
> > +++ b/arch/x86/include/asm/mem_encrypt.h
> > @@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> >  
> >  /* Architecture __weak replacement functions */
> >  void __init mem_encrypt_init(void);
> > +void __init free_decrypted_mem(void);
> >  
> >  bool sme_active(void);
> >  bool sev_active(void);
> >  
> >  #define __decrypted __attribute__((__section__(".data..decrypted")))
> > +#define __decrypted_hvclock __attribute__((__section__(".data..decrypted_hvclock")))
> 
> So are we going to be defining a decrypted section for every piece of
> machinery now?
> 
> That's a bit too much in my book.
> 
> Why can't you simply free everything in .data..decrypted on !SVE guests?

That would prevent adding __decrypted to existing declarations, e.g.
hv_clock_boot, which would be ugly in its own right.  A more generic
solution would be to add something like __decrypted_exclusive to mark
data that is used if and only if SEV is active, and then free the
SEV-only data when SEV is disabled.

Originally, my thought was that this would be a one-off case and the
array could be freed directly in kvmclock_init(), e.g.:

static struct pvclock_vsyscall_time_info
	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);

...

void __init kvmclock_init(void)
{
	u8 flags;

	if (!sev_active())
		free_init_pages("unused decrypted",
			(unsigned long)hv_clock_aux,
			(unsigned long)hv_clock_aux + sizeof(hv_clock_aux));

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> -- 
