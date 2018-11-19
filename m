Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A4EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461D12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461D12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeKTE1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:27:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730227AbeKTE1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:27:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD2B6307D853;
        Mon, 19 Nov 2018 18:02:40 +0000 (UTC)
Received: from treble (ovpn-126-32.rdu2.redhat.com [10.10.126.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D58C60C67;
        Mon, 19 Nov 2018 18:02:40 +0000 (UTC)
Date:   Mon, 19 Nov 2018 12:02:33 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] objtool: fix .cold functions parent symbols search
Message-ID: <20181119180233.mdvuah3geacujpr4@treble>
References: <20181112033800.ujolxvkwzz72lxhm@treble>
 <20181112125519.26855-1-asavkov@redhat.com>
 <20181112125519.26855-3-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112125519.26855-3-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 19 Nov 2018 18:02:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:55:19PM +0100, Artem Savkov wrote:
> Because find_symbol_by_name() traverses the same lists as read_symbols()
> changing sym->name in place without copying it affects the result of
> find_symbol_by_name() and, in case when ".cold" function precedes it's
> parent in sec->symbol_list, can result in function being considered a
> parent of itself. This leads to function length being set to 0 and other
> consequent side-effects including a segfault in add_switch_table().
> The effects of this bug are only visible when building with
> -ffunction-sections in KCFLAGS.
> 
> Fix by copying the search string instead of modifying it in place.
> 
> Fixes: 13810435b9a7 "objtool: Support GCC 8's cold subfunctions"

Same here, needs parentheses.

> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  tools/objtool/elf.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 3decd43477df..15d9acfb2c97 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -31,6 +31,8 @@
>  #include "elf.h"
>  #include "warn.h"
>  
> +#define MAX_NAME_LEN 128
> +
>  struct section *find_section_by_name(struct elf *elf, const char *name)
>  {
>  	struct section *sec;
> @@ -298,6 +300,8 @@ static int read_symbols(struct elf *elf)
>  	/* Create parent/child links for any cold subfunctions */
>  	list_for_each_entry(sec, &elf->sections, list) {
>  		list_for_each_entry(sym, &sec->symbol_list, list) {
> +			char pname[MAX_NAME_LEN + 1];
> +			size_t pnamelen;
>  			if (sym->type != STT_FUNC)
>  				continue;
>  			sym->pfunc = sym->cfunc = sym;
> @@ -305,9 +309,16 @@ static int read_symbols(struct elf *elf)
>  			if (!coldstr)
>  				continue;
>  
> -			coldstr[0] = '\0';
> -			pfunc = find_symbol_by_name(elf, sym->name);
> -			coldstr[0] = '.';
> +			pnamelen = coldstr - sym->name;
> +			if (pnamelen > MAX_NAME_LEN) {
> +				WARN("%s(): parent function name exceeds maximum length of %d characters",
> +				     sym->name, MAX_NAME_LEN);
> +				goto cold_err;

Same here, makes more sense to just return -1 and let elf_close() clean
it up I think.

-- 
Josh
