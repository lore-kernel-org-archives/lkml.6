Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C59F81836
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490DE2174A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggJiJT0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490DE2174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIMV5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:57:42 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46908 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeIMV5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:57:42 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so3522006ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j2lc9C+CbxDGbX0Xw7G/NQSYlrsMO0mPE0rvLDe01ss=;
        b=ggJiJT0Igsw58f9Pti93p5xomqKMEBCV7PRh5SJBtIZyNeSFKrR10jDjEXrDHowISh
         sPHyXLdPkHX9BhWNsKpORf/4+mGt+wkmGsOaXSxj/KNqvIYMH7VmgNLygbXKx0BNuIel
         5Ojg8CYEqqlIUwuYrQmNqbKbLPmcoTKKkC2hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j2lc9C+CbxDGbX0Xw7G/NQSYlrsMO0mPE0rvLDe01ss=;
        b=J15iwh4MjAaiuCI7cwEIOgzHQ3vdlYkdWPJGkFZDl/WkchEIYTczwgSCl5bVcjIEv1
         ttHYNoX5fFoLa1vr3yhkcnbwZot/tyKM4HA5GSBIzXKU8vp/o0GyyGm+AaGZr2TYllcO
         gbBHmzbnXMrD9LJV3PDOC0gZoRSFFyqUIfMw4DQnok+/bW55dnXBw3EMzo3m5yjLWo9k
         FpdcZMR68fhzFOMnh5TwiRfzoBOl0PI5UmAJ4EGURyQe7p/PkSzcFJ0ceSogCgBwZpCI
         Uy+ZyBZt0AEFnrHhux7AGRLJE/pXTc7GTUQi258URa5tNRXo+Sjws9Apol6x2iWaU5Go
         gACg==
X-Gm-Message-State: APzg51COnYzgQo3VBMR/7SXTNsQhusyBx7CWNPaMVnqKb2V4qug1juLs
        hzNjMxTcKG6uy+H6wHEgULEnQWa3/Rw=
X-Google-Smtp-Source: ANB0VdbFKXoNxVyTmONrFBA7GcMy/LRd5GlojaOixxo0ky3i2bqWsVn2v8kGf3VYykUiexv+YdoGgg==
X-Received: by 2002:a25:3990:: with SMTP id g138-v6mr3865671yba.74.1536857243118;
        Thu, 13 Sep 2018 09:47:23 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i123-v6sm5470906ywe.14.2018.09.13.09.47.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:47:22 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id m123-v6so3567848ybm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:47:22 -0700 (PDT)
X-Received: by 2002:a25:7d44:: with SMTP id y65-v6mr4016017ybc.421.1536856906404;
 Thu, 13 Sep 2018 09:41:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 09:41:45
 -0700 (PDT)
In-Reply-To: <20180904031318.47jc3jrxcdjeac5y@gondor.apana.org.au>
References: <20180807211843.47586-1-keescook@chromium.org> <20180807211843.47586-6-keescook@chromium.org>
 <20180904031318.47jc3jrxcdjeac5y@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 09:41:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKfR4JD5O1brLh=NFUvu2jMHHZ4JF93ZKwfk1CuuhGbbg@mail.gmail.com>
Message-ID: <CAGXu5jKfR4JD5O1brLh=NFUvu2jMHHZ4JF93ZKwfk1CuuhGbbg@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] dm: Remove VLA usage from hashes
To:     Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 8:13 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Aug 07, 2018 at 02:18:39PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this uses
>> the new HASH_MAX_DIGESTSIZE from the crypto layer to allocate the upper
>> bounds on stack usage.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Can the dm folks please review this patch?

Mike or Alasdair, can you Ack this patch so Herbert can include it in
the crypto tree? This is blocking some VLA removals[1]...

Thanks!

-Kees

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

-- 
Kees Cook
Pixel Security
