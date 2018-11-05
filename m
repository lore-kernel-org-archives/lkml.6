Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1AEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6C120827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiPtssnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6C120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbeKFBXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:23:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeKFBXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:23:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so8512008ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMxhmbRAIQLj3oBn3eeQ8aveNoV65uYF5CVgV05Xyuk=;
        b=GiPtssnKl+CaYcqrZMuvjYnXfJEkhYhBdBk25cK3lMl5KHop+yZDGdkKEBVAWelLOD
         XFoXM6UHeFBGL1xiYaLo0wDP1NDAtA8li3Ebkbd+MzXjTD67OXlAn9kIqT2Wgd5Uyo5p
         3gOWByV58uKDmRcPpGA2EdqoDXHJ9gLZF6HEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZMxhmbRAIQLj3oBn3eeQ8aveNoV65uYF5CVgV05Xyuk=;
        b=Fyw27jpcXi/fnhjwo+0MJ+rPfDy1FyoqHCsubtPtt2r5Ehp3mDwJl0Utpzcj8uc+0G
         fnKryeDR6OCSIUkBn7zw5wBIQNzgUv7y1MCalW88mx7cZnWA8EUQOYdNICO7cvgHoaz5
         SrTHxZudLyQuRib5xpQ2Uzn8PAge8mR1HOG6IociDCofcDeOELV3svEeiRwBOEIbphbn
         XTFYIzG0LznAjwNHAv7/Wx+tvnqNchY7yNwwYIH1xPv8Ejr52EJTBMGL1TOfaCfd7lID
         /mxUd1PDvaA6T/D2fMqxxBdkpFxpDWUaijkTT9bAlXdkQb4VJfkrP8bCpNW/5S7bHAYc
         MLww==
X-Gm-Message-State: AGRZ1gISgfqwhlUp+07PNggbgOkDSZBXHtLCrdukJxoQJJcTElmQ+DZJ
        J3zNobJvsdPLp2lFCjLmG7BjFg==
X-Google-Smtp-Source: AJdET5dHwTi+LwResUvqRCTJaFDsD+V9E3BMBcl9877qrnDgToHnef7nrlD6NwZfnQ8oNqQkZ2sGKg==
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr14900524ljg.23.1541433781673;
        Mon, 05 Nov 2018 08:03:01 -0800 (PST)
Received: from puchatek.local (89-77-138-96.dynamic.chello.pl. [89.77.138.96])
        by smtp.gmail.com with ESMTPSA id 67-v6sm1724796ljc.26.2018.11.05.08.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:03:00 -0800 (PST)
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>
References: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
From:   Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=marcin.juszkiewicz@linaro.org; prefer-encrypt=mutual; keydata=
 xsBNBFpUjlUBCACcrMkSqYJk8B5O6vhcdvMM4yMBxil9hqLD6oKoLkgNCGpnb03xtf2dkdbq
 yZJKEpPteoiYof/qrS7VewUcqWpNfuq5Q3x/Aun89CUVU1GZ+mY+nHhiTddSTCswCNhYfY8S
 lu0eCYIeF5xr3xNcvRIQhxvO1y3aLAo7Te7CikfmtpcM/5IEbUX3EXejoUeMlvdXvX19NM6I
 8uX1DO7v9g0CUN+1h+9YOvLIV+bOJ33jlsB2TNystteoBKotJYhIbfBhrLMWLMzBhOPUaTIe
 hlGO3+4CHi82MqowKYxablG29vFSCn6UFyJS25xLSbMflslCFJey8I4Wry33R1dmzT2jABEB
 AAHNMk1hcmNpbiBKdXN6a2lld2ljeiA8bWFyY2luLmp1c3praWV3aWN6QGxpbmFyby5vcmc+
 wsCOBBMBCAA4FiEE8CbDcZeweWDKBjDApkmLmwOs1qMFAlpUjlUCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQpkmLmwOs1qMVDQf/aIA4NIB03g6JqFoTvhrzvc+n5ALveUyRyChY
 QE71qYCRJi+2A8apTGxkJuk15I9bJ8ySnb6Z51MRg81pikfbPpumtUr9l5u0377JwZmKE/wE
 9drdHfiB+0iamr0+XTvADjIwEnRwz+Vts9ydZQ39cyDv9+2CRTpv/2yY8eM037Ftkejr5HSd
 PzHAHYAQ1SZZNQPHOvYhX3DxOeiOAKz5PUtLgosQLGnaXJ0PRPoajTh/pV3OPiiLeY9UfVsK
 h0s6vo5fSFIdYBSpRW6rEvIrvCmh2Ovgwmy7J6UQk5qiP5T+vFfyZDR90Z3o5kAxShLfGpIZ
 sWxSxuxeMf9SU96d0c7ATQRaVI5VAQgAvzQOLdVY5IoLKIFYz99HtW3FD05UiBdaeVrO14mv
 rh7AGqtd1vmMW7kTpnNhCMi2S54oM18ZMDcD0m1bTIVhSKNcrWuaTOQtL5KyDjHb5j1Q+MRJ
 d4M0n4rs+oskGicsvAHqcRh8BVTFbgVetn+GgT58alufWzIWDGpLcW4W0SgkL5/tYxEXDQI0
 +UJqMmoyDxZbIHmNJUxCXIFbxvUm5X5pNfT7sirfH+OzAeUt5PmjiIDW2Z9h/fgn0ybeLdty
 ZHPKLVwVwSZ+R7PE2IknkYfcKBaomLhDCfCqOKM3uX+8UtXyJ9cKQdnDZr+g6/ICveJ5SbtG
 vVXDRBTvt14o3QARAQABwsB2BBgBCAAgFiEE8CbDcZeweWDKBjDApkmLmwOs1qMFAlpUjlUC
 GwwACgkQpkmLmwOs1qMggggAjQ+LfkLRinj6VwYuQrIHxuyOipZi81s5GTeg5S2cIVKzA5V2
 LTCrIREhzJcEfU/wtj0WXhov1cDWt+QJUkJo7PugiWGH74LqSUkjcJl5WLNbhRzdXiTEjCij
 uwNnZjiHMzOzrlOLDZNZ2qdDTthcBVXexKLWzyJtVkWXdbDPUV47zhGzCc+Q1fvWi8aCJGlv
 8GxOIVR8OXEe1TV64dlUCbmcmjcFRQmvJyMwZE28AqhNtKsRlLkY0o5Yn02wkmgRtAbNA9jL
 00ZX+4x0H+Qm8NQG5Ps9Ay7DePwZH21SsWBleOo43xNlbiw+NUOxC+cIK9BJqAqMmCYoUwtT
 j99pMA==
Message-ID: <10c6f266-12ce-9f1a-5859-52873ff329f1@linaro.org>
Date:   Mon, 5 Nov 2018 17:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 05.11.2018 o 15:26, David Abdurachmanov pisze:
> Marcin Juszkiewicz reported issues while generating syscall table for riscv
> using 4.20-rc1. The patch refactors our unistd.h files to match some other
> architectures.
> 
> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT
> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
> - Adjust kernel asm/unistd.h
> 
> So now asm/unistd.h UAPI header should show all syscalls for riscv.
> 
> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
> generated asm/unistd.h UAPI header thus user didn't see:
> 
> - __NR_riscv_flush_icache
> - __NR_newfstatat
> - __NR_fstat
> 
> which are supported by riscv kernel.

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

With patch applied I got proper syscall data:

fstat  80
newfstatat     79
riscv_flush_icache     259
