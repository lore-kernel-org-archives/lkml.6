Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE54FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF56821726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="PLuSwoaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfAVTtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:49:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45704 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfAVTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:49:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so18993394lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NmPsqE8G6WGGPv00Ru3X7/khO7ujKuNr4cl12xVMT0k=;
        b=PLuSwoaZLlUUGL4c/2n9h1HsGAmCUeNBTwNC3Wp6gpkazfA8ZSDZ/sgNW05kekhG1/
         b7EDfABU81zuwtjeIOKyr9NHhPM3OrUqztkWbvwQAR553hTZbTW0eNL0rXGoBdr46E8o
         65JVPD3yehMi4Olc8x0MjsEMZx/yAZVmBiMikn2/1eSNI7lkSB1Ur47L8+ZyCIs44iMs
         mtkW+9TP1iVHHkkcjn7aNbHM6cxy0dLvueYAGLoF1lNTlEIy0PWZQAid527xQrInoQpc
         Mt0mmWVTUn2pocTmXruGfNNW87Z8zn3dzyaD/SKST5u9sLg+Qpf8qfvKGZAgMCOMheuF
         3eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmPsqE8G6WGGPv00Ru3X7/khO7ujKuNr4cl12xVMT0k=;
        b=HT6v5tNeiNxZUMqtkRj+MBGxirHJe4du/1jbUoY1GnMOB96BQJtfDE4uT95cr1tudk
         iBFdbuDROCwTY+QTOJw4okFGWotkfn89yWihxAhGdtLFwQl1qnKD7X6NoLMlCsi40IwY
         rZYPV+Rh1/12MsIIN4gG/ohMGPquTfmn2QtgIBmG0CAyeca24dlW3rlxR9KBOANL5Sik
         wtaFJJGzQ+bHRWFOKQ/uA3xqT79hFMkgPZuIkcHTV0FEr02RGr/SYcxFp7PoeN5zc/QH
         r5DDoDj2obj/YZZgY4AannVP929741DrDvODE57y0fcNnelIf68R0/6FkDuQVL/lSdlT
         C0fA==
X-Gm-Message-State: AJcUukc+IehPnA8ICKdG1WWH4lUAYZs4H0KT2ZA9PsiEBANNTXTFD7ey
        4v7hDoy+dL8gCS23dUfJggKy7g==
X-Google-Smtp-Source: ALg8bN4zCg1ilYlYrtl8BhEQM94uIds1bjWSiEct3YGvCjm164QOn54QggejlDKb7Hn5TypNFgo9ig==
X-Received: by 2002:a19:d619:: with SMTP id n25mr20638007lfg.91.1548186540290;
        Tue, 22 Jan 2019 11:49:00 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id y9sm141374lfe.75.2019.01.22.11.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:48:59 -0800 (PST)
Subject: Re: [PATCH] lightnvm: pblk: stop taking the free lock in in
 pblk_lines_free
To:     hans@owltronix.com
Cc:     javier@javigon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190122101531.30893-1-hans@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a0bceb9f-4f8a-1b69-8ef3-f2bc0747a3b5@lightnvm.io>
Date:   Tue, 22 Jan 2019 20:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122101531.30893-1-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 11:15 AM, hans@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> pblk_line_meta_free might sleep (it can end up calling vfree, depending
> on how we allocate lba lists), and this can lead to a BUG()
> if we wake up on a different cpu and release the lock.
> 
> As there is no point of grabbing the free lock when pblk has shut down,
> remove the lock.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index f9a3e47b6a93..eb0135c77805 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -584,14 +584,12 @@ static void pblk_lines_free(struct pblk *pblk)
>   	struct pblk_line *line;
>   	int i;
>   
> -	spin_lock(&l_mg->free_lock);
>   	for (i = 0; i < l_mg->nr_lines; i++) {
>   		line = &pblk->lines[i];
>   
>   		pblk_line_free(line);
>   		pblk_line_meta_free(l_mg, line);
>   	}
> -	spin_unlock(&l_mg->free_lock);
>   
>   	pblk_line_mg_free(pblk);
>   
> 

Thanks Hans. Applied for 5.1.

