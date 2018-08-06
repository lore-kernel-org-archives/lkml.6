Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB46C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4D521A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4D521A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbeHFQfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:35:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFQfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:35:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B387A9;
        Mon,  6 Aug 2018 07:26:20 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A24043F5D0;
        Mon,  6 Aug 2018 07:26:20 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 702621AE2D8E; Mon,  6 Aug 2018 15:26:24 +0100 (BST)
Date:   Mon, 6 Aug 2018 15:26:24 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     gengdongjiu <gengdj.1984@gmail.com>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        mark.rutland@arm.com, Len Brown <lenb@kernel.org>,
        rafael.j.wysocki@intel.com, erik.schmauss@intel.com,
        robert.moore@intel.com,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: Re: [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
Message-ID: <20180806142623.GA15275@arm.com>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
 <20180727100617.GB25592@arm.com>
 <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 10:35:03AM +0800, gengdongjiu wrote:
> 2018-07-27 18:06 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> > On Thu, Jul 26, 2018 at 05:01:47PM -0400, Dongjiu Geng wrote:
> >> In order to remove the additional check before calling the
> >> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will,
>      This patch will be applied, right? thanks

I haven't queued it in the arm64 tree, since it touches include/acpi/ghes.h
and you don't have an ack from the acpi folks. I acked it so that you could
route it via the acpi tree without me holding you up.

Will

> >> This cleanup is ever mentioned by Mark Rutland in [1]
> >>
> >> [1]:
> >> https://lkml.org/lkml/2018/5/31/289
> >> ---
> >>  arch/arm64/mm/fault.c | 7 +------
> >>  include/acpi/ghes.h   | 4 ++++
> >>  2 files changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >> index b8eecc7..9ffe01d 100644
> >> --- a/arch/arm64/mm/fault.c
> >> +++ b/arch/arm64/mm/fault.c
> >> @@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >>
> >>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
> >>  {
> >> -     int ret = -ENOENT;
> >> -
> >> -     if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> >> -             ret = ghes_notify_sea();
> >> -
> >> -     return ret;
> >> +     return ghes_notify_sea();
> >>  }
> >>
> >>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
> >> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> >> index 1624e2b..82cb4eb 100644
> >> --- a/include/acpi/ghes.h
> >> +++ b/include/acpi/ghes.h
> >> @@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
> >>            (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> >>            section = acpi_hest_get_next(section))
> >>
> >> +#ifdef CONFIG_ACPI_APEI_SEA
> >>  int ghes_notify_sea(void);
> >> +#else
> >> +static inline int ghes_notify_sea(void) { return -ENOENT; }
> >> +#endif
> >>
> >>  #endif /* GHES_H */
> >> --
> >> 1.9.1
> >>
