Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC0ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2ED21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deFrarWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2ED21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJSVxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:53:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60032 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeJSVxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:53:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JDg6Cc192678;
        Fri, 19 Oct 2018 13:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WefEzD/HBRrgkLYP4Qh5FSc4wapRgc8Q/ERdeVr/024=;
 b=deFrarWxXLN/sIbqjPWei9kPmtDPmDXq60n5Lz8naqKFiVZE5r3TqIzDdJJ1qfwIwK4h
 avYuUfFezhfXUOQfT+cYl5i1yVnX0VwIuGoVeAggvBDAFAFGHViAqltts+NEP2KnTJP3
 rwchfQXTyd06FOJhjNMojvyCqTx9oamtSko3Rw16nrG+kLsqth9/IsFlf7jP5gkhSZE6
 ovZ+BzuodybP4mAHHkm8rfCSrTUyrWFmnZBani7fL/vqIamRWI3q1WhD0vmGj41boYLQ
 8uQMZwLFSsO+xX65he49YdwDCA+a/fmyU4eoYreEfrNcLUrU0Mxg9oOGcQR4eRFeMnuj Og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384umae7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:46:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9JDkYYN030730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:46:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9JDkX8p021553;
        Fri, 19 Oct 2018 13:46:33 GMT
Received: from Konrads-MacBook-Pro.local (/10.39.209.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 06:46:33 -0700
Date:   Fri, 19 Oct 2018 09:46:30 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
Message-ID: <20181019134629.GE54336@Konrads-MacBook-Pro.local>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-8-hch@lst.de>
 <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
 <20181019003715.GI1251@char.us.oracle.com>
 <20181019065258.GA29249@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019065258.GA29249@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:52:58AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:37:15PM -0400, Konrad Rzeszutek Wilk wrote:
> > > > +	if (!dma_capable(dev, dma_addr, size) ||
> > > > +	    swiotlb_force == SWIOTLB_FORCE) {
> > > > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > > > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > > > +	}
> > > 
> > > FWIW I prefer the inverse condition and early return of the original code
> > > here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> > > a couple of lines), but it's no biggie.
> > > 
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > I agree with Robin - it certainly makes it easier to read.
> > 
> > With that small change:
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> So I did this edit, and in this patch it does indeed look much cleaner.
> But in patch 9 we introduce the cache maintainance, and have to invert
> the condition again if we don't want a goto mess:

Right. In which case please leave this patch as it is. And please
plaster the Reviewed-by on the patch. Thank you!
