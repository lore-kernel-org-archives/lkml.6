Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE33C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89F020827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="apwpL3OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89F020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJaGda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:33:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33410 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeJaGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:33:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id q5-v6so2614635pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jFMyyVwQr/LUCYYQ8WZyGpn7sd0dikyExLnULjRs5Ko=;
        b=apwpL3OF3vrfwo4EhlEU3uBgOx9s11TCVITZ7J+eAIIO00RW+XyUjDCqPLeZbIpU0Y
         N4Z6f+/FHeTjCTgWb1dUL3n6zrscWRZxrpuOD8G6J2mXEeyv7WVuSbNFPqDXRuoVsj2h
         lmhxOTQfMQb2GLSajveguldsjfjGfPPV3YY2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFMyyVwQr/LUCYYQ8WZyGpn7sd0dikyExLnULjRs5Ko=;
        b=DOOGbzIlNs/0yEA3+ochdQ5t4zM5k+EEWtaKtzreHVuYQfCHUAMzzsjeNTQVgDwOE8
         uGsgJaSxvP2/rAsnmvcKG+fn1qocHfkzP15LFjQI+u9pxYY1ea2yvRLWHTBUxH09Zewx
         SiOH22dSwXeM6BLiQgKelbHNRlNo5a1IO7oIdssyNCWcSKT4S8Gyo0VDP/ofaGVvq/h2
         o85UNu3hbmyZzLTaR4ULBUe6qBV0qRAUmr8Mcgk7x9XoXXVmjcpD9eXwB5q/WHDCgE2x
         T6+PGWmjeO/ibQfa2vVe2s10efHQfokXg/zjmJnlyBieiNjzvnUt/8l0gX5nfCi0CQER
         N8+w==
X-Gm-Message-State: AGRZ1gKmJojqNaYwh1rX1MI4if8kzH20C6VPWwQ5hpzDBELzLixXdS4y
        FMmqE6f83TgQnrjoi/xk5KuJOw==
X-Google-Smtp-Source: AJdET5dPLT5EsgbGdF0Ar2/zqWwje+ucaRIZb22Ps0MSlj0Untv/gM83y51P9Jo3Fse+1thr4eb9ww==
X-Received: by 2002:a62:25c2:: with SMTP id l185-v6mr454520pfl.8.1540935500630;
        Tue, 30 Oct 2018 14:38:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id b11-v6sm12800350pgi.10.2018.10.30.14.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:38:19 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:38:18 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peng Wang <wangpeng15@xiaomi.com>
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        vipwangerxiao@gmail.com
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
Message-ID: <20181030213818.GA32621@google.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030075234.21137-1-wangpeng15@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 03:52:34PM +0800, Peng Wang wrote:
> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
> function call path is like this:
> 
> ramoops_init_prz ->
> |
> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
> |
> |-> persistent_ram_zap
> 
> As we can see, persistent_ram_zap() is called twice.
> We can avoid this by adding an option to persistent_ram_new(), and
> only call persistent_ram_zap() when it is needed.
> 
> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
> ---
>  fs/pstore/ram.c            | 4 +---
>  fs/pstore/ram_core.c       | 5 +++--
>  include/linux/pstore_ram.h | 1 +
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ffcff6516e89..b51901f97dc2 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
>  
>  	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
>  	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> -				  cxt->memtype, 0, label);
> +				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>  	if (IS_ERR(*prz)) {
>  		int err = PTR_ERR(*prz);

Looks good to me except the minor comment below:

>  
> @@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
>  		return err;
>  	}
>  
> -	persistent_ram_zap(*prz);
> -
>  	*paddr += sz;
>  
>  	return 0;
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 12e21f789194..2ededd1ea1c2 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>  			pr_debug("found existing buffer, size %zu, start %zu\n",
>  				 buffer_size(prz), buffer_start(prz));
>  			persistent_ram_save_old(prz);
> -			return 0;
> +			if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
> +				return 0;

This could be written differently.

We could just do:

if (prz->flags & PRZ_FLAG_ZAP_OLD)
	persistent_ram_zap(prz);

And remove the zap from below below.

Since Kees already took this patch, I can just patch this in my series if
Kees and you are Ok with this suggestion.

Sorry for the delay in my RFC series, I just got back from paternity leave
and I'm catching up with email.

thanks,

- Joel

>  		}
>  	} else {
>  		pr_debug("no valid data in buffer (sig = 0x%08x)\n",
>  			 prz->buffer->sig);
> +		prz->buffer->sig = sig;
>  	}
>  
>  	/* Rewind missing or invalid memory area. */
> -	prz->buffer->sig = sig;
>  	persistent_ram_zap(prz);
>  
>  	return 0;
