Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A63C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACB20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b4NSf8cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDACB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLEDfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:35:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40604 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLEDfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:35:55 -0500
X-Greylist: delayed 4856 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Dec 2018 22:35:54 EST
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB52EnR1105666;
        Wed, 5 Dec 2018 02:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=BbstwI7caEBS4ZQ0BPR8uUtQpqzzDBzGE7YHG1CCRbs=;
 b=b4NSf8cmZuP+KW05BjFcKCE4+rKSSvBLlf/c4XB0H0Gv/5UA3KNBytzdSTNxR6NXQ0Yf
 e7zj6ejDChAeLZdl5Lki7XiMBf6oBjdlcoNqBGet+eB9EZLMKkIcun4NKreNQeYKS7IF
 XoISIRa6n6ggesELfQEinRM7dgI/0ppUL9sbDEvOwgGmo2c0jAe97rFpuZPnRhPILflS
 tqHv+ZXo+c/+h4y9mOXAuAfdtbn7A3ZhERi2OyZm6Jz1fJmnkc0/s8aA1OjMGA+YB/+A
 GxSlijFFz20ztqc8u/FP4kQSYvJjPy3VB7gq5PrhbQMpqsXGn8Q3Necyr7yDGADy80l4 nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2p3ftf3rjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 02:14:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB52ElCk001944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 02:14:47 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB52EkM2017818;
        Wed, 5 Dec 2018 02:14:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 18:14:45 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v3 4/4] scsi: hisi_sas: Add support for DIF feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1543838994-30028-1-git-send-email-john.garry@huawei.com>
        <1543838994-30028-5-git-send-email-john.garry@huawei.com>
        <yq1ftveszew.fsf@oracle.com>
        <358aae82-394e-9df2-6b05-5af8e0f196b3@huawei.com>
Date:   Tue, 04 Dec 2018 21:14:43 -0500
In-Reply-To: <358aae82-394e-9df2-6b05-5af8e0f196b3@huawei.com> (John Garry's
        message of "Tue, 4 Dec 2018 12:16:54 +0000")
Message-ID: <yq1k1kosorw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=383
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Are you happy for us to make DIX support in this driver "hisi_sas DIX
> experimental" short term?

That's entirely your call, it's your driver/controller.  I just want the
experimental tag to be due to reasons on *your* end.

If it's reasons on my end they'll need to get fixed. We shouldn't have
drivers circumventing features because of bugs in the core block/SCSI
code...

-- 
Martin K. Petersen	Oracle Linux Engineering
