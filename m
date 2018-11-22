Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35E2206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="as4Hq+dz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35E2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbeKVOJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:09:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51068 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbeKVOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:09:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAM3TDCa032853;
        Thu, 22 Nov 2018 03:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=I82tQ5SYiZN3eXtaZcE/DammyUW9AjYYmzOOESP9Z/4=;
 b=as4Hq+dz3nfnIYYCsSfDfDzaGbWkhVKAKfJebsLdmzfSEFY+SVkLWzAU12UTPFQjno1P
 5kqZIvo92N9OnNBszn/a7V+6pwJbW+7ihwK/AgMfnHoc6LlG6/8vETyylA5LXjE29ZU5
 ioo5wNbxb+aDnRBgPROcydCWZBR59z8MfCzjyLEQc0qPA5KL8k77RaGkHMGKh/0XIPee
 4fkbPh7Gs712Mp3LRHA0y7y7F78Q3Q3VcGX/oqTXAsD22hzP/szht6KgLJgy/2zGmJVx
 +J/4YXTpEf160yYegpKH9SjaDjzGuK3hpNcsYRMi2tFtVUr8mh+EHUKWfN89+2pIQ+un SA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ntaxqckxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 03:32:05 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAM3W519001808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 03:32:05 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAM3W5hc027894;
        Thu, 22 Nov 2018 03:32:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 19:32:04 -0800
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: Re: [PATCH] scsi/lpfc/lpfc_sli.c: Use dma_zalloc_coherent
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com>
Date:   Wed, 21 Nov 2018 22:32:02 -0500
In-Reply-To: <5bf1797b.1c69fb81.2368c.1ccc@mx.google.com> (Sabyasachi Gupta's
        message of "Sun, 18 Nov 2018 20:08:48 +0530")
Message-ID: <yq1wop56b4d.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9084 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=472
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811220031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sabyasachi,

> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Applied to 4.21/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
