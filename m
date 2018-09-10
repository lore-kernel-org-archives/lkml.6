Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F366DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="giqy2HeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeIJT3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbeIJT3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:29:09 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CC920833;
        Mon, 10 Sep 2018 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536590086;
        bh=S/oa7tdWcj3evO0RUvzjHRdB55oi8ms6pTj0FdFmo0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giqy2HeScFMXpWlM/KpyG6/QjI/Bo4OIi38/L1TgMmxB2PmEPVw/db3EOhKUX0uxF
         VoOWSNqjUZCbJmPvhsJ4gkW1duFxjKL/jaBMfJbYjs4M/gg8sGHYj4yDSRdVsmrbzE
         /xwLK26SzsKQF0NSt08ysgnW3MtlxtrOMLzAszoY=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 357AA141FFC; Mon, 10 Sep 2018 11:34:44 -0300 (-03)
Date:   Mon, 10 Sep 2018 11:34:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] perf tools: Fix maps__find_symbol_by_name()
Message-ID: <20180910143444.GK5147@kernel.org>
References: <20180907085116.25782-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907085116.25782-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 07, 2018 at 11:51:16AM +0300, Adrian Hunter escreveu:
> Commit 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry
> trampolines") revealed a problem with maps__find_symbol_by_name() that

Can we have this with a Fixes: 1c5aae7710bb?

So that that, combined with the CC: stable, tells which stable kernels
should get that fix, I think there are scripts harvesting Fixes: tags to
help stable maintainers :-)

- Arnaldo

> resulted in probes not being found e.g.
> 
> 	$ sudo perf probe xsk_mmap
> 	xsk_mmap is out of .text, skip it.
> 	Probe point 'xsk_mmap' not found.
> 	   Error: Failed to add events.
> 
> maps__find_symbol_by_name() can optionally return the map of the found
> symbol. It can get the map wrong because, in fact, the symbol is found
> on the map's dso, not allowing for the possibility that the dso has more
> than one map. Fix by always checking the map contains the symbol.
> 
> Reported-by: Björn Töpel <bjorn.topel@intel.com>
> Tested-by: Björn Töpel <bjorn.topel@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V2:
> 
> 	Expanded commit message
> 	Corrected email address
> 
> 
>  tools/perf/util/map.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 3f07a587c8e6..354e54550d2b 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -574,6 +574,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
>  	return NULL;
>  }
>  
> +static bool map__contains_symbol(struct map *map, struct symbol *sym)
> +{
> +	u64 ip = map->unmap_ip(map, sym->start);
> +
> +	return ip >= map->start && ip < map->end;
> +}
> +
>  struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>  					 struct map **mapp)
>  {
> @@ -589,6 +596,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>  
>  		if (sym == NULL)
>  			continue;
> +		if (!map__contains_symbol(pos, sym)) {
> +			sym = NULL;
> +			continue;
> +		}
>  		if (mapp != NULL)
>  			*mapp = pos;
>  		goto out;
> -- 
> 2.17.1
