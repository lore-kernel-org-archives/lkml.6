Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE9DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A7208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACMrnEET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7A7208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeGIXBJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:01:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42804 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeGIXBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:01:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so2501054plb.9;
        Mon, 09 Jul 2018 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/N/hhU+5HqmyaHepc7yL/9ZXm7ls5sBTAozY4Jbbw8=;
        b=ACMrnEETwuhm+JkRTpRdM12sJAcyhI/EV8X1bxdiWJOc1459Pke1tvCgTxqrBaWVwk
         UsD6B2BM+icXjkP0XhsLitdXgkocIknRERvi3GAhEQjtB6Hb36nzeR/MRtu9eMmWH7RZ
         4gkVg1QKwkD2J7gy4SZH8+vkFaSEv2RRQvqOrkB9ZZoPceDDb00gY4L+BUIq6E1944kb
         lgfjrZGsEArW2KPVRSbf79Tt8PrrLB5QyT3Jfhjwock5kyYShfvJ+pDigw//w0d7oQfg
         f6siGqyUQqHz4jyg+terr04YWLjyyIUoxKVxiTSY5/Bhf533EZBexLQrTHojIO4WZ+Hc
         KD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/N/hhU+5HqmyaHepc7yL/9ZXm7ls5sBTAozY4Jbbw8=;
        b=hfga63njhXogb+NPO2fEyNuky7S8q15cXZNOddcyuuGO80g6bCRJJCqI/ZtiWspag0
         vDcuBRBaWosF4aZw1LnH36WBmt7Y/bJymnZepdjR0PywM8vtzeUVwB1TKY4HlbaKlruk
         7I6oJu+5vpBJyJ6Sltm5qOWaBwxsBVHiNYfOk3FEEe/3uG9B7B/zg+tpIDNo7oOWY+rX
         diWhRG0fvxGVmX1m1wmNaCWl+NrIX4jHmHVOo9RPCNp8rTtVulaJbnpFiXU7aRC0mRSn
         4ifiyHS8U5RwTRdNn/GcKbOw/WWyMBx7na6lF+i3QFeQawQ9ElPw/g6bBRM1/HXhPMdS
         /r6Q==
X-Gm-Message-State: APt69E3FCJ5DrCfMLczyTmRdgWhQJd/J7jbjoohuQmVMjFxVNE4gqlt5
        J2RHwm7GKLARPXXhBPiLpjc=
X-Google-Smtp-Source: AAOMgpd8OVb2peTugMaM6HumGmrN0eK9DgpOS0SYNPTyhrJ8Inta16CPPv/IUgfHZ3FXGB/TdU+MXw==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr22388903plb.14.1531177263573;
        Mon, 09 Jul 2018 16:01:03 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7:7b66])
        by smtp.gmail.com with ESMTPSA id e5-v6sm21288975pgs.59.2018.07.09.16.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:01:02 -0700 (PDT)
Date:   Mon, 9 Jul 2018 16:01:01 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tobias Tefke <tobias.tefke@gmail.com>
Cc:     tobias.tefke@tutanota.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: remove unnecessary condition in bpf_check()
Message-ID: <20180709230059.p6afqogzp6rb4ka4@ast-mbp.dhcp.thefacebook.com>
References: <20180709114837.23864-1-tobias.tefke@tutanota.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709114837.23864-1-tobias.tefke@tutanota.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:48:37PM +0200, Tobias Tefke wrote:
> In the label skip_full_check the function sanitize_dead_code()
> is being called if the return value equals zero.
> After that call there is another condition checking
> if the return value equals zero.
> If this condition evaluates to true,
> check_max_stack_depth() is being called.
> However, sanitize_dead_code() has no return value.
> Therefore the return value of bpf_check() is still the same
> and the condition can be removed.
> 
> Signed-off-by: Tobias Tefke <tobias.tefke@tutanota.com>
> ---
>  kernel/bpf/verifier.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e2bf834f13a..b022d0a85427 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5935,11 +5935,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr)
>  	while (!pop_stack(env, NULL, NULL));
>  	free_states(env);
>  
> -	if (ret == 0)
> +	if (ret == 0) {
>  		sanitize_dead_code(env);
> -
> -	if (ret == 0)
>  		ret = check_max_stack_depth(env);
> +	}

Technically the patch is correct, but I think it would make
the code harder to read. I prefer to keep it as-is.

