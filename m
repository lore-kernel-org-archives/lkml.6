Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D23213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjSPUKxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D23213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbeGLV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:27:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38832 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732795AbeGLV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:27:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id p6-v6so23052395ljc.5;
        Thu, 12 Jul 2018 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ksc73jftXBP1fagEsVhR0XUDLJOIwzhHjW752kCIRaA=;
        b=MjSPUKxSJ5yg1XxAZJbwCy6tl4CyIJfLSvWhfNViS+sM/JzVJLlj3S7nL6KMNcoUQ6
         8UH556h+wSNooi96sr/nqc+yl/Rii+hbGOTy6xnINT6K4/ArVJrPcXDERt+PXk43tKtq
         O5Rp4l1XvhBKYDJokgMph+v0loakQbSXd4Cgj9GCKgNwZBhZBlyBEFWitw6LMdVD/5tF
         XntSSKMjMK2O6TpK/MPREBeyha41rwpcPRYm+8eDjM+fEzgtUAU4xmO+nRNz63qPCen4
         Fb38mg1VRWrpemzlDMl9oLpB5ZNUGTZ4nNtmMCSKWqsX75vfM/bMJxgfBbTEkr8uZ5X/
         pMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ksc73jftXBP1fagEsVhR0XUDLJOIwzhHjW752kCIRaA=;
        b=eep4bxxYvv5roUG+Nq2SlCrUEWa8C6pjc59qdt7+TWZDngDzSm8UJ5o87JiCVIeRcP
         4FGMfz5kzmww+U+w2Hy/sSwFBkW05vNR1a8vqtmAys4pkHDZRQ/c71H09U07OwaRzzdV
         meVwOXzWkCLJhtrc3Ok8gLLoe7ONTGalVDpc9iGWHwDfcycF4RJQvDmRWXD/ARsMHlIp
         4c4llU4iTNUmWb2sF9saxcG+FsvpoN9CqMngZVZIUWmkHjZ7Xz1B6/Pok3w38Bgi03gu
         9M960T3hphe4WGUcC2Euefw4/PZpy3FboNZ8VR8mswddlzr3F9lWjZJBKyhe06e2F1Cw
         TRuA==
X-Gm-Message-State: AOUpUlE8HpoeHXY6oiWAQtBGLYADcS1d3r+ZenrAJ0ilIuKnaPBpjg9v
        L4d29GrMc37yGY4y4sGHSQsKggXplDDCZhoZK60=
X-Google-Smtp-Source: AAOMgpdHtC4Z4ZHuiohDclnIykJO+72095i0jSBslwwTrRBwpDEG7ZYpxVkxcKHUZAicB2F11IDm4eDN1ZRJ+JZVg4o=
X-Received: by 2002:a2e:5bc8:: with SMTP id m69-v6mr1623417lje.115.1531430152539;
 Thu, 12 Jul 2018 14:15:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 14:15:51
 -0700 (PDT)
In-Reply-To: <CAGXu5jK7iRv1HE7JgW95vTgg5vhye4dxjfoQyN3G7HZzp7nZhA@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
 <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com>
 <CAGXu5jLUME9cjntUUed9EYukzEaODDzqRmtGht=uu7YVAG2WWg@mail.gmail.com> <CAGXu5jK7iRv1HE7JgW95vTgg5vhye4dxjfoQyN3G7HZzp7nZhA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Jul 2018 23:15:51 +0200
X-Google-Sender-Auth: lxHZIJ6a0Vgm3Jt7-uERVuUfVLk
Message-ID: <CAK8P3a3zvmAtkmqHhNO4788WQ8kbunSW8Jp-nA+hYHc2YmziEg@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:30 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 1:23 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Jul 12, 2018 at 8:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> Two uses of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>>>> (when less than 2048) once the VLA is no longer hidden from the check:
>>>>
>>>> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>>
>>>> This bumps the affected objects by 20% to silence the warnings while
>>>> still providing coverage is anything grows even more.
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>> (adding David Howells to cc)
>>>
>>> I don't think these are in a fast path, it should be possible to just use
>>> skcipher_alloc_req() instead of SKCIPHER_REQUEST_ON_STACK() here.
>>> From what I can tell, neither of the two are called in atomic context, so
>>> you should be able to use a GFP_KERNEL allocation.
>>
>> Sure, I can do that instead.
>
> Actually, I think this can actually be adjusted to just re-use the
> stack allocation, since rxkad_verify_packet() finishes one before
> doing another in rxkad_verify_packet_1():

That looks very nice, yes. The same thing is needed in
rxkad_secure_packet(), right?

       Arnd
