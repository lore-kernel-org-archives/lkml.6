Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135920652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9135920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeJVSBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:01:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJVSBG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1DAA5A1C4;
        Mon, 22 Oct 2018 09:43:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5B98A5D777;
        Mon, 22 Oct 2018 09:43:18 +0000 (UTC)
Date:   Mon, 22 Oct 2018 11:43:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Message-ID: <20181022094317.GG2452@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <20181021191424.16183-2-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021191424.16183-2-milian.wolff@kdab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 22 Oct 2018 09:43:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 09:14:24PM +0200, Milian Wolff wrote:
> When the perf script output is written to a terminal stream,
> the normal output of `perf script` would get buffered, but its
> debug output would be written directly. This made it quite hard
> to figure out where a given debug output is coming from. We can
> improve on this by flushing the output buffer after processing an
> event. To see the value, compare the following output for a
> `perf script -v` run:
> 
> Before this patch:
> ```
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> unwind: find_proc_info dso /usr/lib/ld-2.28.so
> unwind: reg 6, val 0
> unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> unwind: find_proc_info dso /usr/lib/ld-2.28.so
> unwind: reg 6, val 0
> unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> unwind: find_proc_info dso /usr/lib/ld-2.28.so
> unwind: reg 6, val 0
> unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> ... lots and lots of verbose debug output
> cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
>             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> 
> cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
>             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> ...
> ```
> 
> After this patch:
> ```
> ...
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> unwind: find_proc_info dso /usr/lib/ld-2.28.so
> unwind: reg 6, val 0
> unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
>             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> 
> unwind: reg 16, val 7faf7dfdc000
> unwind: reg 7, val 7ffc80811e30
> unwind: find_proc_info dso /usr/lib/ld-2.28.so
> unwind: reg 6, val 0
> unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
> cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
>             7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
> ...
> ```
> 
> This new output format makes it much easier to use perf script
> output for debugging purposes, e.g. to investigate broken dwarf
> unwinding.

yep, I plan to check on this ;-)

> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> ---
>  tools/perf/builtin-script.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index bd468b90801b..ca09b7d2adb7 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script *script,
>  
>  	if (PRINT_FIELD(METRIC))
>  		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
> +
> +	if (verbose)
> +		fflush(fp);

should we call fflush(NULL) to dump all the streams?

the verbose goes to stderr and fp seems to be stdout byt default

jirka
