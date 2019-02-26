Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67CC218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfBZWzV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:55:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:16101 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfBZWzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:55:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 14:55:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,416,1544515200"; 
   d="scan'208";a="118024197"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2019 14:55:20 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6499A3002A2; Tue, 26 Feb 2019 14:55:20 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: Support sample context in perf report
References: <20190226030412.23485-1-andi@firstfloor.org>
        <20190226223319.GA2393@krava>
Date:   Tue, 26 Feb 2019 14:55:20 -0800
In-Reply-To: <20190226223319.GA2393@krava> (Jiri Olsa's message of "Tue, 26
        Feb 2019 23:33:19 +0100")
Message-ID: <87pnrerwh3.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
>
> im still getting compile error the new branch:
>
>   CC       ui/browsers/hists.o
> ui/browsers/hists.c: In function ‘perf_evsel__hists_browse’:
> ui/browsers/hists.c:2567:8: error: ‘%s’ directive output may be truncated writing up to 63 bytes into a region of size between 28 and 91 [-Werror=format-truncation=]
>    n += snprintf(script_opt + n, len - n, " --time %s,%s", start, end);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/include/stdio.h:862,
>                  from ui/browsers/hists.c:5:
> /usr/include/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 10 and 136 bytes into a destination of size 100
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __bos (__s), __fmt, __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> mv: cannot stat 'ui/browsers/.hists.o.tmp': No such file or directory

I tested with gcc 8 and it built on a opensuse leap system.

Of course you never know where you end up with the gcc -Werror
russian roulette. I don't think any of those can really overflow,
it's all false positives. This one is particularly annoying
because the compiler seems to assume that every char[] variable
is filled up to the maximum, which is flat out wrong.

Anyways this patch should help.

-Andi

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index e35b274ee863..8ca988506388 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2554,7 +2554,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 	}
 
 	if (act->time) {
-		char start[64], end[64];
+		char start[22], end[22];
 		unsigned long starttime = act->time;
 		unsigned long endtime = act->time + symbol_conf.time_quantum;
 
