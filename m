Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD80C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAED20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAED20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeHQACG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:02:06 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40976 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeHQACG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:02:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so6451375qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9mVSEOM9s/JSjp4p2NdqxbvCIboDj2DAiAY3D4x5mI=;
        b=a+gLxXTKX+gR60RHCLN/WCA7HY7zUoNYYNPfHFP5p0n2Dee2AIRU/hUaULbOXAG+zB
         AMRHo9K7s9Ifz3YoTui+TfnAsc5VVV5Q+cLqU69uIzZn+WmI4b9+1yTqDX3B/w5Ny1es
         T6unHmhZ6sc9UZW/ePiEUqAK9exXOaJRmRx8IMhqQ2cgTY+niMB1mJq6zctvUcsYe0wZ
         m+6hk/Hfe03jyi316E4vrgfS+sidAQn8ULQi5Ht/y5LZww+wxceemm2eQC01nLcGR11w
         +exIE3X6KlqDd0W5133lOGtgMVE2sR5vdxXYTnOpJN5zSG7ZegkakaSzfviYrr0lrZQx
         ypdA==
X-Gm-Message-State: AOUpUlHIj+G8k57FhnTnhnffJC69x9k0zJgcF9gRHRqaRBCOQL5S/7tN
        R7B68zRn3EMcZmc6qTfoUb24LqMaE5oD2HeLjWI=
X-Google-Smtp-Source: ANB0Vdan2qfTh0KktUkBWFewiaTb2xc6WIR45iOB0G3z+RhqqmjOLlFMoUWJvs6uvvNvx3rEa4ZNh9yKTtNHTCvt7oo=
X-Received: by 2002:ac8:2f43:: with SMTP id k3-v6mr1934280qta.163.1534453285983;
 Thu, 16 Aug 2018 14:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180811155554.3382650-1-arnd@arndb.de> <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
In-Reply-To: <0e2639d6-7816-4e85-3212-74fcd118e396@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Aug 2018 23:01:09 +0200
Message-ID: <CAK8P3a3Z8Z5WjgD2Y_-QfZA+bt59z7kCvfaBTzNuHn6QWCVxJw@mail.gmail.com>
Subject: Re: [PATCH] [v3] drm: amd: dc: don't use FP math when Kcov is enabled
To:     sunpeng.li@amd.com
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, michel.daenzer@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>,
        Jerry.Zuo@amd.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 9:56 PM Leo Li <sunpeng.li@amd.com> wrote:
> On 2018-08-11 11:54 AM, Arnd Bergmann wrote:
> >
> > I tried implementing the two functions in KCOV: __sanitizer_cov_trace_cmpd
> > and __sanitizer_cov_trace_cmpf, but that fails to build on architectures
> > that do not support any floating-point functions, or would require making
> > that code x86 specific as well.  I also looked at what it would take to
>
> Hi Arnd,
>
> Is there a reason why we can't make __sanitizer_cov_trace_cmpd and
> __sanitizer_cov_trace_cmpf X86 dependent?
>
> I sent out two patches to disable DCN1, but would prefer implementing
> these two functions as opposed to disabling a component.

I think it should be possible to implement them, perhaps not even hard
to do it in an architecture independent way. I tried this at some point
and couldn't figure it out, but I suppose it would fix the problem nicely.

This would assume that the two functions can only ever be called
from a context that already has access to the fpu, which I think is
the case here.

         Arnd
