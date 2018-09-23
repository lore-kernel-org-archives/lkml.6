Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C824FC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9382148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 12:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9382148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeIWSLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 14:11:12 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:49018 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeIWSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 14:11:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E9D93183C4;
        Sun, 23 Sep 2018 14:13:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7PBqM3ygVc9Y; Sun, 23 Sep 2018 14:13:52 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id D0F3A18398;
        Sun, 23 Sep 2018 14:13:51 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF0D81A065;
        Sun, 23 Sep 2018 14:13:51 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A39A81A061;
        Sun, 23 Sep 2018 14:13:51 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Sun, 23 Sep 2018 14:13:51 +0200 (CEST)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
        by thoth.se.axis.com (Postfix) with ESMTP id 9749D2F8E;
        Sun, 23 Sep 2018 14:13:51 +0200 (CEST)
Received: from [10.88.41.2] (10.0.5.60) by XBOX02.axis.com (10.0.5.16) with
 Microsoft SMTP Server (TLS) id 15.0.1365.1; Sun, 23 Sep 2018 14:13:51 +0200
Subject: Re: [PATCH crypto-next 18/23] crypto: artpec6 - Remove VLA usage of
 skcipher
To:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        <linux-arm-kernel@axis.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric Biggers" <ebiggers@google.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180919021100.3380-1-keescook@chromium.org>
 <20180919021100.3380-19-keescook@chromium.org>
From:   Lars Persson <lars.persson@axis.com>
Message-ID: <29e492c8-671a-2077-043f-e4f829ba04f2@axis.com>
Date:   Sun, 23 Sep 2018 14:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180919021100.3380-19-keescook@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: sv
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX01.axis.com (10.0.5.15) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/18 4:10 AM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> replaces struct crypto_skcipher and SKCIPHER_REQUEST_ON_STACK() usage
> with struct crypto_sync_skcipher and SYNC_SKCIPHER_REQUEST_ON_STACK(),
> which uses a fixed stack size.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lars Persson <lars.persson@axis.com>
> Cc: linux-arm-kernel@axis.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/crypto/axis/artpec6_crypto.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 

Acked-by: Lars Persson <lars.persson@axis.com>

