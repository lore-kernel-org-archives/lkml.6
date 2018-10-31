Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D256ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C392081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UETGPHMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C392081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeKAAEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:04:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42742 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeKAAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:04:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id e126so10189907vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4crfMsl3Wc2J4jxKAjIepRxTDy5s9OpjesFvpaqHOY=;
        b=UETGPHMhKbXe4GowD+lrhsOxcw5tFA/a+jILfhjdCwRR+7I7fCEN0pkp+gwOKVDcN6
         8bV9ifPmEfKAkTOoOTl5G329ll5PqnV7rD8g3SNSxUQk9sZEQco9ymfRQ7kwVmC/qirA
         3YfRPavg1vsHSmaPOzOtu6Udc27uVTZuMz34c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4crfMsl3Wc2J4jxKAjIepRxTDy5s9OpjesFvpaqHOY=;
        b=bdCj55cFDMp22U7iIOJuve2rA5E4gpvmIHZN9kU4gbr4ZtnifjLpahwIwASxrqeB4O
         5bZ45eoXKFcJv7mbjAL99cvCeg3gSGCwofihrmfGglR+Gw9oRcKSMpyt5dcSJBRuUkEz
         aax/UF4SIcT6byf056By2SFaX3U/sZfVOPOhIkznx0Zt9gfViKX0PhMGQG4Km6+edG5e
         C/OHaaf7+kmPox5FP4i7/qMJM+I05UYzrZIyLSZopkrme++bFVr0/mLzB3GPJgpcpgX5
         k10CtsJ2tRODUsb4h1ZsVLed6VXgPtUadIlqS7SOdP4/JGw1MFSAWhEJ9gEkKITg8jiC
         VLWQ==
X-Gm-Message-State: AGRZ1gLbHczCnVagPfW+57KUFHgFVIuRsdhP6PwEXAVE52eMO/CsFeO8
        8HfISDgrxyrKh4pcHtVPCjpcUEp2/AA=
X-Google-Smtp-Source: AJdET5dn5qjOr2ptjzvxmMduV1G5fltaseMlWIj2drpHRUX2JPwhF8XPEMfMx5FUjOzTtA05zRJliA==
X-Received: by 2002:a67:7b83:: with SMTP id w125mr1436439vsc.5.1540998370683;
        Wed, 31 Oct 2018 08:06:10 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id k22-v6sm8011765vkk.29.2018.10.31.08.06.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 08:06:09 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id g10so6019077uak.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:06:09 -0700 (PDT)
X-Received: by 2002:a9f:3743:: with SMTP id a3mr1583335uae.86.1540998367995;
 Wed, 31 Oct 2018 08:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181030205334.148162-1-dianders@chromium.org> <20181031115910.5bqgtnzf2zujnp5b@holly.lan>
In-Reply-To: <20181031115910.5bqgtnzf2zujnp5b@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Oct 2018 08:05:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W+NScZ8KCcBhULwmx3VMx0uUro=jKm7og9-OsRKmNdmA@mail.gmail.com>
Message-ID: <CAD=FV=W+NScZ8KCcBhULwmx3VMx0uUro=jKm7og9-OsRKmNdmA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix btc (backtrace on each cpu) crash
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, me@tobin.cc,
        Joe Perches <joe@perches.com>, stable@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2018 at 4:59 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 01:53:34PM -0700, Douglas Anderson wrote:
> > Typing 'btc' on kdb doing all sorts of fail.  Sometimes it would
> > crash, sometimes display nothing, and sometimes hang.
> >
> > Bisect tracked this down to the commit ad67b74d2469 ("printk: hash
> > addresses printed with %p"), suggesting an obvious fix.  The pointer
> > used internally in kdb shouldn't be hashed, so switch it to %px.
> >
> > Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think we've already got a fix for this:
> https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git/commit/?h=kgdb-next&id=a0ca72c2d1ac83d0853a23ffde8f3624648b1ee8

Ah ha.  Nice!  Sorry for not noticing this.  The newest I tested was 4.19.

-Doug
