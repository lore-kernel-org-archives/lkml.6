Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C09F20835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C09F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJISis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:38:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbeJISis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:38:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC3B2AD98;
        Tue,  9 Oct 2018 11:22:16 +0000 (UTC)
Date:   Tue, 9 Oct 2018 13:22:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Randomize free memory
Message-ID: <20181009112216.GM8528@dhcp22.suse.cz>
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074457.GD22173@dhcp22.suse.cz>
 <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-10-18 09:44:35, Dan Williams wrote:
> Hi Michal,
> 
> On Thu, Oct 4, 2018 at 12:53 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 03-10-18 19:15:18, Dan Williams wrote:
> > > Changes since v1:
> > > * Add support for shuffling hot-added memory (Andrew)
> > > * Update cover letter and commit message to clarify the performance impact
> > >   and relevance to future platforms
> >
> > I believe this hasn't addressed my questions in
> > http://lkml.kernel.org/r/20181002143015.GX18290@dhcp22.suse.cz. Namely
> > "
> > It is the more general idea that I am not really sure about. First of
> > all. Does it make _any_ sense to randomize 4MB blocks by default? Why
> > cannot we simply have it disabled?
> 
> I'm not aware of any CVE that this would directly preclude, but that
> said the entropy injected at 4MB boundaries raises the bar on heap
> attacks. Environments that want more can adjust that with the boot
> parameter. Given the potential benefits I think it would only make
> sense to default disable it if there was a significant runtime impact,
> from what I have seen there isn't.
> 
> > Then and more concerning question is,
> > does it even make sense to have this randomization applied to higher
> > orders than 0? Attacker might fragment the memory and keep recycling the
> > lowest order and get the predictable behavior that we have right now.
> 
> Certainly I expect there are attacks that can operate within a 4MB
> window, as I expect there are attacks that could operate within a 4K
> window that would need sub-page randomization to deter. In fact I
> believe that is the motivation for CONFIG_SLAB_FREELIST_RANDOM.
> Combining that with page allocator randomization makes the kernel less
> predictable.

I am sorry but this hasn't explained anything (at least to me). I can
still see a way to bypass this randomization by fragmenting the memory.
With that possibility in place this doesn't really provide the promissed
additional security. So either I am missing something or the per-order
threshold is simply a wrong interface to a broken security misfeature.

> Is that enough justification for this patch on its own?

I do not think so from what I have heard so far.

> It's
> debatable. Combine that though with the wider availability of
> platforms with memory-side-cache and I think it's a reasonable default
> behavior for the kernel to deploy.

OK, this sounds a bit more interesting. I am going to speculate because
memory-side-cache is way too generic of a term for me to imagine
anything specific. Many years back while at a university I was playing
with page coloring as a method to reach a more stable performance
results due to reduced cache conflicts. It was not always a performance
gain but it definitely allowed for more stable run-to-run comparable
results. I can imagine that a randomization might lead to a similar effect
although I am not sure how much and it would be more interesting to hear
about that effect. If this is really the case then I would assume on/off
knob to control the randomization without something as specific as
order.
-- 
Michal Hocko
SUSE Labs
