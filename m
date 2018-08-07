Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C440CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692B62172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d34xyeK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692B62172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeHGWSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeHGWSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:18:41 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2BA215E5;
        Tue,  7 Aug 2018 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533672160;
        bh=e60F61QG78APnjLP60XWmT2bs3UhiNyrMf6dbxRa9/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d34xyeK3BvL8Mgp4y7eARnbVDxv5dkQ5vCT0czep9provts40By0/R5uyssP+x9bT
         viX4mcVu6MJvLOyqJWC5NXKR7LGRYnAjdctNS5R8bVp2znmyXCSoiEa9ytpZXlsdjw
         ZKm8pkgNl0JDqMV1YbpIqqy0GLcZhGJe/k+YVMb0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 652E3140A1C; Tue,  7 Aug 2018 17:02:37 -0300 (-03)
Date:   Tue, 7 Aug 2018 17:02:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] perf map: optimize maps__fixup_overlappings()
Message-ID: <20180807200237.GA5395@kernel.org>
References: <153363294565.396323.4605638589903548668.stgit@buzz>
 <153365189407.435244.7234821822450484712.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153365189407.435244.7234821822450484712.stgit@buzz>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 07, 2018 at 05:24:54PM +0300, Konstantin Khlebnikov escreveu:
> This function splits and removes overlapping areas.
> 
> Maps in tree are ordered by start address thus we could find
> first overlap and stop if next map does not overlap.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Jiri, I'm applying this one with your Acked-by, ok?

- Arnaldo
 
> ---
> 
> v2:
> * add comments
> * replace map__overlap with minimal check
> * remove remove map__overlap, that was the only user
> ---
>  tools/perf/util/map.c |   44 ++++++++++++++++++++++++++------------------
>  tools/perf/util/map.h |    1 -
>  2 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 89ac5b5dc218..36d0763311ef 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -381,20 +381,6 @@ struct map *map__clone(struct map *from)
>  	return map;
>  }
>  
> -int map__overlap(struct map *l, struct map *r)
> -{
> -	if (l->start > r->start) {
> -		struct map *t = l;
> -		l = r;
> -		r = t;
> -	}
> -
> -	if (l->end > r->start)
> -		return 1;
> -
> -	return 0;
> -}
> -
>  size_t map__fprintf(struct map *map, FILE *fp)
>  {
>  	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
> @@ -675,20 +661,42 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
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
> +	/*
> +	 * Find first map where end > map->start.
> +	 * Same as find_vma() in kernel.
> +	 */
> +	next = root->rb_node;
> +	first = NULL;
> +	while (next) {
> +		struct map *pos = rb_entry(next, struct map, rb_node);
> +
> +		if (pos->end > map->start) {
> +			first = next;
> +			if (pos->start <= map->start)
> +				break;
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
> -		if (!map__overlap(pos, map))
> -			continue;
> +		/*
> +		 * Stop if current map starts after map->end.
> +		 * Maps are ordered by start: next will not overlap for sure.
> +		 */
> +		if (pos->start >= map->end)
> +			break;
>  
>  		if (verbose >= 2) {
>  
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 4cb90f242bed..e0f327b51e66 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -166,7 +166,6 @@ static inline void __map__zput(struct map **map)
>  
>  #define map__zput(map) __map__zput(&map)
>  
> -int map__overlap(struct map *l, struct map *r);
>  size_t map__fprintf(struct map *map, FILE *fp);
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp);
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
