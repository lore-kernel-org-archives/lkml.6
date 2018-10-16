Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E2E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UTp4qfRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E2E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeJPMRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:17:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55802 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbeJPMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:17:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G4IxcT100622;
        Tue, 16 Oct 2018 04:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8iZEsyh5mPuz4q453imm22EmQVJaAXoaAHflPJ0AsIo=;
 b=UTp4qfRQcC2YUL1eD3FGcmcx60mc+l5X6aPwIB5eJIM4y8/qPfnaFMwji5qtO9BAOI2Z
 wyb3FziJUrphi3RxEiVTgJAXAHaQq9DwHt/60XhQujWcW4Iy+Lscb7+NvZ9A44GtD1JF
 SENzXpNNGymSxgxw4cRwMo3AB/9Jhe1nCGvs0dm0xFFmhuY/e6PGYyk+3yYweLsIAf+I
 VQ9hXw0q9sn2shq8zMWCXZCEhdIloYgibTAsc8RduDySvTKe2sjrlfbPjXfW68Tp274n
 rIgbIPa4qdkBe3YVisYhCeb+BYF2fwCZQtpbHN5Q2WA2140GH+/EXwlckCRfmve7SLJv CA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38npx1v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 04:28:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9G4SZAO017959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 04:28:35 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9G4SY0J005710;
        Tue, 16 Oct 2018 04:28:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 21:28:34 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
        <yq18t354532.fsf@oracle.com>
        <e771c366-2824-8774-4c90-9906992ee813@huawei.com>
Date:   Tue, 16 Oct 2018 00:28:32 -0400
In-Reply-To: <e771c366-2824-8774-4c90-9906992ee813@huawei.com> (John Garry's
        message of "Fri, 12 Oct 2018 11:47:05 +0100")
Message-ID: <yq1h8hmv7kf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=691
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> As I mentioned in the thread that spawned from this, we actually can't
> expose multiple hw queues at the moment. And, if we did, we find a
> performance drop due to having to go back to manage this IPTT
> internally.
>
> So how to handle? We're going to continue to work towards exposing
> multiple queues to upper layer, but for the moment I think patch 6/7 is
> a good change.

Thanks for the discussion. That's exactly what I was looking for.

Applied to 4.20/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
