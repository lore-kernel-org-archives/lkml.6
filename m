Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B2BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C572146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1/NBONqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfAIDaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:30:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60556 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:30:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x093Ou98002531;
        Wed, 9 Jan 2019 03:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Kwd3Gwo/ULJYqzQxkLjInDRkywsL8Ug5W9dz3hxehyU=;
 b=1/NBONqVglVBDyBUo3tZkeomYmucfICpBEw+NK+h7ptLwPCvLAU/bkkMNnR98LTqwqEt
 sp71YzKyTJYPJUJEOD4Ill6l/T1atnosbr1vJeb60F6QrK8gIwH/SXnzUt1Ln3mHX3X+
 HrrXmXGpX8aOjt0eVajyEc7JuQmNjOWkIqmcJxg8H6QyaGMF75xEiPn4qCJA9bwBScef
 LT9LCxCTb9RMD9ENwDfm+pSUZt6kJxOrx0DILG5uBP74E7Tf1dCQcqGR1kdxXGVBWifB
 38cIKQETgNzv9f0c1kjkMmq9mI9BIwaeiXvQcn6oJ9tIb09LFrgWry5Pi4a1H7gTG21g KA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2ptj3dy90w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 03:30:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x093UQCJ003064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 03:30:27 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x093UQ7x024093;
        Wed, 9 Jan 2019 03:30:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 19:30:25 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: sd: Make protection lookup tables static and relocate functions
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1546960492-218420-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 08 Jan 2019 22:30:23 -0500
In-Reply-To: <1546960492-218420-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 8 Jan 2019 23:14:52 +0800")
Message-ID: <yq18szu4ieo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=877
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Currently the protection lookup tables in sd_prot_flag_mask() and
> sd_prot_op() are declared as non-static. As such, they will be rebuilt
> for each respective function call.
>
> Optimise by making them static.

Applied to 5.1/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
