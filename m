Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7589221571
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7589221571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbeHGPJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:09:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbeHGPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9014F87A70;
        Tue,  7 Aug 2018 12:55:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F7E310075E7;
        Tue,  7 Aug 2018 12:55:29 +0000 (UTC)
Date:   Tue, 7 Aug 2018 14:55:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] perf map: optimize maps__fixup_overlappings()
Message-ID: <20180807125528.GE7716@krava>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
 <153363294565.396323.4605638589903548668.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153363294565.396323.4605638589903548668.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 12:55:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 12:55:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:09:05PM +0300, Konstantin Khlebnikov wrote:
> This function splits and removes overlapping areas.
> 
> Maps in tree are ordered by start address thus we could find
> first overlap and stop if next map does not overlap.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  tools/perf/util/map.c |   21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 89ac5b5dc218..9b3f4d244ad4 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -675,20 +675,35 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
>  static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
>  {
>  	struct rb_root *root;
> -	struct rb_node *next;
> +	struct rb_node *next, *first;
>  	int err = 0;
>  
>  	down_write(&maps->lock);
>  
>  	root = &maps->entries;
> -	next = rb_first(root);
>  
> +	/* find first where end > map->start, same as find_vma() */
> +	next = root->rb_node;
> +	first = NULL;
> +	while (next) {
> +		struct map *pos = rb_entry(next, struct map, rb_node);
> +
> +		if (pos->end > map->start) {
> +			first = next;
> +			if (pos->start <= map->start)
> +				break;

please use in here the call to map__overlap as in the
while loop below.. we could change map__overlap to above
(yours) overlap check, seems more straight

> +			next = next->rb_left;
> +		} else
> +			next = next->rb_right;
> +	}
> +
> +	next = first;
>  	while (next) {
>  		struct map *pos = rb_entry(next, struct map, rb_node);
>  		next = rb_next(&pos->rb_node);
>  
>  		if (!map__overlap(pos, map))
> -			continue;
> +			break;

please put in ehre the comment from changelog,
that we could stop searching in here

thanks,
jirka

>  
>  		if (verbose >= 2) {
>  
> 
