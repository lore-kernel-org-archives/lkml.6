Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A67021738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnGmxt51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbeLYHZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:25:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34312 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeLYHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:25:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so6327483pga.1;
        Mon, 24 Dec 2018 23:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fzNWOmT8sh5rGlWNYwljXN2T4O55ofuyfC4HLKotZUI=;
        b=WnGmxt51/Np7PaZJSL6UFR9LOaPgCw8lvfg1wfN4TG2EBp18wlbhoB9Y6YLY39taol
         vr8zvdcsj8Wobvp0u3GZi0PEmdyL9oHmY5uBVfmqIhMadwmU39xi9D9sTe0LZqodM6Qy
         Qu8DU4KwFyRX51PapH0Sdlaarc7Lyu4rU4r4GxYMlOaGx5sQucuW/6PA0YCRqKVQ1A5J
         0lmV/s4zdhLlhsCyN/yLFqeSRJz//aPwuwjuXLV38n3t4dju+QcBjJfxyXRWdBWW3nOX
         zRJzsi/FJgzp51L0rmj97i2v7WboXBdL+KeLkTR+EMe5vwgNLf3AzprStvoZDt/51Htu
         JkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fzNWOmT8sh5rGlWNYwljXN2T4O55ofuyfC4HLKotZUI=;
        b=TUsNkTPqSzFXUDL7jHOHTNb1JWHxHqI+Kafcj+Fz0UJ4JhUj5df8lXZkHSXtoPzu7Q
         Wj9EISAm6jPoijhEzN0TH/rYjzOz5JEoSrya2urlxvtB0E0GsKef2ZNFR6aBloS3CtSK
         3lZ8KGdSyGMpPTKEM3Z9KB7u1byGSnIbRjVFwD8mgeDTYjSuiaias3ZtAdC11M8R4cbs
         zO7dNnStKxV8DmKx0BwBN6Pc14WVazd72EU0YLHPo6iMyw+Pu2axixDJ4KZbBpfCYD76
         hjTg6XYse+sSCxQasEP9w5lBS30A9UA03Uoc40SAFsC4/ZnLSuQCvNopiG//7VqMKUQx
         T/ZQ==
X-Gm-Message-State: AJcUukfHrun0vpEThyQmF6Hy6KZN11e1K26mANDW9fFFtayOBsUXBNR4
        tXLRvjSjxsg3KnJECvS/FmE=
X-Google-Smtp-Source: AFSGD/UyqX0sqgDGFD+EIb6ljNwrWuRkAks+omjyk4Ra/ss5htXhgizAvbfgvjtZZ+OzlYDykUFupw==
X-Received: by 2002:a62:1709:: with SMTP id 9mr15626592pfx.249.1545722735087;
        Mon, 24 Dec 2018 23:25:35 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:6b2b])
        by smtp.gmail.com with ESMTPSA id r80sm50636171pfa.111.2018.12.24.23.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 23:25:34 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:25:31 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix missing checks of the return value of
 check_reg_arg
Message-ID: <20181225072529.t53rszflr3apeexz@ast-mbp.dhcp.thefacebook.com>
References: <20181225071710.67835-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225071710.67835-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 01:17:10AM -0600, Kangjie Lu wrote:
> check_reg_arg() may fail. This fix inserts checks for its return value.
> If check_reg_arg() fails, issues an error message.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  kernel/bpf/verifier.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 51ba84d4d34a..fde91a5c0b5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2619,7 +2619,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	/* after the call registers r0 - r5 were scratched */
>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>  		mark_reg_not_init(env, caller->regs, caller_saved[i]);
> -		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> +		err = check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> +		if (err)
> +			verbose(env,
> +					"check_reg_arg() fails in setting caller saved regs\n");

Such patch was already posted.
These calls cannot fail.
I prefer to leave them as-is.

