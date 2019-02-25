Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58095213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfBYM4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYM4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 806E33DE08;
        Mon, 25 Feb 2019 12:56:10 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id C902810018E0;
        Mon, 25 Feb 2019 12:56:08 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190225125607.GH19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-12-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Feb 2019 12:56:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:22AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> new file mode 100644
> index 000000000000..5b4807c29c2c
> --- /dev/null
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Display a menu with individual samples to browse with perf script */
> +#include "util.h"
> +#include "hist.h"
> +#include "evsel.h"
> +#include "hists.h"
> +#include "sort.h"
> +#include "time-utils.h"
> +
> +/* In ns. Could make configurable. */
> +#define CONTEXT_LEN 100000000
> +
> +int res_sample_browse(struct res_sample *res_samples, int num_res,
> +		      struct perf_evsel *evsel, enum rstype rstype)
> +{
> +	char **names;
> +	int i, n;
> +	int choice;
> +	char *cmd;
> +	char pbuf[256], tidbuf[32], cpubuf[32];
> +	const char *perf = perf_exe(pbuf, sizeof pbuf);
> +	char trange[128], tsample[64];
> +	struct res_sample *r;
> +	char extra_format[256];
> +
> +	/* For now since ui__popup_menu doesn't like lists that don't fit */
> +	num_res = max(min(SLtt_Screen_Rows - 4, num_res), 0);
> +
> +	names = calloc(num_res, sizeof(char *));
> +	if (!names)
> +		return -1;
> +	for (i = 0; i < num_res; i++) {
> +		char tbuf[64];
> +
> +		timestamp__scnprintf_nsec(res_samples[i].time, tbuf, sizeof tbuf);
> +		if (asprintf(&names[i], "%s: CPU %d tid %d", tbuf,
> +			     res_samples[i].cpu, res_samples[i].tid) < 0)
> +			return -1;

leaking names

jirka

> +	}
> +	choice = ui__popup_menu(num_res, names);
> +	for (i = 0; i < num_res; i++)
> +		free(names[i]);
> +	free(names);
> +
> +	if (choice < 0 || choice >= num_res)
> +		return -1;
> +	r = &res_samples[choice];
> +
> +	n = timestamp__scnprintf_nsec(r->time - CONTEXT_LEN, trange, sizeof trange);
> +	trange[n++] = ',';
> +	timestamp__scnprintf_nsec(r->time + CONTEXT_LEN, trange + n, sizeof trange - n);
> +
> +	timestamp__scnprintf_nsec(r->time, tsample, sizeof tsample);
> +
> +	attr_to_script(extra_format, &evsel->attr);
> +
> +	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s | less +/%s",
> +		     perf,
> +		     input_name ? "-i " : "",
> +		     input_name ? input_name : "",
> +		     trange,
> +		     r->cpu ? "--cpu " : "",
> +		     r->cpu ? (sprintf(cpubuf, "%d", r->cpu), cpubuf) : "",
> +		     r->tid ? "--tid " : "",
> +		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
> +		     extra_format,
> +		     rstype == A_ASM ? "-F +insn --xed" :
> +		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
> +		     tsample) < 0)
> +		return -1;
> +	run_script(cmd);
> +	free(cmd);
> +	return 0;
> +}
