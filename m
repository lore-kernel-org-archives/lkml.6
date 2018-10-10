Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7742B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7742B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJJRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:20:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbeJJRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0151AC90;
        Wed, 10 Oct 2018 09:58:40 +0000 (UTC)
Date:   Wed, 10 Oct 2018 11:58:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
Message-ID: <20181010095838.GG5873@dhcp22.suse.cz>
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain>
 <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 13:26:41, Alexander Duyck wrote:
[...]
> I would think with that being the case we still probably need the call to
> __SetPageReserved to set the bit with the expectation that it will not be
> cleared for device-pages since the pages are not onlined. Removing the call
> to __SetPageReserved would probably introduce a number of regressions as
> there are multiple spots that use the reserved bit to determine if a page
> can be swapped out to disk, mapped as system memory, or migrated.

PageReserved is meant to tell any potential pfn walkers that might get
to this struct page to back off and not touch it. Even though
ZONE_DEVICE doesn't online pages in traditional sense it makes those
pages available for further use so the page reserved bit should be
cleared.
-- 
Michal Hocko
SUSE Labs
