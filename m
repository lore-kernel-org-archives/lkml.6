Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48590C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E161208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUeY81Wn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E161208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeK0Xeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbeK0Xdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:44 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958E92133F;
        Tue, 27 Nov 2018 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322156;
        bh=xPv64x1aRiEoidxOcTjdaMexg6PeHgt9/+1iQeeDSCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUeY81WnLs8KqXEpV9FVB5EX3a0RlOhOYYwCcq5oGnIOPhLMquLI6UPZ27nsXMDcC
         /7USlQLsZFVDsM0vpVcdHLpS3+HU1FkXPA2DhQ/lOHKCVoVQgzR+JFzKkH7yNE/UG8
         5ERRU3YFfAkwH9MM1L0maS5F2l7L/RFhhk+LEl1k=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 487BB41118; Mon, 26 Nov 2018 17:06:25 -0300 (-03)
Date:   Mon, 26 Nov 2018 17:06:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests record: Allow for 'sleep' being 'coreutils'
Message-ID: <20181126200625.GH18491@kernel.org>
References: <20181122135545.16295-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122135545.16295-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 03:55:45PM +0200, Adrian Hunter escreveu:
> If the 'sleep' command is provided by coreutils, then the "PERF_RECORD_*
> events & perf_sample fields" test will fail because the MMAP name is
> 'coreutils' not 'sleep', and there is an extra COMM event. Fix the test to
> detect that case.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/perf-record.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index 34394cc05077..07f6bd8ed719 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -58,6 +58,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  	char *bname, *mmap_filename;
>  	u64 prev_time = 0;
>  	bool found_cmd_mmap = false,
> +	     found_coreutils_mmap = false,
>  	     found_libc_mmap = false,
>  	     found_vdso_mmap = false,
>  	     found_ld_mmap = false;
> @@ -254,6 +255,8 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  					if (bname != NULL) {
>  						if (!found_cmd_mmap)
>  							found_cmd_mmap = !strcmp(bname + 1, cmd);
> +						if (!found_coreutils_mmap)
> +							found_coreutils_mmap = !strcmp(bname + 1, "coreutils");
>  						if (!found_libc_mmap)
>  							found_libc_mmap = !strncmp(bname + 1, "libc", 4);
>  						if (!found_ld_mmap)
> @@ -292,7 +295,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  	}
>  
>  found_exit:
> -	if (nr_events[PERF_RECORD_COMM] > 1) {
> +	if (nr_events[PERF_RECORD_COMM] > 1 + !!found_coreutils_mmap) {
>  		pr_debug("Excessive number of PERF_RECORD_COMM events!\n");
>  		++errs;
>  	}
> @@ -302,7 +305,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
>  		++errs;
>  	}
>  
> -	if (!found_cmd_mmap) {
> +	if (!found_cmd_mmap && !found_coreutils_mmap) {
>  		pr_debug("PERF_RECORD_MMAP for %s missing!\n", cmd);
>  		++errs;
>  	}
> -- 
> 2.17.1

-- 

- Arnaldo
