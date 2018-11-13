Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FF1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2D22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB2D22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeKMKRJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:17:09 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54780 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:17:08 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD0LJgL022951
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 09:21:19 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0LJwl026430;
        Tue, 13 Nov 2018 09:21:19 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0Ijo1029359;
        Tue, 13 Nov 2018 09:21:19 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-5489675; Tue, 13 Nov 2018 09:19:09 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 09:19:08 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Laurent Dufour" <ldufour@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v1 11/11] mm: hwpoison: introduce
 clear_hwpoison_free_buddy_page()
Thread-Topic: [RFC][PATCH v1 11/11] mm: hwpoison: introduce
 clear_hwpoison_free_buddy_page()
Thread-Index: AQHUd/gk4LHqKeFY+UKwdfHNwR3/xKVGuSYAgAWNBYA=
Date:   Tue, 13 Nov 2018 00:19:08 +0000
Message-ID: <20181113001907.GD5945@hori1.linux.bs1.fc.nec.co.jp>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-12-git-send-email-n-horiguchi@ah.jp.nec.com>
 <d37c1be2-2069-a147-9ba8-4749cd386d0b@arm.com>
In-Reply-To: <d37c1be2-2069-a147-9ba8-4749cd386d0b@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E98FB80BE4F9824B971DACC8E14BE8C3@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 05:03:06PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> > The new function is a reverse operation of set_hwpoison_free_buddy_page()
> > to adjust unpoison_memory() to the new semantics.
> > 
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> snip
> 
> > +
> > +/*
> > + * Reverse operation of set_hwpoison_free_buddy_page(), which is expected
> > + * to work only on error pages isolated from buddy allocator.
> > + */
> > +bool clear_hwpoison_free_buddy_page(struct page *page)
> > +{
> > +	struct zone *zone = page_zone(page);
> > +	bool unpoisoned = false;
> > +
> > +	spin_lock(&zone->lock);
> > +	if (TestClearPageHWPoison(page)) {
> > +		unsigned long pfn = page_to_pfn(page);
> > +		int migratetype = get_pfnblock_migratetype(page, pfn);
> > +
> > +		__free_one_page(page, pfn, zone, 0, migratetype);
> > +		unpoisoned = true;
> > +	}
> > +	spin_unlock(&zone->lock);
> > +	return unpoisoned;
> > +}
> >  #endif
> > 
> 
> Though there are multiple page state checks in unpoison_memory() leading
> upto clearing HWPoison flag, the page must not be in buddy already if
> __free_one_page() would be called on it.

Yes, you're right.
clear_hwpoison_free_buddy_page() is intended to cancel the isolation by
set_hwpoison_free_buddy_page() which removes the target page from buddy allocator,
so the page clear_hwpoison_free_buddy_page() tries to handle is not a buddy page
actually (not linked to any freelist).

Thanks,
Naoya Horiguchi
