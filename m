Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBDAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B9E2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B9E2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeJBWrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:47:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:4816 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbeJBWrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:47:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2018 09:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,332,1534834800"; 
   d="scan'208";a="79264678"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2018 09:03:39 -0700
Date:   Tue, 2 Oct 2018 10:05:58 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 6/6] mm/gup: Cache dev_pagemap while pinning pages
Message-ID: <20181002160558.GA17231@localhost.localdomain>
References: <20180921223956.3485-1-keith.busch@intel.com>
 <20180921223956.3485-7-keith.busch@intel.com>
 <20181002112623.zlxtcclhtslfx3pa@black.fi.intel.com>
 <5bb265e9-bc23-799a-ad01-30edbc762996@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb265e9-bc23-799a-ad01-30edbc762996@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 08:49:39AM -0700, Dave Hansen wrote:
> On 10/02/2018 04:26 AM, Kirill A. Shutemov wrote:
> >> +	page = follow_page_mask(vma, address, foll_flags, &ctx);
> >> +	if (ctx.pgmap)
> >> +		put_dev_pagemap(ctx.pgmap);
> >> +	return page;
> >>  }
> > Do we still want to keep the function as inline? I don't think so.
> > Let's move it into mm/gup.c and make struct follow_page_context private to
> > the file.
> 
> Yeah, and let's have a put_follow_page_context() that does the
> put_dev_pagemap() rather than spreading that if() to each call site.

Thanks for all the feedback. I will make a new version, but with the
gup_benchmark part split into an independent set since it is logically
separate from the final patch.
