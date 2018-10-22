Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69486C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DA420645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMU7VNQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DA420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJVXPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJVXPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:15:39 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F034420645;
        Mon, 22 Oct 2018 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540220205;
        bh=XrdkzgoG+0eoEeEP8MRgXHFR1n+xC4x6I0aNUAXcsfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMU7VNQ7W13RS17fPAizExt6cMN5I6Cwi4I+OF/c6Id8QhNXV04zIkKFnVjMoykXa
         jjm5HZA5T8DbJiu8B4VRg+VsQdGkwuZkFFRMfqRwKI1qrq3HlbVC8cFVlEqRqLw9nU
         MIM51rAySI3XinLhayUuE/neKAbvweZgtssneNUE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1C35A142C5E; Mon, 22 Oct 2018 11:56:43 -0300 (-03)
Date:   Mon, 22 Oct 2018 11:56:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf stat: Poll for monitored tasks being alive
Message-ID: <20181022145643.GI3849@kernel.org>
References: <20181022093015.9106-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022093015.9106-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 22, 2018 at 11:30:15AM +0200, Jiri Olsa escreveu:
> Adding the check for tasks we monitor via -p/-t options,
> and finish stat if there's no longer task to monitor.

Wonder if instead of doing all those scnprintf, etc, we couldn't have a
perf ring buffer with a dummy event and then ask for PERF_RECORD_EXIT on
it, poll it, etc.

Thought about using getpgid(pid) but thagt also involves radix tree
lookups, so should also be more expensive than asking the kernel perf to
tell us about the exits.

Anyway, that can be done on top, if someone is interested, applying.

- Arnaldo
 
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Requested-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-dfqvnvz0oqu5zg149aquz1jb@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b86aba1c8028..d1028d7755bb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
>  	return leader;
>  }
>  
> +static bool is_target_alive(struct target *_target,
> +			    struct thread_map *threads)
> +{
> +	struct stat st;
> +	int i;
> +
> +	if (!target__has_task(_target))
> +		return true;
> +
> +	for (i = 0; i < threads->nr; i++) {
> +		char path[PATH_MAX];
> +
> +		scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
> +			  threads->map[i].pid);
> +
> +		if (!stat(path, &st))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  {
>  	int interval = stat_config.interval;
> @@ -579,6 +601,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		enable_counters();
>  		while (!done) {
>  			nanosleep(&ts, NULL);
> +			if (!is_target_alive(&target, evsel_list->threads))
> +				break;
>  			if (timeout)
>  				break;
>  			if (interval) {
> -- 
> 2.17.2
