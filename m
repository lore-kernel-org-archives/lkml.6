Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA4A20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="05GUcsHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA4A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeLMIZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:25:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54126 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:25:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBD8NvOS186452;
        Thu, 13 Dec 2018 08:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=zOHGAVPpRvnGgzmsTPuq7ntSoRX7Ko67x6uxJpnEnPc=;
 b=05GUcsHDSTsh57Ybbga+MiFX0jFmVnakTitB8PJKSzT5tp+o4zSgEwfOuL41xd0RMK1m
 epDBlxcC5vl7SCCCqLXAbTwFz6VFfP7fD/yEdW51QCdaf/hsoO/AQMgVyq7r4CHxulZl
 rmjQC0srA5V6CSchsnwTM+uVPHw/mGQ//tqy9uj+PEMDuxv9OhMI0pUh6TPOYSRIBbjY
 vUk8vMv5DQigWwC8QhTDG9bkkTaeNOEqcoAVyXbb0ln3xQEz40tvSDPpi6rK7DDQMdVJ
 6utHIqhoSPM3Kn5L2ookclLhbwC/lajtFq4AzVqROUWTKcthintAD15zCGRQEUhbM+K3 tg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2pb3n74f9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 08:24:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBD8Oa1h005712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Dec 2018 08:24:36 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBD8OXS4025456;
        Thu, 13 Dec 2018 08:24:33 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 00:24:33 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] mm: thp: fix flags for pmd migration when split
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181213051510.20306-1-peterx@redhat.com>
Date:   Thu, 13 Dec 2018 01:24:27 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B1C6409-E855-47E4-9D33-3D7C634A47F6@oracle.com>
References: <20181213051510.20306-1-peterx@redhat.com>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=986
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812130078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f2d19e4fe854..aebade83cec9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2145,23 +2145,25 @@ static void __split_huge_pmd_locked(struct =
vm_area_struct *vma, pmd_t *pmd,
> 	 */
> 	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>=20
> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> 	pmd_migration =3D is_pmd_migration_entry(old_pmd);
> -	if (pmd_migration) {
> +	if (unlikely(pmd_migration)) {
> 		swp_entry_t entry;
>=20
> 		entry =3D pmd_to_swp_entry(old_pmd);
> 		page =3D pfn_to_page(swp_offset(entry));
> -	} else
> -#endif
> +		write =3D is_write_migration_entry(entry);
> +		young =3D false;
> +		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
> +	} else {
> 		page =3D pmd_page(old_pmd);
> +		if (pmd_dirty(old_pmd))
> +			SetPageDirty(page);
> +		write =3D pmd_write(old_pmd);
> +		young =3D pmd_young(old_pmd);
> +		soft_dirty =3D pmd_soft_dirty(old_pmd);
> +	}
> 	VM_BUG_ON_PAGE(!page_count(page), page);
> 	page_ref_add(page, HPAGE_PMD_NR - 1);
> -	if (pmd_dirty(old_pmd))
> -		SetPageDirty(page);
> -	write =3D pmd_write(old_pmd);
> -	young =3D pmd_young(old_pmd);
> -	soft_dirty =3D pmd_soft_dirty(old_pmd);
>=20
> 	/*
> 	 * Withdraw the table only after we mark the pmd entry invalid.
> --=20

Looks good.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

