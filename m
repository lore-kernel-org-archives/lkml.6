Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376ED21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546542441;
	bh=+eQrPgdqKur3hAJqdLpc1OIfNF8N5TW7kyQDBpjQt4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f1bIRMGsdfN/Nh41gb0PpzZS43vYhu/i9ozoBphgf6TmGmt9OHWOostgzC1CMVZgZ
	 g1PSPsVQGFsw53T5BPZwLMlNG/eON38J1DweLAoVUKUqv6Y0k1O24V//wcyf++Weep
	 fcv4aqhnuBCIPCiM3Exh54BCd+pcKjaXMAMLzKPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfACTHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:07:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbfACTHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:07:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B95C8AD0F;
        Thu,  3 Jan 2019 19:07:17 +0000 (UTC)
Date:   Thu, 3 Jan 2019 20:07:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, yang.shi@linaro.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190103190715.GZ31793@dhcp22.suse.cz>
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw>
 <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 12:38:59, Qian Cai wrote:
> On 1/3/19 11:59 AM, Michal Hocko wrote:
> >> As mentioned above, "If deselected DEFERRED_STRUCT_PAGE_INIT, it is still better
> >> to call page_ext_init() earlier, so page owner could catch more early page
> >> allocation call sites."
> > 
> > Do you have any numbers to show how many allocation are we losing that
> > way? In other words, do we care enough to create an ugly code?
> 
> Well, I don't have any numbers, but I read that Joonsoo did not really like to
> defer page_ext_init() unconditionally.
> 
> "because deferring page_ext_init() would make page owner which uses page_ext
> miss some early page allocation callsites. Although it already miss some early
> page allocation callsites, we don't need to miss more."

This is quite unspecific.

> https://lore.kernel.org/lkml/20160524053714.GB32186@js1304-P5Q-DELUXE/
> 
> >>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
> >>>> index ae44f7adbe07..d76fd51e312a 100644
> >>>> --- a/mm/page_ext.c
> >>>> +++ b/mm/page_ext.c
> >>>> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
> >>>>  			 * -------------pfn-------------->
> >>>>  			 * N0 | N1 | N2 | N0 | N1 | N2|....
> >>>>  			 *
> >>>> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
> >>>>  			 */
> >>>> -			if (early_pfn_to_nid(pfn) != nid)
> >>>> +			if (pfn_to_nid(pfn) != nid)
> >>>>  				continue;
> >>>>  			if (init_section_page_ext(pfn, nid))
> >>>>  				goto oom;
> >>>
> >>> Also this doesn't seem to be related, right?
> >>
> >> No, it is related. Because of this patch, page_ext_init() is called after all
> >> the memory has already been initialized,
> >> so no longer necessary to call early_pfn_to_nid().
> > 
> > Yes, but it looks like a follow up cleanup/optimization to me.
> 
> That early_pfn_to_nid() was introduced in fe53ca54270 (mm: use early_pfn_to_nid
> in page_ext_init) which also messed up the order of page_ext_init() in
> start_kernel(), so this patch basically revert that commit.

So can we make the revert with an explanation that the patch was wrong?
If we want to make hacks to catch more objects to be tracked then it
would be great to have some numbers in hands.
-- 
Michal Hocko
SUSE Labs
