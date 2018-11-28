Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E81C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA6E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA6E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeK2Cvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:51:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeK2Cvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:51:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCFB9308626B;
        Wed, 28 Nov 2018 15:49:39 +0000 (UTC)
Received: from krava (unknown [10.40.205.15])
        by smtp.corp.redhat.com (Postfix) with SMTP id 750556A6B4;
        Wed, 28 Nov 2018 15:49:37 +0000 (UTC)
Date:   Wed, 28 Nov 2018 16:49:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH v2] perf symbols: Cannot disassemble some routines when
 debuginfo present
Message-ID: <20181128154922.GA13589@krava>
References: <1543403312-26687-1-git-send-email-eric.saint.etienne@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543403312-26687-1-git-send-email-eric.saint.etienne@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 28 Nov 2018 15:49:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:08:32AM -0800, Eric Saint-Etienne wrote:

SNIP

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index e9c108a..be333a9 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1569,9 +1569,54 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		 * Kernel maps might be changed when loading symbols so loading
>  		 * must be done prior to using kernel maps.
>  		 */
> -		if (load_map)
> +		if (load_map) {
> +			/*
> +			 * Note when using -ffunction-sections on the kernel:
> +			 *
> +			 * Only .text got loaded into al->map at this point.
> +			 * Consequently al->map address range encompass the
> +			 * whole image.
> +			 *
> +			 * map__load() will split this map into many function
> +			 * maps by shrinking al->map accordingly.
> +			 *
> +			 * The split happens in dso_process_kernel_symbol()
> +			 * where we call map_groups__find_by_name() to find an
> +			 * existing map, but with -ffunction-sections and a
> +			 * symbol belonging to a new (function) map, such map
> +			 * doesn't exist yet so we end up creating one and
> +			 * adjusting existing maps accordingly because
> +			 * adjust_kernel_syms is set there.
> +			 */
> +
>  			map__load(al->map);
> -		al->addr = al->map->map_ip(al->map, al->addr);
> +
> +			/*
> +			 * Note when using -ffunction-sections on the kernel:
> +			 *
> +			 * Very likely the target address will now be in one of
> +			 * the newly created function maps but al->map still
> +			 * points to .text which has been drastically shrank by
> +			 * the split done in map__load()
> +			 */
> +			if (al->addr < al->map->start ||
> +			    al->addr >= al->map->end)
> +				al->map = map_groups__find(mg, al->addr);

looks like a good place for WARN_ON_ONCE(!al->map) in here

jirka

> +
> +			/*
> +			 * map_groups__find() should always find a map because
> +			 * the target address was initially found in .text which
> +			 * got split *without introducing gaps* by map__load()
> +			 */
> +		}
> +
> +		/*
> +		 * In case the later call to map_groups__find() didn't find a
> +		 * suitable map (it should always, but better be safe) we make
> +		 * sure that al->map is still valid before deferencing it.
> +		 */
> +		if (al->map != NULL)
> +			al->addr = al->map->map_ip(al->map, al->addr);
>  	}
>  
>  	return al->map;
> -- 
> 1.8.3.1
> 
