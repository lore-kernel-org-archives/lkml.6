Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61B1C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6136214C3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6136214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbeI1USi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:18:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbeI1USi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:18:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A85B2ACEB;
        Fri, 28 Sep 2018 13:54:42 +0000 (UTC)
Date:   Fri, 28 Sep 2018 15:54:39 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH 2/3] resource: Include resource end in walk_*() interfaces
Message-ID: <20180928135439.GD21895@zn.tnic>
References: <153805773703.1157.14773321497580233478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:22:02AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> find_next_iomem_res() finds an iomem resource that covers part of a range
> described by "start, end".  All callers expect that range to be inclusive,
> i.e., both start and end are included, but find_next_iomem_res() doesn't
> handle the end address correctly.
> 
> If it finds an iomem resource that contains exactly the end address, it
> skips it, e.g., if "start, end" is [0x0-0x10000] and there happens to be an
> iomem resource [mem 0x10000-0x10000] (the single byte at 0x10000), we skip
> it:
> 
>   find_next_iomem_res(...)
>   {
>     start = 0x0;
>     end = 0x10000;
>     for (p = next_resource(...)) {
>       # p->start = 0x10000;
>       # p->end = 0x10000;
>       # we *should* return this resource, but this condition is false:
>       if ((p->end >= start) && (p->start < end))
>         break;
> 
> Adjust find_next_iomem_res() so it allows a resource that includes the
> single byte at the end of the range.  This is a corner case that we
> probably don't see in practice.

This is how one should write commit messages! Thanks for that - it was a
joy - for a change - to read it :-)

> 
> Fixes: 58c1b5b07907 ("[PATCH] memory hotadd fixes: find_next_system_ram catch range fix")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  kernel/resource.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..155ec873ea4d 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -319,7 +319,7 @@ int release_resource(struct resource *old)
>  EXPORT_SYMBOL(release_resource);
>  
>  /*
> - * Finds the lowest iomem resource existing within [res->start.res->end).

What I'm still wondering about is, why was it ever even considered to
have a non-inclusive range. Looking at the git history, especially
58c1b5b07907 and 2842f11419704 - it looks like it was an omission and
then users started using it with inclusive ranges.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
