Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD60C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504CD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504CD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeKFTBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:01:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbeKFTBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:01:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37E5A394D2B;
        Tue,  6 Nov 2018 09:36:49 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8617219748;
        Tue,  6 Nov 2018 09:36:48 +0000 (UTC)
Date:   Tue, 6 Nov 2018 17:36:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181106093645.GM27491@MiWiFi-R3L-srv>
References: <20181105002009.GF27491@MiWiFi-R3L-srv>
 <20181105091407.GB4361@dhcp22.suse.cz>
 <20181105092851.GD4361@dhcp22.suse.cz>
 <20181105102520.GB22011@MiWiFi-R3L-srv>
 <20181105123837.GH4361@dhcp22.suse.cz>
 <20181105142308.GJ27491@MiWiFi-R3L-srv>
 <20181105171002.GO4361@dhcp22.suse.cz>
 <20181106002216.GK27491@MiWiFi-R3L-srv>
 <20181106082826.GC27423@dhcp22.suse.cz>
 <20181106091624.GL27491@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106091624.GL27491@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 06 Nov 2018 09:36:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 at 05:16pm, Baoquan He wrote:
> On 11/06/18 at 09:28am, Michal Hocko wrote:
> > > > > > > It failed. Paste the log and patch diff here, please help check if I made
> > > > > > > any mistake on manual code change. The log is at bottom.
> > > > > > 
> > > > > > The retry patch is obviously still racy, it just makes the race window
> > > > > > slightly smaller and I hoped it would catch most of those races but this
> > > > > > is obviously not the case.
> > > > > > 
> > > > > > I was thinking about your MIGRATE_MOVABLE check some more and I still do
> > > > > > not like it much, we just change migrate type at many places and I have
> > > > > > hard time to actually see this is always safe wrt. to what we need here.
> > > > > > 
> > > > > > We should be able to restore the zone type check though. The
> > > > > > primary problem fixed by 15c30bc09085 ("mm, memory_hotplug: make
> > > > > > has_unmovable_pages more robust") was that early allocations made it to
> > > > > > the zone_movable range. If we add the check _after_ the PageReserved()
> > > > > > check then we should be able to rule all bootmem allocation out.
> > > > > > 
> > > > > > So what about the following (on top of the previous patch which makes
> > > > > > sense on its own I believe).
> > > > > 
> > > > > Yes, I think this looks very reasonable and should be robust.
> > > > > 
> > > > > Have tested it, hot removing 4 hotpluggable nodes continusously
> > > > > succeeds, and then hot adding them back, still works well.
> > > > > 
> > > > > So please feel free to add my Tested-by or Acked-by.
> > > > > 
> > > > > Tested-by: Baoquan He <bhe@redhat.com>
> > > > > or
> > > > > Acked-by: Baoquan He <bhe@redhat.com>
> > > > 
> > > > Thanks for retesting! Does this apply to both patches?
> > > 
> > > Sorry, don't get it. I just applied this on top of linus's tree and
> > > tested. Do you mean applying it on top of previous code change?
> > 
> > Yes. While the first patch will obviously not help for movable zone
> > because the movable check will override any later check it
> > seems still useful to reduce false positives on normal zones.
> 
> Hmm, I don't know if it will bring a little bit confusion on code
> understanding. Since we only recognize the movable zone issue, and I can
> only reproduce and verify it on the movable zone issue with the movable
> zone check adding.
> 
> Not sure if there are any scenario or use cases to cover those newly added
> checking other movable zone checking. Surely, I have no objection to
		^ than
> adding them. But the two patches are separate issues, they have no
> dependency on each other.
> 
> I just tested the movable zone checking yesterday, will add your
> previous check back, then test again. I believe the result will be
> positive. Will udpate once done.
> 
> Thanks
> Baoquan
