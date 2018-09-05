Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F150EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JXG371kH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D02B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeIEVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:02:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:02:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w85GSrUm148774;
        Wed, 5 Sep 2018 16:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Ffc9c8opSgwLpNSCeb1cbN8AV5Y9wcEm0UD8sfFRgEw=;
 b=JXG371kHG8h7NftVEHYO62I7ZAuMyl5FnsNz7zEANvqc+g5DjDL1VJVTRkObw5k5tARV
 ncr5dF4mMtNu5vSAYJejYFXI0exW61MxlcZlv7UkpzW7bz+YoWydTPPBd4Ze/lC4Z/hO
 PEwPJ/ttD0otgSokdPIBBYdekW24h+gAsczuU1iVqRmXqPZ2Tqd5gsvYiXUWrag1zBJc
 t5Gsia8if574U3M8A/8nYcXZ1R8xAkjIMGuFBFoayjm4Lpu6agdC6znC2yUgfOrb3FEd
 J7t3XQNT4TOjz0bUvSCOypeZ4uuL0VcpSyJu8u630iKEFHNZtG9MNDKLJ5UQkH0rF6yD kw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2m7j6tn725-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 16:31:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w85GVBQT028283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 16:31:11 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w85GVA5F032699;
        Wed, 5 Sep 2018 16:31:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 09:31:10 -0700
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1536137722.4813.66.camel@gmx.de>
        <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
        <yq15zzj3o99.fsf@oracle.com>
Date:   Wed, 05 Sep 2018 12:31:07 -0400
In-Reply-To: <yq15zzj3o99.fsf@oracle.com> (Martin K. Petersen's message of
        "Wed, 05 Sep 2018 12:25:22 -0400")
Message-ID: <yq11sa73nzo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I reverted the two offending changes last week. James just hasn't sent
> Linus a pull request yet...

Actually, he did earlier today.

-- 
Martin K. Petersen	Oracle Linux Engineering
