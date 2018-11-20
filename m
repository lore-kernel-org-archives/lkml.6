Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D942C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0969B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="caIbR1ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0969B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbeKUDWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:22:36 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:45418 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeKUDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:22:35 -0500
Received: by mail-vk1-f193.google.com with SMTP id n126so553543vke.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpC0CcOv1I31aI53uDJUrdUOcDYKqfjWneEUVPLLDH4=;
        b=caIbR1ro4uMYrhmznX90HEehQNOO4+bKCXlaS6VLssqo2PxuK9GOxv3e/5TD1bTEM+
         SPmMM1yOFadooLqcU/nLJpEX6qWgNDbVuUq7PTLlcmBpszuUYkHn/K9Q7tQNyK6sZCWx
         AaPma1YNWqxvgZSwXlFIQlLkgCZW8clC4S15I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpC0CcOv1I31aI53uDJUrdUOcDYKqfjWneEUVPLLDH4=;
        b=BmyFPlRJC+nRShc/Q1Annz895hf13wnbxqUa55E2bvwvLQq4zQ3RrFdmw6hJgIuFKI
         scStVeAbqt01D5F48ioAiNGVBA+KWy5JyyMc8FaVYGx3BvazZeQA86CCRov7sKdc4TcY
         VBCITp0puYbGzSdNgSr02husp1c5SNOhWUhID+w7YLzMq9NzYPTjjvlHLw/MMkQu68iJ
         RXozOj5jc/N7kk103V5s4TYxK4Egcmn1jSG9vGD1VQfEaVKery07BABe7wFbZ+pKRpVu
         JQUT+FdbnOnBjAaxMx+3dixGq1vdoyGaAXMWJet5Wai6dMvoGy1xV6dqivJzvV0IErEN
         SMfA==
X-Gm-Message-State: AA+aEWY7Oa4lJzTCJlXjcIb6ELt4lkQFI7fMDg2dS2SKqzKacMPgIJ6W
        cFlfpCIPIYbV2nhNF8Lq5OIos3X14do=
X-Google-Smtp-Source: AFSGD/UEm+Dxip8HTmsnfwYnphQ4owqsbSr4bpNN4m41+IcCWJnkfFHMvuYBMGeANB2eKlJpMrBEzw==
X-Received: by 2002:a1f:c111:: with SMTP id r17mr1110620vkf.35.1542732749279;
        Tue, 20 Nov 2018 08:52:29 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id l123sm10774125vsd.26.2018.11.20.08.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:52:27 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id z3so1480859vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:52:26 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr1063013vsv.20.1542732746242;
 Tue, 20 Nov 2018 08:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-5-dianders@chromium.org>
 <20181120161055.GI3894@sirena.org.uk>
In-Reply-To: <20181120161055.GI3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:52:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UO1Dt3SeDs22EgH-95dWX+jq0sU7zzRgew11_DVw43cg@mail.gmail.com>
Message-ID: <CAD=FV=UO1Dt3SeDs22EgH-95dWX+jq0sU7zzRgew11_DVw43cg@mail.gmail.com>
Subject: Re: [PATCH 5/7] regulator: core: add enable_count for consumers to
 debug fs
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:10 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 04:26:52PM -0800, Douglas Anderson wrote:
> > Now that consumers all keep track of their own enable count, let's add
> > it into the regulator_summary.
>
> This patch series contains a bunch of random stuff that's not
> particularly related to each other or even dependent on each other -
> it's better to just send unrelated things in unrelated threads, it
> makes it clear what actual dependencies exist, makes the serieses that
> are sent easier to understand and stops things getting blocked on
> unrelated changes earlier in the series.

Sure.  You want me to repost things now or wait until you've had a
chance to look things over?

Certainly patch #1 is totally self-contained.
  regulator: core: Properly expose requested_microamps in sysfs

Patch #2 is self-contained but helps with confirming patches later in
the series:
  regulator: core: Don't assume always_on when is_enabled returns err

Patch #3: self-contained but helps with confirming patches later in the series:
  regulator: core: Don't double-disable supplies in regulator_disable_deferred()

Patches #4 and #5 are intimately tied.  As per discussion, I'll squash
together for v2.
  regulator: core: Only count load for enabled consumers
  regulator: core: add enable_count for consumers to debug fs

Patch #6: wasn't originally self-contained when I wrote it 2 days ago,
but after commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for
regulators locking") it is.
  regulator: core: Avoid propagating to supplies when possible

Patch #7: Now that I know you want to loop over use_count, depends on
patch #6 which changes how many times supplies are enabled.
   regulator: core: Remove loop disabling supplies in regulator_force_disable()


I don't want to send v2 of things while you're still reviewing.  If
you have a chance give me a ping when you're ready for me to send out
v2 of things.  ...otherwise I'll plan to send it out later today or
tomorrow morning.

-Doug
