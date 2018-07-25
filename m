Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE51C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE0520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xDhweQ/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE0520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeGYMd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbeGYMd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:33:28 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB14320844;
        Wed, 25 Jul 2018 11:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532517735;
        bh=duA7N3V5uLBMdxmu5SBCwqouVlxkRGqgymICr16uc+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDhweQ/sl+NnkOG8KkwBXiIb8h7GtwYe9AD81n3/J0r3UUF8DIxWYDc3boLu9bL+j
         o7rU4bqnREvmnIm3HlCd8il7l0PXVmmN2nZg6iHXrp/izs4kHOtrlfNtlFyTUEuUX1
         ug6Mnxc+rxqBbO3mNhJeebbK6GeQb3VnazCzOSFM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id EE14D1403B8; Wed, 25 Jul 2018 08:22:12 -0300 (-03)
Date:   Wed, 25 Jul 2018 08:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 2/2] bitmap: sync tools with new bitmap allocation API
Message-ID: <20180725112212.GJ13220@kernel.org>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
 <20180623073502.16321-2-ynorov@caviumnetworks.com>
 <20180704221448.GA28525@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704221448.GA28525@yury-thinkpad>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 05, 2018 at 01:15:53AM +0300, Yury Norov escreveu:
> On top of next-20180622 and Andy Shevchenko series:
> https://lkml.org/lkml/2018/6/18/841
> 
> The series https://lkml.org/lkml/2018/6/18/841 introduces helpers for
> bitmap allocation. tools/ has its own bitmap_alloc() which differs from
> bitmap_alloc() proposed in new kernel API, and is equivalent to
> bitmap_zalloc().
> 
> In this patch tools is switched to equivalent API. Some bitmap_zalloc()s
> are not paired with corresponding bitmap_free()s, so marked with FIXME tag.
> 
> Since v1:
>  - removed flags parameter;
>  - removed RFC tag: this is real bug where free() is not called;
>  - FIXME notes added where needed.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  tools/include/linux/bitmap.h | 17 +++++++++++++----
>  tools/perf/builtin-c2c.c     | 11 ++++++-----
>  tools/perf/tests/bitmap.c    |  4 ++--
>  tools/perf/tests/mem2node.c  |  4 ++--
>  tools/perf/util/header.c     |  8 +++++---
>  5 files changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
> index 48c208437bbd..64a87921bac8 100644
> --- a/tools/include/linux/bitmap.h
> +++ b/tools/include/linux/bitmap.h
> @@ -98,12 +98,21 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
>  }
>  
>  /**
> - * bitmap_alloc - Allocate bitmap
> - * @nbits: Number of bits
> + * Allocation and deallocation of bitmap.
>   */
> -static inline unsigned long *bitmap_alloc(int nbits)
> +static inline unsigned long *bitmap_alloc(unsigned int nbits)
>  {
> -	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
> +	return malloc(BITS_TO_LONGS(nbits) * sizeof(unsigned long));
> +}
> +
> +static inline unsigned long *bitmap_zalloc(unsigned int nbits)
> +{
> +	return calloc(BITS_TO_LONGS(nbits), sizeof(unsigned long));
> +}
> +
> +static inline void bitmap_free(const unsigned long *bitmap)
> +{
> +	free((unsigned long *)bitmap);
>  }

So the patch should be split into at least two, one that introduces
bitmap_zalloc() and bitmap_free(),  and then another patch that converts
things to zalloc when needed, other patches adding bitmap_free() where
its missing, etc.

- Arnaldo

p.s. cleaning up inbox after vacation.

>  
>  /*
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 6a8738f7ead3..584abe437154 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -127,11 +127,11 @@ static void *c2c_he_zalloc(size_t size)
>  	if (!c2c_he)
>  		return NULL;
>  
> -	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
> +	c2c_he->cpuset = bitmap_zalloc(c2c.cpus_cnt);
>  	if (!c2c_he->cpuset)
>  		return NULL;
>  
> -	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
> +	c2c_he->nodeset = bitmap_zalloc(c2c.nodes_cnt);
>  	if (!c2c_he->nodeset)
>  		return NULL;
>  
> @@ -156,8 +156,8 @@ static void c2c_he_free(void *he)
>  		free(c2c_he->hists);
>  	}
>  
> -	free(c2c_he->cpuset);
> -	free(c2c_he->nodeset);
> +	bitmap_free(c2c_he->cpuset);
> +	bitmap_free(c2c_he->nodeset);
>  	free(c2c_he->nodestr);
>  	free(c2c_he->node_stats);
>  	free(c2c_he);
> @@ -2051,7 +2051,8 @@ static int setup_nodes(struct perf_session *session)
>  		struct cpu_map *map = n[node].map;
>  		unsigned long *set;
>  
> -		set = bitmap_alloc(c2c.cpus_cnt);
> +		/* FIXME: No counterpart free() */
> +		set = bitmap_zalloc(c2c.cpus_cnt);
>  		if (!set)
>  			return -ENOMEM;
>  
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 96e7fc1ad3f9..0f7491a4e0f2 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -13,7 +13,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	unsigned long *bm = NULL;
>  	int i;
>  
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>  
>  	if (map && bm) {
>  		for (i = 0; i < map->nr; i++)
> @@ -35,7 +35,7 @@ static int test_bitmap(const char *str)
>  	pr_debug("bitmap: %s\n", buf);
>  
>  	ret = !strcmp(buf, str);
> -	free(bm);
> +	bitmap_free(bm);
>  	return ret;
>  }
>  
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index d8e3d49d3638..27fd83bab453 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -21,7 +21,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	unsigned long *bm = NULL;
>  	int i;
>  
> -	bm = bitmap_alloc(nbits);
> +	bm = bitmap_zalloc(nbits);
>  
>  	if (map && bm) {
>  		for (i = 0; i < map->nr; i++)
> @@ -65,7 +65,7 @@ int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	T("failed: mem2node__node", -1 == mem2node__node(&map, 0x1050));
>  
>  	for (i = 0; i < ARRAY_SIZE(nodes); i++)
> -		free(nodes[i].set);
> +		bitmap_free(nodes[i].set);
>  
>  	mem2node__exit(&map);
>  	return 0;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 3a6bec22baa3..8736c70ffb51 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -275,7 +275,8 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>  	if (ret)
>  		return ret;
>  
> -	set = bitmap_alloc(size);
> +	/* FIXME: No counterpart free() */
> +	set = bitmap_zalloc(size);
>  	if (!set)
>  		return -ENOMEM;
>  
> @@ -284,7 +285,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>  	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
>  		ret = do_read_u64(ff, p + i);
>  		if (ret < 0) {
> -			free(set);
> +			bitmap_free(set);
>  			return ret;
>  		}
>  	}
> @@ -1277,7 +1278,8 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>  
>  	size++;
>  
> -	n->set = bitmap_alloc(size);
> +	/* FIXME: No counterpart free() */
> +	n->set = bitmap_zalloc(size);
>  	if (!n->set) {
>  		closedir(dir);
>  		return -ENOMEM;
> -- 
> 2.17.1
