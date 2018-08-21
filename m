Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C5C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77DD214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77DD214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeHUPhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:37:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:35342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727188AbeHUPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E6F0B031;
        Tue, 21 Aug 2018 12:17:36 +0000 (UTC)
Date:   Tue, 21 Aug 2018 14:17:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@techadventures.net>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-ID: <20180821121734.GA29735@dhcp22.suse.cz>
References: <20180820085516.9687-1-osalvador@techadventures.net>
 <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-08-18 14:24:40, Andrew Morton wrote:
> On Mon, 20 Aug 2018 10:55:16 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:
> 
> > From: Oscar Salvador <osalvador@suse.de>
> > 
> > Currently, NODEMASK_ALLOC allocates a nodemask_t with kmalloc when
> > NODES_SHIFT is higher than 8, otherwise it declares it within the stack.
> > 
> > The comment says that the reasoning behind this, is that nodemask_t will be
> > 256 bytes when NODES_SHIFT is higher than 8, but this is not true.
> > For example, NODES_SHIFT = 9 will give us a 64 bytes nodemask_t.
> > Let us fix up the comment for that.
> > 
> > Another thing is that it might make sense to let values lower than 128bytes
> > be allocated in the stack.
> > Although this all depends on the depth of the stack
> > (and this changes from function to function), I think that 64 bytes
> > is something we can easily afford.
> > So we could even bump the limit by 1 (from > 8 to > 9).
> > 
> 
> I agree.  Such a change will reduce the amount of testing which the
> kmalloc version receives, but I assume there are enough people out
> there testing with large NODES_SHIFT values.

We do have CONFIG_NODES_SHIFT=10 in our SLES kernels for quite some
time (around SLE11-SP3 AFAICS).

Anyway, isn't NODES_ALLOC over engineered a bit? Does actually even do
larger than 1024 NUMA nodes? This would be 128B and from a quick glance
it seems that none of those functions are called in deep stacks. I
haven't gone through all of them but a patch which checks them all and
removes NODES_ALLOC would be quite nice IMHO.

-- 
Michal Hocko
SUSE Labs
