Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1ABC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BB520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeLFJRQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:17:16 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:48296 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:17:15 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wB69GxmL001873
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Dec 2018 18:16:59 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB69Gx45029879;
        Thu, 6 Dec 2018 18:16:59 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wB69GxI7006096;
        Thu, 6 Dec 2018 18:16:59 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-411300; Thu, 6 Dec 2018 18:15:54 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Thu, 6
 Dec 2018 18:15:54 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Oscar Salvador <OSalvador@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
Thread-Topic: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages
 to be offlined
Thread-Index: AQHUiu9tY5+24nB+PkGyMm7atS1YiqVvf4kAgABK3wCAAM/4gIAANTgAgAAMOwA=
Date:   Thu, 6 Dec 2018 09:15:53 +0000
Message-ID: <20181206091552.GB26516@hori1.linux.bs1.fc.nec.co.jp>
References: <20181203100309.14784-1-mhocko@kernel.org>
 <20181205122918.GL1286@dhcp22.suse.cz>
 <20181205165716.GS1286@dhcp22.suse.cz>
 <20181206052137.GA28595@hori1.linux.bs1.fc.nec.co.jp>
 <20181206083206.GC1286@dhcp22.suse.cz>
In-Reply-To: <20181206083206.GC1286@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CD9A479AF56DBD4EA4EB6EB94A401617@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:32:06AM +0100, Michal Hocko wrote:
> On Thu 06-12-18 05:21:38, Naoya Horiguchi wrote:
> > On Wed, Dec 05, 2018 at 05:57:16PM +0100, Michal Hocko wrote:
> > > On Wed 05-12-18 13:29:18, Michal Hocko wrote:
> > > [...]
> > > > After some more thinking I am not really sure the above reasoning is
> > > > still true with the current upstream kernel. Maybe I just managed to
> > > > confuse myself so please hold off on this patch for now. Testing by
> > > > Oscar has shown this patch is helping but the changelog might need to be
> > > > updated.
> > > 
> > > OK, so Oscar has nailed it down and it seems that 4.4 kernel we have
> > > been debugging on behaves slightly different. The underlying problem is
> > > the same though. So I have reworded the changelog and added "just in
> > > case" PageLRU handling. Naoya, maybe you have an argument that would
> > > make this void for current upstream kernels.
> > 
> > The following commit (not in 4.4.x stable tree) might explain the
> > difference you experienced:
> > 
> >   commit 286c469a988fbaf68e3a97ddf1e6c245c1446968                          
> >   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>                      
> >   Date:   Wed May 3 14:56:22 2017 -0700                                    
> >                                                                            
> >       mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page
> > 
> > This commit adds shake_page() for mlocked pages to make sure that the target
> > page is flushed out from LRU cache. Without this shake_page(), subsequent
> > delete_from_lru_cache() (from me_pagecache_clean()) fails to isolate it and
> > the page will finally return back to LRU list.  So this scenario leads to
> > "hwpoisoned by still linked to LRU list" page.
> 
> OK, I see. So does that mean that the LRU handling is no longer needed
> and there is a guanratee that all kernels with the above commit cannot
> ever get an LRU page?

Theoretically no such gurantee, because try_to_unmap() doesn't have a
guarantee of success and then memory_failure() returns immediately
when hwpoison_user_mappings fails.
Or the following code (comes after hwpoison_user_mappings block) also implies
that the target page can still have PageLRU flag.

        /*
         * Torn down by someone else?
         */
        if (PageLRU(p) && !PageSwapCache(p) && p->mapping == NULL) {
                action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
                res = -EBUSY;
                goto out;
        }

So I think it's OK to keep "if (WARN_ON(PageLRU(page)))" block in
current version of your patch.

Feel free to add my ack.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks,
Naoya Horiguchi
