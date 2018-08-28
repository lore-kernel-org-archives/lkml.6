Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA56C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C818C20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9pjBfBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C818C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH1UKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:10:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38113 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1UKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:10:51 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so3276429ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=amu3HRL5lcnzkat+QFVEmLhHRCvcFo/JFGD7hXdgWQQ=;
        b=N9pjBfBLNvF5KKcH1ci3k/sjC7AWiowOV1SB8fkLMiFYv4RUjfTkUvYNWDBCQZ0z87
         5cs/L1DW1HQeYtDGnVzmiY3Y02a0S1hJqz/5ar9QDgLIOnFD5W9xxue4bVuzcOh0eS2n
         PohSlNmAzJIftplEO+yrvmDwvAzJM7l5nRJqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=amu3HRL5lcnzkat+QFVEmLhHRCvcFo/JFGD7hXdgWQQ=;
        b=HaiblqAT6uGyZGTcAJMIJefaaw/YVljoIhK919BAYC/tpGeJLTWss4j1u9OZi5Ah99
         4dEGiPYuX+sR/a9vFm5mhT3qhR16xQucV6u8CfKqO5lAin5khDIiXBzw6S5339dTOO0y
         bYrY0GFMjbGwJm4l/iJV8ugjXutFzf+YK4rAhVnR84lsJZwqfEA5f06RwuQvo7as23qE
         vooSr7rkY/kZeOybAqPhTm0WBFwDEfDcLmZh4t4HSB6z6TXIEZHO2+FXZ/FU+dBbymoe
         rBejHToxTVSZ2p4jvp3bxlrXICRRLJ1uqdNAwKWteXhKatoun8TY8XfAf2R8L1yJn6k4
         VjYg==
X-Gm-Message-State: APzg51AcaUSsWgXQ1MWVjTZJZmAOYtf0gHeEAa92lRCFiIxN/xkrUs7p
        sjBG1viZOaD1jvkYCTG3/+7c0Q==
X-Google-Smtp-Source: ANB0Vdbk/+vGk5h1pbNEMYdNfefm9aljGqXTvrpddZnwGSDTj0gYfFsi4/skngklYmFwiscz9iqGLw==
X-Received: by 2002:a24:4a83:: with SMTP id k125-v6mr2146186itb.121.1535473106569;
        Tue, 28 Aug 2018 09:18:26 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w8-v6sm629241iom.15.2018.08.28.09.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 09:18:25 -0700 (PDT)
Date:   Tue, 28 Aug 2018 10:18:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Robert Walker <robert.walker@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, Kim Phillips <Kim.Phillips@arm.com>,
        coresight@lists.linaro.org
Subject: Re: [PATCH] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
Message-ID: <20180828161822.GA8666@xps15>
References: <1534953837-16425-1-git-send-email-robert.walker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534953837-16425-1-git-send-email-robert.walker@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

Your patch landed in the middle of the merge window and will have to be sent
again rebased on 4.19-rc1 and long with minor fix found below.

Regards,
Mathieu 

