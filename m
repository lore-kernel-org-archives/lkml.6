Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC1BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0A7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPjCEka+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0A7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJPXU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPXU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:20:26 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1002F208B3;
        Tue, 16 Oct 2018 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539703768;
        bh=05PW9D8gXVk+BlFXxxgJOKB1tJnVRtNkbzqulALjx4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPjCEka+6KNxDZ56UNi+x3hSh8EpDq84W8f61dhuBPUfP1/zM0aZ2FZ1AXoc2pjRf
         FphoH6iVS5Qt7YRoWyv5r+fLlQrbl1nTlwvIscOJp+Gy/k0OUjrDhMqE4yw5WqzJ08
         36quplzy7hYxII5RfgWxJq7J+4Gffa8DwGoMDNpU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 586B2142C5E; Tue, 16 Oct 2018 12:29:25 -0300 (-03)
Date:   Tue, 16 Oct 2018 12:29:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Align cpu map events properly.
Message-ID: <20181016152925.GD3849@kernel.org>
References: <20181011.224655.716771175766946817.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011.224655.716771175766946817.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 11, 2018 at 10:46:55PM -0700, David Miller escreveu:
> The size of the resulting cpu map can be smaller than a multiple
> of sizeof(u64), resulting in SIGBUS on cpus like Sparc as the
> next event will not be aligned properly.
> 
> Fixes: 6c872901af07 ("perf cpu_map: Add cpu_map event synthesize function")
> Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks, applied to perf/urgent.

- Arnaldo
 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 0cd42150f712..0988eb3b844b 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1081,6 +1081,7 @@ void *cpu_map_data__alloc(struct cpu_map *map, size_t *size, u16 *type, int *max
>  	}
>  
>  	*size += sizeof(struct cpu_map_data);
> +	*size = PERF_ALIGN(*size, sizeof(u64));
>  	return zalloc(*size);
>  }
>  
