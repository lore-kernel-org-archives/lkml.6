Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDF9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9062064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rZXQm6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9062064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJ3X0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbeJ3X0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:26:12 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B0A205F4;
        Tue, 30 Oct 2018 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540909949;
        bh=nPjIH6rpWjXzpdH5/SAYvadZXwF0+fsQbMjxFfDioTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0rZXQm6O8s6UgOW5zSTY+SGiGfx1w6ivWiyc4LcE9UxXOaZLJ+oa+wxd2fgyUGEyX
         tSIVofSNOjVgnU2+JGkCsd672nVbn1VebZwdn+Z/cvoD1HBS4FKjkq1Kh7W5/LasCt
         DXBH6v4/v57oU/SFsZ8iqLJt8Vn/fveWwRy+BsLI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1EB5B142C5F; Tue, 30 Oct 2018 11:32:26 -0300 (-03)
Date:   Tue, 30 Oct 2018 11:32:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Correct CPU mode for samples
Message-ID: <20181030143226.GA23310@kernel.org>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> for vdso symbols lookup"), the kernel address cannot be properly parsed
> to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> thus it fails to find corresponding map/dso in below flows:
> 
>   process_sample_event()
>     `-> machine__resolve()
> 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> 
> In this flow it needs to pass argument 'sample->cpumode' to tell what's
> the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> to kallsyms for vdso symbols lookup") has been merged.  The reason is
> even with the wrong CPU mode the function thread__find_map() firstly
> fails to find map but it will rollback to find kernel map for vdso
> symbols lookup.  In the latest code it has removed the fallback code,
> thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> anymore with kernel address.
> 
> This patch is to correct samples CPU mode setting, it creates a new
> helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> the address with the info from machine structure; this patch has a bit
> extension to check not only kernel and user mode, but also check for
> host/guest and hypervisor mode.  Finally this patch uses the function
> in instruction and branch samples and also apply in cs_etm__mem_access()
> for a minor polishing.

Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
quickly on this one! 

Now processing coresight traces should be faster, less lookups :-)

- Arnaldo
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 3b37d66..73430b7 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -244,6 +244,27 @@ static void cs_etm__free(struct perf_session *session)
>  	zfree(&aux);
>  }
>  
> +static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> +{
> +	struct machine *machine;
> +
> +	machine = etmq->etm->machine;
> +
> +	if (address >= etmq->etm->kernel_start) {
> +		if (machine__is_host(machine))
> +			return PERF_RECORD_MISC_KERNEL;
> +		else
> +			return PERF_RECORD_MISC_GUEST_KERNEL;
> +	} else {
> +		if (machine__is_host(machine))
> +			return PERF_RECORD_MISC_USER;
> +		else if (perf_guest)
> +			return PERF_RECORD_MISC_GUEST_USER;
> +		else
> +			return PERF_RECORD_MISC_HYPERVISOR;
> +	}
> +}
> +
>  static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
>  			      size_t size, u8 *buffer)
>  {
> @@ -258,10 +279,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
>  		return -1;
>  
>  	machine = etmq->etm->machine;
> -	if (address >= etmq->etm->kernel_start)
> -		cpumode = PERF_RECORD_MISC_KERNEL;
> -	else
> -		cpumode = PERF_RECORD_MISC_USER;
> +	cpumode = cs_etm__cpu_mode(etmq, address);
>  
>  	thread = etmq->thread;
>  	if (!thread) {
> @@ -653,7 +671,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	struct perf_sample sample = {.ip = 0,};
>  
>  	event->sample.header.type = PERF_RECORD_SAMPLE;
> -	event->sample.header.misc = PERF_RECORD_MISC_USER;
> +	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
>  	sample.ip = addr;
> @@ -665,7 +683,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	sample.cpu = etmq->packet->cpu;
>  	sample.flags = 0;
>  	sample.insn_len = 1;
> -	sample.cpumode = event->header.misc;
> +	sample.cpumode = event->sample.header.misc;
>  
>  	if (etm->synth_opts.last_branch) {
>  		cs_etm__copy_last_branch_rb(etmq);
> @@ -706,12 +724,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
>  		u64			nr;
>  		struct branch_entry	entries;
>  	} dummy_bs;
> +	u64 ip;
> +
> +	ip = cs_etm__last_executed_instr(etmq->prev_packet);
>  
>  	event->sample.header.type = PERF_RECORD_SAMPLE;
> -	event->sample.header.misc = PERF_RECORD_MISC_USER;
> +	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
> -	sample.ip = cs_etm__last_executed_instr(etmq->prev_packet);
> +	sample.ip = ip;
>  	sample.pid = etmq->pid;
>  	sample.tid = etmq->tid;
>  	sample.addr = cs_etm__first_executed_instr(etmq->packet);
> @@ -720,7 +741,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
>  	sample.period = 1;
>  	sample.cpu = etmq->packet->cpu;
>  	sample.flags = 0;
> -	sample.cpumode = PERF_RECORD_MISC_USER;
> +	sample.cpumode = event->sample.header.misc;
>  
>  	/*
>  	 * perf report cannot handle events without a branch stack
> -- 
> 2.7.4
