Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F1E21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394458AbfBNM0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:26:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfBNM0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:26:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E42D80F79;
        Thu, 14 Feb 2019 12:26:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id C0C565F9AA;
        Thu, 14 Feb 2019 12:26:39 +0000 (UTC)
Date:   Thu, 14 Feb 2019 13:26:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com
Subject: Re: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Message-ID: <20190214122638.GD26714@krava>
References: <20190209011705.2160185-1-songliubraving@fb.com>
 <20190209011705.2160185-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209011705.2160185-6-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 14 Feb 2019 12:26:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:17:01PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d01b8355f4ca..5894a177b7cf 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -3,7 +3,10 @@
>  #define __PERF_ENV_H
>  
>  #include <linux/types.h>
> +#include <linux/rbtree.h>
>  #include "cpumap.h"
> +#include "rwsem.h"
> +#include "bpf-event.h"
>  
>  struct cpu_topology_map {
>  	int	socket_id;
> @@ -64,6 +67,8 @@ struct perf_env {
>  	struct memory_node	*memory_nodes;
>  	unsigned long long	 memory_bsize;
>  	u64                     clockid_res_ns;
> +	struct rw_semaphore	bpf_info_lock;

why's the lock needed?

jirka
