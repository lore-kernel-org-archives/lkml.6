Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88A3C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC0320892
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC0320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeLMSvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:51:32 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:52521 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMSvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:51:32 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 9BBCA5C22C4; Thu, 13 Dec 2018 19:51:26 +0100 (CET)
Date:   Thu, 13 Dec 2018 19:51:26 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 V2] livepatch: handle kzalloc failure properly
Message-ID: <20181213185126.GA24202@osadl.at>
References: <1544709956-16701-1-git-send-email-hofrat@osadl.org>
 <1544709956-16701-2-git-send-email-hofrat@osadl.org>
 <daf5bf66-3bcc-476c-6237-0e46028cb269@redhat.com>
 <20181213153954.GA9816@osadl.at>
 <2d712c92-e661-a32c-06cf-4de93ad93f77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d712c92-e661-a32c-06cf-4de93ad93f77@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:39:25AM -0500, Joe Lawrence wrote:
> On 12/13/2018 10:39 AM, Nicholas Mc Guire wrote:
> > On Thu, Dec 13, 2018 at 09:14:18AM -0500, Joe Lawrence wrote:
> >> On 12/13/2018 09:05 AM, Nicholas Mc Guire wrote:
> >>> kzalloc() return should be checked. On dummy_alloc() failing
> >>> in kzalloc() NULL should be returned.
> >>>
> >>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >>> ---
> >>>
> >>> Problem was located with an experimental coccinelle script
> >>>
> >>> V2: returning NULL is ok but not without cleanup - thanks to
> >>>     Petr Mladek <pmladek@suse.com> for catching this.
> >>>
> >>> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> >>> FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y, SAMPLE_LIVEPATCH=y
> >>> (with a number of unrelated sparse warnings on symbols not being static)
> >>>
> >>> Patch is against 4.20-rc6 (localversion-next is next-20181213)
> >>>
> >>>  samples/livepatch/livepatch-shadow-mod.c | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> >>> index 4c54b25..4aa8a88 100644
> >>> --- a/samples/livepatch/livepatch-shadow-mod.c
> >>> +++ b/samples/livepatch/livepatch-shadow-mod.c
> >>> @@ -118,6 +118,10 @@ noinline struct dummy *dummy_alloc(void)
> >>>  
> >>>  	/* Oops, forgot to save leak! */
> >>>  	leak = kzalloc(sizeof(int), GFP_KERNEL);
> >>> +	if (!leak) {
> >>> +		kfree(d);
> >>> +		return NULL;
> >>> +	}
> >>>  
> >>>  	pr_info("%s: dummy @ %p, expires @ %lx\n",
> >>>  		__func__, d, d->jiffies_expire);
> >>>
> >>
> >> Hi Nicholas,
> >>
> >> Thanks for finding and fixing these up... can we either squash these two
> >> patches into a single commit or give them unique subject lines?  Code
> >> looks good (including Petr's suggested fix) otherwise.
> >>
> > yup - makes sense to pop it into a single patch - I assumed that this
> > would not be acceptable - so I actually split it up :)
> > I´ll send a V3 then.
> 
> I don't know if there is a hard rule, but I always thought that unique
> subject lines were desired to avoid grep/search confusion.
>
the duplicated subjectline was my mistake 
 
> As far as one or two commits, I'd prefer a single commit since these are
> so small.  Personal preference, you could just say that you're fixing
> samples/livepatch as a whole.
> 
> > 
> > BTW: wanted to fix up the sparse warnings but I think thats not going
> > to be that simple as the functions/structs sparse complains about
> > are actually being shared:
> 
> Ok, these are welcome too, separate commit...
> 
> >   CHECK   samples/livepatch/livepatch-shadow-fix1.c
> > samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol 'livepatch_fix1_dummy
> > alloc' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-fix1.c:116:6: warning: symbol 'livepatch_fix1_dummy
> > free' was not declared. Should it be static?
> > 
> >   CHECK   samples/livepatch/livepatch-shadow-mod.c
> > samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol 'dummy_list' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol 'dummy_list_mutex' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol 'dummy_alloc' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:132:15: warning: symbol 'dummy_free' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:140:15: warning: symbol 'dummy_check' was not declared. Should it be static?
> > 
> > so to clean that appropriate declarations should probably
> > go into a .h file. Technically its maybe not important as this
> > is not production code - it would though be nice if sample
> > code is sparse/smatch/cocci clean.
> > 
> > would it be acceptable to clean this up with an additional
> > livepatch-shadow-mod.h ?
> 
> I'm not a C language expert, but as I understand it: static functions
> are only a namespacing game for the compiler.  So I think it is safe to
> pass around and call function pointers to static functions between
> compilation units.  At least I see this throughout the kernel, so that
> is my assumption :)
>
I´m not into the details of livepatch but if I declare e.g. dummy_check
static as proposed by sparse and then check the relocs I no longer see
it: 

Without the changes sparse proposes dummy_check is visible
hofrat@debian:~/linux-next/samples/livepatch# readelf --relocs livepatch-shadow-mod.ko  | grep dummy_check
000000000193  002f00000002 R_X86_64_PC32     0000000000000110 dummy_check - 4

When I then try to load livepatch-shadow-fix1.ko which does not have
dummy_check in its klp_func array its ok but livepatch-shadow-fix2.ko
wich has an entry will fail to load. So while this may work with other modules
I think in the live-patch case its not that simple due to the inner workings
of resolving symbols via klp_object and klp_func array.

So I´ll leave that sparse cleanup to someone who understand the inner
workinsgs of livepatch - before I make a mess of it....

thx!
hofrat
