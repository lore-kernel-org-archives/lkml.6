Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g5aUM/On"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfBOOtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:49:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58574 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfBOOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:49:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1FEhRvN145107;
        Fri, 15 Feb 2019 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LEY7b8sXzNhyukf/ItsQKn6GFmrxWnF+Kj6inOmoBHc=;
 b=g5aUM/On3juV/6dNCJ2/OPN3ycrzeV3k+bTRNIwfJ5yfySj0ogZ65V6Ery9ajs+y+1K6
 xQDwcYHlLsxTVGxBV8ZWA3LT2FJhKKd2yIk4Ltc2YEVL1Q8qeDbrVX4rnZKdxo60pC2h
 a+9qBgfNukozi/KUtGkG6l3uJCPI0dsggN1RLy/LdTqBKeYBM6/LDe8OCznIOKL0sGnt
 dSfomHBKKf5Dzv2Zrv1yTCgOfa8hasNabaEVOnl+MwIQ+1JpEb/91xKVgN9JLyGsclyL
 3+8N2FM42kLuumKB62tz2JlM/ZeCqYl8mlM8oMcSNa/aJxdVwcgE7ZEbX+Y+ODel/LYk pQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrekx7nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 14:47:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1FEliLE020615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 14:47:44 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1FEldPL008491;
        Fri, 15 Feb 2019 14:47:39 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 14:47:39 +0000
Subject: Re: [RFC PATCH v8 08/14] arm64/mm: disable section/contiguous
 mappings if XPFO is enabled
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com, Tycho Andersen <tycho@docker.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <0b9624b6c1fe5a31d73a6390e063d551bfebc321.1550088114.git.khalid.aziz@oracle.com>
 <20190215130942.GD53520@lakrids.cambridge.arm.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <259cac45-3337-d446-5abc-21b694d916e1@oracle.com>
Date:   Fri, 15 Feb 2019 07:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215130942.GD53520@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 6:09 AM, Mark Rutland wrote:
> Hi,
>=20
> On Wed, Feb 13, 2019 at 05:01:31PM -0700, Khalid Aziz wrote:
>> From: Tycho Andersen <tycho@docker.com>
>>
>> XPFO doesn't support section/contiguous mappings yet, so let's disable=
 it
>> if XPFO is turned on.
>>
>> Thanks to Laura Abbot for the simplification from v5, and Mark Rutland=
 for
>> pointing out we need NO_CONT_MAPPINGS too.
>>
>> CC: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Tycho Andersen <tycho@docker.com>
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>=20
> There should be no point in this series where it's possible to enable a=

> broken XPFO. Either this patch should be merged into the rest of the
> arm64 bits, or it should be placed before the rest of the arm64 bits.
>=20
> That's a pre-requisite for merging, and it significantly reduces the
> burden on reviewers.
>=20
> In general, a patch series should bisect cleanly. Could you please
> restructure the series to that effect?
>=20
> Thanks,
> Mark.

That sounds reasonable to me. I will merge this with patch 5 ("arm64/mm:
Add support for XPFO") for the next version unless there are objections.

Thanks,
Khalid

>=20
>> ---
>>  arch/arm64/mm/mmu.c  | 2 +-
>>  include/linux/xpfo.h | 4 ++++
>>  mm/xpfo.c            | 6 ++++++
>>  3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index d1d6601b385d..f4dd27073006 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -451,7 +451,7 @@ static void __init map_mem(pgd_t *pgdp)
>>  	struct memblock_region *reg;
>>  	int flags =3D 0;
>> =20
>> -	if (debug_pagealloc_enabled())
>> +	if (debug_pagealloc_enabled() || xpfo_enabled())
>>  		flags =3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> =20
>>  	/*
>> diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
>> index 1ae05756344d..8b029918a958 100644
>> --- a/include/linux/xpfo.h
>> +++ b/include/linux/xpfo.h
>> @@ -47,6 +47,8 @@ void xpfo_temp_map(const void *addr, size_t size, vo=
id **mapping,
>>  void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
>>  		     size_t mapping_len);
>> =20
>> +bool xpfo_enabled(void);
>> +
>>  #else /* !CONFIG_XPFO */
>> =20
>>  static inline void xpfo_kmap(void *kaddr, struct page *page) { }
>> @@ -69,6 +71,8 @@ static inline void xpfo_temp_unmap(const void *addr,=
 size_t size,
>>  }
>> =20
>> =20
>> +static inline bool xpfo_enabled(void) { return false; }
>> +
>>  #endif /* CONFIG_XPFO */
>> =20
>>  #endif /* _LINUX_XPFO_H */
>> diff --git a/mm/xpfo.c b/mm/xpfo.c
>> index 92ca6d1baf06..150784ae0f08 100644
>> --- a/mm/xpfo.c
>> +++ b/mm/xpfo.c
>> @@ -71,6 +71,12 @@ struct page_ext_operations page_xpfo_ops =3D {
>>  	.init =3D init_xpfo,
>>  };
>> =20
>> +bool __init xpfo_enabled(void)
>> +{
>> +	return !xpfo_disabled;
>> +}
>> +EXPORT_SYMBOL(xpfo_enabled);
>> +
>>  static inline struct xpfo *lookup_xpfo(struct page *page)
>>  {
>>  	struct page_ext *page_ext =3D lookup_page_ext(page);
>> --=20
>> 2.17.1
>>


