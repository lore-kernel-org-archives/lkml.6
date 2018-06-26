Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9188AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478A826E64
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AXMfXOQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478A826E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeFZRMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeFZRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:12:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5QH8tZb010916;
        Tue, 26 Jun 2018 17:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=ILp1O92ZyziVEHaVucAZVAQDBM2ZUoP3ILHDSAV80zE=;
 b=AXMfXOQPf+wB1p5TwffhiP5MWPOpev0SdH54XrZBbbixKFaLe5Z+BpUVXEDzujDsFl3E
 5ZbwUGUc3DMIXQ4/ibQiY2Zu9vEA4xn4bLcJrmXjseE++c5XTDhZs7ETvhk4DmzRRTxr
 eDRfRuTpkd/LNg1KrEkyYsfP1Tlae/NiOq3KwvhWe8bYRK3gNSGqSwC7IiTX9P59FpHg
 5znInmxO/uO5/Sg/Du9tvAbwkE36U6fF5+UYyVbeQQTG+86DXrayg312S1OvGRHOMlKy
 8jBVhI74WtPBeG0uILblQwV+/BhhCJmeVbOqNNdby0VLLCP/WSh4eQ1EfOZ/WX3tqlqM iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jum0a1hbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 17:12:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5QHC0Ck029808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 17:12:01 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5QHBxBn027490;
        Tue, 26 Jun 2018 17:12:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 10:11:59 -0700
To:     Jann Horn <jannh@google.com>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        kernel-hardening@lists.openwall.com, security@kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] sg: mitigate read/write abuse
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180625142544.182673-1-jannh@google.com>
Date:   Tue, 26 Jun 2018 13:11:56 -0400
In-Reply-To: <20180625142544.182673-1-jannh@google.com> (Jann Horn's message
        of "Mon, 25 Jun 2018 16:25:44 +0200")
Message-ID: <yq1bmbx321v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8936 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jann,

> As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is
> not fit to be called under KERNEL_DS"), sg improperly accesses
> userspace memory outside the provided buffer, permitting kernel memory
> corruption via splice().  But it doesn't just do it on ->write(), also
> on ->read().
>
> As a band-aid, make sure that the ->read() and ->write() handlers can
> not be called in weird contexts (kernel context or credentials
> different from file opener), like for ib_safe_file_access().

Applied to 4.18/scsi-fixes with the naming fix pointed out by Doug.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
