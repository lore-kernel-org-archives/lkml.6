Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD2BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BEF20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BEF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeGIOEt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:04:49 -0400
Received: from foss.arm.com ([217.140.101.70]:59624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932827AbeGIOEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:04:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6FC9ED1;
        Mon,  9 Jul 2018 07:04:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C843F589;
        Mon,  9 Jul 2018 07:04:41 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:04:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 03:54:09PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > index f98a097e73f2..d65327cb83c9 100644
> > --- a/drivers/base/devres.c
> > +++ b/drivers/base/devres.c
> > @@ -24,8 +24,12 @@ struct devres_node {
> >  
> >  struct devres {
> >  	struct devres_node		node;
> > -	/* -- 3 pointers */
> > -	unsigned long long		data[];	/* guarantee ull alignment */
> > +	/*
> > +	 * data[] must be 64 bit aligned even on 32 bit architectures
> > +	 * because it might be accessed by instructions that require
> > +	 * aligned memory arguments such as atomic64_t.
> > +	 */
> > +	u8 __aligned(8)			data[];
> >  };
> 
> From a quick reading in Documentation/driver-model/devres.txt this
> devres muck is supposed to be device memory, right?

It's for associating resources (e.g. memory allocations) with a struct
device.

e.g. you do:

	devm_kmalloc(dev, size, GFP_KERNEL);

... and that allocates sizeof(struct devres) + size, putting some
accounting data into that devres, and returning a pointer to the
remaining size bytes.

The data[] thing is a hack to ensure that the structure is padded to
64-bit alignment, in case you'd done:

struct foo {
	atomic64_t counter;
}

struct foo *f = devm_kmalloc(dev, sizeof(*f), GFP_KERNEL);

Mark.
