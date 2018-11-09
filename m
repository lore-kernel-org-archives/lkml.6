Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFA420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFA420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeKJDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:04:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:04:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C66E081E05;
        Fri,  9 Nov 2018 17:23:12 +0000 (UTC)
Received: from treble (ovpn-124-61.rdu2.redhat.com [10.10.124.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46460600CD;
        Fri,  9 Nov 2018 17:23:12 +0000 (UTC)
Date:   Fri, 9 Nov 2018 11:23:09 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: fix .cold. functions parent symbols search
Message-ID: <20181109172309.myxc2owh3k5v2wfb@treble>
References: <20181107202942.s24ej5mnh4b3mflw@treble>
 <20181107214515.9183-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181107214515.9183-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 09 Nov 2018 17:23:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:45:15PM +0100, Artem Savkov wrote:
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
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

This needs a "Fixes" tag to identify the patch which introduced the bug.

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

strndup()'s return code needs to be checked.

Also, for such a short-lived allocation, I think a stack-allocated
string would be better.

-- 
Josh
