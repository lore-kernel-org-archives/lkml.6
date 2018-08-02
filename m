Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A94C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDCD2154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDCD2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeHBWpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:45:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbeHBWpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:45:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC7C140241F2;
        Thu,  2 Aug 2018 20:52:16 +0000 (UTC)
Received: from redhat.com (ovpn-117-57.ams2.redhat.com [10.36.117.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B722215670D;
        Thu,  2 Aug 2018 20:52:11 +0000 (UTC)
Date:   Thu, 2 Aug 2018 23:52:10 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180802225738-mutt-send-email-mst@kernel.org>
References: <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180801081637.GA14438@arm.com>
 <20180801083639.GF26378@infradead.org>
 <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
 <20180802182959-mutt-send-email-mst@kernel.org>
 <82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
 <20180802200646-mutt-send-email-mst@kernel.org>
 <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 20:52:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 20:52:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:53:41PM -0500, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-02 at 20:19 +0300, Michael S. Tsirkin wrote:
> > 
> > I see. So yes, given that device does not know or care, using
> > virtio features is an awkward fit.
> > 
> > So let's say as a quick fix for you maybe we could generalize the
> > xen_domain hack, instead of just checking xen_domain check some static
> > branch.  Then teach xen and others to enable that.>
> 
> > OK but problem then becomes this: if you do this and virtio device appears
> > behind a vIOMMU and it does not advertize the IOMMU flag, the
> > code will try to use the vIOMMU mappings and fail.
> >
> > It does look like even with trick above, you need a special version of
> > DMA ops that does just swiotlb but not any of the other things DMA API
> > might do.
> > 
> > Thoughts?
> 
> Yes, this is the purpose of Anshuman original patch (I haven't looked
> at the details of the patch in a while but that's what I told him to
> implement ;-) :
> 
>  - Make virtio always use DMA ops to simplify the code path (with a set
> of "transparent" ops for legacy)
> 
>  and
> 
>  -  Provide an arch hook allowing us to "override" those "transparent"
> DMA ops with some custom ones that do the appropriate swiotlb gunk.
> 
> Cheers,
> Ben.
> 

Right but as I tried to say doing that brings us to a bunch of issues
with using DMA APIs in virtio. Put simply DMA APIs weren't designed for
guest to hypervisor communication.

When we do (as is the case with PLATFORM_IOMMU right now) this adds a
bunch of overhead which we need to get rid of if we are to switch to
PLATFORM_IOMMU by default.  We need to fix that.

-- 
MST
