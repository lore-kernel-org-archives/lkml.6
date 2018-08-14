Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BA8216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYzTp7eW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BA8216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeHOA4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbeHOA4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:56:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9F2216F9;
        Tue, 14 Aug 2018 22:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534284425;
        bh=zCmpFwvjNRvRehjfudx+2ElQTGlToCXotfkGEaeEKHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYzTp7eWSDwjGy+RIZOlmEneZYOr+k+Bhp46lkdmtLze2Mn9yof+6IEDu890Xq8sZ
         DG6A5viwFq0a0Ic5L3pCxmfUNLzNZ6bcuw86G4Dnor7d94EP3+Egz4VC7KB3gkiXcQ
         IsUmPF/MS6Dng6LzUSuj8TFFXMKU4Cb6hK/CUDCE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 61883140A1C; Tue, 14 Aug 2018 19:07:02 -0300 (-03)
Date:   Tue, 14 Aug 2018 19:07:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Fix queue resize
Message-ID: <20180814220702.GB32497@kernel.org>
References: <20180814084608.6563-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814084608.6563-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 14, 2018 at 11:46:08AM +0300, Adrian Hunter escreveu:
> When the number of queues grows beyond 32, the array of queues is resized
> but not all members were being copied. Fix by also copying 'tid', 'cpu' and
> 'set'.

Thanks, applied.
 
> Fixes: e502789302a6e ("perf auxtrace: Add helpers for queuing AUX area tracing data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index ae8c37b219c9..db1511359c5e 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -203,6 +203,9 @@ static int auxtrace_queues__grow(struct auxtrace_queues *queues,
>  	for (i = 0; i < queues->nr_queues; i++) {
>  		list_splice_tail(&queues->queue_array[i].head,
>  				 &queue_array[i].head);
> +		queue_array[i].tid = queues->queue_array[i].tid;
> +		queue_array[i].cpu = queues->queue_array[i].cpu;
> +		queue_array[i].set = queues->queue_array[i].set;
>  		queue_array[i].priv = queues->queue_array[i].priv;
>  	}
>  
> -- 
> 2.17.1
