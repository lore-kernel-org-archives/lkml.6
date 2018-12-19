Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F20C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C50218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VK1QY2jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeLSEfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:35:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLSEfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:35:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBJ4YLhV035943;
        Wed, 19 Dec 2018 04:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=28i1DheIZZ17SjP2g0ly2alcUQNTjJ0qYoH153Wntpo=;
 b=VK1QY2jzM8CH04CVesotqxPogzfEGBgPA7tzs84jxxI4Gu5FDtmGCTRII7VVtPI+lKho
 ahRsfEc2xhj7mz1gI7AagHPEtSgnVPDbvqyqwuTZm3ROBeAL9BC8cwAdXKKXj1EezxUz
 ryRO0IJm8fTPASGtcpzV5etxO0/+62uXQUw4HOkLHEKJiOZHyPggOLCIhICnJT3NLeXa
 1UyqRd5ZS20gFWdSp1pH5SCJYnCbRY9HFhxlrLmH1uNAt2IfQKQ45Q9h01nYIMPbSg8Q
 bRlJxw/nksEA2zNN5C+Tf0MP/KzLuX48a7Bvgbuk5BXU6DtUs1uMypSuuuIDXFPjQXB3 kA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pct8qxyjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:35:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBJ4Zc91008095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:35:39 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBJ4Zb3K013335;
        Wed, 19 Dec 2018 04:35:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 20:35:37 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v5 1/2] scsi: hisi_sas: Add support for DIF feature for v2 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545057608-89965-1-git-send-email-john.garry@huawei.com>
        <1545057608-89965-2-git-send-email-john.garry@huawei.com>
Date:   Tue, 18 Dec 2018 23:35:35 -0500
In-Reply-To: <1545057608-89965-2-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 17 Dec 2018 22:40:07 +0800")
Message-ID: <yq1pntygmlk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812190038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> For v3 hw, we support DIF operation for SAS, but not SATA.
>
> In addition, DIF CRC16 is supported.
>
> This patchset adds the SW support for the described features. The main
> components are as follows:
> - Get protection mask from module param
> - Fill PI fields
> - Fill related to DIF in DQ and protection iu memories

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
