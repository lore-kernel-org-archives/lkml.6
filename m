Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9AA214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9AA214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHUQMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:12:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727386AbeHUQMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:12:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F5C6B050;
        Tue, 21 Aug 2018 12:51:58 +0000 (UTC)
Date:   Tue, 21 Aug 2018 14:51:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-ID: <20180821125156.GB29735@dhcp22.suse.cz>
References: <20180820085516.9687-1-osalvador@techadventures.net>
 <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
 <20180821121734.GA29735@dhcp22.suse.cz>
 <20180821123024.GA9489@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821123024.GA9489@techadventures.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-08-18 14:30:24, Oscar Salvador wrote:
> On Tue, Aug 21, 2018 at 02:17:34PM +0200, Michal Hocko wrote:
> > We do have CONFIG_NODES_SHIFT=10 in our SLES kernels for quite some
> > time (around SLE11-SP3 AFAICS).
> > 
> > Anyway, isn't NODES_ALLOC over engineered a bit? Does actually even do
> > larger than 1024 NUMA nodes? This would be 128B and from a quick glance
> > it seems that none of those functions are called in deep stacks. I
> > haven't gone through all of them but a patch which checks them all and
> > removes NODES_ALLOC would be quite nice IMHO.
> 
> No, maximum we can get is 1024 NUMA nodes.
> I checked this when writing another patch [1], and since having gone
> through all archs Kconfigs, CONFIG_NODES_SHIFT=10 is the limit.
> 
> NODEMASK_ALLOC gets only called from:
> 
> - unregister_mem_sect_under_nodes() (not anymore after [1])
> - __nr_hugepages_store_common (This does not seem to have a deep stack, we could use a normal nodemask_t)
> 
> But is also used for NODEMASK_SCRATCH (mainly used for mempolicy):

mempolicy code should be a shallow stack as well. Mostly the syscall
entry.

-- 
Michal Hocko
SUSE Labs
