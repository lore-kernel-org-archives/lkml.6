Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3651C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7700C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKHGBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:01:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeKHGBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:01:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97236307DAA9;
        Wed,  7 Nov 2018 20:29:44 +0000 (UTC)
Received: from treble (ovpn-121-72.rdu2.redhat.com [10.10.121.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1390060851;
        Wed,  7 Nov 2018 20:29:43 +0000 (UTC)
Date:   Wed, 7 Nov 2018 14:29:42 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix .cold. functions parent symbols search
Message-ID: <20181107202942.s24ej5mnh4b3mflw@treble>
References: <20181107140559.28504-1-asavkov@redhat.com>
 <20181107170856.usgyzckfirem5qh7@treble>
 <20181107184246.GC11183@shodan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107184246.GC11183@shodan.usersys.redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 07 Nov 2018 20:29:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 07:42:46PM +0100, Artem Savkov wrote:
> On Wed, Nov 07, 2018 at 11:08:56AM -0600, Josh Poimboeuf wrote:
> > On Wed, Nov 07, 2018 at 03:05:59PM +0100, Artem Savkov wrote:
> > > The way it is currently done it is possible for read_symbols() to find the
> > > same symbol as parent for ".cold" functions.
> > 
> > I seem to remember having this discussion for kpatch-build, but I forget
> > the details.  Can you explain how this can happen (and also add that
> > detail to the commit message)?
> 
> find_symbol_by_name() traverses the same lists as read_symbols and when
> we change sym->name in place without copying it it changes in the list
> as well. So if child function is before parent in sec->symbol_list the
> same function will be returned as "parent".

Ah, I see.

> It is hard for me to put it into words worthy to be included into
> commit message.

The above description made sense to me, so it sounds like you're on the
right path :-)

> > I haven't seen any bug reports, is it purely theoretical?
> 
> No, 4.20-rc1 (actually anything after 4a60aa05a063 "objtool: Support
> per-function rodata sections", before that add_switch_table() doesn't
> seem to be called for those .cold. funcs) fails to build for mewith
> KCFLAGS="-ffunction-sections -fdata-sections" because objtool is
> segfaulting.

If you only see it triggered with -ffunction-sections, that would be
another useful nugget for the commit log.

Also, if it's fixing a regression, be sure to add the 'Fixes' tag.

Thanks!

-- 
Josh
