Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B86AFC618F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9721580
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9721580
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIMVce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:32:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeIMVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:32:34 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0UNm-0007G6-CS; Thu, 13 Sep 2018 18:22:18 +0200
Date:   Thu, 13 Sep 2018 18:22:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v7 0/5] x86: Fix SEV guest regression
In-Reply-To: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
Message-ID: <alpine.DEB.2.21.1809131622180.1473@nanos.tec.linutronix.de>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Brijesh Singh wrote:
> x86/kvmclock: Remove memblock dependency
> introduced SEV guest regression.
> 
> The guest physical address holding the wall_clock and hv_clock_boot
> are shared with the hypervisor must be mapped with C=0 when SEV
> is active. To clear the C-bit we use  kernel_physical_mapping_init() to
> split the large pages. The above commit moved the kvmclock initialization
> very early and kernel_physical_mapping_init() fails to allocate memory
> while spliting the large page.
> 
> To solve it, we add a special .data..decrypted section, this section can be
> used to hold the shared variables. Early boot code maps this section with
> C=0. The section is pmd aligned and sized to avoid the need to split the pages.
> Caller can use __decrypted attribute to add the variables in .data..decrypted
> section. 

I went through this patch series and to be honest this is in no way -rc3+
material.

I really have to ask why this whole change to sme_encrypt_kernel() is
required at all.

Lets look at the problem at hand:

  We need exactly TWO pages to be shareable at early boot when the
  kernel runs in a guest and wants to utilize kvmclock.

  No, we do not need the whole NR_CPUS sized thing at that point at
  all. The secondary CPUs are brought up way later and there is absolutely
  no point in having the ugly decrypted..aux hack. That conditional freeing
  is really horrible and prone to break sooner than later.

  Further the TWO pages are BSS pages which does not require to handle them
  special other than fixing up the PMD and doing a memset(0) on the
  actually utilized TWO pages.

We really can enforce that such decrypted variables have to be in the BSS
for now and revisit this when there is an absolute requirement to have
statically initialized ones, which I doubt we have.

So the way simpler solution is:

1) Add a .bss..decrypted section which is PMD aligned and mark the
   kvmclock hv_clock_boot and wallclock struct with __bss_decrypted.

2) Fixup the .bss..decrypted section PMD in the SEV case at the end of
   sme_encrypt_kernel() and do a memset(0) on that. That does not require
   any of the restructuring, really.

3) Have a function which is called after the page allocator is up which
   does:

static struct pvclock_vsyscall_time_info *hvclock_mem;

void __init kvmclock_init_mem(void)
{
	unsigned int ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
	unsigned int order = get_order(ncpus * sizeof(*hvclock_mem));
	struct page *p;

	p = alloc_pages(order, GFP_KERNEL);
	if (p) {
		hvclock_mem = page_address(p);
		set_memory_decrypted((unsigned long) hvclock_mem,
				     PAGE_SIZE << order);
	}
}

4) In kvmclock_setup_percpu() do the following:

        if (cpu < HVC_BOOT_ARRAY_SIZE)
                p = &hv_clock_boot[cpu];
	else if (hvclock_mem)
		p = hvclock_mem + cpu - HVC_BOOT_ARRAY_SIZE;
	else
		return -ENOMEM;

5) Unconditionally free the pages after the used .bbs..decrypted variables,
   so the unused rest of the 2M page is not lost.

That should be a halfways slim sized and non instrusive changeset.

Thanks,

	tglx
