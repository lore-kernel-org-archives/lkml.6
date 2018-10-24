Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8CEC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525E820824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525E820824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeJXTma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:42:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:59226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbeJXTm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:42:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04141ABE7;
        Wed, 24 Oct 2018 11:14:45 +0000 (UTC)
Date:   Wed, 24 Oct 2018 13:14:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181024111444.nf2vhajbjz2rf6cg@pathway.suse.cz>
References: <20180828143603.4442-7-pmladek@suse.com>
 <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
 <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
 <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
 <20181018145456.nrekm2iuyf5ztw3n@pathway.suse.cz>
 <20181018153027.x4nk2ihgs5ehsln2@treble>
 <alpine.LSU.2.21.1810191400320.4692@pobox.suse.cz>
 <20181019143604.35zgwus4arkolbwr@treble>
 <20181022132509.6vxrdvq42e5j2bpx@pathway.suse.cz>
 <20181023163943.ex65stywf2cwqvep@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023163943.ex65stywf2cwqvep@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-23 11:39:43, Josh Poimboeuf wrote:
> On Mon, Oct 22, 2018 at 03:25:10PM +0200, Petr Mladek wrote:
> > On Fri 2018-10-19 09:36:04, Josh Poimboeuf wrote:
> > > On Fri, Oct 19, 2018 at 02:16:19PM +0200, Miroslav Benes wrote:
> > > > On Thu, 18 Oct 2018, Josh Poimboeuf wrote:
> > > > > As long as we're talking about radical changes... how about we just
> > > > > don't allow disabling patches at all?  Instead a patch can be replaced
> > > > > with a 'revert' patch, or an empty 'nop' patch.  That would make our
> > > > > code simpler and also ensure there's an audit trail.
> > > > > 
> > The revert operation allows to remove a livepatch stuck in the
> > transition without forcing.
> 
> True, though I question the real world value of that.

We ended in this situation few times with kGraft when a kthread
was not annotated and migrated. We have not seen this with upstream
livepatch code yet but we shipped first product with it only few
months ago.

I would say that it is nice to have but it is not must to have.


> > One big problem would be how to keep the system consistent. You
> > would need to solve races between loading modules and livepatches
> > anyway.
> > 
> > For example, you could not load fixed/patched modules when the system
> > is not fully patched yet. You would need to load the module and
> > the related livepatch at the same time and follow the consistency
> > model as we do now.
> 
> Yeah, I think that's pretty much the crazy idea Miroslav mentioned.  The
> patch would consist of several modules.  The parent module would
> register the patch and patch vmlinux.  Each child module would be
> associated with a to-be-patched module.  The child modules could be
> loaded on demand, either by special klp code or by modprobe.

Yup, something like this.

> As you described, there would be some races to think about.  However, it
> would also have some benefits.
> 
> I *hope* it would mean we could get rid of a lot of our ugly hacks, like
> 
> - klp symbols, klp relas

The access to external static symbols would still need so klp-specific
relocations.

> - preserving ELF data, PLT's, other horrible arch-specific things
> - klp.arch..altinstructions, klp.arch..parainstructions
> - manually calling apply_relocate_add()

Yup, these might be candidates to go.


> However... we might still need some of those things for another reason:
> to bypass exported symbol protections.  It needs some more
> investigation.
> 
> Given this discussion, I'm thinking there wouldn't be much to discuss at
> LPC for this topic unless we had a prototype to look at (which I won't
> have time to do).  So I may drop my talk in favor of giving more time
> for other more tangible discussions.

Sounds reasonable. At least I would not be able to say much more about
it without seeing a more detailed proposal and ideally a prototype
code. That said, I definitely do not want to discourage you from
playing with the idea.

Best Regards,
Petr
