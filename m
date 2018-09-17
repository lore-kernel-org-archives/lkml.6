Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACFDECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1B20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lVYvxSw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF1B20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeIQMOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:14:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46178 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeIQMOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:14:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H6iXUN080977;
        Mon, 17 Sep 2018 06:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=SVJPwPS5xNoQjszD0sDMHiTQEBE2yMfPe+/eVXrGDVw=;
 b=lVYvxSw9Hg20J7RYEKW9TwWW2N7hwth3UVekmMR3xbOOVQ2ECfxOzkoyw+sKZqLj9Lbz
 7TkJ2bLqi4C/UwYtID1xZ6Mz97qmATlBy7aWtoHv/e3BydRoWBCZhdfuxQWRQGjtrn1L
 LKn8WLQ8A5e9wQJJMnA6H2mCv+FLmFS/4wOLCK+X7hpBUKx3n4iMaiOVt8D9Y/yqLm+L
 yhmfcjYsnEwW65Ly9JmE0dqP3sQK2A2tC+q25WBXOECZ/V1WwAfg5ECtCoOgwZeAZfAN
 LVVqEghzZMt08mhrVTYI4FkCL7TgNXD/l2NRFOAZOhTZWfrWIBNOCmc3mYOW0AL/6Luu uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgtc8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:48:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6mO84010475
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:48:25 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6mNYY003604;
        Mon, 17 Sep 2018 06:48:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 23:48:23 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: make sysfs error messages ratelimited
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180907103924.17598-1-colin.king@canonical.com>
Date:   Mon, 17 Sep 2018 02:48:20 -0400
In-Reply-To: <20180907103924.17598-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 7 Sep 2018 11:39:24 +0100")
Message-ID: <yq1fty8sjpn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=444
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> It is possible to heavily spam the kernel logs with messages by
> excessive reading of the mpt3sas sysfs files.  Make the error messages
> ratelimited to reduce the spamming effect.

That's a bug. Please just nuke all of these.

-- 
Martin K. Petersen	Oracle Linux Engineering
