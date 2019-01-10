Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4CE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ya0YYmWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfAJLo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:44:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfAJLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:44:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ABhZga110788;
        Thu, 10 Jan 2019 11:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=n3s1ZAdLR0jBpj/R+OdXMda6knsYE7fX2xsscIoqQG0=;
 b=ya0YYmWdSdbwkeiN3vQqhPLTmCN/rrPap5uTbdpdXZ/U3hjRgwDZ09hZQ2xD5LI/tp6U
 uA1V3GJQ6mph1WBQW6ko8S6+2RLerF7sIC4e6V4adeIO9+rxJTD5ChBwyd60m3lifuqD
 Y3Fo11isnltMnMxuc9guHSfil7Sx6LrXOdo4JOvW+2ePL49fJuQ4YF0ix7VSKxzjNYUR
 e2e9wq33t+4epzNRzb+ffUd5F01BIxKT3bPQGMUgwZPyIsl30+fx7YpqE7vkLwJYiYoQ
 GdlHMXOmAxsH1ZaXvEi/Tse2AAd0ByFxbevzZchC1N7xjeCXiJ4rBBnzUXemL80aytFH Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7r6j8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 11:44:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0ABi5Yt003163
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 11:44:05 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ABi1gt007674;
        Thu, 10 Jan 2019 11:44:01 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 03:44:00 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mm/shmem: make find_get_pages_range() work for huge page
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190110030838.84446-1-yuzhao@google.com>
Date:   Thu, 10 Jan 2019 04:43:57 -0700
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7BE64E0-8F88-46AC-A330-E1AB23A50073@oracle.com>
References: <20190110030838.84446-1-yuzhao@google.com>
To:     Yu Zhao <yuzhao@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2019, at 8:08 PM, Yu Zhao <yuzhao@google.com> wrote:
>=20
> find_get_pages_range() and find_get_pages_range_tag() already
> correctly increment reference count on head when seeing compound
> page, but they may still use page index from tail. Page index
> from tail is always zero, so these functions don't work on huge
> shmem. This hasn't been a problem because, AFAIK, nobody calls
> these functions on (huge) shmem. Fix them anyway just in case.
>=20
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
> mm/filemap.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 81adec8ee02c..cf5fd773314a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1704,7 +1704,7 @@ unsigned find_get_pages_range(struct =
address_space *mapping, pgoff_t *start,
>=20
> 		pages[ret] =3D page;
> 		if (++ret =3D=3D nr_pages) {
> -			*start =3D page->index + 1;
> +			*start =3D xas.xa_index + 1;
> 			goto out;
> 		}
> 		continue;
> @@ -1850,7 +1850,7 @@ unsigned find_get_pages_range_tag(struct =
address_space *mapping, pgoff_t *index,
>=20
> 		pages[ret] =3D page;
> 		if (++ret =3D=3D nr_pages) {
> -			*index =3D page->index + 1;
> +			*index =3D xas.xa_index + 1;
> 			goto out;
> 		}
> 		continue;
> --=20

While this works, it seems like this would be more readable for future =
maintainers were it to
instead squirrel away the value for *start/*index when ret was zero on =
the first iteration through
the loop.

Though xa_index is designed to hold the first index of the entry, it =
seems inappropriate to have
these routines deference elements of xas directly; I guess it depends on =
how opaque we want to keep
xas and struct xa_state.

Does anyone else have a feeling one way or the other? I could be =
persuaded either way.=
