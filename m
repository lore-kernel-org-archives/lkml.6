Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE4720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544085131;
	bh=dumXPcjkmErYSEQ3/xNLXSi6kM0Xw9noWYHddRVyUXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p/yZevfcQ1f93EILyeMz84n7JvKF6bRpmc7Wn6QOhuBy8I+KIj9xtJlUlxWTM8kv8
	 SOcH/34Hr1eA0PJlXj16OF2RM0jadfoQNvPk5tF/Yip4YRup9N3QiyXpkYz+sbCkqX
	 x66UI078tkQ2nsME9vqD8u0riN+ZrLZGSUoE04BI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE4720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeLFIcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:32:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:44044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFIcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:32:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0739AAD75;
        Thu,  6 Dec 2018 08:32:07 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:32:06 +0100
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
Message-ID: <20181206083206.GC1286@dhcp22.suse.cz>
References: <20181203100309.14784-1-mhocko@kernel.org>
 <20181205122918.GL1286@dhcp22.suse.cz>
 <20181205165716.GS1286@dhcp22.suse.cz>
 <20181206052137.GA28595@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206052137.GA28595@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 05:21:38, Naoya Horiguchi wrote:
> On Wed, Dec 05, 2018 at 05:57:16PM +0100, Michal Hocko wrote:
> > On Wed 05-12-18 13:29:18, Michal Hocko wrote:
> > [...]
> > > After some more thinking I am not really sure the above reasoning is
> > > still true with the current upstream kernel. Maybe I just managed to
> > > confuse myself so please hold off on this patch for now. Testing by
> > > Oscar has shown this patch is helping but the changelog might need to be
> > > updated.
> > 
> > OK, so Oscar has nailed it down and it seems that 4.4 kernel we have
> > been debugging on behaves slightly different. The underlying problem is
> > the same though. So I have reworded the changelog and added "just in
> > case" PageLRU handling. Naoya, maybe you have an argument that would
> > make this void for current upstream kernels.
> 
> The following commit (not in 4.4.x stable tree) might explain the
> difference you experienced:
> 
>   commit 286c469a988fbaf68e3a97ddf1e6c245c1446968                          
>   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>                      
>   Date:   Wed May 3 14:56:22 2017 -0700                                    
>                                                                            
>       mm: hwpoison: call shake_page() after try_to_unmap() for mlocked page
> 
> This commit adds shake_page() for mlocked pages to make sure that the target
> page is flushed out from LRU cache. Without this shake_page(), subsequent
> delete_from_lru_cache() (from me_pagecache_clean()) fails to isolate it and
> the page will finally return back to LRU list.  So this scenario leads to
> "hwpoisoned by still linked to LRU list" page.

OK, I see. So does that mean that the LRU handling is no longer needed
and there is a guanratee that all kernels with the above commit cannot
ever get an LRU page?
-- 
Michal Hocko
SUSE Labs
