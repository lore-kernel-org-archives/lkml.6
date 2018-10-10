Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B5F2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B5F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeJKFz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:55:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:33907 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKFz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:55:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 15:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,366,1534834800"; 
   d="scan'208";a="81595834"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 10 Oct 2018 15:31:45 -0700
Date:   Wed, 10 Oct 2018 16:28:43 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/6] mm/gup_benchmark: Time put_page
Message-ID: <20181010222843.GA11034@localhost.localdomain>
References: <20181010195605.10689-1-keith.busch@intel.com>
 <20181010152655.8510270e5db753f6666f12d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010152655.8510270e5db753f6666f12d3@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:26:55PM -0700, Andrew Morton wrote:
> On Wed, 10 Oct 2018 13:56:00 -0600 Keith Busch <keith.busch@intel.com> wrote:
> 
> > We'd like to measure time to unpin user pages, so this adds a second
> > benchmark timer on put_page, separate from get_page.
> > 
> > Adding the field will breaks this ioctl ABI, but should be okay since
> > this an in-tree kernel selftest.
> > 
> > ...
> >
> > --- a/mm/gup_benchmark.c
> > +++ b/mm/gup_benchmark.c
> > @@ -8,7 +8,8 @@
> >  #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
> >  
> >  struct gup_benchmark {
> > -	__u64 delta_usec;
> > +	__u64 get_delta_usec;
> > +	__u64 put_delta_usec;
> >  	__u64 addr;
> >  	__u64 size;
> >  	__u32 nr_pages_per_call;
> 
> If we move put_delta_usec to the end of this struct, the ABI remains
> back-compatible?

If the kernel writes to a new value appended to the end of the struct,
and the application allocated the older sized struct, wouldn't that
corrupt the user memory?
