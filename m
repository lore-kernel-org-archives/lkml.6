Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3BFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76F2213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Crs1Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76F2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIAzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIAzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:55:04 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059C2213A2;
        Mon,  8 Oct 2018 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020535;
        bh=mdXJnzqV6z7l95lSqJz1dzYEkeIDJxUOUMKwfMqbSEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4Crs1Ly1syUGa/oFudfXOJmiTO5nKWYzMQRFmSRvnEbLtu9D+Vg37EKgjbbaDrHR
         OGfylkMxaWuOEsjYCokER9uQwyY0cIx97ucel5S02IXH+myiavyaeRYSTJoGno83Hp
         7pm9UQdtpHnXN7We5MARB255yMH0KLtx1f+imoHU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4DBAA141DDC; Mon,  8 Oct 2018 14:42:12 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:42:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf record: encode -k clockid frequency into Perf
 trace
Message-ID: <20181008174212.GR3541@kernel.org>
References: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f558425-b420-d99c-ff19-8f91e8ed5302@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 03, 2018 at 07:57:12PM +0300, Alexey Budankov escreveu:
> 
> Store -k clockid frequency into Perf trace to enable timestamps 
> derived metrics conversion into wall clock time on reporting stage.

<SNIP>

> +++ b/tools/perf/util/env.h
> @@ -63,6 +63,7 @@ struct perf_env {
>  	struct numa_node	*numa_nodes;
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
> +	size_t                   clockid_res_ns;
>  };
>  
>  extern struct perf_env perf_env;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 1ec1d9bc2d63..4ce5339158f7 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1034,6 +1034,13 @@ static int write_auxtrace(struct feat_fd *ff,
>  	return err;
>  }
>  
> +static int write_clockid(struct feat_fd *ff,
> +			 struct perf_evlist *evlist __maybe_unused)
> +{
> +	return do_write(ff, &ff->ph->env.clockid_res_ns,
> +			sizeof(ff->ph->env.clockid_res_ns));
> +}
> +

Is sizeof(size_t) the same everywhere? I think you should encode this
always as a u64, read it, assign it to a temp u64 var, write the u64 to
the perf.data header, read it using do_read_u64, that will take care of
endianness, then set it to the size_t in the ff->ph->env.clockid_res_ns,
right?

I'm removing the patch till this gets sorted out,

Thanks,

- Arnaldo
