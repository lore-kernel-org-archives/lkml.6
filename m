Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A264C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDBB2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDBB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeKHEOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:14:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeKHEOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:14:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97D063001DCC;
        Wed,  7 Nov 2018 18:42:47 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F12F5D6A6;
        Wed,  7 Nov 2018 18:42:47 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id B1BF42C1A13; Wed,  7 Nov 2018 19:42:46 +0100 (CET)
Date:   Wed, 7 Nov 2018 19:42:46 +0100
From:   Artem Savkov <asavkov@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix .cold. functions parent symbols search
Message-ID: <20181107184246.GC11183@shodan.usersys.redhat.com>
References: <20181107140559.28504-1-asavkov@redhat.com>
 <20181107170856.usgyzckfirem5qh7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107170856.usgyzckfirem5qh7@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 07 Nov 2018 18:42:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:08:56AM -0600, Josh Poimboeuf wrote:
> On Wed, Nov 07, 2018 at 03:05:59PM +0100, Artem Savkov wrote:
> > The way it is currently done it is possible for read_symbols() to find the
> > same symbol as parent for ".cold" functions.
> 
> I seem to remember having this discussion for kpatch-build, but I forget
> the details.  Can you explain how this can happen (and also add that
> detail to the commit message)?

find_symbol_by_name() traverses the same lists as read_symbols and when
we change sym->name in place without copying it it changes in the list
as well. So if child function is before parent in sec->symbol_list the
same function will be returned as "parent". It is hard for me to put it
into words worthy to be included into commit message.

> I haven't seen any bug reports, is it purely theoretical?

No, 4.20-rc1 (actually anything after 4a60aa05a063 "objtool: Support
per-function rodata sections", before that add_switch_table() doesn't
seem to be called for those .cold. funcs) fails to build for mewith
KCFLAGS="-ffunction-sections -fdata-sections" because objtool is
segfaulting.

> > This leads to a bunch of
> > complications such as func length being set to 0 and a segfault in
> > add_switch_table(). Fix by copying the search string instead of modifying
> > it in place.
> > 
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  tools/objtool/elf.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> > index 6dbb9fae0f9d..781c8afb29b9 100644
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -298,6 +298,7 @@ static int read_symbols(struct elf *elf)
> >  	/* Create parent/child links for any cold subfunctions */
> >  	list_for_each_entry(sec, &elf->sections, list) {
> >  		list_for_each_entry(sym, &sec->symbol_list, list) {
> > +			char *pname;
> >  			if (sym->type != STT_FUNC)
> >  				continue;
> >  			sym->pfunc = sym->cfunc = sym;
> > @@ -305,9 +306,9 @@ static int read_symbols(struct elf *elf)
> >  			if (!coldstr)
> >  				continue;
> >  
> > -			coldstr[0] = '\0';
> > -			pfunc = find_symbol_by_name(elf, sym->name);
> > -			coldstr[0] = '.';
> > +			pname = strndup(sym->name, coldstr - sym->name);
> > +			pfunc = find_symbol_by_name(elf, pname);
> > +			free(pname);
> >  
> >  			if (!pfunc) {
> >  				WARN("%s(): can't find parent function",
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Josh

-- 
Regards,
  Artem
