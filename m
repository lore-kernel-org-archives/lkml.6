Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E54022419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E54022419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeKOJGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:06:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeKOJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:06:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB38BB6B;
        Wed, 14 Nov 2018 23:00:54 +0000 (UTC)
Date:   Wed, 14 Nov 2018 15:00:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/1] vmalloc: add test driver to analyse vmalloc
 allocator
Message-Id: <20181114150053.c3fe42507923322a0a10ae1c@linux-foundation.org>
In-Reply-To: <20181114151737.GA23419@dhcp22.suse.cz>
References: <20181113151629.14826-1-urezki@gmail.com>
        <20181113151629.14826-2-urezki@gmail.com>
        <20181113141046.f62f5bd88d4ebc663b0ac100@linux-foundation.org>
        <20181114151737.GA23419@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 16:17:37 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Tue 13-11-18 14:10:46, Andrew Morton wrote:
> [...]
> > > +static int vmalloc_test_init(void)
> > > +{
> > > +	__my_vmalloc_node_range =
> > > +		(void *) kallsyms_lookup_name("__vmalloc_node_range");
> > > +
> > > +	if (__my_vmalloc_node_range)
> > > +		do_concurrent_test();
> > > +
> > > +	return -EAGAIN; /* Fail will directly unload the module */
> > > +}
> > 
> > It's unclear why this module needs access to the internal
> > __vmalloc_node_range().  Please fully explain this in the changelog.
> > 
> > Then, let's just export the thing.  (I expect this module needs a
> > Kconfig dependency on CONFIG_KALLSYMS, btw).  A suitable way of doing
> > that would be
> > 
> > /* Exported for lib/test_vmalloc.c.  Please do not use elsewhere */
> > EXPORT_SYMBOL_GPL(__vmalloc_node_range);
> 
> There was a previous discussion that testing for internal infrastructure
> is useful quite often and such a testing module needs an access to such
> an internal infrastructure. Exporting those symbols via standard
> EXPORT_SYMBOL_GPL is far from optimal because we can be pretty much sure
> an abuse will arise sooner than later. I was proposing
> EXPORT_SYMBOL_SELFTEST that would link only against testing modules.

That's rather overdoing things, I think.  If someone uses a
dont-use-this symbol then they get to own both pieces when it breaks.

We could simply do

#define EXPORT_SYMBOL_SELFTEST EXPORT_SYMBOL_GPL

then write a script which checks the tree for usages of the
thus-tagged symbols outside tools/testing and lib/ (?)

> If that is not viable for some reason then kallsyms_lookup_name is a
> dirty-but-usable workaround.

Well yes.  It adds a dependency on CONFIG_KALLSYMS and will cause
silent breakage if __vmalloc_node_range gets renamed, has its arguments
changed, etc.

