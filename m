Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8F3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BDF21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfAVOz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:55:27 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55206 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfAVOz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:55:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67EE4A78;
        Tue, 22 Jan 2019 06:55:26 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FFCE3F589;
        Tue, 22 Jan 2019 06:55:24 -0800 (PST)
Date:   Tue, 22 Jan 2019 14:55:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        anshuman.khandual@arm.com
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190122145522.GC52887@lakrids.cambridge.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122054400.GB6445@brain-police>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:
> On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:
> > On Sat, Jan 19, 2019 at 11:58:27PM +0000, Will Deacon wrote:
> > > On Thu, Jan 17, 2019 at 07:42:44AM +0000, chenwandun wrote:
> > > > Recently, I do some tests on linux-4.19 and hit a softlockup issue.
> > > > 
> > > > I find some CPUs get the spinlock in the __split_huge_pmd function and
> > > > then send IPI to other CPUs, waiting the response, while several CPUs
> > > > enter the __split_huge_pmd function, want to get the spinlock, but always
> > > > in queued_spin_lock_slowpath,
> > > > 
> > > > Because long time no response to the IPI, that results in a softlockup.
> > > > 
> > > > As to sending IPI, it was in the patch
> > > > 3b8c9f1cdfc506e94e992ae66b68bbe416f89610.  The patch is mean to send IPI
> > > > to each CPU after invalidating the I-cache for kernel mappings.  In this
> > > > case, after modify pmd, it sends IPI to other CPUS to sync memory
> > > > mappings.
> > > > 
> > > > No stable test case to repeat the result, it is hard to repeat the test procedure.
> > > > 
> > > > The environment is arm64, 64 CPUs. Except for idle CPU, there are 6 kind
> > > > of callstacks in total.
> > > 
> > > This looks like another lockup that would be solved if we deferred our
> > > I-cache invalidation when mapping user-executable pages, and instead
> > > performed the invalidation off the back of a UXN permission fault, where we
> > > could avoid holding any locks.
> > 
> > Looking back at commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after
> > invalidating the I-cache for kernel mappings"), the text implies that it
> > should only do this for kernel mappings. I don't think we need this for
> > user mappings. We have a few scenarios where we invoke set_pte_at() with
> > exec permission:
> 
> Yes, I think you're right. I got confused because in this case we are
> invalidating lines written by the kernel, but actually it's not about who
> writes the data, but about whether or not the page table is being changed.

IIUC we may have a userspace problem analagous to the kernel modules
problem, if userspace uses dlopen/dlclose to dynamically load/unload
shared objects.

If userspace unloads an object, then loads another, the new object might
get placed at the same VA. A PE could have started speculating
instructions from the old object, and IIUC the TLB invalidation and
I-cache maintenance don't cause those instructions be re-fetched from
the I-cache unless there's a context synchronization event.

Do we require the use of membarrier when loading or unloading objects?
If so, when does that happen relative to the unmap or map?

Thanks,
Mark.
