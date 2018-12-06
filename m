Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544115706;
	bh=U1prEW3Fny06M2gsVL/rgChzuuWTID7c5iMvuYSLTBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ytUtRmBiTrufAsqVNIACywJZpkBtyEmXq6yCtj28Q502iUAAkJ6Etuwwd9TNRSQSE
	 QMyTI6ntMhWD96RI+B/IdRF5I8Eu+3wi2nwvOsQwnF7MM9SfkZni6fyHsiTyi4QE5g
	 mWEakdV+qQbqMbxdmCLAUhimXKgzOi59ntdibePM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797B820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeLFRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbeLFRBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:01:44 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798EB20878;
        Thu,  6 Dec 2018 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544115703;
        bh=U1prEW3Fny06M2gsVL/rgChzuuWTID7c5iMvuYSLTBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WK/Pn5Ym4k7cXVZH0eR/2oxVY0M8IRnu4mo+8Hopk6OFm7ehZj92zrOBuu6Dwra4W
         GeY1AaMviHz90uvK2xDkLO7N0BN+W1vpb8UfI3jawtYGIBlXEygDGQiDQX9oZqBFwL
         mCUJHYosF9tcZz+XeoJRA7MBmnobenZHxOvf1rHg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BDAD4042C; Thu,  6 Dec 2018 14:01:41 -0300 (-03)
Date:   Thu, 6 Dec 2018 14:01:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Milian Wolff <milian.wolff@kdab.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Fix LBR skid dump problems in brstackinsn
Message-ID: <20181206170140.GJ19069@kernel.org>
References: <20181120050617.4119-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120050617.4119-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 19, 2018 at 09:06:17PM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> This is a fix for another instance of the skid problem Milian
> recently found [1]

Milian, have you tested this?

Adrian, can I have your Reviewed-by or Acked-by?

Thanks,

- Arnaldo
 
> The LBRs don't freeze at the exact same time as the PMI is triggered.
> The perf script brstackinsn code that dumps LBR assembler
> assumes that the last branch in the LBR leads to the sample point.
> But with skid it's possible that the CPU executes one or more branches
> before the sample, but which do not appear in the LBR.
> 
> What happens then is either that the sample point is before
> the last LBR branch. In this case the dumper sees a negative
> length and ignores it. Or it the sample point is long after
> the last branch. Then the dumper sees a very long block and dumps
> it upto its block limit (16k bytes), which is noise in the output.
> 
> On typical sample session this can happen regularly.
> 
> This patch tries to detect and handle the situation. On the last
> block that is dumped by the LBR dumper we always stop on the first
> branch. If the block length is negative just scan forward to the
> first branch. Otherwise scan until a branch is found.
> 
> The PT decoder already has a function that uses the instruction
> decoder to detect branches, so we can just reuse it here.
> 
> Then when a terminating branch is found print an indication
> and stop dumping. This might miss a few instructions, but at least
> shows no runaway blocks.
> 
> Cc: milian.wolff@kdab.com
> Cc: adrian.hunter@intel.com
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c                    | 18 +++++++++++++++++-
>  tools/perf/util/dump-insn.c                    |  8 ++++++++
>  tools/perf/util/dump-insn.h                    |  2 ++
>  .../intel-pt-decoder/intel-pt-insn-decoder.c   |  8 ++++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4da5e32b9e03..11868bf39e66 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1049,9 +1049,18 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  
>  	/*
>  	 * Print final block upto sample
> +	 *
> +	 * Due to pipeline delays the LBRs might be missing a branch
> +	 * or two, which can result in very large or negative blocks
> +	 * between final branch and sample. When this happens just
> +	 * continue walking after the last TO until we hit a branch.
>  	 */
>  	start = br->entries[0].to;
>  	end = sample->ip;
> +	if (end < start) {
> +		/* Missing jump. Scan 128 bytes for the next branch */
> +		end = start + 128;
> +	}
>  	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
>  	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
>  	if (len <= 0) {
> @@ -1060,7 +1069,6 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			      machine, thread, &x.is64bit, &x.cpumode, false);
>  		if (len <= 0)
>  			goto out;
> -
>  		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
>  			dump_insn(&x, sample->ip, buffer, len, NULL));
>  		goto out;
> @@ -1070,6 +1078,14 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
>  		if (ilen == 0)
>  			break;
> +		if (arch_is_branch(buffer + off, len - off, x.is64bit) &&
> +			start + off != sample->ip) {
> +			/*
> +			 * Hit a missing branch. Just stop.
> +			 */
> +			printed += fprintf(fp, "\t... not reaching sample ...\n");
> +			break;
> +		}
>  	}
>  out:
>  	return printed;
> diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
> index 10988d3de7ce..2bd8585db93c 100644
> --- a/tools/perf/util/dump-insn.c
> +++ b/tools/perf/util/dump-insn.c
> @@ -13,3 +13,11 @@ const char *dump_insn(struct perf_insn *x __maybe_unused,
>  		*lenp = 0;
>  	return "?";
>  }
> +
> +__weak
> +int arch_is_branch(const unsigned char *buf __maybe_unused,
> +		   size_t len __maybe_unused,
> +		   int x86_64 __maybe_unused)
> +{
> +	return 0;
> +}
> diff --git a/tools/perf/util/dump-insn.h b/tools/perf/util/dump-insn.h
> index 0e06280a8860..650125061530 100644
> --- a/tools/perf/util/dump-insn.h
> +++ b/tools/perf/util/dump-insn.h
> @@ -20,4 +20,6 @@ struct perf_insn {
>  
>  const char *dump_insn(struct perf_insn *x, u64 ip,
>  		      u8 *inbuf, int inlen, int *lenp);
> +int arch_is_branch(const unsigned char *buf, size_t len, int x86_64);
> +
>  #endif
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> index 54818828023b..1c0e289f01e6 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
> @@ -180,6 +180,14 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
>  	return 0;
>  }
>  
> +int arch_is_branch(const unsigned char *buf, size_t len, int x86_64)
> +{
> +	struct intel_pt_insn in;
> +	if (intel_pt_get_insn(buf, len, x86_64, &in) < 0)
> +		return -1;
> +	return in.branch != INTEL_PT_BR_NO_BRANCH;
> +}
> +
>  const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
>  		      u8 *inbuf, int inlen, int *lenp)
>  {
> -- 
> 2.17.2

-- 

- Arnaldo
