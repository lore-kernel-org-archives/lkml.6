Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3EBC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234620827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0234620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeKFJon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:44:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeKFJon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:44:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C0F931256BA;
        Tue,  6 Nov 2018 00:22:21 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C90266061;
        Tue,  6 Nov 2018 00:22:20 +0000 (UTC)
Date:   Tue, 6 Nov 2018 08:22:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181106002216.GK27491@MiWiFi-R3L-srv>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
 <20181102155528.20358-1-mhocko@kernel.org>
 <20181105002009.GF27491@MiWiFi-R3L-srv>
 <20181105091407.GB4361@dhcp22.suse.cz>
 <20181105092851.GD4361@dhcp22.suse.cz>
 <20181105102520.GB22011@MiWiFi-R3L-srv>
 <20181105123837.GH4361@dhcp22.suse.cz>
 <20181105142308.GJ27491@MiWiFi-R3L-srv>
 <20181105171002.GO4361@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105171002.GO4361@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 06 Nov 2018 00:22:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 at 06:10pm, Michal Hocko wrote:
> On Mon 05-11-18 22:23:08, Baoquan He wrote:
> > On 11/05/18 at 01:38pm, Michal Hocko wrote:
> > > On Mon 05-11-18 18:25:20, Baoquan He wrote:
> > > > Hi Michal,
> > > > 
> > > > On 11/05/18 at 10:28am, Michal Hocko wrote:
> > > > > 
> > > > > Or something like this. Ugly as hell, no question about that. I also
> > > > > have to think about this some more to convince myself this will not
> > > > > result in an endless loop under some situations.
> > > > 
> > > > It failed. Paste the log and patch diff here, please help check if I made
> > > > any mistake on manual code change. The log is at bottom.
> > > 
> > > The retry patch is obviously still racy, it just makes the race window
> > > slightly smaller and I hoped it would catch most of those races but this
> > > is obviously not the case.
> > > 
> > > I was thinking about your MIGRATE_MOVABLE check some more and I still do
> > > not like it much, we just change migrate type at many places and I have
> > > hard time to actually see this is always safe wrt. to what we need here.
> > > 
> > > We should be able to restore the zone type check though. The
> > > primary problem fixed by 15c30bc09085 ("mm, memory_hotplug: make
> > > has_unmovable_pages more robust") was that early allocations made it to
> > > the zone_movable range. If we add the check _after_ the PageReserved()
> > > check then we should be able to rule all bootmem allocation out.
> > > 
> > > So what about the following (on top of the previous patch which makes
> > > sense on its own I believe).
> > 
> > Yes, I think this looks very reasonable and should be robust.
> > 
> > Have tested it, hot removing 4 hotpluggable nodes continusously
> > succeeds, and then hot adding them back, still works well.
> > 
> > So please feel free to add my Tested-by or Acked-by.
> > 
> > Tested-by: Baoquan He <bhe@redhat.com>
> > or
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> Thanks for retesting! Does this apply to both patches?

Sorry, don't get it. I just applied this on top of linus's tree and
tested. Do you mean applying it on top of previous code change?
