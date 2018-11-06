Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896C8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009D2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NaAQfjHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5009D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbeKFM7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:59:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46642 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeKFM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:59:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA63XwsA157413;
        Tue, 6 Nov 2018 03:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=l6dPsN608SCSu1kyLmxpoULsIdByf9eE0XhnroavLug=;
 b=NaAQfjHrRe9kdnEyoY/096/3e+/qZELRH7UBkQtTq+3zN6NdhbvuLgj/MNW/oTIrGRnJ
 FMOW0EleRQnGHzJ/CootOvCtkGk1V2/YYHkW2TUJCa4bbGPQnfTL/HAIN+skGrU2GT7p
 Awcrtx7QBpcIZPw/DSopuDKGe9AhhED8VAXTusiJKrDflrG6bEvdmCBd2cXm+EWbNvZK
 0/9UEjHuvQaEzuoWyUv1sRjsJa7IQcr5I+Dx2iUpcI706PrwPo99Pp9pXqs/uIBjzOas
 VTOBBNFSMsqpDc3CXEitrEscvvfy4bSVgqQyow8CYCnLCnppXUX2K9X5Igk1VKPrV7C/ TQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nh4aqjmx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 03:36:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA63a1BG007354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 03:36:01 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA63a1BE001590;
        Tue, 6 Nov 2018 03:36:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 19:36:01 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: fix remoteport access
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181102153601.1599945-1-arnd@arndb.de>
Date:   Mon, 05 Nov 2018 22:35:58 -0500
In-Reply-To: <20181102153601.1599945-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 2 Nov 2018 16:35:48 +0100")
Message-ID: <yq1d0ri7u8x.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=571
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The addition of a spinlock in lpfc_debugfs_nodelist_data() introduced
> a bug that lets us not skip NULL pointers correctly, as noticed by
> gcc-8:

Applied to 4.20/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
