Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E29C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6D62083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rtAU5g6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6D62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeKFM7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:59:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeKFM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:59:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA63YEdY015061;
        Tue, 6 Nov 2018 03:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HcjexclKz5bjlCp+wd7sGCTE2TrosSbz1+dOpBCUgKY=;
 b=rtAU5g6dmw5J2J0tq9zwxnkzhLzgGf9zOrqvvDx66WzQMDHqnlejw0ayW7Zj1Y9I7pY5
 o6V+MSU0hRi6QMrNleLot4+CgbiDZhJDSqdJSf4wm9SnOsII/BKkFWzrhrodye7CVLtv
 WiE2x4eF6o5Ajd66rKIV1DjqVL5GzLAEvg9xa2nHdgV8wDwl+XqEYjxlNHUhUBrbfhsR
 mEWac12PvrleGH+eV9CaomD1lIgV1H4WtF8iGJ5bWld0RACrv9Q0XrrNxbrhs5RdoJP6
 Jz/wqKHP5Mt+PNi6bJ4UII6is0de4iD0Ol2VZ2t2Wq2L+Kl2xwNhww9bczlZ7vUOZF3e tw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nh3mpjr1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 03:36:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA63aHmB018871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 03:36:18 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA63aGHU007173;
        Tue, 6 Nov 2018 03:36:16 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 19:36:16 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: myrs: avoid stack overflow warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181102154426.1951776-1-arnd@arndb.de>
Date:   Mon, 05 Nov 2018 22:36:14 -0500
In-Reply-To: <20181102154426.1951776-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Nov 2018 16:44:13 +0100")
Message-ID: <yq18t267u8h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=761
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Putting a 1024 byte data structure on the stack is generally a bad idea.
> On 32-bit systems, it also triggers a compile-time warning when building
> with -Og:

Applied to 4.20/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
