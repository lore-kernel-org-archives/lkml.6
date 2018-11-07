Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C371620862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C371620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKGRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:43:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:60218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbeKGRnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:43:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FC4FB05F;
        Wed,  7 Nov 2018 08:14:28 +0000 (UTC)
Date:   Wed, 7 Nov 2018 09:14:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador <osalvador@suse.de>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: check zone_movable in
 has_unmovable_pages
Message-ID: <20181107081426.GW27423@dhcp22.suse.cz>
References: <20181106095524.14629-1-mhocko@kernel.org>
 <20181106203518.GC9042@350D>
 <20181107073548.GU27423@dhcp22.suse.cz>
 <1541577326.3089.2.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541577326.3089.2.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 08:55:26, osalvador wrote:
> On Wed, 2018-11-07 at 08:35 +0100, Michal Hocko wrote:
> > On Wed 07-11-18 07:35:18, Balbir Singh wrote:
> > > The check seems to be quite aggressive and in a loop that iterates
> > > pages, but has nothing to do with the page, did you mean to make
> > > the check
> > > 
> > > zone_idx(page_zone(page)) == ZONE_MOVABLE
> > 
> > Does it make any difference? Can we actually encounter a page from a
> > different zone here?
> 
> AFAIK, test_pages_in_a_zone() called from offline_pages() should ensure
> that the range belongs to a unique zone, so we should not encounter
> pages from other zones there, right?

Yes that is the case for memory hotplug. We do assume a single zone at
set_migratetype_isolate where we take the zone->lock. If the
contig_alloc can span multiple zones then it should check for similar.
-- 
Michal Hocko
SUSE Labs
