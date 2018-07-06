Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2697C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9823FDB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D9823FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754035AbeGFITN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:19:13 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:58826 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753658AbeGFITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:19:08 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w668J1Gd004437
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Jul 2018 17:19:01 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w668J0bH000385;
        Fri, 6 Jul 2018 17:19:00 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w668Hp3A004687;
        Fri, 6 Jul 2018 17:19:00 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1751908; Fri, 6 Jul 2018 17:18:48 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Fri, 6
 Jul 2018 17:18:47 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     =?iso-2022-jp?B?GyRCamQ1KUBQGyhCKBskQjUpQFAbKEIp?= 
        <xishi.qiuxishi@alibaba-inc.com>
CC:     linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "zy.zhengyi" <zy.zhengyi@alibaba-inc.com>
Subject: Re: [RFC] a question about reuse hwpoison page in
 soft_offline_page()
Thread-Topic: [RFC] a question about reuse hwpoison page in
 soft_offline_page()
Thread-Index: AQHUFNq0gQJXx38HukimJ6uYcXUta6SBQ1eA
Date:   Fri, 6 Jul 2018 08:18:47 +0000
Message-ID: <20180706081847.GA5144@hori1.linux.bs1.fc.nec.co.jp>
References: <99235479-716d-4c40-8f61-8e44c242abf8.xishi.qiuxishi@alibaba-inc.com>
In-Reply-To: <99235479-716d-4c40-8f61-8e44c242abf8.xishi.qiuxishi@alibaba-inc.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <419F96D9D966E6498748381491C4F00A@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:37:41AM +0800, 裘稀石(稀石) wrote:
> This patch add05cec
> (mm: soft-offline: don't free target page in successful page migration) removes
> set_migratetype_isolate() and unset_migratetype_isolate() in soft_offline_page
> ().
> 
> And this patch 243abd5b
> (mm: hugetlb: prevent reuse of hwpoisoned free hugepages) changes
> if (!is_migrate_isolate_page(page)) to if (!PageHWPoison(page)), so it could
> prevent someone
> reuse the free hugetlb again after set the hwpoison flag
> in soft_offline_free_page()
> 
> My question is that if someone reuse the free hugetlb again before 
> soft_offline_free_page() and
> after get_any_page(), then it uses the hopoison page, and this may trigger mce
> kill later, right?

Hi Xishi,

Thank you for pointing out the issue. That's nice catch.

I think that the race condition itself could happen, but it doesn't lead
to MCE kill because PageHWPoison is not visible to HW which triggers MCE.
PageHWPoison flag is just a flag in struct page to report the memory error
from kernel to userspace. So even if a CPU is accessing to the page whose
struct page has PageHWPoison set, that doesn't cause a MCE unless the page
is physically broken.
The type of memory error that soft offline tries to handle is corrected
one which is not a failure yet although it's starting to wear.
So such PageHWPoison page can be reused, but that's not critical because
the page is freed at some point afterword and error containment completes.

However, I noticed that there's a small pain in free hugetlb case.
We call dissolve_free_huge_page() in soft_offline_free_page() which moves
the PageHWPoison flag from the head page to the raw error page.
If the reported race happens, dissolve_free_huge_page() just return without
doing any dissolve work because "if (PageHuge(page) && !page_count(page))"
block is skipped.
The hugepage is allocated and used as usual, but the contaiment doesn't
complete as expected in the normal page, because free_huge_pages() doesn't
call dissolve_free_huge_page() for hwpoison hugepage. This is not critical
because such error hugepage just reside in free hugepage list. But this
might looks like a kind of memory leak. And even worse when hugepage pool
is shrinked and the hwpoison hugepage is freed, the PageHWPoison flag is
still on the head page which is unlikely to be an actual error page.

So I think we need improvement here, how about the fix like below?

  (not tested yet, sorry)

  diff --git a/mm/memory-failure.c b/mm/memory-failure.c
  --- a/mm/memory-failure.c
  +++ b/mm/memory-failure.c
  @@ -1883,6 +1883,11 @@ static void soft_offline_free_page(struct page *page)
          struct page *head = compound_head(page);
  
          if (!TestSetPageHWPoison(head)) {
  +               if (page_count(head)) {
  +                       ClearPageHWPoison(head);
  +                       return;
  +               }
  +
                  num_poisoned_pages_inc();
                  if (PageHuge(head))
                          dissolve_free_huge_page(page);

Thanks,
Naoya Horiguchi
