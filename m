Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D5C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0D12086B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0D12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeIFSyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:54:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:25114 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbeIFSyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:54:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 07:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="72112674"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2018 07:18:25 -0700
Date:   Thu, 6 Sep 2018 07:18:25 -0700
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
Message-ID: <20180906141825.GB370@linux.intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic>
 <20180906135041.GB32336@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906135041.GB32336@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:50:41AM -0700, Sean Christopherson wrote:
> On Thu, Sep 06, 2018 at 02:24:23PM +0200, Borislav Petkov wrote:
> > On Thu, Sep 06, 2018 at 06:43:02AM -0500, Brijesh Singh wrote:
> > > Currently, the per-cpu pvclock data is allocated dynamically when
> > > cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
> > > shared between the guest and the hypervisor hence it must be mapped as
> > > unencrypted (ie. C=0) when SEV is active.
> > > 
> > > When SEV is active, we will be wasting fairly sizeable amount of memory
> > > since each CPU will be doing a separate 4k allocation so that it can clear
> > > C-bit. Let's define few extra static page sized array of pvclock data.
> > > In the preparatory stage of CPU hotplug, use the element of this static
> > > array to avoid the dynamic allocation. This array will be put in
> > > the .data..decrypted section so that its mapped with C=0 during the boot.
> > > 
> > > In non-SEV case, this static page will unused and free'd by the
> > > free_decrypted_mem().
> > > 
> > > diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> > > index 802b2eb..aa204af 100644
> > > --- a/arch/x86/include/asm/mem_encrypt.h
> > > +++ b/arch/x86/include/asm/mem_encrypt.h
> > > @@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
> > >  
> > >  /* Architecture __weak replacement functions */
> > >  void __init mem_encrypt_init(void);
> > > +void __init free_decrypted_mem(void);
> > >  
> > >  bool sme_active(void);
> > >  bool sev_active(void);
> > >  
> > >  #define __decrypted __attribute__((__section__(".data..decrypted")))
> > > +#define __decrypted_hvclock __attribute__((__section__(".data..decrypted_hvclock")))
> > 
> > So are we going to be defining a decrypted section for every piece of
> > machinery now?
> > 
> > That's a bit too much in my book.
> > 
> > Why can't you simply free everything in .data..decrypted on !SVE guests?
> 
> That would prevent adding __decrypted to existing declarations, e.g.
> hv_clock_boot, which would be ugly in its own right.  A more generic
> solution would be to add something like __decrypted_exclusive to mark
> data that is used if and only if SEV is active, and then free the
> SEV-only data when SEV is disabled.

Oh, and we'd need to make sure __decrypted_exclusive is freed when
!CONFIG_AMD_MEM_ENCRYPT, and preferably !sev_active() since the big
array is used only if SEV is active.  This patch unconditionally
defines hv_clock_dec but only frees it if CONFIG_AMD_MEM_ENCRYPT=y &&
!mem_encrypt_active().
