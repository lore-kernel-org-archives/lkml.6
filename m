Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mhffp8AM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2901F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJJWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:11:53 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33103 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeJJWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:11:52 -0400
Received: by mail-yw1-f67.google.com with SMTP id m127-v6so2276053ywb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6vb8mTHxh+51Y3sbgq4Ms+t4t6l508BHXZnjEgq7fsA=;
        b=Mhffp8AMKFwdrB6iAb7AgTcdZn94XJtzeDDD6cD7SaJCfzqbkF/ErOqdlKykwXtzlG
         uCg4JGrT02WaPtGkR1LmMWy2k8fnZC4XkDT7cDJVOC1cmZ8MLUB0ucKLacmEzHqHh5aK
         e8EB8Y066H3TA35Yh73/GFg11PbVXnwTmX4TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6vb8mTHxh+51Y3sbgq4Ms+t4t6l508BHXZnjEgq7fsA=;
        b=atIE5ST5SrO7dGVBYrX+lrT5pu5zNZqlM/9ScrhAXduSEEQOUo5AmwtX9Zxq2Rr1YG
         x8K3L/ClTsrqn8RZAgvG8Y4hdR8OkeZIoHX97nCR2u240pmBu15bIXs+eXGMu15yuQ9W
         oC5+jhB7JYhij1stWBOLTBCRoEWD0j1SggHqjpxSt80b2LxEJ909sLGaNosM5X7aLRwh
         k/ow7JWqiehpi9IkTvd21RloTTFhFUYCEHRhDmKIV8WWW0v0pfE7XWXEJUKJQ+/0BlfU
         r3EfjGS9K3+XgcgfOMjThc72nq9Ep56ekTtSqrRIdAWsdgv/Ugg9NhpxArluLUe/UP0Q
         VGWw==
X-Gm-Message-State: ABuFfoib1a5UpRvMv+KPFldbXr7RILZUZowHbhI6DHsw/RrWfeOu3aE3
        FM5Kt1vEKb3gsgz6aHEd2JOJvHPqZAM=
X-Google-Smtp-Source: ACcGV60eR6VI3Pk2idFRcDzAQheS0DPLDreIbjKvYDrOzZpB7DZQy8SohS/0iduaGOVleJvYlVVVYw==
X-Received: by 2002:a81:9d14:: with SMTP id u20-v6mr19548096ywg.14.1539182960657;
        Wed, 10 Oct 2018 07:49:20 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id j76-v6sm6614660ywj.5.2018.10.10.07.49.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 07:49:18 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id m127-v6so2275941ywb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:49:17 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr18708565ywg.47.1539182957146;
 Wed, 10 Oct 2018 07:49:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:49:16
 -0700 (PDT)
In-Reply-To: <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com>
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
 <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com> <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Oct 2018 07:49:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
Message-ID: <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 12:03 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Oct 10, 2018 at 8:12 AM Joel Stanley <joel@jms.id.au> wrote:
>>
>> On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
>> >
>> > Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?
>>
>> clang built -next is blowing up now that Kees' -Wvla patch has been
>> included. This patch fixes it.
>>
>> Kees, perhaps it should go in your tree along side of the -Wvla patch
>> if no one else wants to take it?
>>
>
> I can take it along in the compiler attributes tree, since that
> touches the compiler*.h stuff. Although that would make it
> not-only-attributes, i.e. slightly lying :-)

Oh, I had assumed Masahiro was going to carry it. If that's not true,
sure I'll pick it up as part of my VLA "series".

-Kees

-- 
Kees Cook
Pixel Security
