Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4974C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A823A20855
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAaIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:40:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfAaIk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B23FAFD2;
        Thu, 31 Jan 2019 08:40:26 +0000 (UTC)
Date:   Thu, 31 Jan 2019 09:40:25 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] livepatch: Handle failing allocation of shadow
 variables in the selftest
In-Reply-To: <20190130084603.bxm57h6wf47b45fs@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1901310936510.26726@pobox.suse.cz>
References: <20190116161720.796-1-pmladek@suse.com> <20190116161720.796-3-pmladek@suse.com> <alpine.LSU.2.21.1901211311401.31573@pobox.suse.cz> <20190130084603.bxm57h6wf47b45fs@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019, Petr Mladek wrote:

> On Mon 2019-01-21 13:14:38, Miroslav Benes wrote:
> > Hi,
> > 
> > On Wed, 16 Jan 2019, Petr Mladek wrote:
> > 
> > > Do not dereference pointers to the shadow variables when either
> > > klp_shadow_alloc() or klp_shadow_get() fail.
> > 
> > I may misunderstand the patch, so bear with me, please. Is this because of 
> > a possible null pointer dereference? If yes, shouldn't this say rather 
> > "when both klp_shadow_alloc() and klp_shadow_get() fail"?
> 
> Well, klp_shadow_get() could fail also from other reasons if there is
> a bug in the implementation.

Yes, but I meant that if only klp_shadow_alloc() or klp_shadow_get() 
failed, it would be caught by ret == sv1 comparison and you would not need 
to add checking of ret at the beginning.
 
> > > There is no need to check the other locations explicitly. The test
> > > would fail if any allocation fails. And the existing messages, printed
> > > during the test, provide enough information to debug eventual problems.
> 
> Heh, this is actually the reason why I did not add the check
> for shadow_alloc(). Any error would be detected later
> with klp_shadow_get() calls that should get tested anyway.
> 
> Hmm, when I think about it. A good practice is to handle
> klp_shadow_allow() or klp_shadow_get() failures immediately.
> After all, it is the sample code that people might follow.

I think so. 

> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > >  lib/livepatch/test_klp_shadow_vars.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
> > > index 02f892f941dc..55e6820430dc 100644
> > > --- a/lib/livepatch/test_klp_shadow_vars.c
> > > +++ b/lib/livepatch/test_klp_shadow_vars.c
> > > @@ -162,15 +162,15 @@ static int test_klp_shadow_vars_init(void)
> > >  	 * to expected data.
> > >  	 */
> > >  	ret = shadow_get(obj, id);
> > > -	if (ret == sv1 && *sv1 == &var1)
> > > +	if (ret && ret == sv1 && *sv1 == &var1)
> > >  		pr_info("  got expected PTR%d -> PTR%d result\n",
> > >  			ptr_id(sv1), ptr_id(*sv1));
> > >  	ret = shadow_get(obj + 1, id);
> > > -	if (ret == sv2 && *sv2 == &var2)
> > > +	if (ret && ret == sv2 && *sv2 == &var2)
> > >  		pr_info("  got expected PTR%d -> PTR%d result\n",
> > >  			ptr_id(sv2), ptr_id(*sv2));
> > >  	ret = shadow_get(obj, id + 1);
> > > -	if (ret == sv3 && *sv3 == &var3)
> > > +	if (ret && ret == sv3 && *sv3 == &var3)
> > >  		pr_info("  got expected PTR%d -> PTR%d result\n",
> > >  			ptr_id(sv3), ptr_id(*sv3));
> > 
> > There is one more similar site calling shadow_get(obj, id + 1) which is 
> > fixed.
> 
> Heh, I think that I did not add the check there on purpose.
> If we are here, shadow_get(obj, id + 1) must have already succeeded
> above.

Yes, but if it failed, you would not notice. The message would not be 
printed and that's all. So it is possible to run into the same problematic 
error condition here.

> But it is a bad practice. We should always check the output.
> I'll do so in v2.

Agreed.

Miroslav
