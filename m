Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7009FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B91207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B91207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeJXX4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:56:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbeJXX4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:56:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6187AAEAF;
        Wed, 24 Oct 2018 15:27:44 +0000 (UTC)
Date:   Wed, 24 Oct 2018 17:27:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [mm PATCH v3 4/6] mm: Move hot-plug specific memory init into
 separate functions and optimize
Message-ID: <20181024152742.GJ18839@dhcp22.suse.cz>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202716.2171.7284.stgit@localhost.localdomain>
 <20181017091824.GL18839@dhcp22.suse.cz>
 <d9011108-4099-58dc-8b8c-110c5f2a3674@linux.intel.com>
 <20181024123640.GF18839@dhcp22.suse.cz>
 <40b17814b2a65531c5059e52a61c8f41b9603904.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b17814b2a65531c5059e52a61c8f41b9603904.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-10-18 08:08:41, Alexander Duyck wrote:
> On Wed, 2018-10-24 at 14:36 +0200, Michal Hocko wrote:
> > On Wed 17-10-18 08:26:20, Alexander Duyck wrote:
> > [...]
> > > With that said I am also wondering if a possible solution to the
> > > complaints
> > > you had would be to look at just exporting the __init_pageblock
> > > function
> > > later and moving the call to memmap_init_zone_device out to the
> > > memremap or
> > > hotplug code when Dan gets the refactoring for HMM and memremap all
> > > sorted
> > > out.
> > 
> > Why cannot we simply provide a constructor for each page by the
> > caller if there are special requirements? we currently have alt_map
> > to do struct page allocation but nothing really prevents to make it
> > more generic and control both allocation and initialization whatever
> > suits a specific usecase. I really do not want make special cases
> > here and there.
> 
> The advantage to the current __init_pageblock function is that we end
> up constructing everything we are going to write outside of the main
> loop and then are focused only on init.

But we do really want move_pfn_range_to_zone to provide a usable pfn
range without any additional tweaks. If there are potential
optimizations to be done there then let's do it but please do not try to
micro optimize to the point that the interface doesn't make any sense
anymore.
-- 
Michal Hocko
SUSE Labs
