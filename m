Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548DFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99920BF3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99920BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHVLYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:24:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:57010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727992AbeHVLYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:24:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21AE0AEE1;
        Wed, 22 Aug 2018 08:00:27 +0000 (UTC)
Date:   Wed, 22 Aug 2018 10:00:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 0/2] mm: soft-offline: fix race against page allocation
Message-ID: <20180822080025.GD29735@dhcp22.suse.cz>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180815154334.f3eecd1029a153421631413a@linux-foundation.org>
 <20180822013748.GA10343@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822013748.GA10343@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 01:37:48, Naoya Horiguchi wrote:
> On Wed, Aug 15, 2018 at 03:43:34PM -0700, Andrew Morton wrote:
> > On Tue, 17 Jul 2018 14:32:30 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> > 
> > > I've updated the patchset based on feedbacks:
> > > 
> > > - updated comments (from Andrew),
> > > - moved calling set_hwpoison_free_buddy_page() from mm/migrate.c to mm/memory-failure.c,
> > >   which is necessary to check the return code of set_hwpoison_free_buddy_page(),
> > > - lkp bot reported a build error when only 1/2 is applied.
> > > 
> > >   >    mm/memory-failure.c: In function 'soft_offline_huge_page':
> > >   > >> mm/memory-failure.c:1610:8: error: implicit declaration of function
> > >   > 'set_hwpoison_free_buddy_page'; did you mean 'is_free_buddy_page'?
> > >   > [-Werror=implicit-function-declaration]
> > >   >        if (set_hwpoison_free_buddy_page(page))
> > >   >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   >            is_free_buddy_page
> > >   >    cc1: some warnings being treated as errors
> > > 
> > >   set_hwpoison_free_buddy_page() is defined in 2/2, so we can't use it
> > >   in 1/2. Simply doing s/set_hwpoison_free_buddy_page/!TestSetPageHWPoison/
> > >   will fix this.
> > > 
> > > v1: https://lkml.org/lkml/2018/7/12/968
> > > 
> > 
> > Quite a bit of discussion on these two, but no actual acks or
> > review-by's?
> 
> Really sorry for late response.
> Xishi provided feedback on previous version, but no final ack/reviewed-by.
> This fix should work on the reported issue, but rewriting soft-offlining
> without PageHWPoison flag would be the better fix (no actual patch yet.)

If we can go with the later the I would obviously prefer that. I cannot
promise to work on the patch though. I can help with reviewing of
course.

If this is important enough that people are hitting the issue in normal
workloads then sure, let's go with the simple fix and continue on top of
that.
-- 
Michal Hocko
SUSE Labs
