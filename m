Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2342C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC92081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BC92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeKHCkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:40:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeKHCkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:40:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4975307CDC2;
        Wed,  7 Nov 2018 17:09:02 +0000 (UTC)
Received: from treble (ovpn-121-72.rdu2.redhat.com [10.10.121.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C64B118EC6;
        Wed,  7 Nov 2018 17:08:58 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:08:56 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix .cold. functions parent symbols search
Message-ID: <20181107170856.usgyzckfirem5qh7@treble>
References: <20181107140559.28504-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107140559.28504-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 07 Nov 2018 17:09:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 03:05:59PM +0100, Artem Savkov wrote:
> The way it is currently done it is possible for read_symbols() to find the
> same symbol as parent for ".cold" functions.

I seem to remember having this discussion for kpatch-build, but I forget
the details.  Can you explain how this can happen (and also add that
detail to the commit message)?  I haven't seen any bug reports, is it
purely theoretical?

> This leads to a bunch of
> complications such as func length being set to 0 and a segfault in
> add_switch_table(). Fix by copying the search string instead of modifying
> it in place.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  tools/objtool/elf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 6dbb9fae0f9d..781c8afb29b9 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -298,6 +298,7 @@ static int read_symbols(struct elf *elf)
>  	/* Create parent/child links for any cold subfunctions */
>  	list_for_each_entry(sec, &elf->sections, list) {
>  		list_for_each_entry(sym, &sec->symbol_list, list) {
> +			char *pname;
>  			if (sym->type != STT_FUNC)
>  				continue;
>  			sym->pfunc = sym->cfunc = sym;
> @@ -305,9 +306,9 @@ static int read_symbols(struct elf *elf)
>  			if (!coldstr)
>  				continue;
>  
> -			coldstr[0] = '\0';
> -			pfunc = find_symbol_by_name(elf, sym->name);
> -			coldstr[0] = '.';
> +			pname = strndup(sym->name, coldstr - sym->name);
> +			pfunc = find_symbol_by_name(elf, pname);
> +			free(pname);
>  
>  			if (!pfunc) {
>  				WARN("%s(): can't find parent function",
> -- 
> 2.17.2
> 

-- 
Josh
