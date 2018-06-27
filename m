Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6083C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C2F23FE1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C2F23FE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753413AbeF0Hjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:39:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40625 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751239AbeF0Hji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:39:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49A18ABDD;
        Wed, 27 Jun 2018 07:39:37 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:39:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        JianKang Chen <chenjiankang1@huawei.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xieyisheng1@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: drop VM_BUG_ON from __get_free_pages
Message-ID: <20180627073936.GE32348@dhcp22.suse.cz>
References: <20180622162841.25114-1-mhocko@kernel.org>
 <6886dee0-3ac4-ef5d-3597-073196c81d88@suse.cz>
 <20180626100416.a3ff53f5c4aac9fae954e3f6@linux-foundation.org>
 <20180627073420.GD32348@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627073420.GD32348@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-06-18 09:34:20, Michal Hocko wrote:
> On Tue 26-06-18 10:04:16, Andrew Morton wrote:
[...]
> > Really, the changelog isn't right.  There *is* a real reason to blow
> > up.  Effectively the caller is attempting to obtain the virtual address
> > of a highmem page without having kmapped it first.  That's an outright
> > bug.
> 
> And as I've argued before the code would be wrong regardless. We would
> leak the memory or worse touch somebody's else kmap without knowing
> that.  So we have a choice between a mem leak, data corruption k or a
> silent fixup. I would prefer the last option. And blowing up on a BUG
> is not much better on something that is easily fixable. I am not really
> convinced that & ~__GFP_HIGHMEM is something to lose sleep over.

It's been some time since I've checked that changelog and you are right
it should contain all the above so the changelog should be:

"
There is no real reason to blow up just because the caller doesn't know
that __get_free_pages cannot return highmem pages. Simply fix that up
silently. Even if we have some confused users such a fixup will not be
harmful.

On the other hand an incorrect usage can lead to either a memory leak
or worse a memory corruption when the allocated page hashes to an
already kmaped page. Most workloads run with CONFIG_DEBUG_VM disabled so
the assert wouldn't help.
"
-- 
Michal Hocko
SUSE Labs
