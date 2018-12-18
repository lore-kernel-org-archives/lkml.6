Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D810214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeLRJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:01:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:48180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRJBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:01:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6AC9AE0E;
        Tue, 18 Dec 2018 09:00:59 +0000 (UTC)
Date:   Tue, 18 Dec 2018 10:00:59 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Nicholas Mc Guire <der.herr@hofr.at>
cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
In-Reply-To: <20181217192308.GB26825@osadl.at>
Message-ID: <alpine.LSU.2.21.1812180956460.9644@pobox.suse.cz>
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org> <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz> <20ef1d3a-2916-ce00-2938-3397746efac9@redhat.com> <20181217192308.GB26825@osadl.at>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Nicholas Mc Guire wrote:

> On Mon, Dec 17, 2018 at 10:44:36AM -0500, Joe Lawrence wrote:
> > On 12/17/2018 07:03 AM, Miroslav Benes wrote:
> > > Hi,
> > > 
> > > I'm sorry for being late to the party.
> > > 
> > > On Sun, 16 Dec 2018, Nicholas Mc Guire wrote:
> > > 
> > >> Sparse reported warnings about non-static symbols. For the variables
> > >> a simple static attribute is fine - for those symbols referenced by
> > >> livepatch via klp_func the symbol-names must be unmodified in the
> > >> symbol table - to resolve this the __noclone attribute is used
> > >> for the shared statically declared functions.
> > >>
> > >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > >> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > >> Link: https://lkml.org/lkml/2018/12/13/827
> > > 
> > > A nit, but I'd reorder the tags. Link, Suggested-by:, Signed-off-by:. Also 
> > > it would be great if you used https://lkml.kernel.org/r/${Msg-ID} 
> > > redirection.
> > > 
> > >> ---
> > >>
> > >> V2: not all static functions shared need to carry the __noclone
> > >>     attribute only those that need to be resolved at runtime by
> > >>     livepatch - so drop the unnecessary __noclone attributes as
> > >>     well as the Note on __noclone as suggested by Joe Lawrence
> > >>     <joe.lawrence@redhat.com> - thanks !
> > > 
> > > I talked to Martin Jambor (GCC) and he suggested __attribute__((used)). It 
> > > should be better than __noclone, which was reportedly implemented only for 
> > > testing purposes (which is why it does not imply noinline, although 
> > > inlining internally uses cloning). Newer gcc also has "noipa" attribute, 
> > > but "used" would definitely be safe.
> > > 
> > > Sorry for not responding earlier.
> > >
> > 
> > Hi Miroslav,
> > 
> > Thanks for following up on this. "noipa" would have been nice to use,
> > but as you say, is a newer gcc attribute.
> > 
> > Regarding "used" vs. "noclone", can we assume that "used" implies that
> > the function name remains unchanged?
> > 
> > The gcc online doc [1] speaks about ensuring that "code must be
> > emitted".  This reads like it solves our
> > static-function-not-directly-referenced problem, but isn't explicit
> > about naming.
> > 
> >     used
> > 
> >     This attribute, attached to a function, means that code must be
> >     emitted for the function even if it appears that the function is not
> >     referenced. This is useful, for example, when the function is
> >     referenced only in inline assembly.
> > 
> > Perhaps it's equivalent to a "I want to keep this function and leave
> > it's symbols alone" attribute.  FWIW, I modified Nicholas' change on my
> > box to use "used" and it worked as Martin advertised, so it would get my
> > Ack.
> > 
> > I'm just being picky about its documentation and how we should note its
> > usage in the v3 patch.  Think that s/__noclone/used/g of the v2 commit
> > message would be sufficient?
> >
> should that then not be  __used  as this is provided in compiler_attributes.h
> see also: https://lkml.org/lkml/2018/9/20/909

Yes, __used is better.

> also would it be reasonable to maybe add something like:
>   #define __livepatch         __attribute__((__noclone__, __noinline__))
> in compiler_attributes.h ? it would make it imediately clear that the attributes
> are related to the way lp works internally.

No, I don't think so. The samples (and selftests) are special in that we 
would like to provide minimal examples (or testcases). GCC is in the way 
due to its optimizations. It is not the case with the common code (the 
problem there is a bit different. Some optimizations are just dangerous 
for livepatching. However that is tangential to this patch and will be 
solved elsewhere).

Thanks,
Miroslav
