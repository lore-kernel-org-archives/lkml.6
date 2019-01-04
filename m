Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD24C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551192173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfADWLv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:11:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:54884 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfADWLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 17:11:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 14:11:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="309055950"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2019 14:11:50 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 14:11:50 -0800
Received: from lcsmsx154.ger.corp.intel.com (10.186.165.229) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 14:11:49 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.79]) by
 LCSMSX154.ger.corp.intel.com ([169.254.7.82]) with mapi id 14.03.0415.000;
 Sat, 5 Jan 2019 00:11:47 +0200
From:   "Skidanov, Alexey" <alexey.skidanov@intel.com>
To:     Liam Mark <lmark@codeaurora.org>
CC:     Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "rve@android.com" <rve@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>
Subject: RE: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
Thread-Topic: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
Thread-Index: AQHTmouuA/gSueaepUm214iBMr8wB6ON0GeAgAFBHoCACOQRAIHq05J8gAAU6oCAAjvdgIABjVKAgBqrtICAAGa6AA==
Date:   Fri, 4 Jan 2019 22:11:46 +0000
Message-ID: <040863540BC4D141BEB177532350882876A5692E@hasmsx108.ger.corp.intel.com>
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com>
 <20180131130047.GA22917@kroah.com>
 <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
 <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com>
 <7d836085-cd8d-300b-56be-e8db4ff37afc@intel.com>
 <alpine.DEB.2.10.1812152119130.2951@lmark-linux.qualcomm.com>
 <67f288db-d9ea-2d45-ddcf-a15dbff316f5@intel.com>
 <alpine.DEB.2.10.1812171036080.23226@lmark-linux.qualcomm.com>
 <3740948f-02be-cf7a-bc41-54b4fd195103@intel.com>
 <alpine.DEB.2.10.1901040940260.19175@lmark-linux.qualcomm.com>
In-Reply-To: <alpine.DEB.2.10.1901040940260.19175@lmark-linux.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGUyZDE3N2UtMWUxMC00MTczLTlmZmYtN2VmNmI5M2JhMGE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVGhTZ1htSmpiNXZOUTFUdmJhRDRBK1FxQXFNMDdYdUJ2am9pOGFmUW82eEpadE9LaTdxeDZYRFwvS2s1eE9nOU8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.255.206.202]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Liam Mark [mailto:lmark@codeaurora.org]
> Sent: Friday, January 04, 2019 19:42
> To: Skidanov, Alexey <alexey.skidanov@intel.com>
> Cc: Laura Abbott <labbott@redhat.com>; Greg KH <gregkh@linuxfoundation.org>;
> devel@driverdev.osuosl.org; tkjos@android.com; rve@android.com; linux-
> kernel@vger.kernel.org; maco@android.com; sumit.semwal@linaro.org
> Subject: Re: [PATCH v3] staging: android: ion: Add implementation of dma_buf_vmap and
> dma_buf_vunmap
> 
> On Tue, 18 Dec 2018, Alexey Skidanov wrote:
> 
> > >>> I was wondering if we could re-open the discussion on adding support to
> > >>> ION for dma_buf_vmap.
> > >>> It seems like the patch was not taken as the reviewers wanted more
> > >>> evidence of an upstream use case.
> > >>>
> > >>> Here would be my upstream usage argument for including dma_buf_vmap
> > >>> support in ION.
> > >>>
> > >>> Currently all calls to ion_dma_buf_begin_cpu_access result in the creation
> > >>> of a kernel mapping for the buffer, unfortunately the resulting call to
> > >>> alloc_vmap_area can be quite expensive and this has caused a performance
> > >>> regression for certain clients when they have moved to the new version of
> > >>> ION.
> > >>>
> > >>> The kernel mapping is not actually needed in ion_dma_buf_begin_cpu_access,
> > >>> and generally isn't needed by clients. So if we remove the creation of the
> > >>> kernel mapping in ion_dma_buf_begin_cpu_access and only create it when
> > >>> needed we can speed up the calls to ion_dma_buf_begin_cpu_access.
> > >>>
> > >>> An additional benefit of removing the creation of kernel mappings from
> > >>> ion_dma_buf_begin_cpu_access is that it makes the ION code more secure.
> > >>> Currently a malicious client could call the DMA_BUF_IOCTL_SYNC IOCTL with
> > >>> flags DMA_BUF_SYNC_END multiple times to cause the ION buffer kmap_cnt to
> > >>> go negative which could lead to undesired behavior.
> > >>>
> > >>> One disadvantage of the above change is that a kernel mapping is not
> > >>> already created when a client calls dma_buf_kmap. So the following
> > >>> dma_buf_kmap contract can't be satisfied.
> > >>>
> > >>> /**
> > >>> * dma_buf_kmap - Map a page of the buffer object into kernel address
> > >>> space. The
> > >>> * same restrictions as for kmap and friends apply.
> > >>> * @dmabuf:	[in]	buffer to map page from.
> > >>> * @page_num:	[in]	page in PAGE_SIZE units to map.
> > >>> *
> > >>> * This call must always succeed, any necessary preparations that might
> > >>> fail
> > >>> * need to be done in begin_cpu_access.
> > >>> */
> > >>>
> > >>> But hopefully we can work around this by moving clients to dma_buf_vmap.
> > >> I think the problem is with the contract. We can't ensure that the call
> > >> is always succeeds regardless the implementation - any mapping might
> > >> fail. Probably this is why  *all* clients of dma_buf_kmap() check the
> > >> return value (so it's safe to return NULL in case of failure).
> > >>
> > >
> > > I think currently the call to dma_buf_kmap will always succeed since the
> > > DMA-Buf contract requires that the client first successfully call
> > > dma_buf_begin_cpu_access(), and if dma_buf_begin_cpu_access() succeeds
> > > then dma_buf_kmap will succeed.
> > >
> > >> I would suggest to fix the contract and to keep the dma_buf_kmap()
> > >> support in ION.
> > >
> > > I will leave it to the DMA-Buf maintainers as to whether they want to
> > > change their contract.
> > >
> > > Liam
> > >
> > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> > > a Linux Foundation Collaborative Project
> > >
> >
> > Ok. We need the list of the clients using the ION in the mainline tree.
> >
> 
> Looks to me like the only functions which might be calling
> dma_buf_kmap/dma_buf_kunmap on ION buffers are
> tegra_bo_kmap/tegra_bo_kunmap, I assume Tegra is used in some Android
> automotive products.
> 
> Looks like these functions could be moved over to using
> dma_buf_vmap/dma_buf_vunmap but it wouldn't be very clean and would add a
> performance hit.
> 
> Liam
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project

I'm a little bit confused. Why making the buffer accessible by CPU (mapping the buffer)
and making the content of the buffer valid (coherent) are so tightly coupled in DMA-BUF? 

Alexey
