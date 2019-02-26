Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98599C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AB121852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551213653;
	bh=woP87ApUw+8dFVLH5svbTasryXVg6iym9sKK6u8gKTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gf38HytXIbv4gfWB6Xo5SDh2Tt2+YVZCfE6I2YcV98l4V56gpor6KcXJDck9NTcd7
	 MVJ6CCaxsMNYNvksZjI7abgDKDD8fF1NM1VNiBwWrQawsN8Vi5qT3wvwEEXbVvdW6j
	 kCKtv5PKYnthKyLzxbEWcQPCB89MHIfgvkdlB13Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfBZUkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:40:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:45098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727981AbfBZUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:40:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A2F5B6A5;
        Tue, 26 Feb 2019 20:40:50 +0000 (UTC)
Date:   Tue, 26 Feb 2019 21:40:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
Message-ID: <20190226204047.GJ10588@dhcp22.suse.cz>
References: <20190225191710.48131-1-cai@lca.pw>
 <20190226123521.GZ10588@dhcp22.suse.cz>
 <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
 <20190226142352.GC10588@dhcp22.suse.cz>
 <1551203585.6911.47.camel@lca.pw>
 <20190226181648.GG10588@dhcp22.suse.cz>
 <20190226182007.GH10588@dhcp22.suse.cz>
 <1551208782.6911.51.camel@lca.pw>
 <20190226194024.GI10588@dhcp22.suse.cz>
 <1551211839.6911.54.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551211839.6911.54.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-02-19 15:10:39, Qian Cai wrote:
> On Tue, 2019-02-26 at 20:40 +0100, Michal Hocko wrote:
> > It seems you have missed the point of my question. It simply doesn't
> > make much sense to have offline memory mapped. That memory is not
> > accessible in general. So mapping it at the offline time is dubious at
> > best. 
> 
> Well, kernel_map_pages() is like other debug features which could look
> "unusual".
> 
> > Also you do not get through the offlining phase on a newly
> > hotplugged (and not yet onlined) memory. So the patch doesn't look
> > correct to me and it all smells like the bug you are seeing is a wrong
> > reporting.
> > 
> 
> That (physical memory hotadd) is a special case like during the boot. The patch
> is strictly to deal with offline/online memory, i.e., logical/soft memory
> hotplug.

And it doesn't handle it properly AFAICS. You want to get an exception
when accessing an offline memory, don't you? Offline, free or not present
memory is basically the same case - nobody should be touching that
memory.

-- 
Michal Hocko
SUSE Labs
