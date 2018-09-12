Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30130C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6B4213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDk7jQWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6B4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIMEDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:03:40 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:45484 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeIMEDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:03:34 -0400
Received: by mail-io1-f50.google.com with SMTP id e12-v6so1594409iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EgZcEbg59QVjWNxoyROPDrTgEyRAiE/Lf/mQjux6twI=;
        b=jDk7jQWHq645EknXsspyOA3LfqfE0N1Ka7FnvwHlZw8KbCsACuJ0O8cg7tvhg068d3
         bRY+Slu5HqbVmXLrcHyc8eepohDPT8pr1mBrR7ZEQan+lfE7FEflq5TyCfD0m5+0KBRH
         ejSwS0dDgFJYvTeaOnavDN/CUZSYXMCFSv3HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EgZcEbg59QVjWNxoyROPDrTgEyRAiE/Lf/mQjux6twI=;
        b=dzZ0ppBSjpzyEET3Er9klIApk1flFTWZDla8CDaXKvTaNoEAtoZUo/OB6jt7XaX6xO
         amkdFKhbpn9DURt37NhnmHxWwbt9MLbVoP8k6AXVw4YWLoDzzwnao5sNhGkEtOfrkDyC
         TAD6u2+bktGOBnS/3uH/D92TczH+ax3p8oywO4Draz0W2G6agmwlg7u+1t+VyXZkDZQr
         a39BVynMAYctR1nvdITVhNQ4Bnqly6mvMl/nLtXyAu6bQxuMsoVhkgMfEjPBfiZo5uNY
         w1NeMV0U0T3P4k5g1hKTFVYjrVlMXkJ6ppvoIU5CKZgilVfWA1/xLe+Eup2RsE7Sxhqx
         k2xQ==
X-Gm-Message-State: APzg51DnTyp8EMtCUdTaKDvKStMkK6lxCef2mmxLm8Ic8us5nB4/Sjze
        OTQvQw3o5hVnF3MRfD38hFT2l7mkeahe8AHJXQoBEQ==
X-Google-Smtp-Source: ANB0VdZ7cWGo87+nD2KnLGp49rsvG5y9zIwEZFs2GQL55ni5lnS5CXQy1K94lnqONi797FZV5+RlfOaAjI3WRKPILQc=
X-Received: by 2002:a6b:4516:: with SMTP id s22-v6mr4122058ioa.60.1536793014199;
 Wed, 12 Sep 2018 15:56:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 15:56:53
 -0700 (PDT)
In-Reply-To: <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com> <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 13 Sep 2018 00:56:53 +0200
Message-ID: <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 September 2018 at 23:22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hello Ard,
>
> I realize you've put a lot of good and hard work into the existing
> crypto API, and that my writing in these commit messages might be a
> bit too bristly and dismissive of that hard work. So I think in a
> sense it's understandable that you've responded as such here. But
> hopefully I can address your concerns. One thing to keep in mind is
> that Zinc endeavors to provide the basis for simple and direct
> functions to software algorithms. This is fairly modest goal. Just
> some functions that do some stuff in software. Around these you'll
> still be able to have complicated and impressive dynamic dispatch and
> asynchronous mechanisms such as the present crypto API. Zinc is merely
> getting the software implementation side done in a very simple and
> direct way. So I don't think there's a good reason for so much
> antagonism, despite a perhaps overbearing tone of my commit messages.
> Rather, I expect that we'll wind up working together on this quite a
> bit down the line.
>

No worries, it takes more than this to piss me off. I do take pride in
my work, but I am perfectly aware that I am not a rare talent like
Andy Polyakov, which is actually why I have worked extensively with
him in the past to get kernel specific changes to the ARM/arm64 NEON
code into upstream OpenSSL, so that we could use the upstream code
unmodified and benefit from upstream review. [1] [2]

In this series, you are dumping a huge volume of unannotated,
generated asm into the kernel which has been modified [by you] to
[among other things?] adhere to the kernel API (without documenting
what the changes are exactly). How does that live up to the promise of
better, peer reviewed code?

Then there is the performance claim. We know for instance that the
OpenSSL ARM NEON code for ChaCha20 is faster on cores that happen to
possess a micro-architectural property that ALU instructions are
essentially free when they are interleaved with SIMD instructions. But
we also know that a) Cortex-A7, which is a relevant target, is not one
of those cores, and b) that chip designers are not likely to optimize
for that particular usage pattern so relying on it in generic code is
unwise in general.

I am also concerned about your claim that all software algorithms will
be moved into this crypto library. You are not specific about whose
responsibility it will be that this is going to happen in a timely
fashion. But more importantly, it is not clear at all how you expect
this to work for, e.g., h/w instruction based SHAxxx or AES in various
chaining modes, which should be used only on cores that implement
those instructions (note that on arm64, we have optional instructions
for AES, PMULL, SHA1, SHA256, SHA512, SHA3, SM3 and SM4). Are all
those implementations (only few of which will be used on a certain
core) going to be part of the monolithic library? What are the APIs
going to look like for block ciphers, taking chaining modes into
account?

I'm sure it is rather simple to port the crypto API implementation of
ChaCha20 to use your library. I am more concerned about how your
library is going to expand to cover all other software algorithms that
we currently use in the kernel.

>> In spite of the wall of text, you fail to point out exactly why the
>> existing AEAD API in unsuitable, and why fixing it is not an option.
>
> I thought I had addressed this. Firstly, there's a need for more than
> just AEAD, but ignoring that, the AEAD API is a big full API that does
> lots of things, makes allocations, parses descriptors, and so forth.
> I'm sure this kind of highly-engineered approach will continue to
> improve over time in that highly engineered direction. Zinc is doing
> something a bit different: it's providing a series of simple functions
> for various cryptographic routines. This is a considerably different
> goal -- perhaps even a complementary one -- to the AEAD API.
>

I understand how your crypto library is different from the crypto API.
But the question was why WireGuard cannot make use of the crypto APIs
AEAD interface. And note that this is an honest question: I know that
the crypto API is cumbersome to use in general, but it would be very
helpful to understand where exactly the impedance mismatch is between
what your code needs and what the crypto API provides.

>> I don't think you have
>> convinced anyone else yet either.
>
> Please only speak for yourself and refrain from rhetoric like this,
> which is patently false.
>

Fair enough. You have clearly convinced Greg :-)

>> Please refrain from sending a v4 with just a couple of more tweaks on
>> top
>
> Sorry, no, I'm not going to stop working hard on this because you're
> wary of a new approach. I will continue to improve the submission
> until it is mergable, and I do not intend to stop.
>

Of course. But please respond to all the concerns, not just the low
hanging fruit. I have already mentioned a couple of times that I
object to dumping large volumes of generated assembly into the kernel
tree without any annotation whatsoever, or any documentation about how
the generated code was hand tweaked before submission. You have not
responded to that concern yet.

> Anyway, it sounds like this whole thing may have ruffled your feathers
> a bit. Will you be at Linux Plumbers Conference in November? I'm
> planning on attending, and perhaps we could find some time there to
> sit down and talk one on one a bit.
>

That would be good, yes. I will be there.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4e7f10bfc4069925e99cc4b428c3434e30b6c3f
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7918ecef073fe80eeb399a37d8d48561864eedf1
