Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21716C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90A6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90A6214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbeKUWwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:52:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:47400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbeKUWwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:52:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEFD7ADED;
        Wed, 21 Nov 2018 12:17:52 +0000 (UTC)
Date:   Wed, 21 Nov 2018 13:17:51 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/12] livepatch: Helper macros to define livepatch
 structures
In-Reply-To: <20181024112822.tam6bal3hnrrgj5m@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1811211316200.26999@pobox.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com> <20181015123713.25868-3-pmladek@suse.com> <20181017181756.cy65ujygmf3ulmiz@treble> <20181018111153.qcmvidttifi57u45@pathway.suse.cz> <20181018125824.ms5zovmsnikv3bgt@treble>
 <20181024112822.tam6bal3hnrrgj5m@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018, Petr Mladek wrote:

> On Thu 2018-10-18 07:58:24, Josh Poimboeuf wrote:
> > On Thu, Oct 18, 2018 at 01:11:53PM +0200, Petr Mladek wrote:
> > > On Wed 2018-10-17 13:17:56, Josh Poimboeuf wrote:
> > > > On Mon, Oct 15, 2018 at 02:37:03PM +0200, Petr Mladek wrote:
> > > > > The definition of struct klp_func might be a bit confusing.
> > > > > The original function is defined by name as a string.
> > > > > The new function is defined by name as a function pointer
> > > > > casted to unsigned long.
> > > > > 
> > > > > This patch adds helper macros that hide the different types.
> > > > > The functions are defined just by the name. For example:
> > > > 
> > > > On one hand, these macros are kind of nice, because they do the function
> > > > pointer casting for the user.
> > > > 
> > > > On the other hand, they hide the field names, which hurts readability a
> > > > bit.  For example, it would be easy to accidentally assign the wrong
> > > > callback function.
> > > 
> > > I am not a big fan of the macros either.
> > > 
> > > 
> > > > Also, it's unfortunate that these macros are needed in the first place.
> > > > 
> > > > What if we just change new_addr (and old_addr) to be 'void *'?  Then the
> > > > macros wouldn't be as useful, and we could just get rid of them.
> > > 
> > > Hmm, I wonder if any change make sense then. The above proposal might
> > > just exchange one confusion with another one:
> > > 
> > >    + I would expect that a variable called addr is of the type
> > >      unsigned long
> > > 
> > >    + we would need casting when calling ftrace API
> > > 
> > >    + .new_addr = function_xxx looks a bit weird and it will
> > >      be used many times in all livepatch sources.
> > 
> > Fair points.  Instead of changing new_func to new_addr, how about we
> > leave it alone, and instead change 'unsigned long old_addr' to 'void
> > *old_func'?
> > 
> > That would give us consistent naming internally, while making the
> > external interface more sensible and cast-free.
> > 
> > We'd still have to cast when passing to the ftrace API, but IMO it would
> > be worth it.
> 
> I am fine with this. I will do this in v14 unless anyone complains ;-)

I agree. I don't like the change from 1/12 much as it exposes casting to 
user. Macros introduced here do not make any better and I go along with 
Josh.

Miroslav
