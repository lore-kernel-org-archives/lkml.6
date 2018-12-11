Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29991C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8122081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QGi+QdbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8122081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLKOcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:32:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52138 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLKOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:32:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBETAom006665;
        Tue, 11 Dec 2018 14:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=m+Zf5zXhqqcZnAonM3pAyyoQDDBxc7KpArPKl3Rjkic=;
 b=QGi+QdbYPOrZgZptgoAmEhOayAotXgqRgtvPhGgPjEanM8Xm2cQBd7QrKFrSBnZ5MqOP
 i+NBYeRQeymO4WGAWEf/oQx8EG0Y38yMsAq19+IqtwUhL4/RYG/ZzcAUvzYzkAlCJjgG
 hfdY4WOyQtVMw8LAFBzhIFRbFqPmNdK6oTzWSWJLhUIdiDLOW7FlKLdYTWYLOgZRvat9
 pNctAwfUkYsCxUAXsOSwpkcvHs6Q6VMfsQHAOjYOLJxCvOUjggEYNX9DB637Flttiol1
 rru9C7A94bgMdGr2wuaI404O6YY5BLygxns22r4LWfUimE1yHLJ82bvOlcZTPc9Ux9cg aA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p86kqv3fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 14:32:11 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBBEW9sS030308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 14:32:10 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBBEW9FH010030;
        Tue, 11 Dec 2018 14:32:09 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 06:32:08 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 2/2] swap: Deal with PTE mapped THP when unuse PTE
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181211084609.19553-2-ying.huang@intel.com>
Date:   Tue, 11 Dec 2018 07:32:07 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77D903B4-E63F-4633-8D5B-C39EFC067FB8@oracle.com>
References: <20181211084609.19553-1-ying.huang@intel.com>
 <20181211084609.19553-2-ying.huang@intel.com>
To:     Huang Ying <ying.huang@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> ---
> mm/swapfile.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 7464d0a92869..9e6da494781f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1921,10 +1921,8 @@ static int unuse_pte_range(struct =
vm_area_struct *vma, pmd_t *pmd,
> 			goto out;
> 		}
>=20
> -		if (PageSwapCache(page) && (swap_count(*swap_map) =3D=3D =
0))
> -			delete_from_swap_cache(compound_head(page));
> +		try_to_free_swap(page);
>=20
> -		SetPageDirty(page);
> 		unlock_page(page);
> 		put_page(page);
>=20
> --=20
> 2.18.1
>=20

Since try_to_free_swap() can return 0 under certain error conditions, =
you should check
check for a return status of 1 before calling unlock_page() and =
put_page().

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
