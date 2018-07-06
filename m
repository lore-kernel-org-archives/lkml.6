Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761EAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3155023DAF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3155023DAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbeGFPgx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:36:53 -0400
Received: from foss.arm.com ([217.140.101.70]:38924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754048AbeGFPgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:36:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D328318A;
        Fri,  6 Jul 2018 08:36:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5DC83F2EA;
        Fri,  6 Jul 2018 08:36:50 -0700 (PDT)
Date:   Fri, 6 Jul 2018 16:36:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] radix-tree: avoid NULL dereference
Message-ID: <20180706153640.53ot2cqm3varx7td@lakrids.cambridge.arm.com>
References: <20180706134144.48446-1-mark.rutland@arm.com>
 <20180706142540.GB20816@bombadil.infradead.org>
 <20180706143603.xrjt4wn5pkuy25sf@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706143603.xrjt4wn5pkuy25sf@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:36:04PM +0100, Mark Rutland wrote:
> On Fri, Jul 06, 2018 at 07:25:40AM -0700, Matthew Wilcox wrote:
> > On Fri, Jul 06, 2018 at 02:41:44PM +0100, Mark Rutland wrote:
> > > When idr_alloc() is called for the first time on an IDR (which has no
> > > nodes in its radix tree), we end up with calculate_count() calling
> > > get_slot_offset() with a NULL node, leading to a NULL pointer
> > > dereference caught by UBSAN:
> > 
> > Thanks!
> > 
> > > The result of the load is passed into node_tag_get(), which ignores the
> > > value when node is NULL. Typically, the compiler inlines both
> > > get_slot_offset() and node_tag_get() into calculate_count(), optimizing
> > > away the NULL-pointer dereference, and hence this doesn't typically
> > > result in a boot failure.
> > > 
> > > We can't rely on the compiler always doing this, and must avoid
> > > dereferencing fields from node when it is potentially NULL.
> > > 
> > > To do so, this patch folds the generation of offset into tag_get(), such
> > > that this only happens when node is not NULL. Callers are updated to
> > > pass the relevant slot, rather than the offset derived from it.
> > 
> > I did think about this ... honest!  My reasoning clearly glitched at some
> > point.  I think this is the right way to fix the problem.
> > 
> > Acked-by: Matthew Wilcox <willy@infradead.org>
> 
> Cheers!
> 
> I assume that Andrew will pick this up, if he's also happy with it.

I've just started fuzzing, and found this also applies with
node_tag_set(). I'll spin a v2 with that fixed up, too.

Thanks,
Mark.
