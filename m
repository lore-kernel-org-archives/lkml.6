Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D39DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E512B20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E512B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeKFCao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:30:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729733AbeKFCao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:30:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9BD8B0B3;
        Mon,  5 Nov 2018 17:10:04 +0000 (UTC)
Date:   Mon, 5 Nov 2018 18:10:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181105171002.GO4361@dhcp22.suse.cz>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
 <20181102155528.20358-1-mhocko@kernel.org>
 <20181105002009.GF27491@MiWiFi-R3L-srv>
 <20181105091407.GB4361@dhcp22.suse.cz>
 <20181105092851.GD4361@dhcp22.suse.cz>
 <20181105102520.GB22011@MiWiFi-R3L-srv>
 <20181105123837.GH4361@dhcp22.suse.cz>
 <20181105142308.GJ27491@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105142308.GJ27491@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 22:23:08, Baoquan He wrote:
> On 11/05/18 at 01:38pm, Michal Hocko wrote:
> > On Mon 05-11-18 18:25:20, Baoquan He wrote:
> > > Hi Michal,
> > > 
> > > On 11/05/18 at 10:28am, Michal Hocko wrote:
> > > > 
> > > > Or something like this. Ugly as hell, no question about that. I also
> > > > have to think about this some more to convince myself this will not
> > > > result in an endless loop under some situations.
> > > 
> > > It failed. Paste the log and patch diff here, please help check if I made
> > > any mistake on manual code change. The log is at bottom.
> > 
> > The retry patch is obviously still racy, it just makes the race window
> > slightly smaller and I hoped it would catch most of those races but this
> > is obviously not the case.
> > 
> > I was thinking about your MIGRATE_MOVABLE check some more and I still do
> > not like it much, we just change migrate type at many places and I have
> > hard time to actually see this is always safe wrt. to what we need here.
> > 
> > We should be able to restore the zone type check though. The
> > primary problem fixed by 15c30bc09085 ("mm, memory_hotplug: make
> > has_unmovable_pages more robust") was that early allocations made it to
> > the zone_movable range. If we add the check _after_ the PageReserved()
> > check then we should be able to rule all bootmem allocation out.
> > 
> > So what about the following (on top of the previous patch which makes
> > sense on its own I believe).
> 
> Yes, I think this looks very reasonable and should be robust.
> 
> Have tested it, hot removing 4 hotpluggable nodes continusously
> succeeds, and then hot adding them back, still works well.
> 
> So please feel free to add my Tested-by or Acked-by.
> 
> Tested-by: Baoquan He <bhe@redhat.com>
> or
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for retesting! Does this apply to both patches?
-- 
Michal Hocko
SUSE Labs
