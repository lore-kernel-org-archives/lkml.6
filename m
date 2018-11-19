Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9323FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6475E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6475E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeKTEVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:21:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732234AbeKTEVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:21:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51A5980470;
        Mon, 19 Nov 2018 17:57:13 +0000 (UTC)
Received: from treble (ovpn-126-32.rdu2.redhat.com [10.10.126.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC054662C5;
        Mon, 19 Nov 2018 17:57:12 +0000 (UTC)
Date:   Mon, 19 Nov 2018 11:57:10 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] objtool: fix failed cold symbol doublefree
Message-ID: <20181119175710.6tcqxtevhg422wsg@treble>
References: <20181112033800.ujolxvkwzz72lxhm@treble>
 <20181112125519.26855-1-asavkov@redhat.com>
 <20181112125519.26855-2-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112125519.26855-2-asavkov@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 19 Nov 2018 17:57:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 01:55:18PM +0100, Artem Savkov wrote:
> If read_symbols() fails during second list traversal (the one dealing
> with ".cold" subfunctions) it frees the symbol, but never deletes it
> from the list/hash_table resulting in symbol being freed again in
> elf_close().
> 
> Fixes: 13810435b9a7 "objtool: Support GCC 8's cold subfunctions"

This needs parentheses, like:

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")

> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  tools/objtool/elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index 6dbb9fae0f9d..3decd43477df 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -312,7 +312,7 @@ static int read_symbols(struct elf *elf)
>  			if (!pfunc) {
>  				WARN("%s(): can't find parent function",
>  				     sym->name);
> -				goto err;
> +				goto cold_err;

Since it will get freed properly in elf_close() anyway, maybe it would
be simpler to just 'return -1' here.

>  			}
>  
>  			sym->pfunc = pfunc;
> @@ -336,6 +336,9 @@ static int read_symbols(struct elf *elf)
>  
>  	return 0;
>  
> +cold_err:
> +	list_del(&sym->list);
> +	hash_del(&sym->hash);
>  err:
>  	free(sym);
>  	return -1;
> -- 
> 2.17.2
> 

-- 
Josh
