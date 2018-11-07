Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB51C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C860B2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C860B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbeKGUJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:09:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:33294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbeKGUJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:09:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87425B6E0;
        Wed,  7 Nov 2018 10:39:51 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:39:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Arun KS <arunks@codeaurora.org>, keescook@chromium.org,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        julia.lawall@lip6.fr
Subject: Re: [PATCH v1 0/4]mm: convert totalram_pages, totalhigh_pages and
 managed pages to atomic
Message-ID: <20181107103950.GD27423@dhcp22.suse.cz>
References: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
 <9b210d4cc9925caf291412d7d45f16d7@codeaurora.org>
 <63d9f48c-e39f-d345-0fb6-2f04afe769a2@yandex-team.ru>
 <08a61c003eed0280fd82f6200debcbca@codeaurora.org>
 <10c88df6-dbb1-7490-628c-055d59b5ad8e@yandex-team.ru>
 <22fa2222012341a54f6b0b6aea341aa2@codeaurora.org>
 <c3b0edf9-e6a2-c1ab-8490-d94b9830c8ae@yandex-team.ru>
 <89a259aa-156e-041c-b3bc-266824acb173@suse.cz>
 <20181107102837.GC27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107102837.GC27423@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 11:28:37, Michal Hocko wrote:
> On Wed 07-11-18 09:50:10, Vlastimil Babka wrote:
> > On 11/7/18 8:02 AM, Konstantin Khlebnikov wrote:
> [...]
> > > Could you point what exactly are you fixing with this set?
> > > 
> > > from v2:
> > > 
> > >  > totalram_pages, zone->managed_pages and totalhigh_pages updates
> > >  > are protected by managed_page_count_lock, but readers never care
> > >  > about it. Convert these variables to atomic to avoid readers
> > >  > potentially seeing a store tear.
> > > 
> > > This?
> > > 
> > > 
> > > Aligned unsigned long almost always stored at once.
> > 
> > The point is "almost always", so better not rely on it :) But the main
> > motivation was that managed_page_count_lock handling was complicating
> > Arun's "memory_hotplug: Free pages as higher order" patch and it seemed
> > a better idea to just remove and convert this to atomics, with
> > preventing potential store-to-read tearing as a bonus.
> 
> And more importantly the lock itself seems bogus as mentioned here
> http://lkml.kernel.org/r/20181106141732.GR27423@dhcp22.suse.cz

Should be http://lkml.kernel.org/r/20181107103630.GF2453@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
