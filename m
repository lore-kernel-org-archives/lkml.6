Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADDCC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8105D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="baCqA3X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8105D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeILF5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:57:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38116 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILF5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:57:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8C0s1e5035771;
        Wed, 12 Sep 2018 00:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8cDRWe7R5sXR81o+5KBRIwTp0E+ha/GOwJKTcAwHHzQ=;
 b=baCqA3X2YpkaqIud0zIWRS7RehRIWL/g1tyN4Qre42RXoUZZaTtgK1/CJE9+djzF3QeY
 vzH7ACf4nqyEF4bCk23WZ+0qv0BDJApukX+e9bt7PUOYCx785cmH7/RnWTBp8GXzjWHI
 zERSo8s6gN6aJroI6fpQWMphPFAFUyEJUfZN1m0ppRlO3w/1dojn6NQjjJh9j9mwOsXg
 GE60Uab5uKD/tghbSkkcOFKcAmekpg2X2G+2pMqENuQUjUTLavveeIMVnCfOyf78Ptvd
 ylU850vqmz/hri7KB+3O1Jon4CKRMtNTSRBlKPn1OSrKp/c25GFP0qH7ImGt2PmbC8vg SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72qq7sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:55:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0tcqG001478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:55:38 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0taih023399;
        Wed, 12 Sep 2018 00:55:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 17:55:36 -0700
To:     Matthew Wilcox <willy6545@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        george.kennedy@oracle.com, Matthew Wilcox <matthew@wil.cx>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sym53c8xx: fix NULL pointer dereference panic in sym_int_sir() in sym_hipd.c
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1535557096-1324-1-git-send-email-george.kennedy@oracle.com>
        <CAHp75Vc=Fg165nL+SFDXXDzBvtba+C7CLK24gyz3EaAb8QdjNQ@mail.gmail.com>
        <CAFhKne_MtbSKXTT2e+CXZGs_uVieqsfX2ODc8hc5ptdAn8_ETg@mail.gmail.com>
Date:   Tue, 11 Sep 2018 20:55:34 -0400
In-Reply-To: <CAFhKne_MtbSKXTT2e+CXZGs_uVieqsfX2ODc8hc5ptdAn8_ETg@mail.gmail.com>
        (Matthew Wilcox's message of "Thu, 30 Aug 2018 09:40:28 -0700")
Message-ID: <yq1o9d3y1o9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=547
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

> I don't think that's worth doing. Let's keep the patch simple like
> this.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
