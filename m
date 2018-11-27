Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCDB2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4AnmbCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCDB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeK1ABB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeK1ABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:01:01 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554922086B;
        Tue, 27 Nov 2018 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543323789;
        bh=p0rZEthblpyFCbptEjxW/5DXo/T1NvZ4y0HYizv5DKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4AnmbCj5N2Xdug1RL4MZGlrOKxLPlcfnI/cX0+WlWIbB2hM3sGXLMXSFOnkSROM5
         uM6gBeHcpM0mxsqlRUTH/XujGqTswD0y+ay6KVhAKbfCfhmZLCkncZNlarCcTO8RWR
         +cO5tcpfz7ugCYokjDjLRe8Clwdy7dY6cIOqUhLM=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 064E141114; Tue, 27 Nov 2018 10:03:07 -0300 (-03)
Date:   Tue, 27 Nov 2018 10:03:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <yellowriver2010@hotmail.com>
Subject: Re: [PATCH] perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
Message-ID: <20181127130306.GD15747@kernel.org>
References: <20181127090610.28488-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127090610.28488-1-wen.yang99@zte.com.cn>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 27, 2018 at 05:06:10PM +0800, Wen Yang escreveu:
> Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).
> This makes it more readable and also fix this warning detected
> by err_cast.cocci:
> tools/perf/util/bpf-loader.c:1606:11-18: WARNING: ERR_CAST can be used with op

Have you tried building perf with this patch applied?

[acme@quaco perf]$ find tools/include/ -name "*.h"  | xargs grep ERR_CAST
[acme@quaco perf]$

Its not there, you first have to grab a copy of ERR_CAST() from
include/linux/err.h and put it in tools/include/linux/err.h to then be
able to apply this patch and keep the tools building:

So, applying your patch I get:

[acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf install-bin
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
  INSTALL  trace_plugins
  CC       /tmp/build/perf/util/bpf-loader.o
util/bpf-loader.c: In function ‘bpf__setup_output_event’:
util/bpf-loader.c:1606:12: error: implicit declaration of function ‘ERR_CAST’; did you mean ‘ERR_PTR’? [-Werror=implicit-function-declaration]
     return ERR_CAST(op);
            ^~~~~~~~
            ERR_PTR
util/bpf-loader.c:1606:12: error: nested extern declaration of ‘ERR_CAST’ [-Werror=nested-externs]
util/bpf-loader.c:1606:12: error: returning ‘int’ from a function with return type ‘struct perf_evsel *’ makes pointer from integer without a cast [-Werror=int-conversion]
     return ERR_CAST(op);
            ^~~~~~~~~~~~
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.bpf-loader.o.tmp': No such file or directory
make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/bpf-loader.o] Error 1
make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:658: /tmp/build/perf/libperf-in.o] Error 2
make[1]: *** [Makefile.perf:215: sub-make] Error 2
make: *** [Makefile:110: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@quaco perf]$ git log --oneline -1
82acac0da3ff (HEAD -> perf/core) perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())
[acme@quaco perf]$


So I went on and added a prep patch adopting ERR_CAST(), then tools/perf
is back again building:

[acme@quaco perf]$ git log --oneline -2
2a371d30dc43 (HEAD -> perf/core) perf record: Extend trace writing to multi AIO
decc44122cf0 perf record: Enable asynchronous trace writing
[acme@quaco perf]$

Thanks, patch applied.

- Arnaldo

 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@redhat.com>
> CC: Namhyung Kim <namhyung@kernel.org>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Wen Yang <yellowriver2010@hotmail.com>
> CC: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/bpf-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index f9ae1a993806..9a280647d829 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1603,7 +1603,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
>  
>  			op = bpf_map__add_newop(map, NULL);
>  			if (IS_ERR(op))
> -				return ERR_PTR(PTR_ERR(op));
> +				return ERR_CAST(op);
>  			op->op_type = BPF_MAP_OP_SET_EVSEL;
>  			op->v.evsel = evsel;
>  		}
> -- 
> 2.19.1

-- 

- Arnaldo
