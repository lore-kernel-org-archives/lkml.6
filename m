Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3516C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FCB20664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="az8rvHHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FCB20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJ2FOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:14:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37223 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeJ2FOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:14:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so5804819lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/K2dBnZR+jc0HKVdZu+KFO9504l9fzV/S/hksoQLws=;
        b=az8rvHHrfWsveUEwqzJ42XL/LydgOJDY8K0t6eqGUj2UqNRdms7dEkSKvs6MRisbN1
         3d2HI2Aa1grlsU5vPMzSRs1rhcGueCu5+Hy8O6054tGt55bTr6JkVJMS8bPPCHRhlSas
         clUxp4RUjGO415wE7cAHGRDCYmAHC8qn9zlcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/K2dBnZR+jc0HKVdZu+KFO9504l9fzV/S/hksoQLws=;
        b=K0FoqZuxUjhUj6tQxAKBr59sbtFKON8uucn9UZlZ+atu9Gx83FZe3yxzHbXI1ixkw0
         2w5HobRsu9bmrxKQUVRolzHJcGYRMMb6px0XmN2zpt0Fza8uM8D735yhWcBIBFTlPihi
         dnUCkLfQczPwcn6SPQFt5fgKjSN6AzrVMZYfBLgsE/OTBh3cR2HkpbwXyrgUQGyVf3mI
         6csluy/+xOn02YQt1X7PYnTa6Gr5TRqejZqf3OZk1+w5ZxcqZE1mP2jnKc88pNDfv2dP
         i+J1HMHTmENRD5oPw5r0xg98/0GL8vbJuCqZeMbhUZrVc0+Eo2Ny/ayrjC8/uuYPaP7A
         cLKQ==
X-Gm-Message-State: AGRZ1gKBwdV3X5d9vNLcQIHB4imWLkbVIsgKUDBvxPkoSsdu0qIlZhq+
        f66hurLLeNZwDhiHLkFCYAEhuP//IL/Vjg==
X-Google-Smtp-Source: AJdET5cs5d6szvex9Xy+7tQMfXWhl1+RulqisK4BOKnEQG55gJht0EY8E8PyqMmUTSbvNW4OKWrK0g==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr7301497ljd.148.1540758496843;
        Sun, 28 Oct 2018 13:28:16 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id w9-v6sm2702471ljh.97.2018.10.28.13.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 13:28:15 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id f3-v6so5803421ljk.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:28:15 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr7220830ljh.59.1540758495125;
 Sun, 28 Oct 2018 13:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181028172401.GA41102@beast>
In-Reply-To: <20181028172401.GA41102@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 13:27:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrKjE_RsPmGv70Z1kN8tk2Rqv0EZczBB0BmcdPpqud1w@mail.gmail.com>
Message-ID: <CAHk-=wjrKjE_RsPmGv70Z1kN8tk2Rqv0EZczBB0BmcdPpqud1w@mail.gmail.com>
Subject: Re: [GIT PULL] VLA removal for v4.20-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kbuild@vger.kernel.org, yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:24 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these VLA removal changes for v4.20-rc1.

Pulled,

                   Linus