On Wed, Aug 22, 2018 at 05:03:57PM +0100, Robert Walker wrote:
> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
> 
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
> member has been added to the feature check for OpenCSD.
> 
> Signed-off-by: Robert Walker <robert.walker@arm.com>
> ---
>  tools/build/feature/test-libopencsd.c           |  7 +++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 27 ++++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++++
>  tools/perf/util/cs-etm.c                        | 71 +++++++++++--------------
>  4 files changed, 75 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 5ff1246..d96b2df 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -3,6 +3,13 @@
>  
>  int main(void)
>  {
> +	/*
> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
> +	 * OpenCSD 0.9
> +	 */
> +	ocsd_generic_trace_elem elem;
> +	(void)elem.num_instr_range;
> +

I really like this - simple and efficient.

>  	(void)ocsd_get_version();
>  	return 0;
>  }
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 938def6..73d8384 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -263,9 +263,12 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  	decoder->tail = 0;
>  	decoder->packet_count = 0;
>  	for (i = 0; i < MAX_BUFFER; i++) {
> +		decoder->packet_buffer[i].isa = CS_ETM_ISA_UNKNOWN;
>  		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
>  		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
> +		decoder->packet_buffer[i].instr_count = 0;
>  		decoder->packet_buffer[i].last_instr_taken_branch = false;
> +		decoder->packet_buffer[i].last_instr_size = 0;
>  		decoder->packet_buffer[i].exc = false;
>  		decoder->packet_buffer[i].exc_ret = false;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
> @@ -294,11 +297,13 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_count++;
>  
>  	decoder->packet_buffer[et].sample_type = sample_type;
> +	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
>  	decoder->packet_buffer[et].exc = false;
>  	decoder->packet_buffer[et].exc_ret = false;
>  	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
>  	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
>  	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
> +	decoder->packet_buffer[et].instr_count = 0;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> @@ -321,8 +326,28 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  
>  	packet = &decoder->packet_buffer[decoder->tail];
>  
> +	switch (elem->isa) {
> +	case ocsd_isa_aarch64:
> +		packet->isa = CS_ETM_ISA_A64;
> +		break;
> +	case ocsd_isa_arm:
> +		packet->isa = CS_ETM_ISA_A32;
> +		break;
> +	case ocsd_isa_thumb2:
> +		packet->isa = CS_ETM_ISA_T32;
> +		break;
> +	case ocsd_isa_tee:
> +	case ocsd_isa_jazelle:
> +	case ocsd_isa_custom:
> +	case ocsd_isa_unknown:
> +	default:
> +		packet->isa = CS_ETM_ISA_UNKNOWN;
> +	}
> +
>  	packet->start_addr = elem->st_addr;
>  	packet->end_addr = elem->en_addr;
> +	packet->instr_count = elem->num_instr_range;
> +
>  	switch (elem->last_i_type) {
>  	case OCSD_INSTR_BR:
>  	case OCSD_INSTR_BR_INDIRECT:
> @@ -336,6 +361,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  		break;
>  	}
>  
> +	packet->last_instr_size = elem->last_instr_sz;
> +
>  	return ret;
>  }
>  
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 612b575..9a10eda 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -28,11 +28,21 @@ enum cs_etm_sample_type {
>  	CS_ETM_TRACE_ON = 1 << 1,
>  };
>  
> +enum cs_etm_isa {
> +	CS_ETM_ISA_UNKNOWN,
> +	CS_ETM_ISA_A64,
> +	CS_ETM_ISA_A32,
> +	CS_ETM_ISA_T32,
> +};
> +
>  struct cs_etm_packet {
>  	enum cs_etm_sample_type sample_type;
> +	enum cs_etm_isa isa;
>  	u64 start_addr;
>  	u64 end_addr;
> +	u64 instr_count;

Shouldn't this be a u32 since ocsd_generic_trace_elem::num_instr_range is a
uint32_t in the openCSD library?

>  	u8 last_instr_taken_branch;
> +	u8 last_instr_size;
>  	u8 exc;
>  	u8 exc_ret;
>  	int cpu;
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2ae6402..579f52a 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -31,14 +31,6 @@
>  
>  #define MAX_TIMESTAMP (~0ULL)
>  
> -/*
> - * A64 instructions are always 4 bytes
> - *
> - * Only A64 is supported, so can use this constant for converting between
> - * addresses and instruction counts, calculting offsets etc
> - */
> -#define A64_INSTR_SIZE 4
> -
>  struct cs_etm_auxtrace {
>  	struct auxtrace auxtrace;
>  	struct auxtrace_queues queues;
> @@ -492,21 +484,16 @@ static inline void cs_etm__reset_last_branch_rb(struct cs_etm_queue *etmq)
>  	etmq->last_branch_rb->nr = 0;
>  }
>  
> -static inline u64 cs_etm__last_executed_instr(struct cs_etm_packet *packet)
> -{
> -	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> -	if (packet->sample_type == CS_ETM_TRACE_ON)
> -		return 0;
> +static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> +					 u64 addr) {
> +	u8 instrBytes[2];
>  
> -	/*
> -	 * The packet records the execution range with an exclusive end address
> -	 *
> -	 * A64 instructions are constant size, so the last executed
> -	 * instruction is A64_INSTR_SIZE before the end address
> -	 * Will need to do instruction level decode for T32 instructions as
> -	 * they can be variable size (not yet supported).
> +	cs_etm__mem_access(etmq, addr, 2, instrBytes);

Please use ARRAY_SIZE(), although trivial here it is just a matter of time
before someone else submits a patch for it.

> +	/* T32 instruction size is indicated by bits[15:11] of the first
> +	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
> +	 * denote a 32-bit instruction.
>  	 */

Thanks for the documentation.

> -	return packet->end_addr - A64_INSTR_SIZE;
> +	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>  }
>  
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> @@ -518,27 +505,32 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  	return packet->start_addr;
>  }
>  
> -static inline u64 cs_etm__instr_count(const struct cs_etm_packet *packet)
> +static inline
> +u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
>  {
> -	/*
> -	 * Only A64 instructions are currently supported, so can get
> -	 * instruction count by dividing.
> -	 * Will need to do instruction level decode for T32 instructions as
> -	 * they can be variable size (not yet supported).
> -	 */
> -	return (packet->end_addr - packet->start_addr) / A64_INSTR_SIZE;
> +	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> +	if (packet->sample_type == CS_ETM_TRACE_ON)
> +		return 0;
> +
> +	return packet->end_addr - packet->last_instr_size;
>  }
>  
> -static inline u64 cs_etm__instr_addr(const struct cs_etm_packet *packet,
> +static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> +				     const struct cs_etm_packet *packet,
>  				     u64 offset)
>  {
> -	/*
> -	 * Only A64 instructions are currently supported, so can get
> -	 * instruction address by muliplying.
> -	 * Will need to do instruction level decode for T32 instructions as
> -	 * they can be variable size (not yet supported).
> -	 */
> -	return packet->start_addr + offset * A64_INSTR_SIZE;
> +	if (packet->isa == CS_ETM_ISA_T32) {
> +		u64 addr = packet->start_addr;
> +
> +		while (offset > 0) {
> +			addr += cs_etm__t32_instr_size(etmq, addr);
> +			offset--;
> +		}
> +		return addr;
> +	}
> +
> +	/* Assume a 4 byte instruction size (A32/A64) */
> +	return packet->start_addr + offset * 4;
>  }
>  
>  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq)
> @@ -867,9 +859,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  	struct cs_etm_auxtrace *etm = etmq->etm;
>  	struct cs_etm_packet *tmp;
>  	int ret;
> -	u64 instrs_executed;
> +	u64 instrs_executed = etmq->packet->instr_count;
>  
> -	instrs_executed = cs_etm__instr_count(etmq->packet);
>  	etmq->period_instructions += instrs_executed;
>  
>  	/*
> @@ -899,7 +890,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  		 * executed, but PC has not advanced to next instruction)
>  		 */
>  		u64 offset = (instrs_executed - instrs_over - 1);
> -		u64 addr = cs_etm__instr_addr(etmq->packet, offset);
> +		u64 addr = cs_etm__instr_addr(etmq, etmq->packet, offset);
>  
>  		ret = cs_etm__synth_instruction_sample(
>  			etmq, addr, etm->instructions_sample_period);
> -- 
> 2.7.4
> 
