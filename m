Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6481C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0AD214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545118619;
	bh=OkOewOpB9BbFSl8RXayotfCTp7BOqPBzc9nI/YURLIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d2iVu8C/neJx3YP29J7FoRAxXsr6pjWxF/SRt2ht426gLlSaQWaCJM6PWaStpQQ2V
	 BV8c8ne+75eVhBFr+NvkfGS9Lc9kiYEdavS+zQ+28P+/Pmk/8aQcugaOhNeht8NWgg
	 BjBESHNUR9ttib/QHJs6jau+D787xxClRDRRVsMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeLRHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:36:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbeLRHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:36:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 931DBAE0C;
        Tue, 18 Dec 2018 07:36:56 +0000 (UTC)
Date:   Tue, 18 Dec 2018 08:36:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181218073655.GB30879@dhcp22.suse.cz>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217150726.6eea4942005516d565dae488@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 15:07:26, Andrew Morton wrote:
> On Mon, 17 Dec 2018 23:51:13 +0100 Oscar Salvador <osalvador@suse.de> wrote:
> 
> > v1 -> v2:
> > 	- Fix the logic for skipping pages by Michal
> > 
> > ---
> 
> Please be careful with the "^---$".  It signifies end-of-changelog, so
> I ended up without a changelog!
> 
> > >From e346b151037d3c37feb10a981a4d2a25018acf81 Mon Sep 17 00:00:00 2001
> > From: Oscar Salvador <osalvador@suse.de>
> > Date: Mon, 17 Dec 2018 14:53:35 +0100
> > Subject: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
> > 
> > While playing with gigantic hugepages and memory_hotplug, I triggered
> > the following #PF when "cat memoryX/removable":
> > 
> > ...
> >
> > Also, since gigantic pages span several pageblocks, re-adjust the logic
> > for skipping pages.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

> cc:stable?

See http://lkml.kernel.org/r/20181217152936.GR30879@dhcp22.suse.cz. I
believe nobody is simply using gigantic pages and hotplug at the same
time and those pages do not seem to cross cma regions as well. At least
not since hugepage_migration_supported stops reporting giga pages as
migrateable.

That being said, I do not think we really need it in stable but it
should be relatively easy to backport so no objection from me to put it
there.

-- 
Michal Hocko
SUSE Labs
