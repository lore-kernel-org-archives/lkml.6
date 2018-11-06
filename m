Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55034C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277212085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277212085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeKGFfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:46258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeKGFfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5DA5B05C;
        Tue,  6 Nov 2018 20:08:24 +0000 (UTC)
Date:   Tue, 6 Nov 2018 21:08:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v6 1/2] memory_hotplug: Free pages as higher order
Message-ID: <20181106200823.GT27423@dhcp22.suse.cz>
References: <1541484194-1493-1-git-send-email-arunks@codeaurora.org>
 <20181106140638.GN27423@dhcp22.suse.cz>
 <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542cd3516b54d88d1bffede02c6045b8@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-11-18 21:01:29, Arun KS wrote:
> On 2018-11-06 19:36, Michal Hocko wrote:
> > On Tue 06-11-18 11:33:13, Arun KS wrote:
> > > When free pages are done with higher order, time spend on
> > > coalescing pages by buddy allocator can be reduced. With
> > > section size of 256MB, hot add latency of a single section
> > > shows improvement from 50-60 ms to less than 1 ms, hence
> > > improving the hot add latency by 60%. Modify external
> > > providers of online callback to align with the change.
> > > 
> > > This patch modifies totalram_pages, zone->managed_pages and
> > > totalhigh_pages outside managed_page_count_lock. A follow up
> > > series will be send to convert these variable to atomic to
> > > avoid readers potentially seeing a store tear.
> > 
> > Is there any reason to rush this through rather than wait for counters
> > conversion first?
> 
> Sure Michal.
> 
> Conversion patch, https://patchwork.kernel.org/cover/10657217/ is currently
> incremental to this patch.

The ordering should be other way around. Because as things stand with
this patch first it is possible to introduce a subtle race prone
updates. As I've said I am skeptical the race would matter, really, but
there is no real reason to risk for that. Especially when you have the
other (first) half ready.

-- 
Michal Hocko
SUSE Labs
