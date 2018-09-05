Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49169C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9282075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ns+LMzsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9282075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIEU4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:56:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIEU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:56:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85GJ8gH140114;
        Wed, 5 Sep 2018 16:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Gcd59JacRde9WYO0JRPm/lUGS1ObD0yGlwQ6RoOLmC8=;
 b=Ns+LMzsgJlCaY9HA8bFeGF5Fa7OR+NmioEJ/5LCTAE10QMrYwCwuZx6juKVlO/6t2mJa
 lUuV23qINQNYXK0PaHh4FPFN1g1yO+N1Ur6W6jbS7bJhCyE4EEjf/LF3vveU/Fgc+tSs
 /7zHKGclKXcY1/rk2Lr8OPaYxfaoQu8SZ+HiYKFCQka5GpHsnS/C/ja1xD1PVfdWsQ7Y
 j3PyoLOU3ZkBGsS4hyq071VYyXcfMBH5Yq1cuGy7QDfOgKGOfaJy15D0ITEAFlEL8m8Z
 ZPmjKRj/0qte1z2usKtEavkSaxpLa6agdoo2062BjG1zuzyzMPbJJOpNqs5uwCnuxznf LA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6tn5yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 16:25:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w85GPP08008559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 16:25:25 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w85GPOPC002488;
        Wed, 5 Sep 2018 16:25:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 09:25:24 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1536137722.4813.66.camel@gmx.de>
        <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
Date:   Wed, 05 Sep 2018 12:25:22 -0400
In-Reply-To: <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk> (Jens Axboe's
        message of "Wed, 5 Sep 2018 07:39:08 -0600")
Message-ID: <yq15zzj3o99.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

> I bet it's the host busy change from Ming, which I already
> reported as being the culprit for another test failure I had. For
> some reason it's not merged yet, nudge nudge Martin.

I reverted the two offending changes last week. James just hasn't sent
Linus a pull request yet...

-- 
Martin K. Petersen	Oracle Linux Engineering
