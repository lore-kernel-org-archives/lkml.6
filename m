Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1958ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58F5206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58F5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJYCEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:04:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:24876 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYCEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:04:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 10:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="94706689"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 24 Oct 2018 10:35:09 -0700
Message-ID: <15bf78bdadd282b0587097d49cc39d0d7b662736.camel@linux.intel.com>
Subject: Re: [mm PATCH v3 4/6] mm: Move hot-plug specific memory init into
 separate functions and optimize
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Wed, 24 Oct 2018 10:35:09 -0700
In-Reply-To: <20181024152742.GJ18839@dhcp22.suse.cz>
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
         <20181015202716.2171.7284.stgit@localhost.localdomain>
         <20181017091824.GL18839@dhcp22.suse.cz>
         <d9011108-4099-58dc-8b8c-110c5f2a3674@linux.intel.com>
         <20181024123640.GF18839@dhcp22.suse.cz>
         <40b17814b2a65531c5059e52a61c8f41b9603904.camel@linux.intel.com>
         <20181024152742.GJ18839@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-24 at 17:27 +0200, Michal Hocko wrote:
> On Wed 24-10-18 08:08:41, Alexander Duyck wrote:
> > On Wed, 2018-10-24 at 14:36 +0200, Michal Hocko wrote:
> > > On Wed 17-10-18 08:26:20, Alexander Duyck wrote:
> > > [...]
> > > > With that said I am also wondering if a possible solution to
> > > > the complaints you had would be to look at just exporting the
> > > > __init_pageblock function later and moving the call to
> > > > memmap_init_zone_device out to the memremap or hotplug code
> > > > when Dan gets the refactoring for HMM and memremap all sorted
> > > > out.
> > > 
> > > Why cannot we simply provide a constructor for each page by the
> > > caller if there are special requirements? we currently have
> > > alt_map
> > > to do struct page allocation but nothing really prevents to make
> > > it
> > > more generic and control both allocation and initialization
> > > whatever
> > > suits a specific usecase. I really do not want make special cases
> > > here and there.
> > 
> > The advantage to the current __init_pageblock function is that we
> > end up constructing everything we are going to write outside of the
> > main loop and then are focused only on init.
> 
> But we do really want move_pfn_range_to_zone to provide a usable pfn
> range without any additional tweaks. If there are potential
> optimizations to be done there then let's do it but please do not try
> to micro optimize to the point that the interface doesn't make any
> sense anymore.

The actual difference between the two setups is not all that great.
From the sound of things the ultimate difference between the
ZONE_DEVICE pages and regular pages is the pgmap and if we want the
reserved bit set or not.

What I am providing with __init_pageblock at this point is a function
that is flexible enough for us to be able to do either one and then
just expose a different front end on it for the specific type of page
we have to initialize. It works for regular hotplug, ZONE_DEVICE, and
deferred memory initialization. The way I view it is that this funciton
is a high performance multi-tasker, not something that is micro-
optimized for any one specific function.

Thanks.

- Alex



