Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38FFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF472086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0QXgGhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF472086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeIEGHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEGHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:07:02 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7922086C;
        Wed,  5 Sep 2018 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536111558;
        bh=7PULMtZwuLh9p7RLfOMbuxPpCOiC5lTQhZSE7ZIeOa8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=S0QXgGhupL9UrihKQec/flimc5uwjcc+Rt6UKGnCW16gmJ8I3pHIfwqodnwKDJmcP
         zvyJcpafmG6cNcJXMoD+HUgPQoOOlJ2chlJi3w/2Ri6RVmhE2dM910VAs7s+3Gpju4
         otvAVyFmeezUi1dPgXOuZJ0o5drgey11J34xJewY=
Date:   Tue, 4 Sep 2018 18:39:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/parser.c: switch match_number() over to use
 match_strdup()
Message-ID: <20180905013915.GA1928@sol.localdomain>
References: <20180830194727.191555-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830194727.191555-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:47:27PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This simplifies the code.  No change in behavior.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/parser.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/parser.c b/lib/parser.c
> index 0142ef28f0eb..96656a6dd59b 100644
> --- a/lib/parser.c
> +++ b/lib/parser.c
> @@ -131,13 +131,10 @@ static int match_number(substring_t *s, int *result, int base)
>  	char *buf;
>  	int ret;
>  	long val;
> -	size_t len = s->to - s->from;
>  
> -	buf = kmalloc(len + 1, GFP_KERNEL);
> +	buf = match_strdup(s);
>  	if (!buf)
>  		return -ENOMEM;
> -	memcpy(buf, s->from, len);
> -	buf[len] = '\0';
>  
>  	ret = 0;
>  	val = simple_strtol(buf, &endp, base);
> -- 

Hi Andrew, are you planning to take this patch too?  The similar patch

  lib/parser.c: switch match_u64int() over to use match_strdup()

is in -mm now, but this one is not.

Thanks,

- Eric
