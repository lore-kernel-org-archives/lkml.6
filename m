Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCLOGG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeCLOGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:06:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327A4208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 11:06:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf record: Avoid duplicate call of
 perf_default_config()
Message-ID: <20180312140601.GC4882@kernel.org>
References: <1520853957-36106-1-git-send-email-xieyisheng1@huawei.com>
 <1520853957-36106-2-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520853957-36106-2-git-send-email-xieyisheng1@huawei.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 07:25:57PM +0800, Yisheng Xie escreveu:
> We have brought perf_default_config to the very beginning at main(), so
> it no need to call perf_default_config() once more for most of config in
> perf-record but only for record.call-graph.

Thanks, applied.
 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a217623..811cfc1 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1260,10 +1260,12 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>  			return -1;
>  		return 0;
>  	}
> -	if (!strcmp(var, "record.call-graph"))
> -		var = "call-graph.record-mode"; /* fall-through */
> +	if (!strcmp(var, "record.call-graph")) {
> +		var = "call-graph.record-mode";
> +		return perf_default_config(var, value, cb);
> +	}
>  
> -	return perf_default_config(var, value, cb);
> +	return 0;
>  }
>  
>  struct clockid_map {
> -- 
> 1.7.12.4
