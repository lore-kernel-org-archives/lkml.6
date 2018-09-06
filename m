Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E413C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5532083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5532083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeIFNoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:44:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeIFNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1F9880401CC;
        Thu,  6 Sep 2018 09:09:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF4C9464F;
        Thu,  6 Sep 2018 09:09:54 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:09:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: use PTR_ERR_OR_ZERO inetead of return code
Message-ID: <20180906090953.GC8248@krava>
References: <1536224648-6597-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536224648-6597-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:09:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:09:55 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:04:08PM +0800, Ding Xiang wrote:
> use PTR_ERR_OR_ZERO for bpf__setup_stdout return code
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  tools/perf/util/bpf-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 47aac41..f9ae1a9 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
>  int bpf__setup_stdout(struct perf_evlist *evlist)
>  {
>  	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
> -	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
> +	return PTR_ERR_OR_ZERO(evsel);

you need to add that macro to tools/include/linux/err.h first...

[jolsa@krava perf]$ make JOBS=1
  BUILD:   Doing 'make -j1' parallel build
  CC       util/bpf-loader.o
util/bpf-loader.c: In function ‘bpf__setup_stdout’:
util/bpf-loader.c:1618:9: error: implicit declaration of function ‘PTR_ERR_OR_ZERO’; did you mean ‘IS_ERR_OR_NULL’? [-Werror=implicit-function-declaration]
  return PTR_ERR_OR_ZERO(evsel);
         ^~~~~~~~~~~~~~~
         IS_ERR_OR_NULL
util/bpf-loader.c:1618:9: error: nested extern declaration of ‘PTR_ERR_OR_ZERO’ [-Werror=nested-externs]
cc1: all warnings being treated as errors
mv: cannot stat 'util/.bpf-loader.o.tmp': No such file or directory

please at least compile the code before posting it ;-)

thanks,
jirka
