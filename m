Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28895C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F4E2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F4E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHaLNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:13:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:55404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbeHaLNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:13:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CF9DADBC;
        Fri, 31 Aug 2018 07:07:23 +0000 (UTC)
Date:   Fri, 31 Aug 2018 09:07:22 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20180831070722.wnulbbmillxkw7ke@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
 <20180830205527.dmemjwxfbwvkdzk2@suse.de>
 <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:12:44AM +0300, Meelis Roos wrote:
> > Thanks for the report! I'll try to reproduce the problem tomorrow and
> > investigate it. Can you please check if any of the kernel configurations
> > that show the bug has CONFIG_X86_PAE set? If not, can you please test
> > if enabling this option still triggers the problem?
> 
> Will check, but out of my memery there were 2 G3 HP Proliants that did 
> not fit into the pattern (problem did not appear). I have more than 4G 
> RAM in those and HIGHMEM_4G there, maybe that's it?

Yeah, I thought a bit about it, and for legacy paging the PMD paging
level is the root-level where we do the mirroring between kernel and
user page-table for PTI. This means we also need to collect A/D bits
from both entries, which we don't do yet.

But that all means it shouldn't happen with CONFIG_X86_PAE=y.

I'll try to reproduce and work on a fix.

Thanks,

	Joerg
