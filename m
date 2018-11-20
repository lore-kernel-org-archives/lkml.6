Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907AAC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400F8204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QYUiMWUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400F8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbeKUDFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:05:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:05:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKGY8Nk097476;
        Tue, 20 Nov 2018 16:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jF3sCPpUCsdPqjWZUWYWtYftJopG9PXAOUUC7dH2OW0=;
 b=QYUiMWUkKOplW25OW7OKf9cPSagLLRuNa5NmoyndCbp/h3GeiSjXaYpbcmsviuYT64dA
 McoWPD6za2yR1/bLP3B3Nx9qKJo3hYpOGav0yeodJookSH2r7oArXg6NVozVSb1Es4e1
 koAMTUUwOATLsuWYfUm4vvJz41fYGBVe7KLqUr81KCuVlWKQ15sso8AvAs8bR0SF7+jI
 i/mh4oLEG2pu2sXuB3AmjrPFQIP8Xl0+lCwnUM4Xl/HYZsjBSgY0h5xdR5mJnM6peQNv
 Ms5Ns3yxVntBZKXYc9kjFnEhUNhZhcna4FN6midvdv5ap9zXPJzzAuz2X1/ZHitmNNqE MQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadtw0jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 16:34:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAKGYTob017211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 16:34:29 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAKGYK7e007847;
        Tue, 20 Nov 2018 16:34:21 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 08:34:17 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 36A0C6A00D4; Tue, 20 Nov 2018 11:34:16 -0500 (EST)
Date:   Tue, 20 Nov 2018 11:34:16 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
Message-ID: <20181120163416.GC31199@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
 <20181120144918.GH10917@char.us.oracle.com>
 <7ea5809e-1e1d-6bac-b723-9f55fafeaaae@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea5809e-1e1d-6bac-b723-9f55fafeaaae@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:01:33PM +0000, Robin Murphy wrote:
> On 20/11/2018 14:49, Konrad Rzeszutek Wilk wrote:
> > On Tue, Nov 20, 2018 at 02:09:52PM +0000, Robin Murphy wrote:
> > > With the overflow buffer removed, we no longer have a unique address
> > > which is guaranteed not to be a valid DMA target to use as an error
> > > token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
> > > an unlikely DMA target, but unfortunately there are already SWIOTLB
> > > users with DMA-able memory at physical address 0 which now gets falsely
> > > treated as a mapping failure and leads to all manner of misbehaviour.
> > > 
> > > The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
> > > commonly-used all-bits-set value, since the last single byte of memory
> > > is by far the least-likely-valid DMA target.
> > 
> > Are all the callers checking for DIRECT_MAPPING_ERROR or is it more of
> > a comparison (as in if (!ret)) ?
> 
> dma_direct_map_page() and dma_direct_mapping_error() were already doing the
> right thing, and external callers must rely on the latter via
> dma_mapping_error() rather than trying to inspect the actual value
> themselves, since that varies between implementations anyway. AFAICS all the
> new return paths from swiotlb_map_page() are also robust in referencing the
> macro explicitly, so I think we're good.

Cool! Thank you for checking.

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> 
> Thanks,
> Robin.
> 
> > > Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")]
> > > Reported-by: John Stultz <john.stultz@linaro.org>
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   include/linux/dma-direct.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> > > index bd73e7a91410..9de9c7ab39d6 100644
> > > --- a/include/linux/dma-direct.h
> > > +++ b/include/linux/dma-direct.h
> > > @@ -5,7 +5,7 @@
> > >   #include <linux/dma-mapping.h>
> > >   #include <linux/mem_encrypt.h>
> > > -#define DIRECT_MAPPING_ERROR		0
> > > +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0
> > >   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
> > >   #include <asm/dma-direct.h>
> > > -- 
> > > 2.19.1.dirty
> > > 
