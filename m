Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77C218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323391;
	bh=DEyebitb/XyFWD4lL/3s878PFo0xvNYM6DdGktzc6KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2FQmd/XLGmEQK6ddakwW8RtlG5CoMVDFsuIXdSBiLPpAcRGCSNae6XuNpCqLlNu4e
	 LPCgbJtkvvVNicz9v07jJtgjmCr2EmHwKi6awR3yJB3HxYXumWq3rgEYVLXdpsOhge
	 qcJo3rp+Ufxur4xuz99wl+voKveCwoouEXlnZ/kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAXJtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfAXJtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:49:49 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270712085A;
        Thu, 24 Jan 2019 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323388;
        bh=DEyebitb/XyFWD4lL/3s878PFo0xvNYM6DdGktzc6KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdAN/CALBYAYz2zKFpQSRdrLUN7xMIAODg297M4n9GM2HS8KdaTpjIDWzF6Gfod6y
         t427+jyp/HrXXM4nIo1fuozD5cW+z/sbYbYpKltBdowBbMNG/oodoZJJ5RW+76v0xm
         lWJARpia3Yg8hyRWdDHJRUAo4xNvV/oKnkaI97Ow=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6384640355; Thu, 24 Jan 2019 10:49:46 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:49:46 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH perf] perf tools: fix synthesized
 PERF_RECORD_KSYMBOL/BPF_EVENT
Message-ID: <20190124094946.GK14973@kernel.org>
References: <20190122210218.358664-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122210218.358664-1-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 22, 2019 at 01:02:18PM -0800, Song Liu escreveu:
> Added missing machine->id_hdr_size to event->header.size. Also fixed size
> of PERF_RECORD_KSYMBOL by removing extra bytes for name.

Ok, noticed this now, thanks,

- Arnaldo
 
> Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 01e1dc1bb7fb..f610872812ef 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -7,6 +7,7 @@
>  #include "bpf-event.h"
>  #include "debug.h"
>  #include "symbol.h"
> +#include "machine.h"
>  
>  #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
>  
> @@ -149,7 +150,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  		*ksymbol_event = (struct ksymbol_event){
>  			.header = {
>  				.type = PERF_RECORD_KSYMBOL,
> -				.size = sizeof(struct ksymbol_event),
> +				.size = offsetof(struct ksymbol_event, name),
>  			},
>  			.addr = prog_addrs[i],
>  			.len = prog_lens[i],
> @@ -178,6 +179,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  
>  		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
>  							 sizeof(u64));
> +
> +		memset(event + event->header.size, 0, machine->id_hdr_size);
> +		event->header.size += machine->id_hdr_size;
>  		err = perf_tool__process_synth_event(tool, event,
>  						     machine, process);
>  	}
> @@ -194,6 +198,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  			.id = info.id,
>  		};
>  		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
> +		memset(event + event->header.size, 0, machine->id_hdr_size);
> +		event->header.size += machine->id_hdr_size;
>  		err = perf_tool__process_synth_event(tool, event,
>  						     machine, process);
>  	}
> -- 
> 2.17.1

-- 

- Arnaldo
