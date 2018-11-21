Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1A921479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kFgh9I9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1A921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeKVBqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:46:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:46:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wALFBVmt123993;
        Wed, 21 Nov 2018 15:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sOV4+1IQYjMl9jEgXS0Gb2GxLgSQkUHBK8QW1whvfso=;
 b=kFgh9I9+5PMEmvnp6uHiIBdp2nU9hPAJgP6WM04F87KPYDDL5SBadwVDIARzLwCzOmAM
 5gN8h6SUnwsqSjVplnwt5GnrSh45X6FSIhwTiCsLCq1OXw8vyIui6z4SxBYCkOkQs09c
 r3p2anai7+eIQ5wYl1+p7COfYfZS+c2gnb8tJ59dAh+wbM19xVGyUMi0VhDiGx4Hhccn
 fuAfeLO2KkXbCHWSM7fpab3nHjFooEp623mKBbR5qgxwq1bQ2iIHgwxlZ1ecfPEKPWSD
 +xQm1t0IvTFfb4qCzeo7O9isjOoTHEnPeKmoYfg5Kn4uprCulnItOp2ECME6KZ16lC+0 fA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ntadu246t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 15:11:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wALFBZ0O012821
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 15:11:35 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wALFBYUA024725;
        Wed, 21 Nov 2018 15:11:34 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 07:11:34 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 7091D6A00D0; Wed, 21 Nov 2018 10:11:33 -0500 (EST)
Date:   Wed, 21 Nov 2018 10:11:33 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sstabellini@kernel.org
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Message-ID: <20181121151133.GC26925@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <20181120160818.GC2492@lst.de>
 <20181120163441.GD31199@char.us.oracle.com>
 <20181121130331.GA1373@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121130331.GA1373@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9083 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=763
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:03:31PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018 at 11:34:41AM -0500, Konrad Rzeszutek Wilk wrote:
> > > Konrad, are you ok with me picking up both through the dma-mapping
> > > tree?
> > 
> > Yes, albeit I would want Stefano to take a peek at patch #2 just in case.
> 
> Stefano, can you take a look asap?  This is a pretty trivial fix for
> a nasty bug that breaks boot on real life systems.  I'd like to merge
> it by tomorrow so that I can send it off to Linus for the next rc
> (I will be offline for about two days after Friday morning)

It is Turkey Day in US so he may be busy catching those pesky turkeys.
How about Tuesday? And in can also send the GIT PULL.
