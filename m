Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82437ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4120321473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4120321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJRGBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:01:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbeJRGBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83F5D8666A;
        Wed, 17 Oct 2018 22:03:55 +0000 (UTC)
Received: from w520.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F3B87EC3;
        Wed, 17 Oct 2018 22:03:55 +0000 (UTC)
Date:   Wed, 17 Oct 2018 16:03:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Wenwen Wang <wang6495@umn.edu>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH] drivers/vfio: Fix an 8-byte alignment issue
Message-ID: <20181017160354.6a732fa5@w520.home>
In-Reply-To: <20181017211532.GB9499@localhost.localdomain>
References: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
        <20181017211532.GB9499@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Oct 2018 22:03:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 17:15:33 -0400
Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:

> On Wed, Oct 17, 2018 at 01:18:19PM -0500, Wenwen Wang wrote:
> > This patch adds a 4-byte reserved field in the structure
> > vfio_eeh_pe_op to make sure that the u64 fields in the structure
> > vfio_eeh_pe_err are 8-byte aligned.  
> 
> Won't this break 32-bit kernels? That is the size of the structure
> will now be 4 bytes bigger..

Hi Konrad,

EEH support here depends on SPAPR_TCE_IOMMU which depends on either
PPC_POWERNV or PPC_PSERIES, both of which depend on PPC64.  So I don't
think 32-bit kernels are a concern here.  Thanks,

Alex
 
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  include/uapi/linux/vfio.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 1aa7b82..3e71ded 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
> >  	__u32 argsz;
> >  	__u32 flags;
> >  	__u32 op;
> > +	__u32 __res;
> >  	union {
> >  		struct vfio_eeh_pe_err err;
> >  	};
> > -- 
> > 2.7.4
> >   

