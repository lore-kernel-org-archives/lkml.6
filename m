Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84722C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52185224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52185224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeKOSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:46:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:42062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728519AbeKOSqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:46:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90E2AAE78;
        Thu, 15 Nov 2018 08:39:58 +0000 (UTC)
Date:   Thu, 15 Nov 2018 09:39:57 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-ID: <20181115083957.GE23831@dhcp22.suse.cz>
References: <20181113151629.14826-1-urezki@gmail.com>
 <20181113151629.14826-2-urezki@gmail.com>
 <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
 <20181114151737.GA23419@dhcp22.suse.cz>
 <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 15:00:53, Andrew Morton wrote:
> On Wed, 14 Nov 2018 16:17:37 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Tue 13-11-18 14:10:46, Andrew Morton wrote:
> > [...]
> > > > +static int vmalloc_test_init(void)
> > > > +{
> > > > +	__my_vmalloc_node_range =
> > > > +		(void *) kallsyms_lookup_name("__vmalloc_node_range");
> > > > +
> > > > +	if (__my_vmalloc_node_range)
> > > > +		do_concurrent_test();
> > > > +
> > > > +	return -EAGAIN; /* Fail will directly unload the module */
> > > > +}
> > > 
> > > It's unclear why this module needs access to the internal
> > > __vmalloc_node_range().  Please fully explain this in the changelog.
> > > 
> > > Then, let's just export the thing.  (I expect this module needs a
> > > Kconfig dependency on CONFIG_KALLSYMS, btw).  A suitable way of doing
> > > that would be
> > > 
> > > /* Exported for lib/test_vmalloc.c.  Please do not use elsewhere */
> > > EXPORT_SYMBOL_GPL(__vmalloc_node_range);
> > 
> > There was a previous discussion that testing for internal infrastructure
> > is useful quite often and such a testing module needs an access to such
> > an internal infrastructure. Exporting those symbols via standard
> > EXPORT_SYMBOL_GPL is far from optimal because we can be pretty much sure
> > an abuse will arise sooner than later. I was proposing
> > EXPORT_SYMBOL_SELFTEST that would link only against testing modules.
> 
> That's rather overdoing things, I think.  If someone uses a
> dont-use-this symbol then they get to own both pieces when it breaks.

I do not think this has ever worked out. People are abusing internal
stuff and then we have to live with that. That is my experience at
least.

> We could simply do
> 
> #define EXPORT_SYMBOL_SELFTEST EXPORT_SYMBOL_GPL
>
> then write a script which checks the tree for usages of the
> thus-tagged symbols outside tools/testing and lib/ (?)

and then yell at people? We can try it out of course. The namespace
would be quite clear and we could document the supported usage pattern.
We also want to make EXPORT_SYMBOL_SELFTEST conditional. EXPORTs are not
free and we do not want to add them if the whole testing infrastructure
is disabled (assuming there is a global one for that).

> > If that is not viable for some reason then kallsyms_lookup_name is a
> > dirty-but-usable workaround.
> 
> Well yes.  It adds a dependency on CONFIG_KALLSYMS and will cause
> silent breakage if __vmalloc_node_range gets renamed, has its arguments
> changed, etc.

Yeah, I've said dirty ;)

-- 
Michal Hocko
SUSE Labs
