Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF9ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7DF2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7DF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeITEGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:06:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:6642 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeITEGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:06:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 15:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="84965431"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2018 15:24:27 -0700
Date:   Wed, 19 Sep 2018 16:26:22 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/7] mm: faster get user pages
Message-ID: <20180919222621.GA29003@localhost.localdomain>
References: <20180919210250.28858-1-keith.busch@intel.com>
 <40b392d0-0642-2d9b-5325-664a328ff677@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b392d0-0642-2d9b-5325-664a328ff677@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 02:15:28PM -0700, Dave Hansen wrote:
> On 09/19/2018 02:02 PM, Keith Busch wrote:
> > Pinning user pages out of nvdimm dax memory is significantly slower
> > compared to system ram. Analysis points to software overhead incurred
> > from a radix tree lookup. This patch series fixes that by removing the
> > relatively costly dev_pagemap lookup that was repeated for each page,
> > significantly increasing gup time.
> 
> Could you also remind us why DAX pages are such special snowflakes and
> *require* radix tree lookups in the first place?

Yeah, ZONE_DEVICE memory is special. It has struct page mappings, but
not for online general use. The dev_pagemap is the metadata to the zone
device memory, and that metadata is stashed in a radix tree.

We're looking up the dev_pagemap in this path to take a reference so
the zone device can't be unmapped.
