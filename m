Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6532520685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfAIRI5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:08:57 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32819 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfAIRI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:08:57 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4F06C9458F82F404DD78;
        Wed,  9 Jan 2019 17:08:52 +0000 (GMT)
Received: from FRAEMA708-CHM.china.huawei.com (10.206.14.57) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 9 Jan 2019 17:08:52 +0000
Received: from FRAEML521-MBS.china.huawei.com ([169.254.2.121]) by
 FRAEMA708-CHM.china.huawei.com ([169.254.8.132]) with mapi id 14.03.0415.000;
 Wed, 9 Jan 2019 18:08:47 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "walling@linux.ibm.com" <walling@linux.ibm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
Thread-Topic: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
 informations
Thread-Index: AQHUqBjIIjcPL398PUeoG9j3BfH1aqWnAWYAgAAjmSA=
Date:   Wed, 9 Jan 2019 17:08:46 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8388B1270@FRAEML521-MBS.china.huawei.com>
References: <1547037714-21592-1-git-send-email-pmorel@linux.ibm.com>
        <1547037714-21592-2-git-send-email-pmorel@linux.ibm.com>
 <20190109083708.1d39234d@x1.home>
In-Reply-To: <20190109083708.1d39234d@x1.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: 09 January 2019 15:37
> To: Pierre Morel <pmorel@linux.ibm.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> walling@linux.ibm.com; cohuck@redhat.com; david@redhat.com;
> pasic@linux.ibm.com; thuth@redhat.com; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Subject: Re: [PATCH v1 1/2] vfio:iommu: Use capabilities do report IOMMU
> informations
> 
> On Wed,  9 Jan 2019 13:41:53 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
> > We add a new flag, VFIO_IOMMU_INFO_CAPABILITIES, inside the
> > vfio_iommu_type1_info to specify the support for capabilities.
> >
> > We add a new capability, with id VFIO_IOMMU_INFO_CAP_DMA
> > in the capability list of the VFIO_IOMMU_GET_INFO ioctl.
> >
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >  include/uapi/linux/vfio.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 8131028..54c4fcb 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -669,6 +669,15 @@ struct vfio_iommu_type1_info {
> >  	__u32	flags;
> >  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes
> info */
> >  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> > +#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities
> info */
> > +	__u64   cap_offset;     /* Offset within info struct of first cap */
> > +};
> > +
> > +#define VFIO_IOMMU_INFO_CAP_DMA 1
> > +struct vfio_iommu_cap_dma {
> > +	struct vfio_info_cap_header header;
> > +	__u64   dma_start;
> > +	__u64   dma_end;
> >  };
> >
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> 
> Unfortunately for most systems, a simple start and end is not really
> sufficient to describe the available IOVA space, there are often
> reserved regions intermixed, so this is not really a complete
> solution.  Shameer tried to solve this last year[1] but we ran into a
> road block that Intel IGD devices impose a reserved range of IOVA
> spaces reported to the user that conflict with existing assignment of
> this device and we haven't figured out yet how to be more selective of
> the enforcement of those reserved ranges.  Thanks,

Right. I had further discussions to unblock this at KVM forum/off-list with
Intel folks and was promised some help.

IIRC the discussion was at, Kevin/Ashok will take another look on your
proposed approach to exclude the RMRR[1] and see whether that is good
enough or not.

Kevin/Ashok,

Please update if you had a chance to look into it.

Thanks,
Shameer

[1]. https://lkml.org/lkml/2018/6/5/897

> Alex
> 
> [1] https://lkml.org/lkml/2018/4/18/293
