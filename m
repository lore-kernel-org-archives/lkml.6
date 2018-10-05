Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F7120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0yWdiVgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F7120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJEVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbeJEVKH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:10:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 713B220834;
        Fri,  5 Oct 2018 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538748673;
        bh=/gYQ3YBKLjsSJyrjHav6MmYheGFP3uG6ISRqlwHq5/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0yWdiVgRVGqsauZ+N8k14l6GgwLixuMIhYyG/yljepdNcP4DlTPzfvQGwTduWUPaJ
         ozqBl59T9jfZHRkN/QebiVdvSkYLQkAVPZWC/H/KLXlJIPP+YSvKqP4kCIeBjNU3Ib
         ElMey6qwgbjgrNtZA3DKQ+DvyQgnwgKiEPRXRGOU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1FE76141DDC; Fri,  5 Oct 2018 11:11:10 -0300 (-03)
Date:   Fri, 5 Oct 2018 11:11:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Message-ID: <20181005141110.GB20250@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002073949.3297-1-milian.wolff@kdab.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 02, 2018 at 09:39:49AM +0200, Milian Wolff escreveu:
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> # Tested-by:
> # Reviewed-by:
> # Suggested-b:
> Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug information")

No, the patch that Ravi pointed out as causing the regression wasn't the
one above, it was this one:

"perf report: Use the offset address to find inline frames"

I'm reworking this again...

- Arnaldo

> ---
>  tools/perf/util/machine.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 73a651f10a0f..111ae858cbcb 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *cursor,
>  	if (!symbol_conf.inline_name || !map || !sym)
>  		return ret;
>  
> -	addr = map__rip_2objdump(map, ip);
> +	addr = map__map_ip(map, ip);
> +	addr = map__rip_2objdump(map, addr);
>  
>  	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
>  	if (!inline_node) {
> @@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
>  
> +	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
> +		return 0;
> +
>  	/*
>  	 * Convert entry->ip from a virtual address to an offset in
>  	 * its corresponding binary.
> @@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	if (entry->map)
>  		addr = map__map_ip(entry->map, entry->ip);
>  
> -	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
> -		return 0;
> -
>  	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
>  				       entry->map, entry->sym,
> -- 
> 2.19.0
