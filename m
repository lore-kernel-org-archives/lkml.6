Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A250BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556E42178B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556E42178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeHVANo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:13:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHVANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:13:44 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E920ACF9;
        Tue, 21 Aug 2018 20:52:00 +0000 (UTC)
Date:   Tue, 21 Aug 2018 13:51:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Michal Hocko <mhocko@kernel.org>, tglx@linutronix.de,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Fix comment for NODEMASK_ALLOC
Message-Id: <20180821135159.63b77492f44c21ad203cd7b1@linux-foundation.org>
In-Reply-To: <20180821123024.GA9489@techadventures.net>
References: <20180820085516.9687-1-osalvador@techadventures.net>
        <20180820142440.1f9ccbebefc5d617c881b41e@linux-foundation.org>
        <20180821121734.GA29735@dhcp22.suse.cz>
        <20180821123024.GA9489@techadventures.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 14:30:24 +0200 Oscar Salvador <osalvador@techadventures.net> wrote:

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
> 
> struct nodemask_scratch {
> 	nodemask_t	mask1;
> 	nodemask_t	mask2;
> };
> 
> that would make 256 bytes in case CONFIG_NODES_SHIFT=10.

And that sole site could use an open-coded kmalloc.


