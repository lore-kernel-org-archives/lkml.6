Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F38C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD692070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549885576;
	bh=swEubQ+Rpi6jgHslOKNlQcwmn7NOdbtojrJWwOsW0Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V2dk2FOXIsimdDUyjkIOAGsSFSWA13LGGLyDLiU7ReTdpnBW6iaBRjKxSEHSRm/s9
	 VeLIB7pQfbdhhd19lBkdIlyNeFeBnMVAZFD3/FLedM4SutI9FjXtUq/RhhIa/8o1Sf
	 5PSidMxhcXjs81feyYFXD+TjkfAKyAZGQr9POaBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBKLqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfBKLqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:46:14 -0500
Received: from quaco.ghostprotocols.net (unknown [179.182.217.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68DEF21A49;
        Mon, 11 Feb 2019 11:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549885573;
        bh=swEubQ+Rpi6jgHslOKNlQcwmn7NOdbtojrJWwOsW0Hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6lzixJ9/jg83XNGx4K2v0kMR0YZm+0ApX5teFoLHrooi0n3HOefTFx00XR4wosBP
         N774l/h/IAW9kllnlnrmRpy6wU5LUD6g2Pv915Qtv5CzHRUAi22+uiiZjToZU43FQH
         1H/WG9qvM+A+J1Zi/wPVKdl4HQD8pE4Ank7F8jCA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58D2340ECC; Mon, 11 Feb 2019 08:46:03 -0300 (-03)
Date:   Mon, 11 Feb 2019 08:46:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add proper header file for symbols
Message-ID: <20190211114603.GA3269@kernel.org>
References: <20190208223543.31836-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208223543.31836-1-mathieu.poirier@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 08, 2019 at 03:35:43PM -0700, Mathieu Poirier escreveu:
> After 'commit e22c1c751140 ("perf thread: Don't include symbol.h,
> symbol_conf.h is enough")'
> 
> Compilation of the perf tools is broken when using the functionality
> provided by the openCSD library:
> 
> [...]
> 
> ...                       timerfd: [ on  ]
> ...                  sched_getcpu: [ on  ]
> ...                           sdt: [ OFF ]
> ...                         setns: [ on  ]
> ...                    libopencsd: [ on  ]
> 
> [...]
> 
>   CC       util/arm-spe.o
>   CC       util/arm-spe-pkt-decoder.o
>   CC       util/s390-cpumsf.o
>   CC       util/cs-etm.o
>   CC       util/parse-branch-options.o
> util/cs-etm.c: In function ‘cs_etm__mem_access’:
> util/cs-etm.c:297:24: error: storage size of ‘al’ isn’t known
>   struct  addr_location al;
> 
> And rightly so since file cs-etm.c doesn't include symbol.h, something
> that is rectified in this patch.

Thanks, I'll make sure the openCSD library is present in one of my
containers doing arm64 cross builds so that this gets caught in the
future.

- Arnaldo
 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8b3f882d6e2f..0b11d653cfbe 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -25,6 +25,7 @@
>  #include "machine.h"
>  #include "map.h"
>  #include "perf.h"
> +#include "symbol.h"
>  #include "thread.h"
>  #include "thread_map.h"
>  #include "thread-stack.h"
> -- 
> 2.17.1

-- 

- Arnaldo
