Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3E2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE3E2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeKMRoP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:44:15 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:34065 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbeKMRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:44:14 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD7lH1x027025
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 16:47:17 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD7lHPS000734;
        Tue, 13 Nov 2018 16:47:17 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD7l0Y0027889;
        Tue, 13 Nov 2018 16:47:17 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-5519007; Tue, 13 Nov 2018 16:46:43 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 16:46:42 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Yongkai Wu <nic.wuyk@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/hwpoison: fix incorrect call put_hwpoison_page()
 when isolate_huge_page() return false
Thread-Topic: [PATCH] mm/hwpoison: fix incorrect call put_hwpoison_page()
 when isolate_huge_page() return false
Thread-Index: AQHUex6Ma11/GXPqe0yWS9n975U8L6VMvOqA
Date:   Tue, 13 Nov 2018 07:46:41 +0000
Message-ID: <20181113074641.GA7645@hori1.linux.bs1.fc.nec.co.jp>
References: <CAJtqMcZVQFp8U0aFqrMDD2-UGuLkWYvg3rytcCswnOT_ZMSzjQ@mail.gmail.com>
In-Reply-To: <CAJtqMcZVQFp8U0aFqrMDD2-UGuLkWYvg3rytcCswnOT_ZMSzjQ@mail.gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <4753732714411E4CAE164C0F4FCE3269@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 03:00:09PM +0800, Yongkai Wu wrote:
> when isolate_huge_page() return false,it won't takes a refcount of page,
> if we call put_hwpoison_page() in that case,we may hit the VM_BUG_ON_PAGE!
> 
> Signed-off-by: Yongkai Wu <nic_w@163.com>
> ---
>  mm/memory-failure.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 0cd3de3..ed09f56 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1699,12 +1699,13 @@ static int soft_offline_huge_page(struct page *page,
> int flags)
>   unlock_page(hpage);
>  
>   ret = isolate_huge_page(hpage, &pagelist);
> - /*
> - * get_any_page() and isolate_huge_page() takes a refcount each,
> - * so need to drop one here.
> - */
> - put_hwpoison_page(hpage);
> - if (!ret) {
> + if (ret) {
> +        /*
> +          * get_any_page() and isolate_huge_page() takes a refcount each,
> +          * so need to drop one here.
> +        */
> + put_hwpoison_page(hpage);
> + } else {

Hi Yongkai,

Although the current code might look odd, it's OK. We have to release
one refcount whether this isolate_huge_page() succeeds or not, because
the put_hwpoison_page() is cancelling the refcount from get_any_page()
which always succeeds when we enter soft_offline_huge_page().

Let's consider that the isolate_huge_page() fails with your patch applied,
then the refcount taken by get_any_page() is never released after returning
from soft_offline_page(). That will lead to memory leak.

I think that current code comment doesn't explaing it well, so if you
like, you can fix the comment.  (If you do that, please check coding style.
scripts/checkpatch.pl will help you.)

Thanks,
Naoya Horiguchi
