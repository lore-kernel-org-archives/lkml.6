Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D83ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF6221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO4G2M5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeIRNFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727475AbeIRNFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:05:08 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73B9214D5;
        Tue, 18 Sep 2018 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537256028;
        bh=SUYU+9qc1rJSOn8u4MTA2unX+kdFQnaoaxMHQ0Gf2X0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nO4G2M5g33QLK/MlBXW9PIz9la65pXBMrBJ1WRUfRRXRVYCjJYd3qRxuKce72didm
         GBhmJbnonUVHvKaLgEUc8AMHzcvtF6hBmQZomwbi0Op7zUV9l+0p/8pFqqWHpNa3WM
         v/YmvLPe3nzV9CIJui1iqmjGl7+Dr3CN4Dqe1qiM=
Received: by mail-wm1-f49.google.com with SMTP id j25-v6so6309183wmc.1;
        Tue, 18 Sep 2018 00:33:47 -0700 (PDT)
X-Gm-Message-State: APzg51BuSjobKDAJHQJDCuTg1MhfiSIzOE4f22/1F5s2Iw+LvnyewOe/
        XMIkd6XngjakV7f3qx2jZHXpCbydF2gHXDL8QUA=
X-Google-Smtp-Source: ANB0VdbJDGJ1XU/XDjktGMdGrqVCgrycd6/MRTfiCxkpRV/4r6SQfj4MzHnJBLcjbN0DTJY8TbvqWt9p/9mQc+th5h8=
X-Received: by 2002:a1c:dc1:: with SMTP id 184-v6mr15022146wmn.145.1537256026240;
 Tue, 18 Sep 2018 00:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495@eucas1p2.samsung.com>
 <1537196970-5987-1-git-send-email-c.manszewski@samsung.com> <20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25@eucas1p2.samsung.com>
In-Reply-To: <20180917151006eucas1p2226806b94605b061bc1bc3e9b5a6c495~VOIhXssSK0729007290eucas1p25@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 18 Sep 2018 09:33:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeADXdhBYiVeErjgxnGdTLJVKNtpK65mXzg6m=hL8XRJA@mail.gmail.com>
Message-ID: <CAJKOXPeADXdhBYiVeErjgxnGdTLJVKNtpK65mXzg6m=hL8XRJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] crypto: s5p-sss: Fix race in error handling
To:     c.manszewski@samsung.com
Cc:     linux-crypto@vger.kernel.org, vz@mleia.com,
        k.konieczny@partner.samsung.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 at 17:10, Christoph Manszewski
<c.manszewski@samsung.com> wrote:
>
> Remove a race condition introduced by error path in functions:
> s5p_aes_interrupt and s5p_aes_crypt_start. Setting the busy field of
> struct s5p_aes_dev to false made it possible for s5p_tasklet_cb to
> change the req field, before s5p_aes_complete was called.
>
> Change the first parameter of s5p_aes_complete to struct
> ablkcipher_request. Before spin_unlock, make a copy of the currently
> handled request, to ensure s5p_aes_complete function call with the
> correct request.
>
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> ---
>  drivers/crypto/s5p-sss.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
