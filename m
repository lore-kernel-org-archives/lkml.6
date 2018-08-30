Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46000C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074CF2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074CF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeH3M6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:58:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeH3M6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1756D807A0C2;
        Thu, 30 Aug 2018 08:57:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C9B7A9EF0;
        Thu, 30 Aug 2018 08:57:45 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:57:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 05/10] perf, tools, script: Print DSO for callindent
Message-ID: <20180830085745.GF16691@krava>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-6-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829171834.6590-6-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:57:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 08:57:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:18:29AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now that we don't need to print the IP/ADDR for callindent the DSO
> is also not printed. It's useful for some cases, so add an own DSO
> printout for callindent for the case when IP/ADDR is not enabled.

please put before/after outputs to changelogs

thanks,
jirka

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index bae960c56763..6a470dd8f2d0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1116,6 +1116,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  	const char *name = NULL;
>  	static int spacing;
>  	int len = 0;
> +	int dlen = 0;
>  	u64 ip = 0;
>  
>  	/*
> @@ -1142,6 +1143,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  			ip = sample->ip;
>  	}
>  
> +	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
> +		dlen += fprintf(fp, "(");
> +		dlen += map__fprintf_dsoname(al->map, fp);
> +		dlen += fprintf(fp, ")\t");
> +	}
> +
>  	if (name)
>  		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
>  	else if (ip)
> @@ -1160,7 +1167,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  	if (len < spacing)
>  		len += fprintf(fp, "%*s", spacing - len, "");
>  
> -	return len;
> +	return len + dlen;
>  }
>  
>  static int perf_sample__fprintf_insn(struct perf_sample *sample,
> -- 
> 2.17.1
> 
