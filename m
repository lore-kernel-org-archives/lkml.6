Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9FFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44F02084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44F02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJBBkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:40:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJBBkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:40:42 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1g73Rh-0000xy-1C
        for linux-kernel@vger.kernel.org; Mon, 01 Oct 2018 19:01:29 +0000
Received: by mail-qk1-f197.google.com with SMTP id a130-v6so15180750qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:cc:to:in-reply-to:from
         :openpgp:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=4vZl04JKGcA/xs1axAel9lKfFo8PbeprXVLZSpqzkLc=;
        b=mCe156qqclO5XrtdsclzIU3/SkGL/uLzp9L2pvgPbQqnQgo6n+f1/KPWQkEbfk4hwo
         PjN0PziIUoi+XediCrZnM1iyXDRpB3hnNVx997UBWIKlK2/IWXU6P1D6ljJB1YpTyxdD
         vnllNpz8uba+6x6zWE5dpTRWylH9Sshochg9oNO2QwE5WMzeXCYYHeYdoP/tPY211xaR
         ryVxm4rtY5YzMVd5RrxwT1dvh1mZi62mYxa19gPxrSZYlmhM7obL+C3I5kqbg7euLRFN
         aosEdVzfJ2JPG0t7e4k0nop48wYdobvsKzfbuG9Gl4WsTskLXmbxZExiJg/WpIerv5u1
         qp3A==
X-Gm-Message-State: ABuFfoj2nus6Kkqvu3YLvKX2cveSR6F98Cdwd6ywJbAvHeqE26/GA0zg
        BTkHmOxnqFWCnuXPuwrps7yKYFBUR/Carcj6pFqezFMcruJzTz2y0d+GqR5lAGVuLQVKPLB+nTY
        ZC4THtd3wuTVFaxB5Hs927Ad4ChkVCdovrJtffjd3Xg==
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr9171784qkb.326.1538420488265;
        Mon, 01 Oct 2018 12:01:28 -0700 (PDT)
X-Google-Smtp-Source: ACcGV610CRXv2KXGDxXhTAGd20fti/gQwPKKrmqz2lSYjNIj115WjIgl9HB1t4Ff9W0jR2zGvvUWEw==
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr9171773qkb.326.1538420488114;
        Mon, 01 Oct 2018 12:01:28 -0700 (PDT)
Received: from [192.168.1.109] (189-47-87-29.dsl.telesp.net.br. [189.47.87.29])
        by smtp.gmail.com with ESMTPSA id r79-v6sm2662585qke.31.2018.10.01.12.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 12:01:26 -0700 (PDT)
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
References: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
Cc:     gpiccoli@canonical.com
To:     linux-kernel@vger.kernel.org, dima@arista.com
In-Reply-To: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
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
Message-ID: <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com>
Date:   Mon, 1 Oct 2018 16:01:23 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2018 15:32, Guilherme G. Piccoli wrote:
> Hi Dmitry, thanks for the patch. It's very promising, we have some
> reports of this issue and I'm building a kernel with this patch in
> order the reporter can test it. But based in the previous feedback,
> this seems to be very mature now and ready to get merged, right?
> 
> I'd like to ask you if you did respin the patch with Greg's suggestion
> for the tag - I couldn't find it in LKML heheh
> 
> Oh, if you can CC me in future spins of this patch (in case there any),
> I'd really be glad.
> 
> Thank in advance,
> 
> 
> Guilherme
> 


Sorry, forgot to CC linux-kernel...
