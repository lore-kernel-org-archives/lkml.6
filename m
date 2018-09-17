Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62056ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F0214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197F0214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQQ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:59:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57728 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbeIQQ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:59:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82E118A;
        Mon, 17 Sep 2018 04:33:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7952C3F5BD;
        Mon, 17 Sep 2018 04:33:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0C6B81AE2F82; Mon, 17 Sep 2018 12:33:22 +0100 (BST)
Date:   Mon, 17 Sep 2018 12:33:22 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] x86: pgtable: Drop pXd_none() checks from
 pXd_free_pYd_table()
Message-ID: <20180917113321.GB22717@arm.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
 <1536747974-25875-4-git-send-email-will.deacon@arm.com>
 <dc8b03de1e3318e3dd577d80482260f99ab4e9a5.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8b03de1e3318e3dd577d80482260f99ab4e9a5.camel@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 08:37:48PM +0000, Kani, Toshi wrote:
> On Wed, 2018-09-12 at 11:26 +0100, Will Deacon wrote:
> > Now that the core code checks this for us, we don't need to do it in the
> > backend.
> > 
> > Cc: Chintan Pandya <cpandya@codeaurora.org>
> > Cc: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/x86/mm/pgtable.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index ae394552fb94..b4919c44a194 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -796,9 +796,6 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> >  	pte_t *pte;
> >  	int i;
> >  
> > -	if (pud_none(*pud))
> > -		return 1;
> > -
> 
> Do we need to remove this safe guard?  I feel list this is same as
> kfree() accepting NULL.

I think two big differences with kfree() are (1) that this function has
exactly one caller in the tree and (2) it's implemented per-arch. Therefore
we're in a good position to give it some simple semantics and implement
those. Of course, if the x86 people would like to keep the redundant check,
that's up to them, but I think it makes the function more confusing and
tempts people into calling it for present entries.

Will
