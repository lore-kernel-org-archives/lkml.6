Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35425C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FCE21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeQdR9oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FCE21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGLQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:12:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34551 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeGLQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:12:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so4686846ljk.1;
        Thu, 12 Jul 2018 09:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4o+pVc76I4NpqHH2eR1yG+6hT4eS3LzYIYHVK++AuhU=;
        b=KeQdR9ocgfs2t8StC9pSnOCLJ/iL7v+K0hgB3swKdmJxPKD+jRhS59A38aWdrVRXh2
         PQw0ehbPgU/pj7ghCXl4059+kxU/EcozCgzGIna9N61QlKF4Zd9q82fHAdC7hxrB5y/U
         E2S7E41QLaM7ec1F9jzEZaitGTkLjTmJTjkFQ6wN82Hug7llZUbL6YbLfJDcTstuU2sW
         vHaw7a8vOcZOS3ICj4O0GFK+ReFEELlLFqBOZydiohZtqOfcC0aMymbmCD/phnceo5+d
         BUlbf7u+JzQJREEQqeaXJF1qaXZmFz0Gz38rwQeSgpCfRfgBG7DwgLfgb+8p/NtcMJZd
         A4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4o+pVc76I4NpqHH2eR1yG+6hT4eS3LzYIYHVK++AuhU=;
        b=kQTas87THZ7UJ1beFMcqUGALGQzb0PaOO5Dq4BxSXcmq0yfZvinVEIev5wGZ11Ua8c
         +xUEgYS/+viibh4sh8QggkiRWoM94WyACDydSXFjiIrXliaiM/spNBkbtEd55P+NV0/T
         0Mhbn+pPaGS5kltcLiUpDtZiitmN+URVm64S4fcWXk2Jx0xe7saK4OL/CgPuuZqZ2Kuk
         mCsYCtnA1lc3aRkkR/tkIxsJkJ+3I4i4C5yybunTK2fG7Rq3wQrnjdzqSoR5ERjlSxiJ
         YREAnhMVz7FrxTLeLHeEY1ULQWeMnYLSz5OJ6xvz3HhsRzrXjTrE+U8ZzAy7JNpQc1LS
         mWnw==
X-Gm-Message-State: AOUpUlFmpTPrs/FhHgPL2CjUYGyLArPGfLpoqucdJ2B8qf2rV84r4r3r
        +hiiwOTEW9GXnN70EjRkm5ltyaX+IojLADlhA7c=
X-Google-Smtp-Source: AAOMgpfDbu/5XMCh7XNcTDeRCZyEMYnL9vfeTBvaBJLLHcJDOF1tBRXLRteCwRjw4vG75lXgz2kWIYdSyU28ttGWoP8=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr1000986ljr.38.1531411347093;
 Thu, 12 Jul 2018 09:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:02:26
 -0700 (PDT)
In-Reply-To: <20180711203619.1020-12-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 18:02:26 +0200
X-Google-Sender-Auth: 6SiFBbG0ndqMPx7ST90W_pifB8o
Message-ID: <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
> Several uses of AHASH_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
> (when less than 2048) once the VLA is no longer hidden from the check:
>
> drivers/block/drbd/drbd_worker.c:325:1: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/block/drbd/drbd_worker.c:352:1: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> crypto/ccm.c:235:1: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/md/dm-crypt.c:353:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/net/ppp/ppp_mppe.c:158:1: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> net/wireless/lib80211_crypt_tkip.c:537:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c:528:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/staging/rtl8192e/rtllib_crypt_tkip.c:531:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This bumps the affected objects by 20% to silence the warnings while still
> providing coverage is anything grows even more.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

I think this is a dangerous precedent, I wouldn't really want any of
those functions to
ever take more than 1024 bytes, even that is really too much, but we
can't easily
lower the global limit.

You are patching all users of AHASH_REQUEST_ON_STACK with the exception of
arch/x86/power/hibernate_64.c here (which is always used on 64-bit and has
a larger limit already), which in turn suggests that the AHASH_REQUEST_ON_STACK
macro using bytes is just fundamentally broken by requiring that much space
(808 bytes for the context, plus 8 pointers for struct ahash_request, plus
CRYPTO_MINALIGN_ATTR).

How did you come up with that 808 byte number? I see a total of 39 callers
of crypto_ahash_set_reqsize(), did you check all of those individually?
If 808 bytes is the worst case, what are the next 5 ones? If there are only
a few of them that are badly written, maybe we can fix the drivers instead
and lower that number to something more reasonable.

Looking through some of the drivers, I found this interesting one:

#define SHA_BUFFER_LEN          (PAGE_SIZE / 16)
struct atmel_sha_reqctx {
...
        u8 buffer[SHA_BUFFER_LEN + SHA512_BLOCK_SIZE] __aligned(sizeof(u32));
};

which would result in overrunning the kernel stack immediately if ever
used with 64k PAGE_SIZE (we fortunately don't support that driver on
any architectures with 64k pages yet).

The other ones I looked at seem to all be well under 400 bytes (which is
still a lot to put on the stack, but probably ok).

      Arnd
