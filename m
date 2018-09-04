Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB2D20658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB2D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIEAFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:05:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47750 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeIEAFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:05:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E7CC80D;
        Tue,  4 Sep 2018 12:38:38 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A564D3F575;
        Tue,  4 Sep 2018 12:38:37 -0700 (PDT)
Date:   Tue, 4 Sep 2018 14:38:36 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     <acme@kernel.org>, <jolsa@kernel.org>, <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 6/8] perf, tools, script: Make itrace script default
 to all calls
Message-Id: <20180904143836.43f1c07134e25bda6fa0842c@arm.com>
In-Reply-To: <20180903162249.36304-7-andi@firstfloor.org>
References: <20180903162249.36304-1-andi@firstfloor.org>
        <20180903162249.36304-7-andi@firstfloor.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 09:22:47 -0700
Andi Kleen <andi@firstfloor.org> wrote:

<snip>
> Fix ETM build failure
> ---
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2ae640257fdb..0296405f38b2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1432,7 +1432,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
>  		etm->synth_opts = *session->itrace_synth_opts;
>  	} else {
> -		itrace_synth_opts__set_default(&etm->synth_opts);
> +		itrace_synth_opts__set_default(&etm->synth_opts,
> +				etm->synth_opts->default_no_sample);

This still fails but with a different error:

  CC       util/cs-etm.o
util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info’:
util/cs-etm.c:1436:20: error: invalid type argument of ‘->’ (have ‘struct itrace_synth_opts’)
     etm->synth_opts->default_no_sample);
                    ^~

I tried this diff, and it built:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0296405f38b2..3b37d66dc533 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1433,7 +1433,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
                etm->synth_opts = *session->itrace_synth_opts;
        } else {
                itrace_synth_opts__set_default(&etm->synth_opts,
-                               etm->synth_opts->default_no_sample);
+                               session->itrace_synth_opts->default_no_sample);
                etm->synth_opts.callchain = false;
        }
 
So please incorporate it in this patch.

FYI, building-in cs-etm decoding into perf depends on
CONFIG_LIBOPENCSD.  Debian has a package 'libopencsd' that provides
it.  I don't know about other distros, but it's possible to build and
install the library from scratch:

https://github.com/Linaro/OpenCSD/

Thanks,

Kim
