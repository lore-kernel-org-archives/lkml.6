Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239BA2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3w+mGLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfBGUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:47:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBGUrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bEHNsOwIgj2itCnyGzcvVjHB+SGmRzUaNDbsBFafgJY=; b=a3w+mGLwkOd/LnmT1Kr17k8Ac
        iiSGnFoBQOvfQLItyqgAN5qfcm7xBZ1vMohHj+l/Mb86wTUG5ei8jRwOKQQr19RHICdtX+XBgnSPm
        ngWzQav+9byDRbJdC2L4Qt9dIA8BaiScsgkiNmCNFItcDrxdFfUL52noO6o/1wn/uMzK7HUaLlWpu
        +xc6VTs+Hb9K7rp9XlNqEH0fSbhdA65dTkFojxq87skezQMas/XHUvr3wXBm0xyO0mMNUqsB7deR1
        hv7BMXw4MXdmqNRRb0lxu2L+R8nxalxpbbSjt9wzmoLAHETncwDBKhlTMSEA3l9iJ3vDvY4yGYgoV
        XgrmgX6dA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grqa3-00060N-Hd; Thu, 07 Feb 2019 20:47:31 +0000
Date:   Thu, 7 Feb 2019 12:47:30 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     stuart.w.hayes@gmail.com, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario_Limonciello@dell.com
Subject: Re: [PATCH] dell_rbu: stop abusing the DMA API
Message-ID: <20190207204730.GA21530@wrath>
References: <20190129073409.7247-1-hch@lst.de>
 <20190201231559.GC105752@fedora.eng.vmware.com>
 <20190202171659.GA3324@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202171659.GA3324@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 06:16:59PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019 at 03:15:59PM -0800, Darren Hart wrote:
> > On Tue, Jan 29, 2019 at 08:34:09AM +0100, Christoph Hellwig wrote:
> > > For some odd reason dell_rbu actually seems to want the physical and
> > > not a bus address for the allocated buffer.  Lets assume that actually
> > > is correct given that it is BIOS-related and that is a good source
> > > of insanity.  In that case we should not use dma_alloc_coherent with
> > > a NULL device to allocate memory, but use GFP_DMA32 to stay under
> > > the 32-bit BIOS limit.
> > 
> > + Mario re bios related physical address - is Christoph's assumption
> > correct?
> > 
> > Christoph, did you observe a failure? If so, we should probably also
> > tag for stable.
> 
> No, I've been auditing for DMA API (ab-)users that don't pass a
> struct device.  Generally the fix was to just pass a struct device
> that is easily available.  But dell_rbu doesn't actually seem to
> be a "device" in the traditional sense, and the way it uses the
> DMA API is really, really odd - it first does a virt_to_phys on
> memory allocated from the page allocator (so works with physical
> addresses in that case) and the retries with a dma_alloc_coherent
> with a NULL argument, which in no way is guaranteed to you give
> you something else, although for the current x86 implementation
> will give you the equivalent of a GFP_DMA32 page allocator allocation
> plus virt_to_phys.
> 

Thanks Christoph, merged to for-next.


-- 
Darren Hart
VMware Open Source Technology Center
