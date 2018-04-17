Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDQRs2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:48:28 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:44491 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeDQRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:48:24 -0400
X-Google-Smtp-Source: AIpwx49ltlHiNrO8qCpYawq+19G3uF+f2QX1Pe+/rQ6Rwx+r7LNM6FaPQrmtwBdRBHsjB7lh2fcfxKKdQzwWQqWYw/g=
MIME-Version: 1.0
X-Originating-IP: [90.77.100.34]
In-Reply-To: <20180417172229.GK8973@sirena.org.uk>
References: <20180417171204.259146-1-dianders@chromium.org> <20180417172229.GK8973@sirena.org.uk>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 17 Apr 2018 19:48:22 +0200
Message-ID: <CABxcv=n6HFXB+sAW_8qwMJWwWXDgspFgNs9Kk37hMO53EimWCg@mail.gmail.com>
Subject: Re: [PATCH] regulator: Fix return type of of_map_mode()
To: Mark Brown <broonie@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
        David Collins <collinsd@codeaurora.org>, evgreen@chromium.org,
        swboyd@chromium.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 7:22 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Apr 17, 2018 at 10:12:04AM -0700, Douglas Anderson wrote:
>> In of_get_regulation_constraints() it can clearly be seen that the
>> return value of of_map_mode() is assigned to a signed integer.  This
>> is important because the first thing the regulator core does with this
>> value is to compare it to -EINVAL.
>>

Sorry about that, as Mark mentioned both the regulator device specific
and standard modes are a bitmap, and that's why I used an unsigned int
as return type.

IIRC, at some point in the review someone mentioned error handling and
I just blindly added a check for -EINVAL assuming the drivers would
return that, but forgot about the return type :(

>> Let's fix the return type of all of the current of_map_mode()
>> functions.  While we're at it, we'll remove one pointless "inline".
>
> Ah, I see...  the thing here is that the mode is always an unsigned int
> since it's a bitmask - this goes out beying the use in of_map_mode() and
> into all the other APIs.  We only actually use 4 bits currently so I
> think there's no problem switching to int but it seems we should
> probably do that consistently throughout the API so that things don't
> get missed later on.

Maybe another option could be to add a REGULATOR_MODE_INVALID with
value 0x0, and fix the drivers that are returning -EINVAL to return
that instead?

In of_get_regulation_constraints() we could check for that and
propagate -EINVAL.

Best regards,
Javier
