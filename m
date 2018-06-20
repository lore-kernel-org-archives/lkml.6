Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B014C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E282083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="R5442HLf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lZjTljSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E282083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeFTUmp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:42:45 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:37823 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933136AbeFTUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:42:43 -0400
Received: by mail-yb0-f196.google.com with SMTP id h141-v6so357325ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tATrQWWW0pd2UvYxNQ4/lti6HhEJpb4t5hNJ19mDN0g=;
        b=R5442HLfmNLCqqzGx1xJe0/Gw5oMKY028iOrRBqQOJKrA1MxT0MbWBQ/FYs4hN/a/R
         toMBBLlC+DRbMrOpo5xWXUlZYRyc7dfgB1jywiiXE7pDqzLCXLEJ64NVJwOSxw2l0YnU
         Po6Hxtreacitalu/SWOBOcSfYeaXNQQPcaYflAfvwBIQR5zl94DtWsuEJEG6Uquj1l9+
         WayrvD0YpZR+NP+jsd2lXdvzYB4iQM7KnaArFzwWRL7ixZFMoAU+QXNVjDWhk58QDtPp
         Iel9GWHQ3YaLZu7Sy0yYwutZauLv48tqwCrTSsoFhXouiJY4+LcuuYJZrJUbwQ2Odb4Y
         D8Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=tATrQWWW0pd2UvYxNQ4/lti6HhEJpb4t5hNJ19mDN0g=;
        b=lZjTljSQLbqWxR5PkBbMyqzvghWRc9Xn1WnzPbXD2Qe0lvWg7V6aL0KhujTEHO68Dt
         uQI2FjD+e7Pr1Zl7n/ETySbuTldkuUAeZYmC2EIypy7DrsH8cmxcXgvG2slrm4ngK1Gg
         EnKfm8Y9fvc5ESYH63fCULXfc3eZTi2h3PAeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=tATrQWWW0pd2UvYxNQ4/lti6HhEJpb4t5hNJ19mDN0g=;
        b=k0n1wUZQKSARmC41GtOrHSYQucTSnp3GfdNHFNHVzFY8mRbzEE20ZRwIJOQ7gA6fFo
         w/5BaezqfgzIBhQeHd9f5pI0mTYU8nQS1fPl4vDIfc8P7P4qO33GtOa/c7ZD+bqx7i0V
         De6G/zYRvr21eBJVZdMPaMdW3KLSiHYlLyeLUsX3gWnV306nfnMDmKms13ROzGvtpyDf
         SSlubueT+EfFDColzSZkC6Hc+pXtisz50SMRS2knxAwh+Tt1gsVQcJEuJq4znmElL/p6
         ePlgQ2O/zZfqhBJAlLff/yTdZtO7DhDGvzfeN8RHL/P8YCHALy42q8CTslih1OL72nsy
         2Mag==
X-Gm-Message-State: APt69E0zUGdiClz8uuRMytoJWVqypTvBqyWEiyiZo4QTFzvaHLG0o8QC
        xP5tMMuFZ1p3ad7H27SFF5gN6iRz5RaJou/qMkhLag==
X-Google-Smtp-Source: ADUXVKKHUZezNNZM2B9A5+tTDx6698iKXxd9R9fEUJdUDAw5wmm6Lu1NsSYRtCrWN/z/JNLeuvKQ7vGgY0oCpGJGzjg=
X-Received: by 2002:a25:8b05:: with SMTP id i5-v6mr11613504ybl.484.1529527362528;
 Wed, 20 Jun 2018 13:42:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 13:42:41
 -0700 (PDT)
In-Reply-To: <073a8f9e-8ad5-6fd5-e9b8-33e2c9a65e37@c-s.fr>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-2-keescook@chromium.org>
 <638faf05-946a-1345-dda4-f75fee5b07d9@c-s.fr> <CAGXu5jKmZ2jn1V8rd3B5BcS0z_WOj0x4eThSG=DYdxSj+fnd2g@mail.gmail.com>
 <073a8f9e-8ad5-6fd5-e9b8-33e2c9a65e37@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 13:42:41 -0700
X-Google-Sender-Auth: FJ2QWmZAFzpmkG3DKNcWbTSaNgo
Message-ID: <CAGXu5jJe4k6ijfr9nk-uTZmuhZ+WxGnGBG_sh5ZqJQOuTcDpTQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] crypto: shash: Remove VLA usage
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 1:39 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 20/06/2018 =C3=A0 22:36, Kees Cook a =C3=A9crit :
>>
>> On Wed, Jun 20, 2018 at 12:30 PM, Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>>
>>>
>>> On 06/20/2018 07:03 PM, Kees Cook wrote:
>>>>
>>>>
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
>>>> by using the maximum allowable size (which is now more clearly capture=
d
>>>> in a macro). Similar limits are turned into macros as well.
>>>>
>>>> [1]
>>>>
>>>> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydA=
acU1RqZWA@mail.gmail.com
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>>
>>>
>>> Got the following warnings:
>>>
>>> crypto/testmgr.c: In function =E2=80=98alg_test_crc32c.part.4=E2=80=99:
>>> crypto/testmgr.c:1896:1: warning: the frame size of 2088 bytes is large=
r
>>> than 1024 bytes [-Wframe-larger-than=3D]
>>> crypto/hmac.c: In function =E2=80=98hmac_setkey=E2=80=99:
>>> crypto/hmac.c:88:1: warning: the frame size of 2088 bytes is larger tha=
n
>>> 1024 bytes [-Wframe-larger-than=3D]
>>
>>
>> Ah yes. I didn't do 32-bit builds. So, here's the issue: this uncovers
>> the frame size problems that were hidden by in being a VLA before. It
>> was always possible for the frame to get this big, it's just that the
>> compiler couldn't see it.
>>
>> For qat, I raised the -Wframe-larger-than flag. It seems we'll need to
>> do this in some other places too.
>
>
> Maybe the issue is because I have selected 16k pages ?

That would do it! And that's exactly the problem Arnd mentioned. For
v2, I will switch all the PAGE_SIZE-related limits to an explicit 512.
(And I'll do some 32-bit builds too to see if any other cases pop up
that I need to mask out.)

-Kees

--=20
Kees Cook
Pixel Security
