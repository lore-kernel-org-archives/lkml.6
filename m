Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A58C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F524029
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HxH+axcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F524029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeGEVAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:00:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754121AbeGEVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CpiktrdEVkas6Tm/GM1yTbg9Sr6QvEGH8//7AhKj1cM=; b=HxH+axcwfO0DseqXzn+2XkBEp
        nqNZ7gBMy18PvE3UWHSiSYKC7orWqsB6lOks22N++5xpfTCh4MvsUQHmlORcKCMUT5l15NbTW78P6
        5ZlphePrvsuwztDaSF446tb0WM1Ka6FwQRGqrFgWpBfa8PBdBjowKZYJltn7X8aCwNocl3FcXaHKo
        VcpHGtQdL45bx4yJX0aM0aFye51Zy6gVFhjhYnpo5fEO+j1oerbAaldTMTfEis92TWWrVgGW3HbvO
        1BN5zZN88mGAPjYhCrmYXqFsqUjqkbz2tui4ZZwmXQMu9RVyGDYOwkLwb9VFjhIGA2NTe/SYqPJD3
        aySbcJz4Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbBMF-0001Rh-NC; Thu, 05 Jul 2018 21:00:07 +0000
Date:   Thu, 5 Jul 2018 14:00:07 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
Message-ID: <20180705210007.GC28447@bombadil.infradead.org>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
 <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
 <20180705144941.drfiwhqcnqqorqu3@linux-x5ow.site>
 <20180705132455.2a40de08dbe3a9bb384fb870@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705132455.2a40de08dbe3a9bb384fb870@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 01:24:55PM -0700, Andrew Morton wrote:
> On Thu, 5 Jul 2018 16:49:41 +0200 Johannes Thumshirn <jthumshirn@suse.de> wrote:
> 
> > On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
> > > ...but that also allows 'echo "syncAndThenSomeGarbage" >
> > > /sys/.../memmap_state' to succeed.
> > 
> > Yep it does :-(.
> > 
> > Damn
> 
> sysfs_streq()

Thanks!  I didn't know that one existed.

It's kind of a shame that we realised this was a problem and decided
to solve it this way back in 2008 instead of realising that no driver
actually cares whether there's a \n or not and stripping off the \n
before the driver gets to see it.  Probably too late to fix that now.
