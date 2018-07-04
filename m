Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C77208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C77208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbeGDNOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:52946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753179AbeGDNOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:14:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4DC9AF44;
        Wed,  4 Jul 2018 13:14:05 +0000 (UTC)
Date:   Wed, 4 Jul 2018 15:14:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] m68k: switch to MEMBLOCK + NO_BOOTMEM
Message-ID: <20180704131404.GR22503@dhcp22.suse.cz>
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1530685696-14672-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAMuHMdWEHSz34bN-U3gHW972w13f_Jrx_ObEsP3w8XZ1Gx65OA@mail.gmail.com>
 <20180704075410.GF22503@dhcp22.suse.cz>
 <89f48f7a-6cbf-ac9a-cacc-cd3ca79f8c66@suse.cz>
 <20180704123627.GM22503@dhcp22.suse.cz>
 <CAMuHMdVuLd=y4Wk6ghFZ8YV_1Z9kvh588VkwBMwxScxateMu1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVuLd=y4Wk6ghFZ8YV_1Z9kvh588VkwBMwxScxateMu1g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 15:05:08, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Jul 4, 2018 at 2:36 PM Michal Hocko <mhocko@kernel.org> wrote:
> > [CC Andrew - email thread starts
> > http://lkml.kernel.org/r/1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com]
> >
> > OK, so here we go with the full patch.
> >
> > From 0e8432b875d98a7a0d3f757fce2caa8d16a8de15 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Wed, 4 Jul 2018 14:31:46 +0200
> > Subject: [PATCH] memblock: do not complain about top-down allocations for
> >  !MEMORY_HOTREMOVE
> >
> > Mike Rapoport is converting architectures from bootmem to noboodmem
> 
> nobootmem

fixed

> 
> > allocator. While doing so for m68k Geert has noticed that he gets
> > a scary looking warning
> > WARNING: CPU: 0 PID: 0 at mm/memblock.c:230
> > memblock_find_in_range_node+0x11c/0x1be
> > memblock: bottom-up allocation failed, memory hotunplug may be affected
> 
> > The warning is basically saying that a top-down allocation can break
> > memory hotremove because memblock allocation is not movable. But m68k
> > doesn't even support MEMORY_HOTREMOVE is there is no point to warn
> 
> so there is

fixed

> > about it.
> >
> > Make the warning conditional only to configurations that care.
> 
> Still, I'm wondering if the warning is really that unlikely on systems
> that support
> hotremove. Or is it due to the low amount of RAM on m68k boxes?

Most likely yes. If you want to have full NUMA nodes hot-removable then
the BIOS/FW is supposed to mark them hotplug and then we rely on the
available memory on the low physical memory ranges (usually on not 0)
to cover all early boot allocations. Hack? Sure thing like the whole
memory hotremove, if you ask me.
-- 
Michal Hocko
SUSE Labs
