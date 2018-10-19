Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A134C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A6020C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDhAkcFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A6020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeJSIlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:41:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeJSIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:41:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J0Svbq004494;
        Fri, 19 Oct 2018 00:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lJbqdJPSSuzMxpKVFzGhFuC194ApRmChv+O584c8BpY=;
 b=ZDhAkcFjRZup5DpE7RNHxvwymlNrkHJhqw61rzNihIMhn0mjXyCC8cRgpAVqWnkQZu0n
 KcZkGOlZYvI2K51vozyYhAztFzxYqgihXl0zpM76ZlN36x/uqLJyq32m5j6z5pzULHLi
 kzjn9JOAnuOnAXSAY2IpP+U2V2HaCTQmOrHZcBCIfCwDIddSj8kqcG+hnSi1Tn2hPpKF
 yrW8ENA2WW7+PKhdrDrREOfvRPWDkDsGV/gNNPxiX5VF8yDHC1H6vHmGOdVnlwbjxXFL
 BJ+IQksaNkyJUQFfECzzJ+id+U6tsDacqUdY3+VnocUNVlM0KhI1TEPRiw0eorf1pcHC rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n384uhqcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:37:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0bGxA029847
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:37:17 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0bGlk016701;
        Fri, 19 Oct 2018 00:37:16 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:37:16 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 666036A0136; Thu, 18 Oct 2018 20:37:15 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:37:15 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
Message-ID: <20181019003715.GI1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-8-hch@lst.de>
 <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	if (!dma_capable(dev, dma_addr, size) ||
> > +	    swiotlb_force == SWIOTLB_FORCE) {
> > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > +	}
> 
> FWIW I prefer the inverse condition and early return of the original code
> here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> a couple of lines), but it's no biggie.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I agree with Robin - it certainly makes it easier to read.

With that small change:
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!

> 
> > -	return DIRECT_MAPPING_ERROR;
> > +	return dma_addr;
> >   }
> >   /*
> > 
