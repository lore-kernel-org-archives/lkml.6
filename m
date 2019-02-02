Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC34C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E85E2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfBBRRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:17:01 -0500
Received: from verein.lst.de ([213.95.11.211]:40524 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:17:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 894B968CEB; Sat,  2 Feb 2019 18:16:59 +0100 (CET)
Date:   Sat, 2 Feb 2019 18:16:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Darren Hart <dvhart@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, stuart.w.hayes@gmail.com,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mario_Limonciello@Dell.com
Subject: Re: [PATCH] dell_rbu: stop abusing the DMA API
Message-ID: <20190202171659.GA3324@lst.de>
References: <20190129073409.7247-1-hch@lst.de> <20190201231559.GC105752@fedora.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201231559.GC105752@fedora.eng.vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:15:59PM -0800, Darren Hart wrote:
> On Tue, Jan 29, 2019 at 08:34:09AM +0100, Christoph Hellwig wrote:
> > For some odd reason dell_rbu actually seems to want the physical and
> > not a bus address for the allocated buffer.  Lets assume that actually
> > is correct given that it is BIOS-related and that is a good source
> > of insanity.  In that case we should not use dma_alloc_coherent with
> > a NULL device to allocate memory, but use GFP_DMA32 to stay under
> > the 32-bit BIOS limit.
> 
> + Mario re bios related physical address - is Christoph's assumption
> correct?
> 
> Christoph, did you observe a failure? If so, we should probably also
> tag for stable.

No, I've been auditing for DMA API (ab-)users that don't pass a
struct device.  Generally the fix was to just pass a struct device
that is easily available.  But dell_rbu doesn't actually seem to
be a "device" in the traditional sense, and the way it uses the
DMA API is really, really odd - it first does a virt_to_phys on
memory allocated from the page allocator (so works with physical
addresses in that case) and the retries with a dma_alloc_coherent
with a NULL argument, which in no way is guaranteed to you give
you something else, although for the current x86 implementation
will give you the equivalent of a GFP_DMA32 page allocator allocation
plus virt_to_phys.
