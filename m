Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD34C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844FB214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844FB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLGSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:10:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45348 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeLGSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:10:02 -0500
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gVKZc-0004gQ-6f
        for linux-kernel@vger.kernel.org; Fri, 07 Dec 2018 18:10:00 +0000
Received: by mail-qk1-f197.google.com with SMTP id z126so4022055qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XxOy1VaqqiDQE2cKwX2EUwjsafgfJdq9lW/ooO7GVsk=;
        b=T0vs/w0uGZR9X2COr1+IrxHKqUmK6CUf8zqHlZMZguLt4VqSTssV0O+UB6e3v0/nYJ
         qWhokn8DTLyQMBFfiddExd1PPHFfgYk4B5MV8fM4zKHX+Tl+olujeibrMd/lju9owh//
         FCHLoUPd0bbQJ0WXoRvgUhTCfV2bA8oXWU6AHGrocDXy/VXmSN4MiGArBvByG4RH6pXi
         cRRflQakFEtHnYp/Sp4nuBgO9oPCvQuM68ZzTIysQhXCdtQ/dSG3s3z10BykgAbIP6HY
         X0HiBiXC3LQVspGu6VGPrS3DZEW8YDRX2s1Q37GKVpq/4kZ744MAtnXNxyRagtrzh+Ed
         k5GA==
X-Gm-Message-State: AA+aEWaSTtGIDEe1DoPcEWVpD0urFTSr7N/+32YupkaI8/PD+y5a1N98
        uRUQl67SwtOSFujbjGJs/yNv6bbMlEqjvEpkoroxngiRMpd6ygQ6N7PzxrZyJzDtSpKig/wyf2b
        KJG0GKCbb1GE11601F0Qq3FHHo816m+dPQ808ziRq/w==
X-Received: by 2002:aed:2c22:: with SMTP id f31mr3133308qtd.154.1544206199021;
        Fri, 07 Dec 2018 10:09:59 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V1bwVUc5V3/VXdUppUpEgo1kCP0fGBS+urSDHBsMdpkrgAUZY43ONUhLeYdHI+CHrhx+yRNg==
X-Received: by 2002:aed:2c22:: with SMTP id f31mr3133290qtd.154.1544206198834;
        Fri, 07 Dec 2018 10:09:58 -0800 (PST)
Received: from [192.168.1.204] (200-161-156-119.dsl.telesp.net.br. [200.161.156.119])
        by smtp.gmail.com with ESMTPSA id d193sm3203404qka.91.2018.12.07.10.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:09:57 -0800 (PST)
Subject: Re: [PATCHv6 0/7] tty: Hold write ldisc sem in tty_reopen()
To:     Dmitry Safonov <dima@arista.com>, Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, mpatocka@redhat.com, pasik@iki.fi,
        peterz@infradead.org
References: <20181119125208.GC15229@reaktio.net>
 <addf7faa-f6e9-df6b-8dad-4c43b71cfc1e@canonical.com>
 <20181207152309.GA30796@cisco>
 <CAHD1Q_yPbhTYcKwk2PUkoabD+dTqegkVEab7nAvcrgAN10otSQ@mail.gmail.com>
 <9c3c1c65-3717-3567-89c5-85d35d89c678@arista.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <5d97600a-ce11-b2cb-47e5-0a539ac5860f@canonical.com>
Date:   Fri, 7 Dec 2018 16:09:53 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9c3c1c65-3717-3567-89c5-85d35d89c678@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 13:37, Dmitry Safonov wrote:
> [...]
> Yes, Greg kindly took the patches set into -next to increase coverage.
> So far, there is no standing issues known to me.
> 
> Ping me, if you have any, please.
> 
> Thanks,
>           Dmitry
> 

Thanks Dmitry, hopefully this time the series gets merged
in Linus tree and we have the fix for this long-standing issue.
Cheers,


Guilherme
