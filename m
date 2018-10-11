Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E45DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302220841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lu1UofcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeJKJcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:32:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeJKJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:32:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B25EFO177306;
        Thu, 11 Oct 2018 02:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=WiBmhyDKeTRDYKwNGbkNC4OTJplOqWN/K5cqkivmgK8=;
 b=Lu1UofcQ57EkBRoolM5g8QmIx/WM04dUaTC/ggdq54GnBwZ/ev/2DjCSRO4Q0/df+9Ur
 VODsTuSAzX+5eNCGtss4X/pMZPXp8O2BraJhhopRuoC3P56IyFQV7ZwNd9OZ+kk+PgEO
 TW+Np4K2L3NKHteAFytGVtr5kbX0iV6dDiip3+iLmxWx1t6/HDCMMlIiIdffctP/UHxR
 eObbdJNeGhQNDp2FHqBMq+CJ98CpmtGc6A2FRdrNlcl2sSS8wHUMk34OoXp8ofI3jNxm
 YF6lamGtr+kDa2DZ1knXsMGsEB1SDigmp4O1OP82dHBNPYJYvXux2AxBWMkZZBS23vTN 0A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mxnpr7d94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:07:05 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B26xbk019136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:06:59 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9B26xKM011000;
        Thu, 11 Oct 2018 02:06:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:06:58 +0000
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     jrdr.linux@gmail.com, Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra Basappa <chaitra.basappa@broadcom.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        brajeswar.linux@gmail.com,
        PDL-MPT-FUSIONLINUX <MPT-FusionLinux.pdl@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi/mpt3sas: Use dma_pool_zalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181002054804.GA11315@jordon-HP-15-Notebook-PC>
        <CA+RiK643GtCGGgivSZbS=DxU7DveqHjZFhZh9+PNoVUAyFmOLQ@mail.gmail.com>
Date:   Wed, 10 Oct 2018 22:06:56 -0400
In-Reply-To: <CA+RiK643GtCGGgivSZbS=DxU7DveqHjZFhZh9+PNoVUAyFmOLQ@mail.gmail.com>
        (Suganath Prabu Subramani's message of "Tue, 9 Oct 2018 11:32:45
        +0530")
Message-ID: <yq1va692q4f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suganath,

> Please consider this patch as Acked-by: Suganath Prabu
> <suganath-prabu.subramani@broadcom.com>

Next time, please make sure to put

Acked-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

on a line by itself. Otherwise patchwork won't pick up the tag.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
