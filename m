Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3805D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbeLQPy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:54:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387737AbeLQPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:54:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B71AFACE5;
        Mon, 17 Dec 2018 15:54:53 +0000 (UTC)
Date:   Mon, 17 Dec 2018 16:54:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
Message-ID: <20181217155453.nr34ooxmriik2cln@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-9-pmladek@suse.com>
 <20181213230045.2xgi2pyewkjbou22@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213230045.2xgi2pyewkjbou22@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 17:00:45, Josh Poimboeuf wrote:
> On Thu, Nov 29, 2018 at 10:44:28AM +0100, Petr Mladek wrote:
> > +static void __klp_free_funcs(struct klp_object *obj, bool free_all)
> >  {
> > -	struct klp_func *func;
> > +	struct klp_func *func, *tmp_func;
> > +
> > +	klp_for_each_func_safe(obj, func, tmp_func) {
> > +		if (!free_all && !func->nop)
> > +			continue;
> 
> I suspect that changing 'free_all" to 'nops_only' (and inverting the
> condition) would make the code more readable.
> 
> And a similar suggestion for __klp_free_objects().

I am not super happy with the negative check as well. The problem is
that in __klp_free_objects() it would look like:

		if (nops_only && !obj->dynamic)
			continue;

By other words, "free_all" works better with both "nops" and "dynamic".

That said, I do not mind about it. Tell me what you prefer and I'll
change it.


> > +
> > +		/*
> > +		 * Avoid double free. It would be tricky to wait for kobject
> > +		 * callbacks when only NOPs are handled.
> > +		 */
> > +		list_del(&func->node);
> 
> I've read this comment several times but I still have no idea how it
> relates to the code :-)

I wrote this comment when I was lost in thoughts how to make freeing
safe. Especially I wondered whether we would need to wait until
the structures are freed.

You are right that this is needed to remove the freed nops/dynamic
structures in general.

I will remove the comment.

Best Regards,
Petr
