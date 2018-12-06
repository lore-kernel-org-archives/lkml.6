Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81A20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544115941;
	bh=5R6BoTEfolE1sujpZmyhMzEVjx+RqmMpipSJ2bQZ5FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LqD3A7jOe6ib26EQ/T17ndOeeXvuWhXiyXDxv7WpBfHBwz91aok8J/vgB5ABe3gEb
	 qP+vakZw/L+H6V8B7Nb9P894UAEBuHXmKLHkHiB4Urd0J4/2lJEV1jAhdfEexYf4VK
	 592gzeAYlyGqbBy0jB9avF5v+Z6TIPNIxDkN2UfA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF81A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLFRFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeLFRFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:05:39 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533F820661;
        Thu,  6 Dec 2018 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544115938;
        bh=5R6BoTEfolE1sujpZmyhMzEVjx+RqmMpipSJ2bQZ5FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eANVlkXdMD/MlracYLYugJTufFZE2abHY7RBTPc+sdw/Fgk/yDPMNf0/EJPUi7itw
         lMUGkILU7fVbBvRA37QzXVu4S02VmfjTn/B9Fm8oydKsFsafZgkFs/MhVSFfdtq1/E
         3crKbU93P+yOws/4Kjbxmzr1pCiSOqzcbR5fcg9I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E058E4042C; Thu,  6 Dec 2018 14:05:35 -0300 (-03)
Date:   Thu, 6 Dec 2018 14:05:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: fix memory leak on AIO objects
 deallocation
Message-ID: <20181206170535.GK19069@kernel.org>
References: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 05, 2018 at 08:19:41PM +0300, Alexey Budankov escreveu:
> 
> Sending a part which was missed between v12 and v13 of the patch set
> introducing AIO trace streaming for perf record mode. 
> 
> The part is essential to avoid memory leakage during deallocation
> of AIO related trace data buffers.
> 
> It is applied on top of acme perf/core repo.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> tools/perf/util/mmap.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab30555d2afc..169d02973757 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -207,8 +207,18 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
>  
>  static void perf_mmap__aio_munmap(struct perf_mmap *map)
>  {
> +	int i;
> +
> +	for (i = 0; i < map->aio.nr_cblocks; ++i) {
> +		if (map->aio.data[i])
> +			zfree(&map->aio.data[i]);
> +	}
>  	if (map->aio.data)
>  		zfree(&map->aio.data);
> +	if (map->aio.cblocks)
> +		zfree(&map->aio.cblocks);
> +	if (map->aio.aiocb)
> +		zfree(&map->aio.aiocb);

There is no need to check for NULL before calling zfree(), as it is just
a wrapper for free that sets that variable to NULL after calling it.

And free(NULL) is valid, just a noop to avoid having all those tests
before each call to free(). I'm making those plain zfree() and later
will do a sweep at removing other cases.

>  }
>  
>  int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,

-- 

- Arnaldo
