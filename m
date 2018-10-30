Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286DDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF51520657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF51520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJ3PsR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:48:17 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:57132 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeJ3PsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:48:17 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w9U6tkeV024245
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Oct 2018 15:55:46 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9U6tkDD014360;
        Tue, 30 Oct 2018 15:55:46 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9U6rARW002869;
        Tue, 30 Oct 2018 15:55:46 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5018466; Tue, 30 Oct 2018 15:54:35 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Tue,
 30 Oct 2018 15:54:34 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 0/2] mm: soft-offline: fix race against page
 allocation
Thread-Topic: [PATCH v2 0/2] mm: soft-offline: fix race against page
 allocation
Thread-Index: AQHUNOlnrqT+pxWFwUe9BDyggy7ShKTKcMQAgGc3NyeABZIlgA==
Date:   Tue, 30 Oct 2018 06:54:33 +0000
Message-ID: <20181030065433.GA1119@hori1.linux.bs1.fc.nec.co.jp>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180815154334.f3eecd1029a153421631413a@linux-foundation.org>
 <20180822013748.GA10343@hori1.linux.bs1.fc.nec.co.jp>
 <20180822080025.GD29735@dhcp22.suse.cz>
 <20181026084636.GY18839@dhcp22.suse.cz>
In-Reply-To: <20181026084636.GY18839@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <7022FA189286CD4F87E4A444A2A70611@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 10:46:36AM +0200, Michal Hocko wrote:
> On Wed 22-08-18 10:00:25, Michal Hocko wrote:
> > On Wed 22-08-18 01:37:48, Naoya Horiguchi wrote:
> > > On Wed, Aug 15, 2018 at 03:43:34PM -0700, Andrew Morton wrote:
> > > > On Tue, 17 Jul 2018 14:32:30 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> > > > 
> > > > > I've updated the patchset based on feedbacks:
> > > > > 
> > > > > - updated comments (from Andrew),
> > > > > - moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to mm/memory-failure.c,
> > > > >   which is necessary to check the return code of set_hwpoison_free_buddy_page(),
> > > > > - lkp bot reported a build error when only 1/2 is applied.
> > > > > 
> > > > >   >    mm/memory-failure.c: In function 'soft_offline_huge_page':
> > > > >   > >> mm/memory-failure.c:1610:8: error: implicit declaration of function
> > > > >   > 'set_hwpoison_free_buddy_page'; did you mean 'is_free_buddy_page'?
> > > > >   > [-Werror=implicit-function-declaration]
> > > > >   >        if (set_hwpoison_free_buddy_page(page))
> > > > >   >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >   >            is_free_buddy_page
> > > > >   >    cc1: some warnings being treated as errors
> > > > > 
> > > > >   set_hwpoison_free_buddy_page() is defined in 2/2, so we can't use it
> > > > >   in 1/2. Simply doing s/set_hwpoison_free_buddy_page/!TestSetPageHWPoison/
> > > > >   will fix this.
> > > > > 
> > > > > v1: https://lkml.org/lkml/2018/7/12/968
> > > > > 
> > > > 
> > > > Quite a bit of discussion on these two, but no actual acks or
> > > > review-by's?
> > > 
> > > Really sorry for late response.
> > > Xishi provided feedback on previous version, but no final ack/reviewed-by.
> > > This fix should work on the reported issue, but rewriting soft-offlining
> > > without PageHWPoison flag would be the better fix (no actual patch yet.)
> > 
> > If we can go with the later the I would obviously prefer that. I cannot
> > promise to work on the patch though. I can help with reviewing of
> > course.
> > 
> > If this is important enough that people are hitting the issue in normal
> > workloads then sure, let's go with the simple fix and continue on top of
> > that.
> 
> Naoya, did you have any chance to look at this or have any plans to look?
> I am willing to review and help with the overal design but I cannot
> really promise to work on the code.

I have a draft version of a patch to isolate a page in buddy-friendly manner
without PageHWPoison flag (that was written weeks ago, but I couldn't finish
because my other project interrupted me ...).
I'll post it after testing, especially confirming that hotplug code properly
reset the isolated page.

Thanks,
Naoya Horiguchi
