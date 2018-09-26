Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30A720842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUg9CiNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30A720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeIZUbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeIZUbe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:31:34 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFCD20842;
        Wed, 26 Sep 2018 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537971503;
        bh=EChfn623QGhjNIy+uArELKwSkJMPTVaUqOA5x+00DWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUg9CiNJ1zvXj2BM3pWkyTux8vGJNSYVR0zLlDRZvRmTVcVdAB7NGu4g8rythLJJP
         AcrdQkq1yiSOC8jJcHil3gZNDuG9cWKdKWr60XJe2H+2bbheFKZTbw4oxw8lYX/upH
         qeKTMnRA8tlbn8JvpmDkZHAAEwIryykxA5mLoN5s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7CAEB1401A1; Wed, 26 Sep 2018 11:18:19 -0300 (-03)
Date:   Wed, 26 Sep 2018 11:18:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH 1/3] perf report: don't try to map ip to invalid map
Message-ID: <20180926141819.GD25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926135207.30263-1-milian.wolff@kdab.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 26, 2018 at 03:52:05PM +0200, Milian Wolff escreveu:
> Fixes a crash when the report encounters an address that
> could not be associated with an mmaped region:

Milian, can you spot which cset introduced this problem? So that we can
add a "Fixes: sha" tag in this (and the others, if needed) to help the
stable kernel maintainers to find which kernels this has to be
backported to?

Thanks for working on this!

- Arnaldo
 
> #0  0x00005555557bdc4a in callchain_srcline (ip=<error reading variable: Cannot access memory at address 0x38>, sym=0x0, map=0x0) at util/machine.c:2329
> #1  unwind_entry (entry=entry@entry=0x7fffffff9180, arg=arg@entry=0x7ffff5642498) at util/machine.c:2329
> #2  0x00005555558370af in entry (arg=0x7ffff5642498, cb=0x5555557bdb50 <unwind_entry>, thread=<optimized out>, ip=18446744073709551615) at util/unwind-libunwind-local.c:586
> #3  get_entries (ui=ui@entry=0x7fffffff9620, cb=0x5555557bdb50 <unwind_entry>, arg=0x7ffff5642498, max_stack=<optimized out>) at util/unwind-libunwind-local.c:703
> #4  0x0000555555837192 in _unwind__get_entries (cb=<optimized out>, arg=<optimized out>, thread=<optimized out>, data=<optimized out>, max_stack=<optimized out>) at util/unwind-libunwind-local.c:725
> #5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=127, sample=0x7fffffff9830, evsel=0x555555c7b3b0, cursor=0x7ffff5642498, thread=0x555555c7f6f0) at util/machine.c:2351
> #6  thread__resolve_callchain (thread=0x555555c7f6f0, cursor=0x7ffff5642498, evsel=0x555555c7b3b0, sample=0x7fffffff9830, parent=0x7fffffff97b8, root_al=0x7fffffff9750, max_stack=127) at util/machine.c:2378
> #7  0x00005555557ba4ee in sample__resolve_callchain (sample=<optimized out>, cursor=<optimized out>, parent=parent@entry=0x7fffffff97b8, evsel=<optimized out>, al=al@entry=0x7fffffff9750,
>     max_stack=<optimized out>) at util/callchain.c:1085
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Sandipan Das <sandipan@linux.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/util/machine.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index c4acd2001db0..0cb4f8bf3ca7 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2312,7 +2312,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  {
>  	struct callchain_cursor *cursor = arg;
>  	const char *srcline = NULL;
> -	u64 addr;
> +	u64 addr = entry->ip;
>  
>  	if (symbol_conf.hide_unresolved && entry->sym == NULL)
>  		return 0;
> @@ -2324,7 +2324,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	 * Convert entry->ip from a virtual address to an offset in
>  	 * its corresponding binary.
>  	 */
> -	addr = map__map_ip(entry->map, entry->ip);
> +	if (entry->map)
> +		addr = map__map_ip(entry->map, entry->ip);
>  
>  	srcline = callchain_srcline(entry->map, entry->sym, addr);
>  	return callchain_cursor_append(cursor, entry->ip,
> -- 
> 2.19.0
