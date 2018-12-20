Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82112086C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 02:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w7bhqmdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeLTC1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 21:27:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60642 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbeLTC1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 21:27:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK2O1Lh048527;
        Thu, 20 Dec 2018 02:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=o5iGTFxA5g8Re3ZZntSs8KQDE7E+b68NdNeBVWWHcRk=;
 b=w7bhqmdz7B5u6sphdfZfxXCFik74wQyG3xDDHbNd1ULskVhqOfL4Pwy3he/5zULEnO6f
 bmm+ct4oEUTo1TAv5EvTHFmGYreSo8Tn0ranHrj5+cv6guPUJwbd6W4rrcm2PhnSMOkb
 o4QBM2CGW+g6ElMsIi9H3CXIgrIzoTpfAreFtQI7D40LqCTWwQcTxh0+l4v8O8ynVawP
 MOfV45nKnsDQFOE9rbLpStwYnogBOe1BoQrpyYw+soKeTJE6ucNLLL08vT/UnJvOI9BO
 gQyJNzjWKDz70w2jJ9BdicgSD0WL0U2EaHu2mooOt7lvFjWyxjTjmcdXLka1n4mFCTk+ yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pfn1yuqca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:27:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBK2RQGS019599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 02:27:26 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBK2RQMK011108;
        Thu, 20 Dec 2018 02:27:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Dec 2018 18:27:25 -0800
To:     Anatoliy Glagolev <glagolig@gmail.com>
Cc:     aglagolev@purestorage.com, adailey@purestorage.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: deadlock by configfs_depend_item
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1544140125-3060-1-git-send-email-glagolig@gmail.com>
Date:   Wed, 19 Dec 2018 21:27:23 -0500
In-Reply-To: <1544140125-3060-1-git-send-email-glagolig@gmail.com> (Anatoliy
        Glagolev's message of "Thu, 6 Dec 2018 16:48:45 -0700")
Message-ID: <yq1tvj9exv8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anatoliy,

> The intent of invoking configfs_depend_item in commit 7474f52a82d51
> ("tcm_qla2xxx: Perform configfs depend/undepend for base_tpg") was to
> prevent a physical Fibre Channel port removal when virtual (NPIV)
> ports announced through that physical port are active.  The change
> does not work as expected: it makes enabled physical port dependent on
> target configfs subsystem (the port's parent), something the configfs
> guarantees anyway.
>
> Besides, scheduling work in a worker thread and waiting for the work's
> completion is not really a valid workaround for the requirement not to
> call configfs_depend_item from a configfs callback: the call
> occasionally deadlocks.
>
> Thus, removing configfs_depend_item calls does not break anything and
> fixes the deadlock problem.

Applied to 4.21/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
