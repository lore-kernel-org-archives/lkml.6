Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14963C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CD20644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="31UOjFhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51CD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJKJag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:30:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34972 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:30:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B23wbR039089;
        Thu, 11 Oct 2018 02:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bJqP13jI2fiePndIV9ZOfCmnpvzqn3BHFomJEAwyQZI=;
 b=31UOjFhE+hNponXtRZH8e8LyS+sCYwH2wyG3eZZDx74d8pjayCS2Q0ijDomM9UxUeFa3
 mYNmaCn2r6/56sYyYMJSMY5BQp7kkslFnqbsM0WmL6Pr6jKTvGgbJSPQaU9PuK6XwkYf
 VooAoyxeUsCXVG3bpmq9clELRwdM05cyjxTciI1nbuRScLTVsbA+0MtX6/E8AXtZwKvM
 hSisq4GLQmxtmCFeFN3+a9lO7KsJWJaFguhK/nMl/6/DD9+QK7h5XUoMt/ywcOxTL/+t
 49oKdAqEnBoHbFQhPR/qqN8hkm3+su10QjTW70Fb/ircbLJM9H4kad7Qmi1UwV5MP3lg Ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0q7j7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:05:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B25SOY015868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:05:28 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B25SVO003576;
        Thu, 11 Oct 2018 02:05:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:05:28 +0000
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, brajeswar.linux@gmail.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/mpt3sas: Use dma_pool_zalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
Date:   Wed, 10 Oct 2018 22:05:25 -0400
In-Reply-To: <20181002054804.GA11315@jordon-HP-15-Notebook-PC> (Souptick
        Joarder's message of "Tue, 2 Oct 2018 11:18:04 +0530")
Message-ID: <yq1zhvl2q6y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=548
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Souptick,

> Replaced dma_pool_alloc + memset with dma_pool_zalloc.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
