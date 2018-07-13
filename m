Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97934214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZJVgt65S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97934214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeGMCsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:48:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50848 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbeGMCsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:48:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CNtxDX091938;
        Fri, 13 Jul 2018 02:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Bwd/YwGSsa5MwBxgqlW+WKuoW/mi0h1dFia4ptntiAY=;
 b=ZJVgt65SYHTlJLueNGjXFThxwcDIpDLH+yY4UNISgrSr2SKpUs8vfCrhsZFLzWd46CQj
 Sv0viTtIrf92zu1fLNoLx/7twtwzWH5o+gLB+bLv48IE28zeXaS3EH+Yx/8g7BFhhBhc
 rb9Pxof2pgQmd+q4aucEyQku76yHzz83fQHT9kAMoEGmwDeY65d1pi6fYbVf2Mqi/VsG
 cOLFqBOm26M8brNoZZ1BRDM9E4JEBMgUSabdhjMazL2D2KTHYuAIUxNE3B7P+05VR+DY
 W/Hgj4eFLFS69pkyrS+ncabbNl4nUKiy1oMN08wj8ImD/qVR7hK3ha70jpBbgD+cCoP8 Vg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k2p7vnxr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 02:35:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6D2ZdHG007398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jul 2018 02:35:39 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6D2ZbtW029239;
        Fri, 13 Jul 2018 02:35:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 19:35:36 -0700
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Subject: Re: [PATCH 0/2] scsi: arcmsr: fix error of resuming from hibernation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1531131568.5779.8.camel@Centos6.3-64>
Date:   Thu, 12 Jul 2018 22:35:34 -0400
In-Reply-To: <1531131568.5779.8.camel@Centos6.3-64> (Ching Huang's message of
        "Mon, 09 Jul 2018 18:19:28 +0800")
Message-ID: <yq1lgafj215.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8952 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=477
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ching,

> This patch series are against to mkp's 4.19/scsi-queue.
>
> 1. Fix error of resuming from hibernation for adapter type E.
> 2. Update driver version to v1.40.00.09-20180709

Applied to 4.19/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
