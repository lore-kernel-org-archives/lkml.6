Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF76C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381B325BCD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNNhcoRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381B325BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeFYOwx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934325AbeFYOwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:52:51 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC34525BCB;
        Mon, 25 Jun 2018 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529938371;
        bh=P9QF5kAbcoZIjVQ3d5pr2r8OPhfvq/9EytA3V5V85MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNNhcoRj52JsWY2/7oTWeDcidRH2vBNEURxSmuXSdRgbAk1XB0KciBSaAArHh+DA0
         67WGi4LJJ7udyg8Lm1aSzyAMQzOJVi6a2d7lz4qjPHbV3Cp4BpbD0IbIQ/SX1mSuDn
         DLJD0q9I9sotBdshx0fWxAAIylsbh2mKTzknWDoo=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C6CF31401E5; Mon, 25 Jun 2018 11:52:47 -0300 (-03)
Date:   Mon, 25 Jun 2018 11:52:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/4 v3] perf stat: Add transaction flag (-T) support for
 s390
Message-ID: <20180625145247.GY20477@kernel.org>
References: <20180625125856.20262-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625125856.20262-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 25, 2018 at 02:58:56PM +0200, Thomas Richter escreveu:
> perf stat command line flag -T to display transaction counters is
> currently supported for x86 only.
> Add support for s390. It is based on the metrics flag -M transaction
> using the architecture dependend json files. This requires a metric
> named "transaction" in the json files for the platform.

You forgot to CC Andi in this post, Andi, is everything ok now? May I
have your reviewed-by or acked-by?

Thanks,

- Arnaldo
 
> v2 --> v3:
> Introduce new function metricgroup__has_metric() to check for
> the existance of a metric named transaction.
> 
> As suggested by Andi Kleen, this is the new approach to support
> transactions counters. Other architectures will follow.
> 
> Output before:
> [root@p23lp27 perf]# ./perf stat -T -- sleep 1
> Cannot set up transaction events
> [root@p23lp27 perf]#
> 
> Output after:
> [root@s35lp76 perf]# ./perf stat -T -- ~/mytesttx 1 >/tmp/111
> 
>  Performance counter stats for '/root/mytesttx 1':
> 
>                  1      tx_c_tend           #     13.0 transaction
>                  1      tx_nc_tend
>                 11      tx_nc_tabort
>                  0      tx_c_tabort_special
>                  0      tx_c_tabort_no_special
> 
>        0.001070109 seconds time elapsed
> 
> [root@s35lp76 perf]#
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/builtin-stat.c     | 12 ++++++++++++
>  tools/perf/util/metricgroup.c | 23 +++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  1 +
>  3 files changed, 36 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a4f662a462c6..e309279e7b04 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2425,6 +2425,18 @@ static int add_default_attributes(void)
>  	if (transaction_run) {
>  		struct parse_events_error errinfo;
>  
> +		/* Handle -T as -M transaction. Once platform specific metrics
> +		 * support has been added to the json files, all archictures
> +		 * will use this approach. To determine transaction support
> +		 * on an architecture test for such a metric name.
> +		 */
> +		if (metricgroup__has_metric("transaction")) {
> +			struct option opt = { .value = &evsel_list };
> +
> +			return metricgroup__parse_groups(&opt, "transaction",
> +							 &metric_events);
> +		}
> +
>  		if (pmu_have_event("cpu", "cycles-ct") &&
>  		    pmu_have_event("cpu", "el-start"))
>  			err = parse_events(evsel_list, transaction_attrs,
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 1ddc3d1d0147..90cff5226ecc 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -490,3 +490,26 @@ int metricgroup__parse_groups(const struct option *opt,
>  	metricgroup__free_egroups(&group_list);
>  	return ret;
>  }
> +
> +bool metricgroup__has_metric(const char *metric)
> +{
> +	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> +	struct pmu_event *pe;
> +	int i;
> +
> +	if (!map)
> +		return false;
> +
> +	for (i = 0; ; i++) {
> +		pe = &map->table[i];
> +
> +		if (!pe->name && !pe->metric_group && !pe->metric_name)
> +			break;
> +		if (!pe->metric_expr)
> +			continue;
> +		if (match_metric(pe->metric_group, metric) ||
> +		    match_metric(pe->metric_name, metric))
> +			return true;
> +	}
> +	return false;
> +}
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 06854e125ee7..8a155dba0581 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -28,4 +28,5 @@ int metricgroup__parse_groups(const struct option *opt,
>  			struct rblist *metric_events);
>  
>  void metricgroup__print(bool metrics, bool groups, char *filter, bool raw);
> +bool metricgroup__has_metric(const char *metric);
>  #endif
> -- 
> 2.14.3
