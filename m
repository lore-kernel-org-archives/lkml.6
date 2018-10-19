Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C33ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A3221479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qe3UYzIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeJSVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:51:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeJSVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:51:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JDgZke145792;
        Fri, 19 Oct 2018 13:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=mn3Nazr3zgQ/ck0hbicjMAT/vLC6bN0ZWj6IU4JxA2Y=;
 b=Qe3UYzIvTl10/JYMzOeXIspWnGxlc7uFKYdeqN13X6n49Ac1aRemMB69OJaEiSdrYdwk
 xFZ5Z+6nqQyQTogiF+ImMomKPAnSLUMqVbTcF0ylGL4q4/xcRNC6DTLU+eCmWK5kSV7R
 J/T7sB1ni4URR7o5VseBMxjbfulcxbzZajsBnwEBd05WwH8AEq+CId1Hm/+bilFyj+XR
 1SGXr+37Qaz2w/qlg5ZCrXqc/+w6D5qij+I5fXSdgVfmJ0R/zyx5dQkJbK3+Hnt3Mm/3
 ILe6yElvnGzPU+XO/MNliYmmGLq4V+R5V/HeeycL3GUJklhJ6iq53a+mi9H0Mlp+XxYa UA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brv0dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:45:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9JDjFTD012882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 13:45:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9JDjFDA012113;
        Fri, 19 Oct 2018 13:45:15 GMT
Received: from Konrads-MacBook-Pro.local (/10.39.209.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 06:45:15 -0700
Date:   Fri, 19 Oct 2018 09:45:12 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
Message-ID: <20181019134512.GD54336@Konrads-MacBook-Pro.local>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-4-hch@lst.de>
 <20181019001714.GD1251@char.us.oracle.com>
 <20181019060425.GA28108@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019060425.GA28108@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:04:25AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:17:14PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Oct 08, 2018 at 10:02:39AM +0200, Christoph Hellwig wrote:
> > > All properly written drivers now have error handling in the
> > > dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> > > prints a useful warning when running out of swiotlb pool swace we can
> > 
> > s/swace/space/
> > 
> > > also remove swiotlb_full entirely as it serves no purpose now.
> > 
> > The panic albeit was useful for those drivers that didn't handle it.
> > 
> > Thoughts? I am kind of thinking screw them but then I am not too thrilled
> > about silent data corruption errors.
> 
> I can add an (optional) panic back in common code so that the different
> mapping types are covered.

Thank you.
> 
> Btw, are you fine with taking this through the dma mapping tree for
> this merge window?  I'd probably leave it in linux-next for another

Yes, please.
> week or so and don't send it with the first pull request on Monday.

<nods>
