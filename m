Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C17214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547027044;
	bh=N6BJg0wtr4GtnPRcKV3wRN1Kjvil0sKOQOuUiBOhN6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lGWqU9HYzEHvzMmN07j6L0Ukx3RLVw3Dzkz4edj9VZ0fbk3NKUJ79cQldfElbnUi/
	 hkQmq25R8acAUmktg0qtBuCIt7xkHL+Ry7DggZMPKIHeFoIQ9d+1hXDV6Pvmz8rG8i
	 GmgYJl6424zEmZBVg914/F/nxv5IFF9JAjO9EMlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfAIJoD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:44:03 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34350 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfAIJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:44:02 -0500
Received: by mail-oi1-f177.google.com with SMTP id r62so5824605oie.1;
        Wed, 09 Jan 2019 01:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zbwo1Voy/TDZYXcAJfit3k7umA8oVRutjv4ekO+a860=;
        b=mezhRsOMTUL3Aa0PNZ16rcerU8TQGWIc2MdGgMc0wnKhTzBmkBx/6kKcTChvY+Y9wk
         RA+hIHOkgxjxuGKCru4qtAN0KCQyMvXTy+E9VX4+xq2IsVrsA/ez3i9NEXntuPTfAzTg
         w4GnzVkZommls7U37lhUtjCFZKwoHTlj9MnZ8XaB8zALj4LyFHVAlr7mqbqxLes+Xv2Q
         feUkQ8weKhiXI2SUa/4lBTlPTcQAFckh27BAyVSTYk6MUmp69Ax2prylzQ5TrPFO3zUU
         Klp8DzL29EYnlTvY2d0N1bD+jvl3K1bx6S9nGpxIGzJjp9LF80pXYJ2RKgczQIJJJnlW
         Gxrw==
X-Gm-Message-State: AJcUuke5goQ4pPjacWbSAB6VmHhiAdLScGCCa8IlAlZ/eBivKe9iTe5p
        2X8f2fjNj34fpHkJZQP4EcaGuOW2JBmxfnocmCo=
X-Google-Smtp-Source: ALg8bN5iY6Da81NiaUUra/cTcpi6K1GVqj8em5N44VvknmK3B+7hw3x146V55h/6hSGuiETNgZobZv9VRNVuS9wjBOI=
X-Received: by 2002:aca:195:: with SMTP id 143mr3247104oib.322.1547027042043;
 Wed, 09 Jan 2019 01:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20190107233833.GI5544@atomide.com> <CAKfTPtDBEmcsLotp-6K1KU1wM9Ba1EpMp3niXScRxYgzjs0nog@mail.gmail.com>
 <20190108155354.GL5544@atomide.com> <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com> <20190109014218.GA8363@linaro.org> <20190109015124.GO5544@atomide.com>
In-Reply-To: <20190109015124.GO5544@atomide.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 10:43:51 +0100
Message-ID: <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
To:     Tony Lindgren <tony@atomide.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 2:51 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> > Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> > > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > > Anything higher than 2200 ms seems to somehow time out immediately
> > > now :)
> >
> > This is quite close to the max ns of an int on arm 32bits
> >
> > Could you try the patch below ?
>
> Yup great thanks, that's it:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Cool.  Thanks for getting to the bottom of this!
