Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C61CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3586721871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546546961;
	bh=DSNGpogYPcR5QU5zd4d3Oh4WaeGQhPl/kY8FkSHzdPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fmTOtWbbOU8UFuaMys0ykspVxp2zZY1M4Za+AlK9IGE75jEg06Mvo+7dm2EHT0df+
	 DW4LM72LkCLYig6l8jq+oEJ08nPGkULHupgN7IrWIrNABAgYqOdmpRhobJEL5C6G1z
	 pcGMI/UUdhTQ+MjqRPL1GZm8iudzOZ3VbHTpvujI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfACUWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:22:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:50758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbfACUWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:22:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E27ADAE43;
        Thu,  3 Jan 2019 20:22:37 +0000 (UTC)
Date:   Thu, 3 Jan 2019 21:22:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190103202235.GE31793@dhcp22.suse.cz>
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw>
 <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
 <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
 <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 14:53:47, Qian Cai wrote:
> On 1/3/19 2:07 PM, Michal Hocko wrote> So can we make the revert with an
> explanation that the patch was wrong?
> > If we want to make hacks to catch more objects to be tracked then it
> > would be great to have some numbers in hands.
> 
> Well, those numbers are subject to change depends on future start_kernel()
> order. Right now, there are many functions could be caught earlier by page owner.
> 
> 	kmemleak_init();
[...]
> 	sched_init_smp();

The kernel source dump will not tell us much of course. A ball park
number whether we are talking about dozen, hundreds or thousands of
allocations would tell us something at least, doesn't it.

Handwaving that it might help us some is not particurarly useful. We are
already losing some allocations already. Does it matter? Well, that
depends, sometimes we do want to catch an owner of particular page and
it is sad to find nothing. But how many times have you or somebody else
encountered that in practice. That is exactly a useful information to
judge an ugly ifdefery in the code. See my point?

-- 
Michal Hocko
SUSE Labs
