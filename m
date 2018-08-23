Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1052147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVZcd6sJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1052147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeHWRmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeHWRmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:42:13 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDCE2147A;
        Thu, 23 Aug 2018 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535033541;
        bh=M1VWXvsP066sEGfChnDjqrQQfSNJptl4hkfGQyd7KdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVZcd6sJ3HKzzu+ppWS9rymlb9WWYCdG3INgrgd5YlpMMvHmPx6IUvDXu8UrVqRmN
         mdzKvZlPqy9MilGzbPaakhgTAhU4yrRO0PlmhoBCKaLQpgLzCBI6yMIr/GRzuaMKt/
         PN62259bfAzKmDblNba5bZhhbFFcr7O1teAwz6z0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A0BD0141C3F; Thu, 23 Aug 2018 11:12:19 -0300 (-03)
Date:   Thu, 23 Aug 2018 11:12:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Properly interpret indirect call in perf annotate.
Message-ID: <20180823141219.GA4766@kernel.org>
References: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2018 at 02:29:34PM +0200, Martin Liška escreveu:
> The patch changes interpretation of:
> callq  *0x8(%rbx)
> 
> from:
>   0.26 │     → callq  *8
> to:
>   0.26 │     → callq  *0x8(%rbx)
> 
> in this can an address is followed by a register, thus
> one can't parse only address.

Please mention one or two functions where such sequence appears, so that
others can reproduce your before/after more quickly,

- Arnaldo
 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/util/annotate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> 

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e4268b948e0e..e32ead4744bd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  
>  indirect_call:
>  	tok = strchr(endptr, '*');
> -	if (tok != NULL)
> -		ops->target.addr = strtoull(tok + 1, NULL, 16);
> +	if (tok != NULL) {
> +		endptr++;
> +
> +		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
> +		 * Do not parse such instruction.  */
> +		if (strstr(endptr, "(%r") == NULL)
> +			ops->target.addr = strtoull(endptr, NULL, 16);
> +	}
>  	goto find_target;
>  }
>  
> 

