Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE90C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267620842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wcoAN6Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbfBLPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:54:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfBLPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:54:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CFn7Hi093071;
        Tue, 12 Feb 2019 15:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type; s=corp-2018-07-02;
 bh=byLhuTWcAJtsD+8gN5cbHsUplgXHJ5TjR9BbBHliQDY=;
 b=wcoAN6Vmo2y18k2tcw0tBVfKea4IGHuY3FK8HEZhfNhCzsfckC6V94Vzr+ZewIt+MpGQ
 nc8gIJANFXP/n4+kExJYa2Kr6jpsc4vf1RVR/MD0VWtruSTKmhvvXhwJ5+bUlQUT91zh
 S2YaKMEyuY9lPBRgjlqZIR12LUsNtv9yO9AB1NYgK5JstyppWaIws+o6YUMZX9dsCm96
 ZoFWqbNRQmg7bAPK9TWF1VzpWsrHGVt6bbS8pnXi7S6ze7xhW38YenwqrwdOPvoHwZPG
 J+iTsqlWY6dszf7Te/iANEQg7brXIVZMcQCG5NjzoW7oItcRRXwAG9MHWJxAENRorMJB Wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qhrekcry6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 15:52:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1CFquPt031138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 15:52:56 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1CFqsMl011172;
        Tue, 12 Feb 2019 15:52:55 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 07:52:54 -0800
Subject: Re: [RFC PATCH v7 05/16] arm64/mm: Add support for XPFO
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tycho Andersen <tycho@docker.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <89f03091af87f5ab27bd6cafb032236d5bd81d65.1547153058.git.khalid.aziz@oracle.com>
 <20190123142410.GC19289@Konrads-MacBook-Pro.local>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <4dfba458-1bf6-25ff-df4c-b96a1221cd95@oracle.com>
Date:   Tue, 12 Feb 2019 08:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123142410.GC19289@Konrads-MacBook-Pro.local>
Content-Type: multipart/mixed;
 boundary="------------E60D98927E4F6B22818A3147"
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E60D98927E4F6B22818A3147
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 7:24 AM, Konrad Rzeszutek Wilk wrote:
> On Thu, Jan 10, 2019 at 02:09:37PM -0700, Khalid Aziz wrote:
>> From: Juerg Haefliger <juerg.haefliger@canonical.com>
>>
>> Enable support for eXclusive Page Frame Ownership (XPFO) for arm64 and=

>> provide a hook for updating a single kernel page table entry (which is=

>> required by the generic XPFO code).
>>
>> v6: use flush_tlb_kernel_range() instead of __flush_tlb_one()
>>
>> CC: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
>> Signed-off-by: Tycho Andersen <tycho@docker.com>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>  arch/arm64/Kconfig     |  1 +
>>  arch/arm64/mm/Makefile |  2 ++
>>  arch/arm64/mm/xpfo.c   | 58 +++++++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 61 insertions(+)
>>  create mode 100644 arch/arm64/mm/xpfo.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index ea2ab0330e3a..f0a9c0007d23 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -171,6 +171,7 @@ config ARM64
>>  	select SWIOTLB
>>  	select SYSCTL_EXCEPTION_TRACE
>>  	select THREAD_INFO_IN_TASK
>> +	select ARCH_SUPPORTS_XPFO
>>  	help
>>  	  ARM 64-bit (AArch64) Linux support.
>> =20
>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
>> index 849c1df3d214..cca3808d9776 100644
>> --- a/arch/arm64/mm/Makefile
>> +++ b/arch/arm64/mm/Makefile
>> @@ -12,3 +12,5 @@ KASAN_SANITIZE_physaddr.o	+=3D n
>> =20
>>  obj-$(CONFIG_KASAN)		+=3D kasan_init.o
>>  KASAN_SANITIZE_kasan_init.o	:=3D n
>> +
>> +obj-$(CONFIG_XPFO)		+=3D xpfo.o
>> diff --git a/arch/arm64/mm/xpfo.c b/arch/arm64/mm/xpfo.c
>> new file mode 100644
>> index 000000000000..678e2be848eb
>> --- /dev/null
>> +++ b/arch/arm64/mm/xpfo.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
>> + * Copyright (C) 2016 Brown University. All rights reserved.
>> + *
>> + * Authors:
>> + *   Juerg Haefliger <juerg.haefliger@hpe.com>
>> + *   Vasileios P. Kemerlis <vpk@cs.brown.edu>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy it
>> + * under the terms of the GNU General Public License version 2 as pub=
lished by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/module.h>
>> +
>> +#include <asm/tlbflush.h>
>> +
>> +/*
>> + * Lookup the page table entry for a virtual address and return a poi=
nter to
>> + * the entry. Based on x86 tree.
>> + */
>> +static pte_t *lookup_address(unsigned long addr)
>> +{
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +
>> +	pgd =3D pgd_offset_k(addr);
>> +	if (pgd_none(*pgd))
>> +		return NULL;
>> +
>> +	pud =3D pud_offset(pgd, addr);
>> +	if (pud_none(*pud))
>> +		return NULL;
>> +
>> +	pmd =3D pmd_offset(pud, addr);
>> +	if (pmd_none(*pmd))
>> +		return NULL;
>> +
>> +	return pte_offset_kernel(pmd, addr);
>> +}
>> +
>> +/* Update a single kernel page table entry */
>> +inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
>> +{
>> +	pte_t *pte =3D lookup_address((unsigned long)kaddr);
>> +
>> +	set_pte(pte, pfn_pte(page_to_pfn(page), prot));
>=20
> Thought on the other hand.. what if the page is PMD? Do you really want=

> to do this?
>=20
> What if 'pte' is NULL?
>> +}
>> +
>> +inline void xpfo_flush_kernel_tlb(struct page *page, int order)
>> +{
>> +	unsigned long kaddr =3D (unsigned long)page_address(page);
>> +	unsigned long size =3D PAGE_SIZE;
>> +
>> +	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
>=20
> Ditto here. You are assuming it is PTE, but it may be PMD or such.
> Or worts - the lookup_address could be NULL.
>=20
>> +}
>> --=20
>> 2.17.1
>>

Hi Konrad,

This makes sense. x86 version of set_kpte() checks pte for NULL and also
checks if the page is PMD. Now what you said about adding level to
lookup_address() for arm makes more sense.

Can someone with knowledge of arm64 mmu make recommendations here?

Thanks,
Khalid

--------------E60D98927E4F6B22818A3147
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
+Wrj8Rwom6h21PXZRKnlkis7ibQfE+TxqOI7vg=3D=3D
=3DnPqY
-----END PGP PUBLIC KEY BLOCK-----

--------------E60D98927E4F6B22818A3147--
