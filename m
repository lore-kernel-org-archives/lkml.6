Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499C20866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="buNUAy44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeLTCve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:51:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49008 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTCve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:51:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK2nlwj103787;
        Thu, 20 Dec 2018 02:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=9HTrMzNBGTglOr/lTFke6xIbnrhEmNC7kCuXn+zAMj0=;
 b=buNUAy44SknDSMPb7f2QshoCZScTbVD3cl0e7BTjp9wASbXOy8W27+OX+Y/54osyaYNA
 lfs1PgNrh9HBBXqJvppJmE+v48z38rYu2smjgolktLLXDAEsETkpJUD8yn/bZaUyRr3E
 rhFedHl7/iuvMn49aC/DOHfTzC9Wout593h/aRuxctIb7oo6rXck6YvzTv3SprHp7+TG
 rGEKxNUZ+ZeELI9nBlt2gyMJ0bchWqMCr+l4rJpHBB37jUmSvivKEwdMtQVX+2aUk9Tp
 QGGYofQmolNybW6Y84dCBCUWGOJikAYFSHSS4OGKBBj8UjsGh+Egak28MIV+PXIDcJWK rg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pfh3a4wt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:51:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2p81d006750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:51:08 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2p7mD005096;
        Thu, 20 Dec 2018 02:51:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 18:51:07 -0800
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>,
        "James.Bottomley\@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "emilne\@redhat.com" <emilne@redhat.com>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: storvsc: Always use blk-mq
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545243282-10573-1-git-send-email-mikelley@microsoft.com>
Date:   Wed, 19 Dec 2018 21:51:04 -0500
In-Reply-To: <1545243282-10573-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Wed, 19 Dec 2018 18:40:49 +0000")
Message-ID: <yq14lb8gbc7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=297
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael,

> With high IOPS storage being increasingly prevalent for guests
> on Hyper-V and in Azure, make blk-mq the default so that the
> full performance of the storage can be realized without having
> to tweak other configuration settings.

The legacy I/O path will be gone in 4.21 so this patch isn't needed.

-- 
Martin K. Petersen	Oracle Linux Engineering
