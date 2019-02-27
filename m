Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228C52133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfB0NVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E47130BEA58;
        Wed, 27 Feb 2019 13:21:43 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0207366D49;
        Wed, 27 Feb 2019 13:21:38 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190227132137.GG18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-7-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Feb 2019 13:21:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:10PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d01b8355f4ca..33ef4b2d2a29 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -3,7 +3,9 @@
>  #define __PERF_ENV_H
>  
>  #include <linux/types.h>
> +#include <linux/rbtree.h>
>  #include "cpumap.h"
> +#include "rwsem.h"
>  
>  struct cpu_topology_map {
>  	int	socket_id;
> @@ -64,8 +66,19 @@ struct perf_env {
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
>  	u64                     clockid_res_ns;
> +
> +	/*
> +	 * bpf_info_lock protects bpf rbtrees. This is needed because the
> +	 * trees are accessed by different threads in perf-top
> +	 */
> +	struct {
> +		struct rw_semaphore	lock;
> +		struct rb_root		prog_infos;

could be just 'infos'                   ^^^^ is already in struct name


> +	} bpf_progs;
>  };
>  


jirka
