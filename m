Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC4C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4752075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cpUy7lAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4752075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeJXLpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:45:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:45:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O1Oqri080310;
        Wed, 24 Oct 2018 01:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=e1U7TZVec4BZe0cRMSBqHUTnVRTl5KKCv3NIHvTyoNE=;
 b=cpUy7lAXmfPb24smHcIa/UbOhiWtlJgh4ptLwKmxrz2PB3Qe4HprFn55IcXAO1Z92qSQ
 By8CsNl4XtA0aZb82HVXMdG/+ybWImgllbpYnD+DuEqNBFi1gbUGrRw4mNh+Q0olpCAP
 ReQouyKhJD2ltuOIhRvBB650ChCumj7dcN9Rt8vTUTowYy2sAh/aDFIkW0I1GLPS2aBr
 r/zdOPK4IvAyfYlARzOeUbYOGBHBqBm025MCvrjcV/TYuXO8dbCShWceMSYY+V/ZxwFR
 seMNnspdJqrhTmoVdkqVv87QOS/bGgEhfA54MM5Q/FwXXi6i8FGk0cLml0HtAZhhtLlW dQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaq0meb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 01:27:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9O1R1Or014456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 01:27:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9O1R1jZ026757;
        Wed, 24 Oct 2018 01:27:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 18:27:00 -0700
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        keescook@chromium.org, john.garry@huawei.com,
        jinpu.wang@profitbricks.com, jrdr.linux@gmail.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] scsi/mvsas/mv_sas.c: Use dma_pool_zalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com>
Date:   Tue, 23 Oct 2018 21:26:58 -0400
In-Reply-To: <5bc8af85.1c69fb81.3eebc.a22b@mx.google.com> (Sabyasachi Gupta's
        message of "Thu, 18 Oct 2018 21:36:26 +0530")
Message-ID: <yq15zxsgmn1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=550
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sabyasachi,

> Replaced dma_pool_alloc + memset with dma_pool_zalloc

Applied to 4.20/scsi-queue, thank you.

-- 
Martin K. Petersen	Oracle Linux Engineering
