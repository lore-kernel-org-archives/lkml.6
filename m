Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F97C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE521773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfBQXFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:05:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBQXFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:05:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBF18750E3;
        Sun, 17 Feb 2019 23:05:53 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC04F60C45;
        Sun, 17 Feb 2019 23:05:50 +0000 (UTC)
Date:   Mon, 18 Feb 2019 00:05:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190217230549.GE7443@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190215215354.3114006-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215215354.3114006-6-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 17 Feb 2019 23:05:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:53:48PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d01b8355f4ca..d0c53fe6d431 100644
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
> +		struct rw_semaphore	bpf_info_lock;
> +		struct rb_root		bpf_prog_infos;

there's already struct name 'bpf_progs', no need for
those bpf_ prefixes

jirka


> +	} bpf_progs;

SNIP
