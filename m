Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F55BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178702080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ls1eybPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178702080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbeKVNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:44:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33704 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbeKVNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:44:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAM33pak012203;
        Thu, 22 Nov 2018 03:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MyR65N5n8GpF1N4QqeAEqiH7549dfC5F9a9TFlm4rUE=;
 b=ls1eybPqT7bqLwVgIUHyacTzZSmFWhpXsS+xPPqfny0lILZUCYATzASwwFKuZJVJ31pl
 ESwqGUgghtfTgYltFjZ/PtAp4W4F0CIpyjseWjpdSk3u/tWEyt/X8SK9t5eU7A9omJ4x
 0RXhCKn8fYuIAAu73WLyu5Mbk+FHjsmCGQvwo0l/JBlYgBQROCbHH7xGGclZgb4USah2
 zuWVe5mrO7RVCz+vjQnq0Dss1HVxozydHCk81sowtO4SfVe88TP4EmmeSc7OtCYVp3S3
 TzbyufRj1LZvVG7ZkcAiJo4wPj8jt0ptPaM5nv3fqJlXTwpv399aopjgpnNXRV/CvY7x Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ntbmqvfyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 03:06:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAM36Yg9020046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 03:06:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAM36Xia014525;
        Thu, 22 Nov 2018 03:06:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 19:06:33 -0800
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        keescook@chromium.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] scsi/aic94xx/aic94xx_hwi.c: Use dma_pool_zalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181101041909.GA3241@jordon-HP-15-Notebook-PC>
Date:   Wed, 21 Nov 2018 22:06:29 -0500
In-Reply-To: <20181101041909.GA3241@jordon-HP-15-Notebook-PC> (Souptick
        Joarder's message of "Thu, 1 Nov 2018 09:49:09 +0530")
Message-ID: <yq18t1l95fu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9084 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=564
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811220027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Souptick,

> Replaced dma_pool_alloc + memset with dma_pool_zalloc

Applied to 4.21/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
