Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B731C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA8208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544097749;
	bh=0sLcR5DV8d8KUCA36ww29jHiFNbJ5mjslSYkbMALxKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uFkFk+MigpFnpAsLUahY39DCx9g4eny5F3HbmZ2GNtcD5m4vWbsRjDNI1yW3pGJyK
	 044rV+ZI5wvF9nducILLjh0o3gv6fO7j5mhQe2+Zoh/j5FM5cH/7nDqABNw1H5i8La
	 qUdIrQTDbEdi0odTbpEhF2vFfmhgcggj8RiDkfYk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFA8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeLFMC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:02:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:59452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbeLFMC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:02:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE789AFBB;
        Thu,  6 Dec 2018 12:02:24 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:02:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Oscar Salvador <OSalvador@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] hwpoison, memory_hotplug: allow hwpoisoned pages to
 be offlined
Message-ID: <20181206120223.GG1286@dhcp22.suse.cz>
References: <20181203100309.14784-1-mhocko@kernel.org>
 <20181205122918.GL1286@dhcp22.suse.cz>
 <20181205165716.GS1286@dhcp22.suse.cz>
 <20181206052137.GA28595@hori1.linux.bs1.fc.nec.co.jp>
 <20181206083206.GC1286@dhcp22.suse.cz>
 <20181206091552.GB26516@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206091552.GB26516@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 09:15:53, Naoya Horiguchi wrote:
> On Thu, Dec 06, 2018 at 09:32:06AM +0100, Michal Hocko wrote:
> > On Thu 06-12-18 05:21:38, Naoya Horiguchi wrote:
> > > On Wed, Dec 05, 2018 at 05:57:16PM +0100, Michal Hocko wrote:
> > > > On Wed 05-12-18 13:29:18, Michal Hocko wrote:
> > > > [...]
> > > > > After some more thinking I am not really sure the above reasoning is
> > > > > still true with the current upstream kernel. Maybe I just managed to
> > > > > confuse myself so please hold off on this patch for now. Testing by
> > > > > Oscar has shown this patch is helping but the changelog might need to be
> > > > > updated.
> > > > 
> > > > OK, so Oscar has nailed it down and it seems that 4.4 kernel we have
> > > > been debugging on behaves slightly different. The underlying problem is
> > > > the same though. So I have reworded the changelog and added "just in
> > > > case" PageLRU handling. Naoya, maybe you have an argument that would
> > > > make this void for current upstream kernels.
> > > 
> > > The following commit (not in 4.4.x stable tree) might explain the
> > > difference you experienced:
> > > 
> > >   commit 286c469a988fbaf68e3a97ddf1e6c245c1446968                          
> > >   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>                      
> > >   Date:   Wed May 3 14:56:22 2017 -0700                                    
> > >                                                                            
> > >       mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page
> > > 
> > > This commit adds shake_page() for mlocked pages to make sure that the target
> > > page is flushed out from LRU cache. Without this shake_page(), subsequent
> > > delete_from_lru_cache() (from me_pagecache_clean()) fails to isolate it and
> > > the page will finally return back to LRU list.  So this scenario leads to
> > > "hwpoisoned by still linked to LRU list" page.
> > 
> > OK, I see. So does that mean that the LRU handling is no longer needed
> > and there is a guanratee that all kernels with the above commit cannot
> > ever get an LRU page?
> 
> Theoretically no such gurantee, because try_to_unmap() doesn't have a
> guarantee of success and then memory_failure() returns immediately
> when hwpoison_user_mappings fails.
> Or the following code (comes after hwpoison_user_mappings block) also implies
> that the target page can still have PageLRU flag.
> 
>         /*
>          * Torn down by someone else?
>          */
>         if (PageLRU(p) && !PageSwapCache(p) && p->mapping == NULL) {
>                 action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
>                 res = -EBUSY;
>                 goto out;
>         }
> 
> So I think it's OK to keep "if (WARN_ON(PageLRU(page)))" block in
> current version of your patch.
> 
> Feel free to add my ack.
> 
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks a lot Naoya! I will extend the changelog with your wording.

-- 
Michal Hocko
SUSE Labs
