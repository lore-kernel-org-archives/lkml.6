Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266021726
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546987232;
	bh=2NKqfWR+Ce9zOh1+rfyrEZG2MV4491x0izwGW5GmEl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z59GEGfjbrR271SdFtkiTmBqO7sv5uOkd/RrEXmbhj65w4bCRzSDPgSw6OQUTSXz4
	 FlSVv45V4ZX7ZWfuqtXqtc1r3L7VN2rbi0DMNZHbVE+/zIIkBUWzf07JsMlIi1Cf5d
	 k4rqWbgCk5epVS7lxCrxmCiX/cIWZyJDTxQVFzR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfAHWkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:40:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfAHWkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:40:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1B67AFE8;
        Tue,  8 Jan 2019 22:40:29 +0000 (UTC)
Date:   Tue, 8 Jan 2019 23:40:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel.Tatashin@microsoft.com, mingo@kernel.org,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190108224026.GL31793@dhcp22.suse.cz>
References: <20190104151737.GT31793@dhcp22.suse.cz>
 <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
 <20190104153245.GV31793@dhcp22.suse.cz>
 <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
 <20190107184309.GM31793@dhcp22.suse.cz>
 <bfcd017d-dcf4-b687-1aef-ab0810b12c73@lca.pw>
 <20190108082032.GP31793@dhcp22.suse.cz>
 <1546953547.6911.1.camel@lca.pw>
 <20190108140253.5b6db0ab37334b845e9d4fc2@linux-foundation.org>
 <c7a80f25-c30b-01cc-d2ef-49834f2d6078@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a80f25-c30b-01cc-d2ef-49834f2d6078@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 17:13:41, Qian Cai wrote:
> 
> 
> On 1/8/19 5:02 PM, Andrew Morton wrote:
> > 
> > It's unclear (to me) where we stand with this patch.  Shold we proceed
> > with v3 for now, or is something else planned?
> 
> I don't have anything else plan for this right now. Michal particular don't like
> that 4-line ifdef which supposes to avoid an immediately regression (arguably
> small) that existing page_owner users with DEFERRED_STRUCT_PAGE_INIT deselected
> that would start to miss tens of thousands early page allocation call sites. So,
> feel free to choose v2 of this which has no ifdef if you agree with Michal too.
> I am fine either way.

Yes I would prefer to revert the faulty commit (fe53ca54270) and work on
a more robust page_owner initialization to cover earlier allocations on
top of that.

Not that I would insist but this would be a more straightforward
approach and I hope it will result in a better long term maintainable
code in the end.

-- 
Michal Hocko
SUSE Labs
