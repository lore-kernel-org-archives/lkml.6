Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEA22145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SE45sQ7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLRDbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:31:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLRDbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:31:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBI3O4k6088962;
        Tue, 18 Dec 2018 03:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=m1BoNvBkD5fsx8Y+MCl8NBhxlmaFEWCw+QdtHWQxE0Y=;
 b=SE45sQ7R7yzEb9fx/pUV1oXyy5y/FdFqZ/+kzZQQgtI4IBODLDsPZHli6pDpnrOiO/pl
 GMeFRgm9ww+uhIUhyo4l3Ivm3R+VpDV+Cz3kE4eEeUyb1HR/NLeo/FT9xjenz/EUY2+Z
 Jc+G/f83xAQtQsC7k3WhxHuoIyEGJvQF7FozeiVEZ0hNJCsDOFtHD6A0CbHVTetuuiOJ
 g74mE/18aPSmdAKYiQ0PkF1GNWTuuqZ/moylC5DFkMIXcEJ95zzygt34h57N83x25by1
 Dh4gAPQrxFYlemDmWES3VUDRGJW8toZwO7lx9jzzZrbxAsHSnfND3Root9bPAdL515TU xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pcs1tgvh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 03:31:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBI3V5s0022422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 03:31:06 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBI3V5kr023699;
        Tue, 18 Dec 2018 03:31:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Dec 2018 19:31:04 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v4 4/5] scsi: hisi_sas: Add support for DIF feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
        <1544103284-100497-5-git-send-email-john.garry@huawei.com>
        <yq1o99qgobi.fsf@oracle.com>
        <4752be71-f39c-ac55-0e51-36c146108a38@huawei.com>
        <afb32599-9b81-9d56-3ae7-2797992353a1@huawei.com>
Date:   Mon, 17 Dec 2018 22:31:02 -0500
In-Reply-To: <afb32599-9b81-9d56-3ae7-2797992353a1@huawei.com> (John Garry's
        message of "Mon, 17 Dec 2018 14:51:36 +0000")
Message-ID: <yq11s6flde1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=532
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> We have an issue with using scsi_transfer_length().
>
> As I understand, for our controller we need to set the host structure
> data transfer size to the size of data to write to the disk for WRITE
> type command, and at size of info received to host memory for READ
> type command. As such, for READ STRIP, we only want the SCSI buf len,
> and not the scsi buf len and PI (this is what scsi_transfer_length()
> provides).

Interesting asymmetry.

-- 
Martin K. Petersen	Oracle Linux Engineering
