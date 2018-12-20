Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01D6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9F9218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAaBem/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbeLTVAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:00:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35724 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbeLTVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:00:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBKKx0NI155791;
        Thu, 20 Dec 2018 21:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=cU/xnRyvdnIdqVnQb1f6AS1w+Ej/bdwikiP1QO5HvR0=;
 b=OAaBem/13NJgHKkNLEgySXNfK2mLEILb/4dlhbKFrJbh4a/h6EiBvRV/8tCi8tEoxV5P
 M5JF2/cEFOTbPn2aotP/CES+KuXHb7jABFOdoh9XTSLiscmYJCNcipFPKUSqBlGrruJD
 PTacKY/Dpq/jcFOQo8DsA+rkfRO3eHE+KYgKnmJ9RTR6tIuPC0TljAU/LaZEvk12X01/
 GBIhPstc2o/hqV7i4CH9ywVtXNwNg0gPB3m0c7U+Z6sdkI2x12G+bZryzKNO/Vwq5ELt
 bQyHtHy2pSN4MuTYRNAuLaIJAYmrMO1WAm+dP5MZqZzLQmZogIdYFpuZ0srSScNyqk3M yw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pfh3a9deh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 21:00:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBKL0EsU002531
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 21:00:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBKL0BEu020934;
        Thu, 20 Dec 2018 21:00:12 GMT
Received: from dhcp-10-65-162-91.vpn.oracle.com (/10.65.162.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 13:00:11 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181220203156.43441-1-cai@lca.pw>
Date:   Thu, 20 Dec 2018 14:00:10 -0700
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        Pavel.Tatashin@microsoft.com, mingo@kernel.org, hpa@zytor.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com,
        yang.shi@linaro.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E084FF0A-88CD-4E61-88F2-7D542D67DDF1@oracle.com>
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=73 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 20, 2018, at 1:31 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index ae44f7adbe07..d76fd51e312a 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
> 			 * -------------pfn-------------->
> 			 * N0 | N1 | N2 | N0 | N1 | N2|....
> 			 *
> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
> 			 */
> -			if (early_pfn_to_nid(pfn) !=3D nid)
> +			if (pfn_to_nid(pfn) !=3D nid)
> 				continue;
> 			if (init_section_page_ext(pfn, nid))
> 				goto oom;
> --=20
> 2.17.2 (Apple Git-113)
>=20

Is there any danger in the fact that in the CONFIG_NUMA case in mmzone.h =
(around line 1261), pfn_to_nid() calls page_to_nid(), possibly causing =
the same issue seen in v2?

