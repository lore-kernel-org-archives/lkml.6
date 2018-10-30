Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12835C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91B620838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91B620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeJaHfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:35:34 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:38592 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbeJaHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:35:34 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 7DABE1A402D8; Tue, 30 Oct 2018 15:40:12 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:40:12 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Waiman Long <longman@redhat.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181030224012.mgatj7ddhj3sefkv@shells.gnugeneration.com>
References: <20181029192521.23059-1-dave@stgolabs.net>
 <0afed890-7c5a-93ee-cdb9-e30775bd9cf1@redhat.com>
 <20181029200050.iejuxckzbm742dmw@linux-r8p5>
 <3c5ba85b-5114-c751-0114-ac2cb64c02ea@redhat.com>
 <20181029203818.pot26ewxbncfrnua@linux-r8p5>
 <b40690db-273f-ff67-01bf-de0111deb499@redhat.com>
 <20181029212314.nwruqg6au23ebqlu@shells.gnugeneration.com>
 <20181030185756.w3f2trelb7nikgmk@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030185756.w3f2trelb7nikgmk@linux-r8p5>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:57:56AM -0700, Davidlohr Bueso wrote:
> On Mon, 29 Oct 2018, Vito Caputo wrote:
> 
> > I'm definitely not in favor of just adding another stat file that is the
> > same format as the existing one with the intrs zeroed out.  It's a dirty
> > hack; fine for your local needs but too gross for upstream IMHO.
> 
> I suspect very few users of /proc/stat actually use the irq fields in the
> first place. So the common case ends up doing unnecessary operations. The
> stat2 approach is not perfect, but I think it's the best approach so far.
> This sort of renaming is not uncommon when we cannot break userspace, and
> its not like procfs is not already far contaminated already.
> 
> There are not enough users that care about this stuff, afaik. What you
> suggest sounds like a lot of over-engineering.
> 

What you suggest sounds like a kludge with zero engineering at all.

My suggestion might be stupid, insofar as the same thing can be achieved
using ioctls without assigning surprising semantics to an existing vfs
api.  But I think the spirit of the suggestion is a reasonable
compromise, if /proc/stat is not a deprecated interface and it's
too difficult to make everything it collects sufficiently efficient on
any size machine.

If you create /proc/stat2 to omit interrupts, do we then create
/proc/stat3 to omit CPUs when just interrupts are of interest to the
application running on a 256-cpu machine?

Furthermore, your rationale of procfs already being contaminated is an
active embrace of the broken windows effect.  If you recognize something
is flawed, it's cause to work harder to improve the situation when
working in the flawed area, not worsen it.

Regards,
Vito Caputo
