Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6168C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD0420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ByuTGB8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD0420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeLKQWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:22:11 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44916 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeLKQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:22:09 -0500
Received: by mail-vk1-f196.google.com with SMTP id h128so3500184vkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GREVsNBwr4Iijc8Kuiq4yr0HOhrd4qZDW90NZ7AjwXM=;
        b=ByuTGB8ufTNwmRRQ8yPvAdQHaOUmVbX9mporX93o+RMj7LczkKek5KHB9uXvUy27bQ
         xJP7BF/e0VquY9FB11Pyb2C1VdIUcj190oeR9lfVtMWfNVdcXxkvB9HMKmm/qz56RIHD
         TrQxdSIDNPQCKpJ61BPMaJGcMgFCCt4MyKZdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GREVsNBwr4Iijc8Kuiq4yr0HOhrd4qZDW90NZ7AjwXM=;
        b=CFeOviP4TP22YRx1OQjKkEHkZRX7CJVEQr8hPYUDugV5PZUC1g/Ihc0HNtXNRCYOT/
         mGxWSlJWzYfH2IkmokQWh4G5MT9vIVJ9ZovsMc1BbmFtgEQEg5FeBSKpGbz+y9ss5LRr
         zsiRAqdhMKVQKrKJUEWI3U9bVdiU5rSUEzk/C64eZ8YJGVbaEPx5xMtRA7NqiwpWdEkc
         X2T0yYer7AM4Tpp67OCwUX4EBPBDB/hsT0Dbb7aGE8v3y/qZZTueXbuaMTN7N5S/2G7A
         hFc+YkuzgrvrgcpzJxzXwNHrftI7NrNFAFH770ukopToVX/ON1L5vvGiJFXKSAjSMIjI
         iJLQ==
X-Gm-Message-State: AA+aEWbP/SlJP3X0DjwW5cCT1yOyWGmdQ1OHaIGnTuRnAFRrm17Ne5WB
        EwsEmFYn5hSiV+nFBLjVNMsspFUKPFI=
X-Google-Smtp-Source: AFSGD/WWTPcgEhphYxuK6Qg2cI2s3C2ppNJWjxRqMOEViqaUcOgY/Zu/W9350F7fCaSOBknxwfFF1Q==
X-Received: by 2002:a1f:b58d:: with SMTP id e135mr7499129vkf.86.1544545328242;
        Tue, 11 Dec 2018 08:22:08 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 2sm4245278vsd.13.2018.12.11.08.22.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 08:22:07 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 197so3505395vkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:22:07 -0800 (PST)
X-Received: by 2002:a1f:1881:: with SMTP id 123mr7330905vky.40.1544545326733;
 Tue, 11 Dec 2018 08:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20181206222318.240401-1-dianders@chromium.org>
 <20181210154311.GF6307@sirena.org.uk> <CAD=FV=X33+-TiBohnwN6+2R26iwxW0Rcthp16-3XYy+01hW4nw@mail.gmail.com>
 <20181211005221.GB3004@sirena.org.uk> <20181211010032.GE3004@sirena.org.uk>
 <CAD=FV=Xh26OSoMVTJCLiinw94MmgqNRexc=uWP+-58L8fBUavQ@mail.gmail.com> <20181211140609.GD6686@sirena.org.uk>
In-Reply-To: <20181211140609.GD6686@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Dec 2018 08:21:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XsOSBipZHg+DotyFPOsbLXDoS_rPyv7KRHA50GszbN0w@mail.gmail.com>
Message-ID: <CAD=FV=XsOSBipZHg+DotyFPOsbLXDoS_rPyv7KRHA50GszbN0w@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Clean enabling always-on regulators +
 their supplies
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Evan Green <evgreen@chromium.org>, masneyb@onstation.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 11, 2018 at 6:06 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 10, 2018 at 06:40:53PM -0800, Doug Anderson wrote:
>
> > Can you confirm my patch applies cleanly to your for-next branch?  I
> > can see that it doesn't apply to your 4.21 branch but I can't see it
> > fail on your for-next branch.
>
> No, I tried both and it didn't work on either.

I'm totally confused because I can't reproduce, but OK.


> > The problem is that commit 2bb166636933 ("regulator: core: enable
> > power when setting up constraints") touches the same code but isn't in
> > the 4.21 branch.  If you pick that to your 4.21 then my patch applies
> > cleanly.
>
> > If you'd prefer that I post my patch atop 4.21 I can do that tomorrow.
>
> I'd prefer that you resend like I said :(

If I can't reproduce the merge conflict that you're seeing I'm worried
that I'll just be sending you the exact same patch I sent before and
it'll have the same problem.  That's why I've been so focused on
trying to understand.

In any case it sounds as if sending it up against 4.21 should be fine
and maybe is preferred (since the patch it Fixes is in 4.21), so here
comes v2 against for-4.21.  OK, posted at
<https://lkml.kernel.org/r/20181211161720.102888-1-dianders@chromium.org>


-Doug
