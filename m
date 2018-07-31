Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE8E208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HVUQnN7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8E208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGaDqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:46:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53464 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbeGaDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:46:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V2446v137427;
        Tue, 31 Jul 2018 02:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=FBu7pvEBYbS2k2YbT5ep9zU7YkMDWOFgXVWyWZJIdtk=;
 b=HVUQnN7GZI8ZDKIa8ptJswUzMYB6v5y2EhM/wwHRjrBPNkAu07nC/ZuW4NVpxDFLT6tX
 AVuq97vDmcuUXXa52PDparleBBmXHb79H0JjB4w5//lIFtV273853ptjP6TJ44ybi64e
 /53fwBz/4v7IgQtb6a75JrlcAaLt2fU8amaSF3FNzaJlNbMjDx+Azyd2m2w1vDWKTw/D
 IBcFMetIVigy2sV05RiOdNn2ErolGVteEg/qFKB/GJ2fxbcT/6tCuBmg9LEKSeIqax7r
 C2uabSHv2ftjNKZzTlEbUpZRUmDeIbWAMuUc2qpZstAQJbfV/9iGl0Q0kHZLwvtLwj6h dQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kge0cy1m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 02:08:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V28UUa022202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 02:08:30 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6V28Shq024605;
        Tue, 31 Jul 2018 02:08:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 19:08:28 -0700
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Adam Radford <aradford@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] scsi: 3ware: fix return 0 on the error path of probe
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180727135157.13051-1-vasilyev@ispras.ru>
Date:   Mon, 30 Jul 2018 22:08:26 -0400
In-Reply-To: <20180727135157.13051-1-vasilyev@ispras.ru> (Anton Vasilyev's
        message of "Fri, 27 Jul 2018 16:51:57 +0300")
Message-ID: <yq1o9eow411.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anton,

> tw_probe() returns 0 in case of fail of tw_initialize_device_extension(),
> pci_resource_start() or tw_reset_sequence() and releases resources.
> twl_probe() returns 0 in case of fail of twl_initialize_device_extension(),
> pci_iomap() and twl_reset_sequence().
> twa_probe() returns 0 in case of fail of tw_initialize_device_extension(),
> ioremap() and twa_reset_sequence().

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
