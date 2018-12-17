Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD3DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B62206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbeLQQLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbeLQQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:11:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1919BC0495BF;
        Mon, 17 Dec 2018 16:11:10 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E9496012B;
        Mon, 17 Dec 2018 16:11:06 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:11:04 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 08/11] livepatch: Remove Nop structures when unused
Message-ID: <20181217161104.bc4jkklw35svcaqy@treble>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-9-pmladek@suse.com>
 <20181213230045.2xgi2pyewkjbou22@treble>
 <20181217155453.nr34ooxmriik2cln@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217155453.nr34ooxmriik2cln@pathway.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 16:11:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:54:53PM +0100, Petr Mladek wrote:
> On Thu 2018-12-13 17:00:45, Josh Poimboeuf wrote:
> > On Thu, Nov 29, 2018 at 10:44:28AM +0100, Petr Mladek wrote:
> > > +static void __klp_free_funcs(struct klp_object *obj, bool free_all)
> > >  {
> > > -	struct klp_func *func;
> > > +	struct klp_func *func, *tmp_func;
> > > +
> > > +	klp_for_each_func_safe(obj, func, tmp_func) {
> > > +		if (!free_all && !func->nop)
> > > +			continue;
> > 
> > I suspect that changing 'free_all" to 'nops_only' (and inverting the
> > condition) would make the code more readable.
> > 
> > And a similar suggestion for __klp_free_objects().
> 
> I am not super happy with the negative check as well. The problem is
> that in __klp_free_objects() it would look like:
> 
> 		if (nops_only && !obj->dynamic)
> 			continue;
> 
> By other words, "free_all" works better with both "nops" and "dynamic".
> 
> That said, I do not mind about it. Tell me what you prefer and I'll
> change it.

The problem I had with 'free_all' was that it's vague: For a reader of
the code, freeing all would be the expected case, so it's not
necessarily clear what *not* freeing all would mean.

Using 'nops_only' makes the meaning of !all explicit.  Even for the
__klp_free_objects() case, I think it's an improvement, though you could
maybe call it 'dynamic_only' or 'dyn_only' instead (any of those options
would be fine with me).

-- 
Josh
