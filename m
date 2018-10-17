Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42DDECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641762150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641762150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJQXJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:09:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40716 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:09:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id a13-v6so16677072qkc.7;
        Wed, 17 Oct 2018 08:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIil8q6ebQI673uNcHwbjnuIXYdWT7ZQm2WmVxLGQRc=;
        b=dwylzd2mFxrZUPHC11HzzQiv2WObvnBnPd4vR27pfZWzRucsTXakMk4jd8Zdn2V5RE
         EX99kKbj+xV4WC05R2p8guQVbXp0oyDp0WM+C7fJN/Ktiec9lS52uVHYWOilJbyJXTI6
         97rybjc/tkLRp3EFoAVL15eWvCm3No5G1OQbx26ZwNeqEt5AhuuEAI44dnIFGY5jg72x
         BqWDH0jl+T/Nr6W8b+s83sZrLOl/YyKqqLDAZQ65iYd2eRpwwm3ptm2UE2Q+fIX1ISKM
         U8mNhUKDlYV8E1dtF6WxZb54awtcUdO0GWxPzKxT4FupvQFVs/ADVM1GSyIPC59fCzQ5
         1mHg==
X-Gm-Message-State: ABuFfojbqAEITMEG1/ev1ZLk7r0RmdrbHnBQlNO7E3OZ2lau7kNfsYGL
        lqt+4vLS11n1uCKWQDxNJRRFosjQL+PCbukQpgSUDYri
X-Google-Smtp-Source: ACcGV60RF2hjPHk63nwSgLYJth0BPp62rFvzYZm4lVxT3PyW9ab5x8DI/kgvuCCQ3idRvsqDa2HMBhX3ARrFqKs1t6w=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr24491133qki.330.1539789207836;
 Wed, 17 Oct 2018 08:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <cdb473fa2fc1dd5752a989a03b1b9fb2016cb1a2.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <cdb473fa2fc1dd5752a989a03b1b9fb2016cb1a2.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:13:11 +0200
Message-ID: <CAK8P3a2Mbks25yEh7UQVFcBgtrFGext4QY33f3k-geABcsB5_g@mail.gmail.com>
Subject: Re: [PATCH V9 09/21] csky: VDSO and rt_sigreturn
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to VDSO and our VDSO only support
> rt_sigreturn.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I was a little worried about the VDSO because of the discussion we had about
64-bit time_t. Since there is no gettimeofday call in here, that's fine, so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
