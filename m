Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9722EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4C0213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfBYM40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbfBYM40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFD263003AFB;
        Mon, 25 Feb 2019 12:56:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21EC26017E;
        Mon, 25 Feb 2019 12:56:23 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 08/11] perf tools: Add perf_exe() helper to find perf
 binary
Message-ID: <20190225125622.GJ19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-9-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-9-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 25 Feb 2019 12:56:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:19AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Also convert one existing user.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/header.c | 12 +++---------
>  tools/perf/util/util.c   | 10 ++++++++++
>  tools/perf/util/util.h   |  2 ++
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 61ce197c5362..2f290a0343d4 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -526,17 +526,11 @@ static int write_event_desc(struct feat_fd *ff,
>  static int write_cmdline(struct feat_fd *ff,
>  			 struct perf_evlist *evlist __maybe_unused)
>  {
> -	char buf[MAXPATHLEN];
> -	u32 n;
> -	int i, ret;
> +	char pbuf[MAXPATHLEN], *buf;
> +	int i, ret, n;
>  
>  	/* actual path to perf binary */
> -	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
> -	if (ret <= 0)
> -		return -1;
> -
> -	/* readlink() does not add null termination */
> -	buf[ret] = '\0';
> +	buf = perf_exe(pbuf, MAXPATHLEN);
>  
>  	/* account for binary path */
>  	n = perf_env.nr_cmdline + 1;
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 320b0fef249a..dd693e018aef 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -507,3 +507,13 @@ const char *perf_tip(const char *dirpath)
>  
>  	return tip;
>  }
> +
> +char *perf_exe(char *buf, int len)
> +{
> +	int n = readlink("/proc/self/exe", buf, len);
> +	if (n > 0) {
> +		buf[n] = 0;
> +		return buf;
> +	}
> +	return strcpy(buf, "perf");
> +}
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index ece040b799f6..dc2a99ad5c96 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -76,6 +76,8 @@ extern bool perf_singlethreaded;
>  void perf_set_singlethreaded(void);
>  void perf_set_multithreaded(void);
>  
> +char *perf_exe(char *buf, int len);
> +
>  #ifndef O_CLOEXEC
>  #ifdef __sparc__
>  #define O_CLOEXEC      0x400000
> -- 
> 2.17.2
> 
