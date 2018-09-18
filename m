Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5CFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F3F20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uygXB/Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F3F20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbeISCad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbeISCad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:30:33 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0AC20C0E;
        Tue, 18 Sep 2018 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537304171;
        bh=pKUgc5IQpWLNzoa1uk9YVwk8DghKhm6BwzmLQBzpMsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uygXB/EtSpRocVbqtovxz+tt7OEjnusKOm0WgAM1b76yqe/kc7VejhNOZzHP65X2n
         bpTHoZkAXc7tH2Ya84MrYpgkVQxGDdS4FX8yHdjozCx6GcrBy/GtlVOy01CoikkeuO
         ZWQYSofhss0G9FSdAu0V6SP85SRI3wUFvyCQ9w/0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9A085140260; Tue, 18 Sep 2018 17:56:09 -0300 (-03)
Date:   Tue, 18 Sep 2018 17:56:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 02/48] perf tools: Remove perf_tool from event_op3
Message-ID: <20180918205609.GB311@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913125450.21342-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 13, 2018 at 02:54:04PM +0200, Jiri Olsa escreveu:
> Now when we keep perf_tool pointer inside perf_session,
> there's no need to have perf_tool argument in the
> event_op3 callback. Removing it.
> 
> Link: http://lkml.kernel.org/n/tip-78u9m0jbre3bn16l6guqfyrf@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-inject.c | 6 +++---
>  tools/perf/util/auxtrace.c  | 7 +++----
>  tools/perf/util/auxtrace.h  | 5 ++---
>  tools/perf/util/session.c   | 8 +++-----
>  tools/perf/util/tool.h      | 4 +---
>  5 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index d77ed2aea95a..03fc65da0657 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -131,10 +131,10 @@ static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
>  	return 0;
>  }
>  
> -static s64 perf_event__repipe_auxtrace(struct perf_tool *tool,
> -				       union perf_event *event,
> -				       struct perf_session *session)
> +static s64 perf_event__repipe_auxtrace(struct perf_session *session,
> +				       union perf_event *event)
>  {
> +	struct perf_tool *tool = session->tool;
>  	struct perf_inject *inject = container_of(tool, struct perf_inject,
>  						  tool);
>  	int ret;

You forgot the !HAVE_AUXTRACE_SUPPORT case, fixed with:


diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 03fc65da0657..b4a29f435b06 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -172,9 +172,8 @@ static s64 perf_event__repipe_auxtrace(struct perf_session *session,
 #else
 
 static s64
-perf_event__repipe_auxtrace(struct perf_tool *tool __maybe_unused,
-			    union perf_event *event __maybe_unused,
-			    struct perf_session *session __maybe_unused)
+perf_event__repipe_auxtrace(struct perf_session *session __maybe_unused,
+			    union perf_event *event __maybe_unused)
 {
 	pr_err("AUX area tracing not supported\n");
 	return -EINVAL;
