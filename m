Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A710C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8DC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDKVMaQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8DC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbeKNUiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:38:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeKNUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:38:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAEAYISD180859;
        Wed, 14 Nov 2018 10:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=LQPGZ1ZZBUCslARdxXIXYIzsNi5Lbfm9NhZw89a0no4=;
 b=gDKVMaQLkJzcXfMirq2bxw73RwMVtsjdvXgyqHB9jodPl9UGpKD/lpgALrsOxsjTthaV
 kjojz1wBVak4oyzSBkz/+XGV8YiS0WLrgHbl5d37V9ampnB2fWzGD04Hk5/0Hu9LG/RQ
 /0eiSlPRC45hsBhi7fu7N8gitMJyuoEoBDIvkRKoEixmcnJjEI4LRZGbeY77o9KnW0ws
 lZou4kfVVGK96gwMq2bWmqTrmabWJTruUpe5wfUJZ/6IMXuCM4pxDJYISi6riyxa+HyK
 vdaK0FKWaqU9v0QbJg/hdFWwqMC/QNsVUi/QDmhx7LlOZ/95RTx0FpRwPZSSRAyv3gmF hA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nr7cs2jwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 10:35:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAEAZRXk018137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 10:35:27 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAEAZQlQ000658;
        Wed, 14 Nov 2018 10:35:26 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 02:35:26 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
Date:   Wed, 14 Nov 2018 03:35:25 -0700
Cc:     Kees Cook <keescook@chromium.org>, crecklin@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=780
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 13, 2018, at 5:51 PM, Isaac J. Manjarres =
<isaacm@codeaurora.org> wrote:
>=20
> diff --git a/mm/usercopy.c b/mm/usercopy.c
> index 852eb4e..0293645 100644
> --- a/mm/usercopy.c
> +++ b/mm/usercopy.c
> @@ -151,7 +151,7 @@ static inline void check_bogus_address(const =
unsigned long ptr, unsigned long n,
> 				       bool to_user)
> {
> 	/* Reject if object wraps past end of memory. */
> -	if (ptr + n < ptr)
> +	if (ptr + (n - 1) < ptr)
> 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr =
+ n);

I'm being paranoid, but is it possible this routine could ever be passed =
"n" set to zero?

If so, it will erroneously abort indicating a wrapped address as (n - 1) =
wraps to ULONG_MAX.

Easily fixed via:

	if ((n !=3D 0) && (ptr + (n - 1) < ptr))

William Kucharski=
