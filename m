Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C3C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2077120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA4uIp7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2077120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeGYMbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 08:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeGYMbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 08:31:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094EC20844;
        Wed, 25 Jul 2018 11:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532517603;
        bh=13XUri3/wi88o6Umh1nW322tYhaWseUDVKuc81fIO44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA4uIp7ZDQg6YH2+jqyXX8u8mBiE5FrJaKJXXWJnx/Hw7m5tP6d1ywcCAgngPMgsk
         Bp2hYQ7LasD4sNIoxBLWOpKEaxRgkmOCpN07eoiS8vvsZhAoZWS/sQaci6IyDGePun
         GsOy02Ar+SEoAzaeKpItRol8A5gJv0hmj7FDmorY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8DFB81403B8; Wed, 25 Jul 2018 08:20:00 -0300 (-03)
Date:   Wed, 25 Jul 2018 08:20:00 -0300
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
Subject: Re: [PATCH 1/2] perf: drop unneeded bitmap_zero() in util/header.c
Message-ID: <20180725112000.GI13220@kernel.org>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623073502.16321-1-ynorov@caviumnetworks.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 23, 2018 at 10:35:01AM +0300, Yury Norov escreveu:
> On top of next-20180622.
> 
> bitmap_zero() is called after bitmap_alloc() in perf code. But
> bitmap_alloc() internally uses calloc() which guarantees that allocated
> area is zeroed. So following bitmap_zero is unneeded. Drop it.
> 
> This happened because of confusing name for bitmap allocator. It
> should has name bitmap_zalloc instead of bitmap_alloc. This series:
> https://lkml.org/lkml/2018/6/18/841
> introduces new API for bitmap allocations in kernel, and functions
> there are named correctly. Following patch propogates the API to tools,
> and fixes naming issue.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  tools/perf/tests/bitmap.c   | 2 --
>  tools/perf/tests/mem2node.c | 5 +----
>  tools/perf/util/header.c    | 3 ---
>  3 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 47bedf25ba69..96e7fc1ad3f9 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -16,8 +16,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	bm = bitmap_alloc(nbits);
>  
>  	if (map && bm) {
> -		bitmap_zero(bm, nbits);
> -
>  		for (i = 0; i < map->nr; i++)
>  			set_bit(map->map[i], bm);
>  	}
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index 0c3c87f86e03..d8e3d49d3638 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -24,11 +24,8 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	bm = bitmap_alloc(nbits);
>  
>  	if (map && bm) {
> -		bitmap_zero(bm, nbits);
> -
> -		for (i = 0; i < map->nr; i++) {
> +		for (i = 0; i < map->nr; i++)
>  			set_bit(map->map[i], bm);
> -		}
>  	}

Please refrain from doing unrelated changes to the purpose of the patch,
that just gets in the way of reviewing, i.e. what for removing those
braces? The patch should be just:

@@ -24,6 +24,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
 
 		for (i = 0; i < map->nr; i++) {

Because the point of this patch is just to remove this unneeded
bitmap_zero().

>  
>  	if (map)
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 540cd2dcd3e7..3a6bec22baa3 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -279,8 +279,6 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
>  	if (!set)
>  		return -ENOMEM;
>  
> -	bitmap_zero(set, size);
> -
>  	p = (u64 *) set;
>  
>  	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
> @@ -1285,7 +1283,6 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>  		return -ENOMEM;
>  	}
>  
> -	bitmap_zero(n->set, size);
>  	n->node = idx;
>  	n->size = size;
>  
> -- 
> 2.17.1
