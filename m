Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99CC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B7223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 04:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6B7223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeHJHXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 03:23:50 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46617 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725784AbeHJHXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 03:23:49 -0400
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 10 Aug 2018 13:55:38 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 10 Aug 2018 13:55:38 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 10 Aug 2018 13:55:37 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Benno Evers <bevers@mesosphere.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] perf tools: Check for null when copying nsinfo.
Message-ID: <20180810045537.GA479@sejong>
References: <20180809215349.24299-1-bevers@mesosphere.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809215349.24299-1-bevers@mesosphere.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 09, 2018 at 11:53:48PM +0200, Benno Evers wrote:
> The argument to nsinfo__copy() was assumed to be valid, but some code paths
> exist that will lead to NULL being passed.
> 
> In particular, running 'perf script -D' on a perf.data file containing an
> PERF_RECORD_MMAP event associating the '[vdso]' dso with pid 0 earlier in
> the event stream will lead to a segfault.
> 
> Since all calling code is already checking for a non-null return value,
> just return NULL for this case as well.

Acked-by: Namhyung Kim <namhyung@kernel.org>

It seems you missed the Signed-off-by though.

Thanks,
Namhyung


> ---
>  tools/perf/util/namespaces.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> index 5be021701f34..cf8bd123cf73 100644
> --- a/tools/perf/util/namespaces.c
> +++ b/tools/perf/util/namespaces.c
> @@ -139,6 +139,9 @@ struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
>  {
>  	struct nsinfo *nnsi;
>  
> +	if (nsi == NULL)
> +		return NULL;
> +
>  	nnsi = calloc(1, sizeof(*nnsi));
>  	if (nnsi != NULL) {
>  		nnsi->pid = nsi->pid;
> -- 
> 2.17.1
> 
