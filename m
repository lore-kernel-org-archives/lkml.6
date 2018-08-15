Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C732C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F100F215B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jWLc6jHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F100F215B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeHORFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:05:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38895 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbeHORFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:05:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so1478434wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=56xddTHqa+XoWD7cCXyJKuSTx7yHSuzZdKzMW3tAa4M=;
        b=jWLc6jHpMLIS/oU/J7IbaldaTFX2cHXFsSawQ7kj4MAg55m44eN39rAOQkLFHPIRxF
         LbArGJv/9xFsva/YIbameamG9+JLShWa6YRUGPUOmG/HhlBgSlmvFy7XER26Y3eo1DLW
         rPTKJ8A81XYcTfzPA7BaZm0j2YP6IOEVoAEkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=56xddTHqa+XoWD7cCXyJKuSTx7yHSuzZdKzMW3tAa4M=;
        b=I9FnXU5xdTDJCdHIDgXcqbdjybaFukKt88mQJHjBeGAHfjVAEt03Bt7jXMNUS6XuOQ
         1j8xnjRw1n5F4DomqL0De1ePqdvxKcUvxvosWLWEVPVJhJRJSQySowWbkfaeUIrqhPCm
         NAdrNRJ+m3VLXJPLAV/y0yv4fjyihCMqTDQDwPsUuy9spXphVyLCLOProaOqozE7xVYm
         9cveJLrPhkR/tE4kS3Wi29eB8eRmsnhLzfERENL4Egwe/VCjDVenOoFDZh9RBDZr7eUW
         n8IU0a76LaDzOFyvsTI8PaUXYqKP6QDIPBTvn1sik9D1j4DxfuEQHEefPcWij3wKWtRe
         hLhQ==
X-Gm-Message-State: AOUpUlHtNyjjWnGFTkUCbAuE5PNVERpI7iOgG/Vt5vho0g4TvxbL45Ym
        +2hQsWBd4TJ6gxulAMsfXA38E1skkjk=
X-Google-Smtp-Source: AA+uWPz9vm0bycnG3rCxA7kI3ETVSY8oxhxtncW/QxzWuT2mVV/KjUpOkVPl0vNOUbuks/R+OrD3zg==
X-Received: by 2002:a1c:588c:: with SMTP id m134-v6mr11805530wmb.154.1534342410573;
        Wed, 15 Aug 2018 07:13:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id e133-v6sm3536581wma.33.2018.08.15.07.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:13:29 -0700 (PDT)
Subject: Re: [PATCH] kdb: kdb_keyboard: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180805041825.GA20310@embeddedor.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <87f7d53a-8349-9fae-695e-c00cd5111161@linaro.org>
Date:   Wed, 15 Aug 2018 15:13:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805041825.GA20310@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/18 05:18, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I replaced the code comments with
> a proper "fall through" annotation, which is what GCC is expecting
> to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>   kernel/debug/kdb/kdb_keyboard.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
> index 118527a..750497b 100644
> --- a/kernel/debug/kdb/kdb_keyboard.c
> +++ b/kernel/debug/kdb/kdb_keyboard.c
> @@ -173,11 +173,11 @@ int kdb_get_kbd_char(void)
>   	case KT_LATIN:
>   		if (isprint(keychar))
>   			break;		/* printable characters */
> -		/* drop through */
> +		/* fall through */
>   	case KT_SPEC:
>   		if (keychar == K_ENTER)
>   			break;
> -		/* drop through */
> +		/* fall through */
>   	default:
>   		return -1;	/* ignore unprintables */
>   	}
> 

