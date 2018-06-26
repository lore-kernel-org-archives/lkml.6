Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B955D26D80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rxpvGSyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B955D26D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeFZQBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:01:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeFZQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:01:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QFsNEA174294;
        Tue, 26 Jun 2018 15:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=+KHln7qe579CBg7WdxraHBOfp1c3PTKp2h3cr8IHaic=;
 b=rxpvGSyb/CJl2jO1Sets2NvPLYw6OLp3wygYOCN1XEtkeD6qeK3kparX8BJlnbcONWDm
 WmnWGJhMEQK8zY9PB/La1x8aTMJEGNYK82RZJTBcjI7ctESwKxib0TImibILorypJKck
 E87kCG8DQiZlw+THwnc2xdNJEIb+GT+4qrJjFfez44pKy51jQEb4AiL51JA8Tv4o9pPG
 wxMrUyMumt3MA1pns2t87eD4ZoeqL2+rdFwV0oxXnim6Ms+yMjq2pxlaYzOmjjqtj/W/
 MSI1WlQB/IvJzSFec1+fNu1z6daJI/vJ+lrGQYizLsYTrw870bBc+rRph5PV3pOt55X4 WQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jukmtsb2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 15:59:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5QFxD64015057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 15:59:13 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QFxC5w028450;
        Tue, 26 Jun 2018 15:59:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 08:59:11 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        y2038@lists.linaro.org, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Steffen Maier <maier@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi_transport_fc: use 64-bit timestamps consistently
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180618153004.1808419-1-arnd@arndb.de>
Date:   Tue, 26 Jun 2018 11:59:08 -0400
In-Reply-To: <20180618153004.1808419-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 18 Jun 2018 17:29:51 +0200")
Message-ID: <yq1woul4jzn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=628
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The get_seconds() helper returns an 'unsigned long' value, which can
> overflow on 32-bit architectures. Since the interface we pass it into
> already uses a 64-bit type, we can just use ktime_get_real_seconds()
> instead.
>
> While we generally prefer local timestamps in CLOCK_MONOTONIC format
> (ktime_get_seconds), this keeps using the CLOCK_REALTIME version in
> order to maintain compatibility with existing code.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
