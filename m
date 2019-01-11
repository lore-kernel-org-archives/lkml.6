Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD12C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBCB2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfAKVzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:55:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:33368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKVzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:55:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 13:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="114054591"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2019 13:55:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 04A82F7; Fri, 11 Jan 2019 23:55:06 +0200 (EET)
Date:   Sat, 12 Jan 2019 00:55:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Message-ID: <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111201003.19755-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
> to get an address returned by mmap() suitably aligned for THP.  It seems
> that if mmap is asking for a mapping length greater than huge page
> size, it should align the returned address to huge page size.
> 
> THP alignment has already been added for DAX, shm and tmpfs.  However,
> simple anon mappings does not take THP alignment into account.

In general case, when no hint address provided, all anonymous memory
requests have tendency to clamp into a single bigger VMA and get you
better chance having THP, even if a single allocation is too small.
This patch will *reduce* the effect and I guess the net result will be
net negative.

The patch also effectively reduces bit available for ASLR and increases
address space fragmentation (increases number of VMA and therefore page
fault cost).

I think any change in this direction has to be way more data driven.

-- 
 Kirill A. Shutemov
