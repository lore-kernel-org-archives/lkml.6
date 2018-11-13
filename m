Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524ADC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199CB2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199CB2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbeKML3V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:29:21 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:55948 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKML3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:29:21 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD1XIrD009934
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 10:33:18 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD1XIA9012740;
        Tue, 13 Nov 2018 10:33:18 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD1URDa020044;
        Tue, 13 Nov 2018 10:33:18 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5449202; Tue, 13 Nov 2018 10:32:16 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 10:32:15 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Laurent Dufour" <ldufour@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v1 10/11] mm: clear PageHWPoison in memory hotremove
Thread-Topic: [RFC][PATCH v1 10/11] mm: clear PageHWPoison in memory
 hotremove
Thread-Index: AQHUevC1WE7Ov12NQki9D02l1L5ksg==
Date:   Tue, 13 Nov 2018 01:32:15 +0000
Message-ID: <20181113013214.GA14528@hori1.linux.bs1.fc.nec.co.jp>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-11-git-send-email-n-horiguchi@ah.jp.nec.com>
In-Reply-To: <1541746035-13408-11-git-send-email-n-horiguchi@ah.jp.nec.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DA34DA41D102784C949AFD4B4E0EBFD8@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:47:14PM +0900, Naoya Horiguchi wrote:
> One hopeful usecase of memory hotplug is to replace half-broken DIMMs
> with new ones, so it makes sense to clear hwpoison info at the time of
> memory hotremove.
> 
> I hope that this patch covers the topic discussed in
> https://lkml.org/lkml/2018/1/17/1228
> 
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
> index 970d6ff..27826b3 100644
> --- v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c
> +++ v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
> @@ -8139,8 +8139,9 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		 * The HWPoisoned page may be not in buddy system, and
>  		 * page_count() is not 0.
>  		 */
> -		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
> +		if (unlikely(!PageBuddy(page) && TestClearPageHWPoison(page))) {
>  			pfn++;
> +			num_poisoned_pages_dec();
>  			SetPageReserved(page);
>  			continue;
>  		}

Kbuild test robot shows that this patch causes build errors on
!CONFIG_MEMORY_FAILURE, which should be fixed by the following changes.

Thanks,
Naoya Horiguchi
---
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6c496dab246d..559092915fe6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2785,6 +2785,10 @@ static inline void num_poisoned_pages_dec(void)
 {
 	atomic_long_dec(&num_poisoned_pages);
 }
+#else
+static inline void num_poisoned_pages_dec(void)
+{
+}
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ab0bde073050..1461384aa1a3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -385,6 +385,7 @@ extern bool set_hwpoison_free_buddy_page(struct page *page);
 extern bool clear_hwpoison_free_buddy_page(struct page *page);
 #else
 PAGEFLAG_FALSE(HWPoison)
+TESTCLEARFLAG_FALSE(HWPoison)
 static inline bool set_hwpoison_free_buddy_page(struct page *page)
 {
 	return false;
