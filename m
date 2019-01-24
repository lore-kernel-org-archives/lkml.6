Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC9FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915F62184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfAXQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:37:48 -0500
Received: from foss.arm.com ([217.140.101.70]:60532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfAXQhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:37:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33054A78;
        Thu, 24 Jan 2019 08:37:48 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898543F237;
        Thu, 24 Jan 2019 08:37:46 -0800 (PST)
Date:   Thu, 24 Jan 2019 16:37:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shijith Thotton <sthotton@marvell.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Message-ID: <20190124163743.GK253679@arrakis.emea.arm.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190123181530.GA234790@arrakis.emea.arm.com>
 <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Shijith,

On Thu, Jan 24, 2019 at 07:00:42AM +0000, Shijith Thotton wrote:
> On 01/23/2019 11:45 PM, Catalin Marinas wrote:
> > diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> > index 30695a868107..5c9073bace83 100644
> > --- a/arch/arm64/mm/flush.c
> > +++ b/arch/arm64/mm/flush.c
> > @@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long len)
> >   		__clean_dcache_area_pou(kaddr, len);
> >   		__flush_icache_all();
> >   	} else {
> > -		flush_icache_range(addr, addr + len);
> > +		/*
> > +		 * Don't issue kick_all_cpus_sync() after I-cache invalidation
> > +		 * for user mappings.
> > +		 */
> > +		__flush_icache_range(addr, addr + len);
> >   	}
> >   }
> 
> We also faced similar issue with LTP test migrate_pages03 in past and this patch 
> fixes the issue.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623574.html

Thanks for confirming. I presume I can add your tested-by.

-- 
Catalin
