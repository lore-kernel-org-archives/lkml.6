Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869272133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGNtIGEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869272133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeK0XhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeK0XhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:37:19 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023162082F;
        Tue, 27 Nov 2018 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322371;
        bh=AfgRTVYgfc7yXsHN/vsh3aKOWqIh3fZI6cJZIq3kNN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGNtIGElIxUSumtZLlyox4zP7lf6aZnweoqpZc5dgpsayZIQM3dNN1709NiSxuEGE
         eD3pX0YmP0QKITSo3N3VjCEqsvdaGgGkccc22iyoRZFDZZBfZ7d5GuhhNM97Y/DhUU
         eJ/8Ihlfe7oVoLzGSixxevsbQIhWdcKXswF4zV3w=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id CFFFB41114; Tue, 27 Nov 2018 09:39:28 -0300 (-03)
Date:   Tue, 27 Nov 2018 09:39:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix error with config term pt=0
Message-ID: <20181127123928.GB15747@kernel.org>
References: <20181127084336.12142-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127084336.12142-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 27, 2018 at 10:43:36AM +0200, Adrian Hunter escreveu:
> Users should never use 'pt=0', but if they do it may give a meaningless
> error:
> 
> 	$ perf record -e intel_pt/pt=0/u uname
> 	Error:
> 	The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
> 	event (intel_pt/pt=0/u).
> 
> Fix that by forcing 'pt=1'.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/x86/util/intel-pt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index db0ba8caf5a2..af25a7824ee0 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -524,10 +524,18 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
>  				    struct perf_evsel *evsel)
>  {
>  	int err;
> +	char c;
>  
>  	if (!evsel)
>  		return 0;
>  
> +	/*
> +	 * If supported, force pass-through config term (pt=1) even if user
> +	 * sets pt=0, which avoids senseless kernel errors.
> +	 */
> +	if (perf_pmu__scan_file(intel_pt_pmu, "format/pt", "%c", &c) == 1)
> +		evsel->attr.config |= 1;

shouldn't we have a warning like:

   pr_warning("pt=0 doesn't make sense, forcing pt=1")


Instead of silently doing something the user, mistakenly, did
explicitely?

- Arnaldo
  

> +
>  	err = intel_pt_val_config_term(intel_pt_pmu, "caps/cycle_thresholds",
>  				       "cyc_thresh", "caps/psb_cyc",
>  				       evsel->attr.config);
> -- 
> 2.17.1

-- 

- Arnaldo
