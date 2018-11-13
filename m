Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094BFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8836224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8836224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeKMKRN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:17:13 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:41011 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbeKMKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:17:12 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD0LHFs016707
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 09:21:17 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0LHml027819;
        Tue, 13 Nov 2018 09:21:17 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0K0Go021299;
        Tue, 13 Nov 2018 09:21:17 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5486924; Tue, 13 Nov 2018 09:18:56 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 09:18:55 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Laurent Dufour" <ldufour@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v1 04/11] mm: madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Thread-Topic: [RFC][PATCH v1 04/11] mm: madvise: call soft_offline_page()
 without MF_COUNT_INCREASED
Thread-Index: AQHUd/gbu+owDBS+uE6QSKhtcOyj6aVGrD+AgAWZ3oA=
Date:   Tue, 13 Nov 2018 00:18:55 +0000
Message-ID: <20181113001855.GC5945@hori1.linux.bs1.fc.nec.co.jp>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-5-git-send-email-n-horiguchi@ah.jp.nec.com>
 <21e5b9ca-ad72-b0d5-3397-4b65831b236b@arm.com>
In-Reply-To: <21e5b9ca-ad72-b0d5-3397-4b65831b236b@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <49E40B2BBA888A4BB7E66ACE16F63DEE@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 04:16:55PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> > Currently madvise_inject_error() pins the target page when calling
> > memory error handler, but it's not good because the refcount is just
> > an artifact of error injector and mock nothing about hw error itself.
> > IOW, pinning the error page is part of error handler's task, so
> > let's stop doing it.
> 
> Did not get that. Could you please kindly explain how an incremented
> ref count through get_user_pages_fast() was a mocking the HW error
> previously ? Though I might be missing the some context here.

I meant in "mock nothing about hw error itself" that in the code path
for actual HW error (from MCE handler code) the error page is not pinned
outside (but inside) memory_failure().
So it makes more sense to me to do similarly also in error injection code,
and another good thing is that that makes code more simple (A later patch
eliminates MF_COUNT_INCREASED.)

> 
> > 
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > ---
> >  mm/madvise.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git v4.19-mmotm-2018-10-30-16-08/mm/madvise.c v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
> > index 6cb1ca9..9fa0225 100644
> > --- v4.19-mmotm-2018-10-30-16-08/mm/madvise.c
> > +++ v4.19-mmotm-2018-10-30-16-08_patched/mm/madvise.c
> > @@ -637,6 +637,16 @@ static int madvise_inject_error(int behavior,
> >  		ret = get_user_pages_fast(start, 1, 0, &page);
> >  		if (ret != 1)
> >  			return ret;
> > +		/*
> > +		 * The get_user_pages_fast() is just to get the pfn of the
> > +		 * given address, and the refcount has nothing to do with
> > +		 * what we try to test, so it should be released immediately.
> > +		 * This is racy but it's intended because the real hardware
> > +		 * errors could happen at any moment and memory error handlers
> > +		 * must properly handle the race.
> > +		 */
> > +		put_page(page);
> > +
> >  		pfn = page_to_pfn(page);
> >  
> >  		/*
> > @@ -646,16 +656,11 @@ static int madvise_inject_error(int behavior,
> >  		 */
> >  		order = compound_order(compound_head(page));
> >  
> > -		if (PageHWPoison(page)) {
> > -			put_page(page);
> > -			continue;
> > -		}
> > -
> >  		if (behavior == MADV_SOFT_OFFLINE) {
> >  			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
> >  					pfn, start);
> >  
> > -			ret = soft_offline_page(page, MF_COUNT_INCREASED);
> > +			ret = soft_offline_page(page, 0);
> 
> Probably something defined as a new "ignored" in the memory faults flag
> enumeration instead of passing '0' directly.

MF_* flags are defined as bitmap, not separate values. And according to
other caller like do_memory_failure(), multiple bits in flags can be set together.

    static int do_memory_failure(struct mce *m)
    {
            int flags = MF_ACTION_REQUIRED;
            ....
            if (!(m->mcgstatus & MCG_STATUS_RIPV))
                    flags |= MF_MUST_KILL;
            ret = memory_failure(m->addr >> PAGE_SHIFT, flags);

So I think that simply adding new MF_* value doesn't work, and "flags == 0"
seems to me to show "no flag set" in the clearest way.
Or if you have any code suggestion, that's great.

Thanks,
Naoya Horiguchi
