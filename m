Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7913C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C64B24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C64B24207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934456AbeGDJEv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:04:51 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:57700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932376AbeGDJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:04:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 927161800B451;
        Wed,  4 Jul 2018 09:04:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gate60_c83badddf347
X-Filterd-Recvd-Size: 3055
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Jul 2018 09:04:45 +0000 (UTC)
Message-ID: <8dc61092669356f5417bc275e3b7c69ce637e63e.camel@perches.com>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 04 Jul 2018 02:04:44 -0700
In-Reply-To: <20180704072308.GA458@jagdpanzerIV>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
         <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
         <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
         <20180704070305.GB4352@rapoport-lnx> <20180704072308.GA458@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 16:23 +0900, Sergey Senozhatsky wrote:
> On (07/04/18 10:03), Mike Rapoport wrote:
> > > %p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67
> > > 
> > > I think it'd be simplest to just convert
> > > all the %pF and %pf uses all at once.
> > > 
> > > $ git grep --name-only "%p[Ff]" | \
> > >   xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'
> > > 
> > > and remove the appropriate Documentation bit.
> > > 
> > 
> > Something like this:
> > 
> > From 0d3e7cf494123c2640b9a892160d2e2430787004 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Date: Wed, 4 Jul 2018 09:55:50 +0300
> > Subject: [PATCH] treewide: retire '%pF/%pf'
> > 
> > %p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67
> > ("symbol lookup: introduce dereference_symbol_descriptor()")
> > 
> > Replace their uses with %p[Ss] with
> > 
> > $ git grep --name-only "%p[Ff]" | \
> >   xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'
> 
> 
> Sorry, NACK on lib/vsprintf.c part
> 
> I definitely didn't want to do this tree-wide pf->ps conversion when
> I introduced my patch set. pf/pF should have never existed, true,
> but I think we must support pf/pF in vsprintf(). Simply because it
> has been around for *far* too long.

And?  checkpatch warns about %p[Ff] uses.

> People tend to develop "habits",
> you know, I'm quite sure ppc/hppa/etc folks still do [and will] use
> pf/pF occasionally.

There's this saying about habits made to be broken.
This is one of those habits.

I'd expect more people probably get the %pS or %ps wrong
than use %pF.

And most people probably look for examples in code and
copy instead of thinking what's correct, so removing old
and deprecated uses from existing code is a good thing.

