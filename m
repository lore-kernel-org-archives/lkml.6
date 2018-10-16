Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD10BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8394F2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jW1oGrQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8394F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeJQFtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:49:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33474 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJQFtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:49:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9GLuGwh176231;
        Tue, 16 Oct 2018 21:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yxpOZfS9iBDFzO3nBZaj5DjsvZ+RdeVXenbvkCbpfZk=;
 b=jW1oGrQeG3aGYfVNMEomwKTPSOthGiN4yzUVrT3cOY1Xw/B52noEZk+7JKnIUFvDIFyR
 GO3GyjDDQPDENQQKbF2lJustyZw7VgO1MGOwzR26DnOIDOBwwYFaRMfr8U/exIZPtoBB
 Zqo7cEkgpy2t7LoKKryiGr73fYxJ/4KiJydPRFQhEpIfAUW0C61y1HUtjFmyC+OF2gHX
 CJgAGZzzyog934T+BHAqCZAl40yYqIaXmszaMp/6qsEekehqfGhhij83lRwneVBMj5+q
 +IIZmyGP8TnfMiyvTkO3vrHDtsNRoMSjjunBG7V8NGNf4Cq06d5kTxaNv3IbqWxEE4Be sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39brbd4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 21:56:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9GLubV5001997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 21:56:37 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9GLubhF004324;
        Tue, 16 Oct 2018 21:56:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 14:56:36 -0700
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-scsi@vger.kernel.org (open list:MEGARAID SCSI/SAS DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] scsi: megaraid_sas: fix a missing-check bug
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1538850861-26882-1-git-send-email-wang6495@umn.edu>
Date:   Tue, 16 Oct 2018 17:56:33 -0400
In-Reply-To: <1538850861-26882-1-git-send-email-wang6495@umn.edu> (Wenwen
        Wang's message of "Sat, 6 Oct 2018 13:34:21 -0500")
Message-ID: <yq1pnw9r1wu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=627
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenwen,

> This patch enforces a check on the two kernel variables 'local_sense_off'
> and 'user_sense_off' to make sure they are the same after the copy. In case
> they are not, an error code EINVAL will be returned.

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
