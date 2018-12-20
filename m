Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0546321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297590;
	bh=o5/MmnIBDarYU0ccr19Ux5hy4ZdTfH04jiDG8m4UNX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zixYHNW5CVu2dZE96yLQcJEzFcezFI01ZbYnqHTsGIKjiDZgOu+1pW0wZXjQHPYaa
	 Z0FlgxQFEk1Z1JrSR80lcBLcJGPWYNtXoOI0SW20qM7+Wn75nOYawFY3/Kc+N6LiPO
	 KUmKp5ixqkniIa0bQl9if0YqBzMg22i9NdBTdS6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeLTJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:19:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730206AbeLTJTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EB1EB012;
        Thu, 20 Dec 2018 09:19:35 +0000 (UTC)
Date:   Thu, 20 Dec 2018 10:19:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20181220091934.GC14234@dhcp22.suse.cz>
References: <20181207142240.GC1286@dhcp22.suse.cz>
 <CAFgQCTuu54oZWKq_ppEvZFb4Mz31gVmsa37gTap+e9KbE=T0aQ@mail.gmail.com>
 <20181207155627.GG1286@dhcp22.suse.cz>
 <20181210123738.GN1286@dhcp22.suse.cz>
 <CAFgQCTupPc1rKv2SrmWD+eJ0H6PRaizPBw3+AG67_PuLA2SKFw@mail.gmail.com>
 <20181212115340.GQ1286@dhcp22.suse.cz>
 <CAFgQCTuhW6sPtCNFmnz13p30v3owE3Rty5WJNgtqgz8XaZT-aQ@mail.gmail.com>
 <CAFgQCTtFZ8ku7W_7rcmrbmH4Qvsv7zgOSHKfPSpNSkVjYkPfBg@mail.gmail.com>
 <20181217132926.GM30879@dhcp22.suse.cz>
 <CAFgQCTubm9B1_zM+oc1GLfOChu+XY9N4OcjyeDgk6ggObRtMKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTubm9B1_zM+oc1GLfOChu+XY9N4OcjyeDgk6ggObRtMKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 15:19:39, Pingfan Liu wrote:
> Hi Michal,
> 
> WIth this patch applied on the old one, I got the following message.
> Please get it from attachment.
[...]
> [    0.409637] NUMA: Node 1 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0x7fffffff] -> [mem 0x00000000-0x7fffffff]
> [    0.419858] NUMA: Node 1 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x47fffffff] -> [mem 0x00000000-0x47fffffff]
> [    0.430356] NODE_DATA(0) allocated [mem 0x87efd4000-0x87effefff]
> [    0.436325]     NODE_DATA(0) on node 5
> [    0.440092] Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
> [    0.447078] node[0] zonelist: 
> [    0.450106] NODE_DATA(1) allocated [mem 0x47ffd5000-0x47fffffff]
> [    0.456114] NODE_DATA(2) allocated [mem 0x87efa9000-0x87efd3fff]
> [    0.462064]     NODE_DATA(2) on node 5
> [    0.465852] Initmem setup node 2 [mem 0x0000000000000000-0x0000000000000000]
> [    0.472813] node[2] zonelist: 
> [    0.475846] NODE_DATA(3) allocated [mem 0x87ef7e000-0x87efa8fff]
> [    0.481827]     NODE_DATA(3) on node 5
> [    0.485590] Initmem setup node 3 [mem 0x0000000000000000-0x0000000000000000]
> [    0.492575] node[3] zonelist: 
> [    0.495608] NODE_DATA(4) allocated [mem 0x87ef53000-0x87ef7dfff]
> [    0.501587]     NODE_DATA(4) on node 5
> [    0.505349] Initmem setup node 4 [mem 0x0000000000000000-0x0000000000000000]
> [    0.512334] node[4] zonelist: 
> [    0.515370] NODE_DATA(5) allocated [mem 0x87ef28000-0x87ef52fff]
> [    0.521384] NODE_DATA(6) allocated [mem 0x87eefd000-0x87ef27fff]
> [    0.527329]     NODE_DATA(6) on node 5
> [    0.531091] Initmem setup node 6 [mem 0x0000000000000000-0x0000000000000000]
> [    0.538076] node[6] zonelist: 
> [    0.541109] NODE_DATA(7) allocated [mem 0x87eed2000-0x87eefcfff]
> [    0.547090]     NODE_DATA(7) on node 5
> [    0.550851] Initmem setup node 7 [mem 0x0000000000000000-0x0000000000000000]
> [    0.557836] node[7] zonelist: 

OK, so it is clear that building zonelists this early is not going to
fly. We do not have the complete information yet. I am not sure when do
we get that at this moment but I suspect the we either need to move that
initialization to a sooner stage or we have to reconsider whether the
phase when we build zonelists really needs to consider only online numa
nodes.

[...]
> [    1.067658] percpu: Embedded 46 pages/cpu @(____ptrval____) s151552 r8192 d28672 u262144
> [    1.075692] node[1] zonelist: 1:Normal 1:DMA32 1:DMA 5:Normal 
> [    1.081376] node[5] zonelist: 5:Normal 1:Normal 1:DMA32 1:DMA 

I hope to get to this before I leave for christmas vacation, if not I
will stare into it after then.

Thanks!
-- 
Michal Hocko
SUSE Labs
