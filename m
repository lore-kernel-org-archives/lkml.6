Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C431C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03CE20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjVToKdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03CE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeK0FG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:06:57 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:44040 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeK0FG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:06:57 -0500
Received: by mail-vk1-f181.google.com with SMTP id h128so4386377vkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQcI5HpizNOOVv58xxmUn1eRor+QvfYnd/JrL94VI2w=;
        b=UjVToKddpmzJ02Ae8PJ+izaOo5z3eJfS5C5ZnHv0++Qqgw7Ng9mxUb89xcOI4fRtbu
         1sLNmZKOrVEQL6LZxaiEat0dGNoAIV6jXLVhpUkKY5fnH/xCt5QxuPsCG8Cr6bWtrub8
         yWvEy6gDQzWL0hxNdJ7ZUDsjcsOlh8CiUA81U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQcI5HpizNOOVv58xxmUn1eRor+QvfYnd/JrL94VI2w=;
        b=s2yceV9tuOgBM+C1uheXqwey1oe9n/wyX7WyhYzuo4zq0kIwrL/QIuxGs69IWj7mPm
         CNW0q6Lwv6NDrepEvA6B+m3sugVZlXuZK3DY37fBlbPPx+5/SJvAsF8xbW/e1peww8xg
         7lpBWlmLbCXCVWm1ouy+Pib7I0FJtQONp63FOqldJxy0PPJmYRFHcMl9iQV8z/9iRRZj
         cPHdGrMKl+DXcUeiq4sWTPugINOMnpJkrkqCwY9Q2MWA6aOguIzgddwvmYHYNg4LHBbY
         4P9DylQtR2gIhC5s5zikBCmI41qIKy+yYloknzv1HHMRAECO/WZUizMs7sCRqNSjmmLp
         02ug==
X-Gm-Message-State: AA+aEWat8MBAza2VrmbsCzIbqki743otrlJo0xdSXJu2HG7J20WjOLhU
        josXSM0QUGWZ1v5DOY1S2pvz6Yww6Cg=
X-Google-Smtp-Source: AFSGD/WyPSozXwBQ0h4QsaCxzuzNsN3yxFXWp4cmHPIaqhdVjSGdzdgHhbyUcKH+NGtJm6wIXWr3qQ==
X-Received: by 2002:a1f:aed6:: with SMTP id x205mr11575621vke.11.1543255922093;
        Mon, 26 Nov 2018 10:12:02 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id l13sm902898vka.16.2018.11.26.10.12.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:12:01 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h78so11963257vsi.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:12:00 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr10896933vsv.20.1543255920172;
 Mon, 26 Nov 2018 10:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20181125093750.GA28055@basecamp> <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
 <20181125232450.GA3774@basecamp> <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
 <20181126175945.GL9715@sirena.org.uk>
In-Reply-To: <20181126175945.GL9715@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Nov 2018 10:11:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X+X1NmF1jwu0KyBm5FEupx-oU7D5paGT=ZaP=+KazPkQ@mail.gmail.com>
Message-ID: <CAD=FV=X+X1NmF1jwu0KyBm5FEupx-oU7D5paGT=ZaP=+KazPkQ@mail.gmail.com>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
To:     Mark Brown <broonie@kernel.org>
Cc:     masneyb@onstation.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 9:59 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 26, 2018 at 09:43:42AM -0800, Doug Anderson wrote:
>
> > NOTE: another option would be to change the regulator driver to just
> > force this rail to a high power mode and never let it change.  That's
> > what we're doing on a SDM845-based board.  When the regulator is off
> > the mode doesn't matter and as per the above argument we always want
> > it in high power mode when it's on.
>
> You should never need to modify the driver for this, the regulator
> framework will only change things if it's been given permission to do
> so - simply don't specify a regulator-allowed-modes property and the
> mode will be left alone (we should probably still use -initial-mode if
> it's specified but I'd need to check if we actually do).

Ah, right, there's nothing actually in rpmh and it's all in the core.
So it's just removing 'regulator-allowed-modes' and adding a
'regulator-initial-mode' property.

...hrm, but it looks like this won't just magically apply to the older
RPM driver.  For one it looks like the conversion from load to mode
happens outside of Linux (on the AOP I guess?).  rpm_reg_set_load()
just takes the load you pass it and sends it on.  It looks like you
can still force the mode but it looks like it's using a custom
attribute for that (qcom,force-mode).  I wonder if that should be
changed to use 'regulator-initial-mode'...

-Doug
