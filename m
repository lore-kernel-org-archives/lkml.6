Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F4EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D15A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfAVFoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:44:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVFoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:44:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741A2A78;
        Mon, 21 Jan 2019 21:44:09 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C38963F6A8;
        Mon, 21 Jan 2019 21:44:07 -0800 (PST)
Date:   Tue, 22 Jan 2019 05:44:02 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        anshuman.khandual@arm.com
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190122054400.GB6445@brain-police>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121142127.GD29504@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
> On Sat, Jan 19, 2019 at 11:58:27PM +0000, Will Deacon wrote:
> > On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> > > Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> > > 
> > > I find some CPUs get the spinlock in the __split_huge_pmd function and
> > > then send IPI to other CPUs, waiting the response, while several CPUs
> > > enter the __split_huge_pmd function, want to get the spinlock, but always
> > > in queued_spin_lock_slowpath,
> > > 
> > > Because long time no response to the IPI, that results in a softlockup.
> > > 
> > > As to sending IPI, it was in the patch
> > > 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> > > to each CPU after invalidating the I-cache for kernel mappings.  In this
> > > case, after modify pmd, it sends IPI to other CPUS to sync memory
> > > mappings.
> > > 
> > > No stable test case to repeat the result, it is hard to repeat the test procedure.
> > > 
> > > The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> > > of callstacks in total.
> > 
> > This looks like another lockup that would be solved if we deferred our
> > I-cache invalidation when mapping user-executable pages, and instead
> > performed the invalidation off the back of a UXN permission fault, where we
> > could avoid holding any locks.
> 
> Looking back at commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after
> invalidating the I-cache for kernel mappings"), the text implies that it
> should only do this for kernel mappings. I don't think we need this for
> user mappings. We have a few scenarios where we invoke set_pte_at() with
> exec permission:

Yes, I think you're right. I got confused because in this case we are
invalidating lines written by the kernel, but actually it's not about who
writes the data, but about whether or not the page table is being changed.

> 1. Page faulted in - the pte was not previously accessible and the CPU
>    should not have stale decoded instructions (my interpretation of the
>    ARM ARM).
> 
> 2. huge pmd splitting - there is no change to the underlying data. I
>    have a suspicion here that we shouldn't even call
>    sync_icache_aliases() but probably the PG_arch_1 isn't carried over
>    from the head compound page to the small pages (needs checking).
> 
> 3. page migration - there is no change to the underlying data and
>    instructions, so I don't think we need the all CPUs sync.
> 
> 4. mprotect() setting exec permission - that's normally the
>    responsibility of the user to ensure cache maintenance
> 
> (I can add more text to the patch below but need to get to the bottom of
> this first)
> 
> ---------8<-------------------------------------------------
> arm64: Do not issue IPIs for user executable ptes
> 
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> for kernel mappings") was aimed at fixing the I-cache invalidation for
> kernel mappings. However, it inadvertently caused all cache maintenance
> for user mappings via set_pte_at() -> __sync_icache_dcache() to call
> kick_all_cpus_sync().
> 
> Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> Cc: <stable@vger.kernel.org> # 4.19.x-
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/cacheflush.h |    2 +-
>  arch/arm64/kernel/probes/uprobes.c  |    2 +-
>  arch/arm64/mm/flush.c               |   14 ++++++++++----
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 19844211a4e6..18e92d9dacd4 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -80,7 +80,7 @@ extern void __clean_dcache_area_poc(void *addr, size_t len);
>  extern void __clean_dcache_area_pop(void *addr, size_t len);
>  extern void __clean_dcache_area_pou(void *addr, size_t len);
>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
> -extern void sync_icache_aliases(void *kaddr, unsigned long len);
> +extern void sync_icache_aliases(void *kaddr, unsigned long len, bool sync);

I'd much prefer just adding something like sync_user_icache_aliases(), which
would avoid the IPI, since bool arguments tend to make the callsites
unreadable imo.

With that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
