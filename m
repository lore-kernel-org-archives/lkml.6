Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A88C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754FB20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 14:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754FB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeJNVpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 17:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeJNVpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 17:45:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10C6930588D2;
        Sun, 14 Oct 2018 14:04:49 +0000 (UTC)
Received: from krava (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 006C3106223F;
        Sun, 14 Oct 2018 14:04:46 +0000 (UTC)
Date:   Sun, 14 Oct 2018 16:04:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf stat: Potential NULL dereference in print_aggr()
Message-ID: <20181014140446.GA24104@krava>
References: <20181013101940.GA16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013101940.GA16086@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 14 Oct 2018 14:04:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 01:19:40PM +0300, Dan Carpenter wrote:
> Smatch complains that:
> 
>     ./tools/perf/util/stat-display.c:616 print_aggr()
>     error: we previously assumed 'config->aggr_map' could be null (see line 607)
> 
> Not only that, but it looks like aggr_update_shadow() can Oops if
> "config->aggr_get_id" is NULL.  The intent seems to have been to return
> if either of these pointers is NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Fixes: 86ee6e18f6cb ("perf stat: Refactor aggregation code")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e7b4c44ebb62..db635c01d3a3 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -604,7 +604,7 @@ static void print_aggr(struct perf_stat_config *config,
>  	u64 ena, run, val;
>  	bool first;
>  
> -	if (!(config->aggr_map || config->aggr_get_id))
> +	if (!config->aggr_map || !config->aggr_get_id)
>  		return;
>  
>  	aggr_update_shadow(config, evlist);
> -- 
> 2.18.0
> 
