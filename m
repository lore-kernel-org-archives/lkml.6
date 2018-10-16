Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ED921470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URxAwUh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ED921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJQFnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:43:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:43:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GLohOV171782;
        Tue, 16 Oct 2018 21:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=q5PZW6UPDJXqXVXLwgAANcDjk9Sh2xciK+6jUwle/xY=;
 b=URxAwUh9d5m2pYI63T99LhpwW/ZNgS0YT+7ArBsHL7fa/UVLpd/3U1mFEzYE5zLot7Kv
 iSorW/id/vE10lw/Re7XJ+QRvY6Koa1Sk5PecmsmasfZAHyQwAVva+Z09EA3pr7k6oLL
 IRe6Hs1V6H77PwOaWTluORA6CRZlntc9abACOl0ze5B/398bVVMVYHbnG+bxQ4awdncs
 T6av3U0scTeDxpcFkx4nKS9RB3NP4OSKMbgskU2d+D3tHyonh5zd3Iw9hqDxoker5ftE
 f+V9D/Wp+ogTbrqCrWFFpkmYdVl6qi43VhKBUyjDiwjB6ygqsGCorLiAZ3gIo//7DdE3 yQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n39brbchw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 21:51:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9GLpCH6009755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 21:51:12 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9GLpC8D004964;
        Tue, 16 Oct 2018 21:51:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 14:51:11 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <julia.lawall@lip6.fr>, <linuxarm@huawei.com>
Subject: Re: [PATCH] scsi: hisi_sas: Fix spin lock management in slot_index_alloc_quirk_v2_hw()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1539702036-191138-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 16 Oct 2018 17:51:09 -0400
In-Reply-To: <1539702036-191138-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Tue, 16 Oct 2018 23:00:36 +0800")
Message-ID: <yq136t5sgqa.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=615
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Currently a spin_unlock_irqrestore() call is missing on the error path, so
> add it.

Applied to 4.20/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
