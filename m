Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBF8222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3yqa2sc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfBPDRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:17:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfBPDRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:17:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1G34IeA128314;
        Sat, 16 Feb 2019 03:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HE3+D+5oZCXr6QEjjhXo7D/LpdTn6L66LPwbZI4Jv9Y=;
 b=3yqa2sc4OHZsCbEEb2U29/8jA9uGUGF4QxiQMV4TZ+vj901VKvjGLLwlCaKYSz2Hth5N
 W7LcnOc9rpuWL90VSfGx1BGA9gxiLyS3o9El+VLwnzMRiDoentAB7ZmPLzEUezplcw5w
 QwunX9MvRmfI2WPBTSqVV/SFAHGz0dXmFs8uNL5xqDMMfXnCHAeVajUo9Kgz0Yh44oJb
 39WSFL2gL+2G5JKbpe4cuCOdTO1f7Z+ZUYAbD5Z4H0jinCsVXCRiOGbgS1NnHNAdpiVs
 EhnzRxDwwbdKv7cniw6TDWIjblF88h/VOLU1X/v69M4s1AS5Gx8vnxkDLSLA8ef8bH2b yg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81dr735-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:17:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1G3H5oS002577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Feb 2019 03:17:05 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1G3H4cs007860;
        Sat, 16 Feb 2019 03:17:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 19:17:04 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <dann.frazier@canonical.com>,
        <yanaijie@huawei.com>
Subject: Re: [PATCH] scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1550162277-17615-1-git-send-email-john.garry@huawei.com>
Date:   Fri, 15 Feb 2019 22:17:01 -0500
In-Reply-To: <1550162277-17615-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 15 Feb 2019 00:37:57 +0800")
Message-ID: <yq1va1kmngy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=506 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902160019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The sysfs phy_identifier attribute for a sas_end_device comes
> from the rphy phy_identifier value.

Applied to 5.0/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
