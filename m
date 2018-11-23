Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECFBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F6320659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F6320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632778AbeKXCsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436604AbeKXCsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:48:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86ECE8830F;
        Fri, 23 Nov 2018 16:03:59 +0000 (UTC)
Received: from krava (unknown [10.40.205.162])
        by smtp.corp.redhat.com (Postfix) with SMTP id 412D25D9C7;
        Fri, 23 Nov 2018 16:03:57 +0000 (UTC)
Date:   Fri, 23 Nov 2018 17:03:56 +0100
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
Subject: Re: [PATCH] perf symbols: Cannot disassemble some routines when
 debuginfo present
Message-ID: <20181123160337.GA5575@krava>
References: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 23 Nov 2018 16:03:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 02:25:26AM -0800, Eric Saint-Etienne wrote:
> When the kernel is compiled with -ffunction-sections and perf uses the
> kernel debuginfo, perf fails the very first symbol lookup and ends up with
> an hex offset inside [kernel.vmlinux]. It's due to how perf loads the maps.
> 
> Indeed only .text gets loaded by map_groups__find() into al->map.
> Consequently al->map address range encompass the whole code.
> But map__load() has just loaded many function maps by splitting al->map,
> which reduced al->map range drastically. Very likely the target address is
> now in one of those newly created function maps, so we need to lookup the
> map again to find that new map.
> 
> This issue is not specific to the kernel but to how the image is linked.
> For the kernel, when we're not using the kernel debuginfo, perf will
> fallback to using kallsyms and then the first lookup will work.
> 
> This patch makes sure that the event address we're looking-up is indeed
> within the map we've found, otherwise we lookup another map again.
> Only one extra lookup at most is required for the proper map to be found,
> if it exists.
> 
> Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>  tools/perf/util/event.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index e9c108a..a69ef52 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1571,7 +1571,28 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  		 */
>  		if (load_map)
>  			map__load(al->map);
> -		al->addr = al->map->map_ip(al->map, al->addr);
> +
> +		/*
> +		 * When using -ffunction-sections, only .text gets loaded by
> +		 * map_groups__find() into al->map. Consequently al->map address
> +		 * range encompass the whole code.
> +		 *
> +		 * But map__load() has just loaded many function maps by
> +		 * splitting al->map, which reduced al->map range drastically.
> +		 * Very likely the target address is now in one of those newly
> +		 * created function maps, so we need to lookup the map again
> +		 * to find that new map.
> +		 */

hum, so map__load actualy can split the map to create new maps?

cold you please point me to that code? I haven't touch
this area for some time and I can't find it

thanks,
jirka

> +		if (al->addr < al->map->start || al->addr >= al->map->end)
> +			al->map = map_groups__find(mg, al->addr);
> +
> +		/*
> +		 * The new map *ought* to exist because the initial al->map
> +		 * contained that address and subsequently has been split into
> +		 * many *contiguous* maps.
> +		 */
> +		if (al->map != NULL)
> +			al->addr = al->map->map_ip(al->map, al->addr);
>  	}
>  
>  	return al->map;
> -- 
> 1.8.3.1
> 
