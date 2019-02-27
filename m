Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB432133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfB0NVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C06D230BDE77;
        Wed, 27 Feb 2019 13:21:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id A06B15D6B6;
        Wed, 27 Feb 2019 13:21:48 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190227132147.GH18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-13-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-13-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 27 Feb 2019 13:21:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:16PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 093352e93d50..0bc9ec69f38a 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -506,3 +506,13 @@ const char *perf_tip(const char *dirpath)
>  
>  	return tip;
>  }
> +
> +void get_exec_path(char *tpath, size_t size)
> +{
> +	const char *path = "/proc/self/exe";
> +	ssize_t len;
> +
> +	len = readlink(path, tpath, size - 1);
> +	assert(len > 0);
> +	tpath[len] = 0;
> +}

we have now helper for that, please rebase this on top of
arnaldo's perf/core:

  94816add0005 perf tools: Add perf_exe() helper to find perf binary

jirka
