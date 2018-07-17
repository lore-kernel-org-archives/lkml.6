Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C190ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3366F208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3366F208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeGQBEM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:04:12 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:36781 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbeGQBEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:04:12 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6H0YBcg011770
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 09:34:11 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H0YBYQ015692;
        Tue, 17 Jul 2018 09:34:11 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6H0Wqxc004895;
        Tue, 17 Jul 2018 09:34:11 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1970953; Tue, 17 Jul 2018 09:27:33 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Tue,
 17 Jul 2018 09:27:32 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] mm: soft-offline: close the race against page
 allocation
Thread-Topic: [PATCH v1 2/2] mm: soft-offline: close the race against page
 allocation
Thread-Index: AQHUGllLPw0CmtrOu0aJXCyoyx0DG6SNB8YAgAT2jYA=
Date:   Tue, 17 Jul 2018 00:27:31 +0000
Message-ID: <20180717002731.GA11433@hori1.linux.bs1.fc.nec.co.jp>
References: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531452366-11661-3-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180713134002.a365049a79d41be3c28916cc@linux-foundation.org>
In-Reply-To: <20180713134002.a365049a79d41be3c28916cc@linux-foundation.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <317E8E8C8B68C64890D63BEBEA885BB8@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 01:40:02PM -0700, Andrew Morton wrote:
> On Fri, 13 Jul 2018 12:26:06 +0900 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> 
> > A process can be killed with SIGBUS(BUS_MCEERR_AR) when it tries to
> > allocate a page that was just freed on the way of soft-offline.
> > This is undesirable because soft-offline (which is about corrected error)
> > is less aggressive than hard-offline (which is about uncorrected error),
> > and we can make soft-offline fail and keep using the page for good reason
> > like "system is busy."
> > 
> > Two main changes of this patch are:
> > 
> > - setting migrate type of the target page to MIGRATE_ISOLATE. As done
> >   in free_unref_page_commit(), this makes kernel bypass pcplist when
> >   freeing the page. So we can assume that the page is in freelist just
> >   after put_page() returns,
> > 
> > - setting PG_hwpoison on free page under zone->lock which protects
> >   freelists, so this allows us to avoid setting PG_hwpoison on a page
> >   that is decided to be allocated soon.
> > 
> >
> > ...
> >
> > +
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +/*
> > + * Set PG_hwpoison flag if a given page is confirmed to be a free page
> > + * within zone lock, which prevents the race against page allocation.
> > + */
> 
> I think this is clearer?
> 
> --- a/mm/page_alloc.c~mm-soft-offline-close-the-race-against-page-allocation-fix
> +++ a/mm/page_alloc.c
> @@ -8039,8 +8039,9 @@ bool is_free_buddy_page(struct page *pag
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  /*
> - * Set PG_hwpoison flag if a given page is confirmed to be a free page
> - * within zone lock, which prevents the race against page allocation.
> + * Set PG_hwpoison flag if a given page is confirmed to be a free page.  This
> + * test is performed under the zone lock to prevent a race against page
> + * allocation.

Yes, I like it.

Thanks,
Naoya Horiguchi
