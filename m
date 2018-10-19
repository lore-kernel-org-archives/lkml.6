Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B4920843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5fYi+jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B4920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeJTGhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:37:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41052 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeJTGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:37:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JMSjUf173939;
        Fri, 19 Oct 2018 22:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ShMaIsTXErDUBnEjJ+7Lm1TY3ym2vE15QhVw0KNx4L8=;
 b=R5fYi+jhHDpuBvcHntZ5vN+sp78uBXrDIYEVKBcPf5dpqAoyg1kcMy6bws08bmyGy+/b
 kheryEDmiC/LbCZfjiwgF0qnyvgnQ1xtKTKbsglUW6HYgIHDrYTmZjycH3a1FYPxeYKP
 6ZXH+HHZn0KrWJJQ245PYtpYcCzT5zbHqVSTmIA1lzgmuKdlBZ6CCM5vl0sM3ac0BZAj
 NzGWzpITy5odrg07lNvcT2jKiILoPJKXfEV+coV3Rg4xnMherwTliIs2RJUNN9QvYbjn
 0qLFrBbryPVaFJHINaYXTdoePoGsg18fbrU9ny06uOHD2mH9apcBojDFV44wn98P8xeB uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39brx8gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 22:28:45 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9JMSfwa030786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 22:28:42 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9JMSfUZ015845;
        Fri, 19 Oct 2018 22:28:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 15:28:40 -0700
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: hisi_sas: Fix NULL pointer dereference
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181018165939.GA26491@embeddedor.com>
Date:   Fri, 19 Oct 2018 18:28:38 -0400
In-Reply-To: <20181018165939.GA26491@embeddedor.com> (Gustavo A. R. Silva's
        message of "Thu, 18 Oct 2018 18:59:39 +0200")
Message-ID: <yq1efclinah.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9051 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> There is a NULL pointer dereference in case *slot* happens to
> be NULL at lines 1053 and 1878:
>
> struct hisi_sas_cq *cq =
> 	&hisi_hba->cq[slot->dlvry_queue];
>
> Notice that *slot* is being NULL checked at lines 1057 and 1881:
> if (slot), which implies it may be NULL.
>
> Fix this by placing the declaration and definition of variable cq,
> which contains the pointer dereference slot->dlvry_queue, after
> slot has been properly NULL checked.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
