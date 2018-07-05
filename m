Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D89EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7D624076
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlXP7LMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7D624076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeGETto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:49:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbeGETtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XHAMxw6CXBYg5NE9j2EHSKSy6vVRwvrWIH3vI/OHPM8=; b=LlXP7LMitFFyehyp6eW5ehc5X
        TWRmeIY1vuNrwY+2w8DS4GcIeqmv1qOrYoFccY9edy3P6gBaojEi2JoPmgHaLfrgbPI1UbaAtoG7T
        ZlBOacqAzuQLYEN6D2sQw13mWZvLHKYlUEB9DIu9neM0dWVDinIj4uio8LFnByuHFqAqrSrIjv2Ca
        kM2w4jz6VCI+ANXXk8Tfm7m0xpowCCDAwlxrX64emXrBZb3tjBM3jgLRt2FqCbdCsGp3kiZHHvpbV
        3LRFGSkWjaE/6QUnXm0HLxOJ+i6NRYO85U+sJKfLE4RQFWIZpAs8aL8Npay8QcO2jtZCZLEowI4Iw
        J3DE1fIGA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbAG0-0002Lh-8G; Thu, 05 Jul 2018 19:49:36 +0000
Date:   Thu, 5 Jul 2018 12:49:36 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
Message-ID: <20180705194936.GA28447@bombadil.infradead.org>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
 <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
> On Thu, Jul 5, 2018 at 1:29 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> > On Wed, Jul 04, 2018 at 11:50:13PM -0700, Dan Williams wrote:
> >> +static ssize_t memmap_state_store(struct device *dev,
> >> +             struct device_attribute *attr, const char *buf, size_t len)
> >> +{
> >> +     int i;
> >> +     struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
> >> +     struct memmap_async_state *async = &nd_pfn->async;
> >> +
> >> +     if (strcmp(buf, "sync") == 0)
> >> +             /* pass */;
> >> +     else if (strcmp(buf, "sync\n") == 0)
> >> +             /* pass */;
> >> +     else
> >> +             return -EINVAL;
> >
> > Hmm what about:
> >
> >         if (strncmp(buf, "sync", 4))
> >            return -EINVAL;
> >
> > This collapses 6 lines into 4.
> 
> ...but that also allows 'echo "syncAndThenSomeGarbage" >
> /sys/.../memmap_state' to succeed.

	if (strncmp(buf, "sync", 4))
		return -EINVAL;
	if (buf[4] != '\0' && buf[4] != '\n')
		return -EINVAL;

