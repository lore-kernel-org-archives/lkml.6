Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E520671
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Shmi0k9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1E520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbeKVHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732609AbeKVHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:40:27 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B10E420645;
        Wed, 21 Nov 2018 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542834268;
        bh=VBnwCBHt5PYFkyuuoGMwaDcL2ukl6sOZepvIvuLIqNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Shmi0k9Gm3Jq0mP3E9zZl6eh8Uyf1O91RdKdhJ67LECP0RoNZgfoJgQbxV7gcVQD4
         6/zDVsLYDznAiqeXj4YCHbU1f5EAt71aH9DEnkOzGHVkemKjRxDSNx7ceHTQpk9npd
         3ASzRXxiXJH6bf09AgQ5zgRQL3P/bIGZI8t5Pxf8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E851D1443D9; Wed, 21 Nov 2018 18:04:25 -0300 (-03)
Date:   Wed, 21 Nov 2018 18:04:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH] perf pmu: Move *_cpuid_str() weak functions to header.c
Message-ID: <20181121210425.GJ6248@kernel.org>
References: <20181121164939.13482-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121164939.13482-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 21, 2018 at 08:49:39AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The weak functions, strcmp_cpuid_str() and get_cpuid_str(), are defined
> in pmu.c.
> Most of the cpuid related functions, including *_cpuid_str()'s
> declaration and platform specific definition, are in header.c/h.
> 
> To make the declaration and definition of all cpuid related functions in
> a consistent place, move the weak functions to header.c.
> 
> There is no functional change.

Thanks, applied.

- Arnaldo
 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> ---
> 
> Based on tmp.perf/core branch, on top of
> commit 	649d656ba01f ("perf vendor events: Add JSON metrics for Cascadelake server")
> 
>  tools/perf/util/header.c | 39 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c    | 39 ---------------------------------------
>  2 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4fd45be95a43..e31f52845e77 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -987,6 +987,45 @@ static int write_group_desc(struct feat_fd *ff,
>  	return 0;
>  }
>  
> +/*
> + * Return the CPU id as a raw string.
> + *
> + * Each architecture should provide a more precise id string that
> + * can be use to match the architecture's "mapfile".
> + */
> +char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> +{
> +	return NULL;
> +}
> +
> +/* Return zero when the cpuid from the mapfile.csv matches the
> + * cpuid string generated on this platform.
> + * Otherwise return non-zero.
> + */
> +int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
> +{
> +	regex_t re;
> +	regmatch_t pmatch[1];
> +	int match;
> +
> +	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
> +		/* Warn unable to generate match particular string. */
> +		pr_info("Invalid regular expression %s\n", mapcpuid);
> +		return 1;
> +	}
> +
> +	match = !regexec(&re, cpuid, 1, pmatch, 0);
> +	regfree(&re);
> +	if (match) {
> +		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
> +
> +		/* Verify the entire string matched. */
> +		if (match_len == strlen(cpuid))
> +			return 0;
> +	}
> +	return 1;
> +}
> +
>  /*
>   * default get_cpuid(): nothing gets recorded
>   * actual implementation must be in arch/$(SRCARCH)/util/header.c
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index c660625d7d4b..11a234740632 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -655,45 +655,6 @@ static int is_arm_pmu_core(const char *name)
>  	return 0;
>  }
>  
> -/*
> - * Return the CPU id as a raw string.
> - *
> - * Each architecture should provide a more precise id string that
> - * can be use to match the architecture's "mapfile".
> - */
> -char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> -{
> -	return NULL;
> -}
> -
> -/* Return zero when the cpuid from the mapfile.csv matches the
> - * cpuid string generated on this platform.
> - * Otherwise return non-zero.
> - */
> -int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
> -{
> -	regex_t re;
> -	regmatch_t pmatch[1];
> -	int match;
> -
> -	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
> -		/* Warn unable to generate match particular string. */
> -		pr_info("Invalid regular expression %s\n", mapcpuid);
> -		return 1;
> -	}
> -
> -	match = !regexec(&re, cpuid, 1, pmatch, 0);
> -	regfree(&re);
> -	if (match) {
> -		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
> -
> -		/* Verify the entire string matched. */
> -		if (match_len == strlen(cpuid))
> -			return 0;
> -	}
> -	return 1;
> -}
> -
>  static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
>  {
>  	char *cpuid;
> -- 
> 2.14.5
