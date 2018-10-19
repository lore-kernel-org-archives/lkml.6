Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB482C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B8020645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B8020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJSKGY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:06:24 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:41526 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:06:24 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w9J21umX007134
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 19 Oct 2018 11:01:56 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9J21uZb028123;
        Fri, 19 Oct 2018 11:01:56 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9J21Ame003402;
        Fri, 19 Oct 2018 11:01:56 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-4688595; Fri, 19 Oct 2018 10:59:32 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Fri,
 19 Oct 2018 10:59:31 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "punit.agrawal@arm.com" <punit.agrawal@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Steven.Price@arm.com" <Steven.Price@arm.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH V2 2/5] mm/hugetlb: Distinguish between migratability
 and movability
Thread-Topic: [PATCH V2 2/5] mm/hugetlb: Distinguish between migratability
 and movability
Thread-Index: AQHUYeAhh+l78BzFeEGRzFlmEYQ+5aUlRB+A
Date:   Fri, 19 Oct 2018 01:59:31 +0000
Message-ID: <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <0D6086D1CF56CC48B332AC9789ACCB2B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:29:56AM +0530, Anshuman Khandual wrote:
> During huge page allocation it's migratability is checked to determine if
> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
> movability aspect of the huge page could depend on other factors than just
> migratability. Movability in itself is a distinct property which should not
> be tied with migratability alone.
> 
> This differentiates these two and implements an enhanced movability check
> which also considers huge page size to determine if it is feasible to be
> placed under a movable zone. At present it just checks for gigantic pages
> but going forward it can incorporate other enhanced checks.

(nitpicking...)
The following code just checks hugepage_migration_supported(), so maybe
s/Movability/Migratability/ is expected in the comment?

  static int unmap_and_move_huge_page(...)
  {
          ...
          /*
           * Movability of hugepages depends on architectures and hugepage size.
           * This check is necessary because some callers of hugepage migration
           * like soft offline and memory hotremove don't walk through page
           * tables or check whether the hugepage is pmd-based or not before
           * kicking migration.
           */
          if (!hugepage_migration_supported(page_hstate(hpage))) {

Thanks,
Naoya Horiguchi

> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/hugetlb.h | 30 ++++++++++++++++++++++++++++++
>  mm/hugetlb.c            |  2 +-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 9c1b77f..456cb60 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -493,6 +493,31 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  #endif
>  }
>  
> +/*
> + * Movability check is different as compared to migration check.
> + * It determines whether or not a huge page should be placed on
> + * movable zone or not. Movability of any huge page should be
> + * required only if huge page size is supported for migration.
> + * There wont be any reason for the huge page to be movable if
> + * it is not migratable to start with. Also the size of the huge
> + * page should be large enough to be placed under a movable zone
> + * and still feasible enough to be migratable. Just the presence
> + * in movable zone does not make the migration feasible.
> + *
> + * So even though large huge page sizes like the gigantic ones
> + * are migratable they should not be movable because its not
> + * feasible to migrate them from movable zone.
> + */
> +static inline bool hugepage_movable_supported(struct hstate *h)
> +{
> +	if (!hugepage_migration_supported(h))
> +		return false;
> +
> +	if (hstate_is_gigantic(h))
> +		return false;
> +	return true;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> @@ -589,6 +614,11 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>  	return false;
>  }
>  
> +static inline bool hugepage_movable_supported(struct hstate *h)
> +{
> +	return false;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3c21775..a5a111d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -919,7 +919,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  /* Movability of hugepages depends on migration support. */
>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>  {
> -	if (hugepage_migration_supported(h))
> +	if (hugepage_movable_supported(h))
>  		return GFP_HIGHUSER_MOVABLE;
>  	else
>  		return GFP_HIGHUSER;
> -- 
> 2.7.4
> 
> 
