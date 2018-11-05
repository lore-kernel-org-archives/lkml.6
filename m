Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C2920881
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="unoSP/5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C2920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeKFDRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbeKFDRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:17:22 -0500
Received: from jouet.infradead.org (unknown [189.40.101.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0652089F;
        Mon,  5 Nov 2018 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541440590;
        bh=7a7/RXLootrwqDkwddZAt2DgI49+BiDL26V2vHyM5LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unoSP/5Fgox/jfVcQowEeegV7/nokvtTrTIwFfutzJZGd+h+T5kAXFj5abVBOk2mo
         vsrYEb9vhVsxQ46Isesfpwehi+nemtnNb3nS2DU1gzNZs+dPh5sh8AHQQH/F5DGDrT
         xJAvER3T5AShCElhgtkiNXcl0D5YFKpf6/epTCuI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E0A23142D3F; Mon,  5 Nov 2018 14:56:04 -0300 (-03)
Date:   Mon, 5 Nov 2018 14:56:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 3/5] perf tools: Use fallbacks for branch stacks
Message-ID: <20181105175604.GC7077@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031091043.23465-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 31, 2018 at 11:10:41AM +0200, Adrian Hunter escreveu:
> Branch stacks do not necessarily have the same cpumode as the 'ip'. Use the
> fallback functions in those cases.
> 
> This patch depends on patch "perf tools: Add fallback functions for cases
>> where cpumode is insufficient".

This one is ok, i.e. only in places where we need a fallback we do it.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 4.19
> ---
>  tools/perf/builtin-script.c                      | 12 ++++++------
>  .../util/scripting-engines/trace-event-python.c  | 16 ++++++++--------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b5bc85bd0bbe..996317d8e183 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -728,8 +728,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  		if (PRINT_FIELD(DSO)) {
>  			memset(&alf, 0, sizeof(alf));
>  			memset(&alt, 0, sizeof(alt));
> -			thread__find_map(thread, sample->cpumode, from, &alf);
> -			thread__find_map(thread, sample->cpumode, to, &alt);
> +			thread__find_map_fallback(thread, sample->cpumode, from, &alf);
> +			thread__find_map_fallback(thread, sample->cpumode, to, &alt);
>  		}
>  
>  		printed += fprintf(fp, " 0x%"PRIx64, from);
> @@ -775,8 +775,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>  		from = br->entries[i].from;
>  		to   = br->entries[i].to;
>  
> -		thread__find_symbol(thread, sample->cpumode, from, &alf);
> -		thread__find_symbol(thread, sample->cpumode, to, &alt);
> +		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
> +		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
>  
>  		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
>  		if (PRINT_FIELD(DSO)) {
> @@ -820,11 +820,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>  		from = br->entries[i].from;
>  		to   = br->entries[i].to;
>  
> -		if (thread__find_map(thread, sample->cpumode, from, &alf) &&
> +		if (thread__find_map_fallback(thread, sample->cpumode, from, &alf) &&
>  		    !alf.map->dso->adjust_symbols)
>  			from = map__map_ip(alf.map, from);
>  
> -		if (thread__find_map(thread, sample->cpumode, to, &alt) &&
> +		if (thread__find_map_fallback(thread, sample->cpumode, to, &alt) &&
>  		    !alt.map->dso->adjust_symbols)
>  			to = map__map_ip(alt.map, to);
>  
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 69aa93d4ee99..244aeeee9c7a 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -494,14 +494,14 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
>  		pydict_set_item_string_decref(pyelem, "cycles",
>  		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
>  
> -		thread__find_map(thread, sample->cpumode,
> -				 br->entries[i].from, &al);
> +		thread__find_map_fallback(thread, sample->cpumode,
> +					  br->entries[i].from, &al);
>  		dsoname = get_dsoname(al.map);
>  		pydict_set_item_string_decref(pyelem, "from_dsoname",
>  					      _PyUnicode_FromString(dsoname));
>  
> -		thread__find_map(thread, sample->cpumode,
> -				 br->entries[i].to, &al);
> +		thread__find_map_fallback(thread, sample->cpumode,
> +					  br->entries[i].to, &al);
>  		dsoname = get_dsoname(al.map);
>  		pydict_set_item_string_decref(pyelem, "to_dsoname",
>  					      _PyUnicode_FromString(dsoname));
> @@ -576,14 +576,14 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
>  		if (!pyelem)
>  			Py_FatalError("couldn't create Python dictionary");
>  
> -		thread__find_symbol(thread, sample->cpumode,
> -				    br->entries[i].from, &al);
> +		thread__find_symbol_fb(thread, sample->cpumode,
> +				       br->entries[i].from, &al);
>  		get_symoff(al.sym, &al, true, bf, sizeof(bf));
>  		pydict_set_item_string_decref(pyelem, "from",
>  					      _PyUnicode_FromString(bf));
>  
> -		thread__find_symbol(thread, sample->cpumode,
> -				    br->entries[i].to, &al);
> +		thread__find_symbol_fb(thread, sample->cpumode,
> +				       br->entries[i].to, &al);
>  		get_symoff(al.sym, &al, true, bf, sizeof(bf));
>  		pydict_set_item_string_decref(pyelem, "to",
>  					      _PyUnicode_FromString(bf));
> -- 
> 2.17.1
