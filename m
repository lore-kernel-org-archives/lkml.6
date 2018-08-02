Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8790DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4943021530
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4943021530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHBTrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:47:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:49248 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeHBTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:47:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w72HrfJP026998;
        Thu, 2 Aug 2018 12:53:42 -0500
Message-ID: <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date:   Thu, 02 Aug 2018 12:53:41 -0500
In-Reply-To: <20180802200646-mutt-send-email-mst@kernel.org>
References: <20180730125100-mutt-send-email-mst@kernel.org>
         <20180730111802.GA9830@infradead.org>
         <20180730155633-mutt-send-email-mst@kernel.org>
         <20180731173052.GA17153@infradead.org>
         <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
         <20180801081637.GA14438@arm.com> <20180801083639.GF26378@infradead.org>
         <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
         <20180802182959-mutt-send-email-mst@kernel.org>
         <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
         <20180802200646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 20:19 +0300, Michael S. Tsirkin wrote:
> 
> I see. So yes, given that device does not know or care, using
> virtio features is an awkward fit.
> 
> So let's say as a quick fix for you maybe we could generalize the
> xen_domain hack, instead of just checking xen_domain check some static
> branch.  Then teach xen and others to enable that.>

> OK but problem then becomes this: if you do this and virtio device appears
> behind a vIOMMU and it does not advertize the IOMMU flag, the
> code will try to use the vIOMMU mappings and fail.
>
> It does look like even with trick above, you need a special version of
> DMA ops that does just swiotlb but not any of the other things DMA API
> might do.
> 
> Thoughts?

Yes, this is the purpose of Anshuman original patch (I haven't looked
at the details of the patch in a while but that's what I told him to
implement ;-) :

 - Make virtio always use DMA ops to simplify the code path (with a set
of "transparent" ops for legacy)

 and

 -  Provide an arch hook allowing us to "override" those "transparent"
DMA ops with some custom ones that do the appropriate swiotlb gunk.

Cheers,
Ben.


