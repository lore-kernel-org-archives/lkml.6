Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB56C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D982086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bORExDWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756445AbeFOSxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756346AbeFOSxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:53:53 -0400
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com [209.85.128.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69148208B2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529088832;
        bh=WGR9HA8fQDs7GgeeCC/tRoXoKNMmT8OokD1iIyVHJqU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bORExDWyaKRQIEIjBJEiWwO+sIyp7gkSCI00Kfr3JrO//6UVOSbVoAHcQ/39NC45q
         UldzKOH4XtIc6uoPKTvV+tGfuwTCKULuS2nLoxlItP0Cm9b6VM3KCYVkjS+6vz40yX
         TCKVBNQQVK5sFrffKCT65yjqfw1szY0m8etFrjf0=
Received: by mail-wr0-f171.google.com with SMTP id w10-v6so10849838wrk.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:53:52 -0700 (PDT)
X-Gm-Message-State: APt69E1qFBjnFrI0SKPhO73b84rTx2uBDFTcBVXuAN9R/4+WkuimuQ1/
        AtBrneHQcDmsy7FInRTiZr019yQvBR3ErkwXcVp/dg==
X-Google-Smtp-Source: ADUXVKKuRFYL/o0f4j2VqSplkkjYrokCnowSNyKmStQ9dVVbin1xTSYOlxHrCK+8uItULk+XQaTnCzH/nV9jRwM8z+Q=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr2571414wrd.67.1529088830896;
 Fri, 15 Jun 2018 11:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com> <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com>
In-Reply-To: <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 15 Jun 2018 11:53:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
Message-ID: <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:50 AM Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> On 06/15/2018 11:31 AM, Andy Lutomirski wrote:
> > for (thing) {
> >   kernel_fpu_begin();
> >   encrypt(thing);
> >   kernel_fpu_end();
> > }
>
> Don't forget that the processor has optimizations for this, too.  The
> "modified optimization" will notice that between:
>
>         kernel_fpu_end();   -> XRSTOR
> and
>         kernel_fpu_start(); -> XSAVE(S|OPT)
>
> the processor has not modified the states.  It'll skip doing any writes
> of the state.  Doing what Andy is describing is still way better than
> letting the processor do it, but you should just know up front that this
> may not be as much of a win as you would expect.

Even with the modified optimization, kernel_fpu_end() still needs to
reload the state that was trashed by the kernel FPU use.  If the
kernel is using something like AVX512 state, then kernel_fpu_end()
will transfer an enormous amount of data no matter how clever the CPU
is.  And I think I once measured XSAVEOPT taking a hundred cycles or
so even when RFBM==0, so it's not exactly super fast.
