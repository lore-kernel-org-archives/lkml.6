Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B6920685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B6920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440489AbeKXC7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:59:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436604AbeKXC7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:59:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 359583082E10;
        Fri, 23 Nov 2018 16:14:28 +0000 (UTC)
Received: from krava (unknown [10.40.205.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B5A583EAD;
        Fri, 23 Nov 2018 16:14:25 +0000 (UTC)
Date:   Fri, 23 Nov 2018 17:14:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH] perf map: remove extra indirection from map__find()
Message-ID: <20181123161416.GB5575@krava>
References: <1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 23 Nov 2018 16:14:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 02:42:39AM -0800, Eric Saint-Etienne wrote:
> A double pointer is used in map__find() where a single pointer is enough
> because the function doesn't affect the rbtree and the rbtree is locked.
> 
> Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/map.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 354e545..3dac766 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -846,19 +846,18 @@ void maps__remove(struct maps *maps, struct map *map)
>  
>  struct map *maps__find(struct maps *maps, u64 ip)
>  {
> -	struct rb_node **p, *parent = NULL;
> +	struct rb_node *p;
>  	struct map *m;
>  
>  	down_read(&maps->lock);
>  
> -	p = &maps->entries.rb_node;
> -	while (*p != NULL) {
> -		parent = *p;
> -		m = rb_entry(parent, struct map, rb_node);
> +	p = maps->entries.rb_node;
> +	while (p != NULL) {
> +		m = rb_entry(p, struct map, rb_node);
>  		if (ip < m->start)
> -			p = &(*p)->rb_left;
> +			p = p->rb_left;
>  		else if (ip >= m->end)
> -			p = &(*p)->rb_right;
> +			p = p->rb_right;
>  		else
>  			goto out;
>  	}
> -- 
> 1.8.3.1
> 
