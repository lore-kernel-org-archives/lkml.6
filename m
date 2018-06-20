Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5146FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqfbRfx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbeFTOT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753987AbeFTOT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:19:26 -0400
Received: from jouet.infradead.org (unknown [177.79.79.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9619520872;
        Wed, 20 Jun 2018 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529504366;
        bh=ejEsL0BJmf2L7qDHWz3toaER/1Thj/WriBMyEbRgV/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqfbRfx8MiKM6nnYmUTlJOLpoGFrNb64XGJUw6FC5PeX1WIwngHbZ8Yu3WCmoksLV
         y2zbGtqMGaGSrtR0BHe02IYCUo32dsK6XolFUn7gQkob49b3NTq/YkggqNBfGmqRa6
         DfdVMvzCeSjpKesXLmuNFlxgOtvTACdX7YLdZico=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 65CBE1401E5; Wed, 20 Jun 2018 11:19:22 -0300 (-03)
Date:   Wed, 20 Jun 2018 11:19:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf bench: Fix numa report output code
Message-ID: <20180620141922.GR20477@kernel.org>
References: <20180620094036.17278-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620094036.17278-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 20, 2018 at 11:40:36AM +0200, Jiri Olsa escreveu:
> Currently we can hit following assert when running numa bench:
> 
>   $ perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZ0cm --thp 1
>   perf: bench/numa.c:1577: __bench_numa: Assertion `!(!(((wait_stat) & 0x7f) == 0))' failed.
> 
> The assertion is correct, because we hit the SIGFPE in following line:
> 
>   Thread 2.2 "thread 0/0" received signal SIGFPE, Arithmetic exception.
>   [Switching to Thread 0x7fffd28c6700 (LWP 11750)]
>   0x000.. in worker_thread (__tdata=0x7.. ) at bench/numa.c:1257
>   1257 td->speed_gbs = bytes_done / (td->runtime_ns / NSEC_PER_SEC) / 1e9;
> 
> We don't check if the runtime is actually bigger than 1 second,
> and thus this might end up with zero division within FPU.
> 
> Adding the check to prevent this.
> 
> Link: http://lkml.kernel.org/n/tip-9y8n4x48mjbbcay73sq6nche@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

thanks, applied to perf/urgent.

- Arnaldo
