Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D212C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F212147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfBTALa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:11:30 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:39317 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbfBTALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:11:30 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 443ygz347Mz204J;
        Wed, 20 Feb 2019 01:11:27 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 185.220.102.7
Received: from uni-erlangen.de (unknown [185.220.102.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18wkvuL4FL63U0NilhTT0wTenLc+RJDtGo=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 443ygw0b8gz20H4;
        Wed, 20 Feb 2019 01:11:23 +0100 (CET)
Date:   Wed, 20 Feb 2019 01:11:16 +0100
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf evsel: add inline functions to sample callchain
 output
Message-ID: <20190220001116.3b3yyndjjmqs3hmm@studium.uni-erlangen.de>
References: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
 <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aab7b5b0816426fed3cb2f2a2ba08e73e4c51e2.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:38:10PM +0100, Jonas Rabenstein wrote:
> Whenever a callchain shall be printed search for each address whether
> inline information is available and add those symbols to the output
> if symbol_conf.inline_name is enabled.
> 
> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> ---
>  tools/perf/util/evsel_fprintf.c | 46 +++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index c710f687ddf4..9f9ece453dc4 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -168,6 +168,49 @@ static int __fprintf_callchain_link(u64 ip, struct map *map, struct symbol *symb
>  	return printed;
>  }
>  
> +static int __fprintf_callchain_inlines(struct callchain_cursor_node *node,
> +				       bool first, int left_alignment,
> +				       unsigned int print_opts, FILE *fp)
> +{
> +	int printed = 0;
> +	struct inline_node *inline_node;
> +	struct inline_list *ilist;
> +	u64 addr;
> +
> +	if (!symbol_conf.inline_name)
> +		return 0;
> +
> +	if (!node->map || !node->map->dso)
> +		return 0;
> +
> +	addr = node->map->map_ip(node->map, node->ip);
I stumbled across a problem with the usage of map_ip here. Using the map_ip
on dynamic binaries does resolve the inline symbols but it fails with static
ones. Using node->ip directly works for static binaries but fails for
static ones...
Is there a way to decide whether node->map->dso is a static or dynamic
object file? Furthermore, is it even correct for a static dso to have
map->map_ip set to map__map_ip instead of identity__map_ip?
> +
> +	inline_node = inlines__tree_find(&node->map->dso->inlined_nodes,
> +					 addr);
> +	if (!inline_node) {
> +		inline_node = dso__parse_addr_inlines(node->map->dso,
> +						      addr, node->sym);
> +		if (!inline_node)
> +			return 0;
> +		inlines__tree_insert(&node->map->dso->inlined_nodes,
> +				     inline_node);
> +	}
> +
> +	list_for_each_entry(ilist, &inline_node->val, list) {
> +		if (ilist->symbol == node->sym)
> +			break;
> +
> +		printed += __fprintf_callchain_link(node->ip, node->map,
> +						    ilist->symbol,
> +						    ilist->srcline,
> +						    first, left_alignment,
> +						    print_opts, fp);
> +		first = (first && printed == 0);
> +	}
> +
> +	return printed;
> +}
> +
>  int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			      unsigned int print_opts, struct callchain_cursor *cursor,
>  			      FILE *fp)
> @@ -183,6 +226,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (!node)
>  				break;
>  
> +			printed += __fprintf_callchain_inlines(node, (printed ==  0),
> +							       left_alignment,
> +							       print_opts, fp);
>  
>  			printed += __fprintf_callchain_link(node->ip, node->map,
>  							    node->sym, NULL,
> -- 
> 2.19.2
> 
