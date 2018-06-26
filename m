Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B93CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D00726D4E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dn2sZPEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D00726D4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeFZP6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:58:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54320 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeFZP57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:57:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QFsjn9139448;
        Tue, 26 Jun 2018 15:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=DgWiyR2H+ABpuS1gRaaIM8ZIiZGmS6s9mIXKgchRqqI=;
 b=Dn2sZPEM5EQzMXc3HTNRIh4/zhrNB+On0Bh3ueXP4ZYxvtWF0f1HZY+GBPnFDPh4NIXa
 JezcUS6D2bevJ9RTnPiNPaRDAzGiKUCZ1iXUBHOibW0XfIi1VRgZaLIEhvqju+PMmJnc
 w6z8xH7gpYBQduz5yJgnjMN+psDknB3aQYRm1ZvAJ+Vzfd50Lzpb9FUCGWFA7StAZUwc
 WK0GD0yDuAjl0ffVcJccrX8XqzLHFxbwY6v5B4ClS8hrOLt3OT7SP8+c7f1E4wavTB51
 GlcUfY4mtPn26Xel6GcA6RQ0XK0+F5TL8UFmOnXPNcdVysnTgItwcKr5DTdTLnsx95Xv Xw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jum57s748-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 15:57:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5QFvoK5020703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 15:57:50 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QFvm3N027745;
        Tue, 26 Jun 2018 15:57:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 08:57:48 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        y2038@lists.linaro.org,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aacraid: stop using deprated get_seconds()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180618152734.1705907-1-arnd@arndb.de>
Date:   Tue, 26 Jun 2018 11:57:45 -0400
In-Reply-To: <20180618152734.1705907-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 18 Jun 2018 17:26:47 +0200")
Message-ID: <yq11sct5yme.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=301
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> get_seconds() can overflow on 32-bit architectures and is deprecated
> because of that. The use in the aacraid driver has the same problem
> due to a limited firmware interface, it also overflows in the year
> 2106.
>
> This changes all calls to get_seconds() to the non-deprecated
> ktime_get_real_seconds(), which unfortunately doesn't solve that
> problem but gets rid of one user of the deprecated interface.

Applied to 4.19/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
