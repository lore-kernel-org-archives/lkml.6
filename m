Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F9218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYL63tw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfAHIAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:00:08 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:39462 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:00:08 -0500
Received: by mail-io1-f53.google.com with SMTP id k7so2456394iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 00:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n80u3Bj0sRgCZ2Ib0Abtxqm5mtdRub1PL/fORDN6hnY=;
        b=FYL63tw/QA90Ex09/G/sBbeL30LHGYI+8z03Z1/5O/1TtRMLuUNTgTE8VumYE/cXlL
         nPU9jRF5B/ofMmki6ZZl227e7+f5XdetHdD4Ihri/acNdR3FvyMlhMfQQWc8RDgDJRnJ
         stp71yeQIw7IF5rcPshtpeb1dfBtXUWb1U3lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n80u3Bj0sRgCZ2Ib0Abtxqm5mtdRub1PL/fORDN6hnY=;
        b=Grn5Fx7Sc7u+2A6HwFsaVS7i9beNMwVRTId0tUm2j6OgrjMrLCnLrn3fDEHizh6Uje
         benGTEmbdfsyXzA/3FwUMN3mNxsHd4i1XtrIEiB4OawxCAW2JiyBkVR/iYCtejRSdXba
         uJjAWGD3w34odRfRynNO/l3pNYsHpZJlNmrTqnkMkywEYnVys+kNfJpQ6OghPkKRamA4
         uTsfbcyqgqgkVJrXUhRI5YqhZgTCTyJS4EbbZcYUPLLmSwMRu+RK2zBszRRfLTgOEZPf
         zeaDEfPP3JgVpaHtW7hpg1DxT/R3Y6x67O+BjZp5rG4uF9miTWEeoq+hkryleRXjNCCI
         mTYA==
X-Gm-Message-State: AJcUukdKA0vRyL0WuzNmFSrurrWcHMgg1xwhEoVs5uFAvShSqdllAnQa
        JtT+qopDReUh9/EFTjsAnM6dSt0/HUoiRPlRo03VJw==
X-Google-Smtp-Source: ALg8bN4EOpyRuSmrkPIRDEuI583rUwwU2H+mu6bJCCzwD1t2lBoGJOUM1na1y6cZpu0cWPcPpYtwAjKUj8Umw+rFSUY=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr375125iof.183.1546934407614;
 Tue, 08 Jan 2019 00:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com>
In-Reply-To: <20190107233833.GI5544@atomide.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Jan 2019 08:59:56 +0100
Message-ID: <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Tony Lindgren <tony@atomide.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Tue, 8 Jan 2019 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi all,
>
> Looks like commit 8234f6734c5d ("PM-runtime: Switch autosuspend
> over to using hrtimers") caused a regression on at least
> omap5-uevm where 8250 UART rx wake no longer works. I have not
> noticed this happening on others so far.
>
> The devices I've tested all are using 8250 with dedicated
> wakeirqs configured for the rx pin. I can see the interrupt
> increase on omap5-uevm after some one or more keypresses,
> but then nothing. It seems that the uart just falls back
> asleep right away or something.
>
> Any ideas what might be going wrong?

What is the autosuspend value ? Can it be that the autosuspend is set
to a short value but was finally greater than 10-20ms on arm32. And
now the autosuspend happens before and this has changed the sequence ?

Regards,
Vincent
>
> Regards,
>
> Tony
>
