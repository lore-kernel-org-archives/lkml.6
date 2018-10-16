Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3747C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7C8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 03:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cci0qvZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJPLbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:31:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:31:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G3cX8m074264;
        Tue, 16 Oct 2018 03:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2KQBBdVnEMWqSG1xiOpSokLhgT+H29fSuKGSz2+RrHk=;
 b=Cci0qvZm0CNqzEzCWdO/9MMRxGFs1gd4l7DaflabuEu8Mg2r899+OnE9INI5J9G381Ns
 84X5sTxoCVIk2aDEP4IV6N2QZwd1e5eRPypqx/dr/DdFG+a4HuIh9Dz1UL09WYQ69mo2
 VQTX/ogHs9P/AjxRp7nldOfVhG5LAilIeh+CRQNKTsYVzdha7onv3hkIsbsFaAArq5L6
 QGSSbvXJuf6C/qQ9BhFoJyD3Eznxt+U1OvtSLoiKKqujJLwE0T0jCpy5WmIcgCnX5kLp
 c/eAHPe08v5sOb8VU6yUWGJIIDmJz/Y/dX67EkvkpDEy2nesNauq+tkVMRhGrptqRoCq sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n38npwxr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 03:43:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9G3hGmt009865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 03:43:16 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G3hEFv020442;
        Tue, 16 Oct 2018 03:43:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 20:43:14 -0700
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
Date:   Mon, 15 Oct 2018 23:43:12 -0400
In-Reply-To: <1538850861-26882-1-git-send-email-wang6495@umn.edu> (Wenwen
        Wang's message of "Sat, 6 Oct 2018 13:34:21 -0500")
Message-ID: <yq136t6wo8f.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=746
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenwen,

> In megasas_mgmt_compat_ioctl_fw(), to handle the structure
> compat_megasas_iocpacket 'cioc', a user-space structure megasas_iocpacket
> 'ioc' is allocated before megasas_mgmt_ioctl_fw() is invoked to handle the
> packet. Since the two data structures have different fields, the data is
> copied from 'cioc' to 'ioc' field by field. In the copy process,
> 'sense_ptr' is prepared if the field 'sense_len' is not null, because it
> will be used in megasas_mgmt_ioctl_fw(). To prepare 'sense_ptr', the
> user-space data 'ioc->sense_off' and 'cioc->sense_off' are copied and saved
> to kernel-space variables 'local_sense_off' and 'user_sense_off'
> respectively. Given that 'ioc->sense_off' is also copied from
> 'cioc->sense_off', 'local_sense_off' and 'user_sense_off' should have the
> same value. However, 'cioc' is in the user space and a malicious user can
> race to change the value of 'cioc->sense_off' after it is copied to
> 'ioc->sense_off' but before it is copied to 'user_sense_off'. By doing so,
> the attacker can inject different values into 'local_sense_off' and
> 'user_sense_off'. This can cause undefined behavior in the following
> execution, because the two variables are supposed to be same.
>
> This patch enforces a check on the two kernel variables 'local_sense_off'
> and 'user_sense_off' to make sure they are the same after the copy. In case
> they are not, an error code EINVAL will be returned.

Broadcom folks: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
