Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CD20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQighkSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeLSTEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:04:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbeLSTE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:04:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so9869657plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vh8T2inOJ25IQEKjOC6j5qkkV3kczuPBsJF+LxTgu5g=;
        b=DQighkSMTv7fp7wr3qvQwNKiCdAZVqzEjuaQ8xQqJrGbdymlDrAZk4YTZ+P95oCZQD
         UK8U267JsC5P/ktvJeroDZ9YJHx+DN8vCPgaEZ2PvkT4oks56ml/iVTantvGrxlgE0oo
         jQrHdhlmn9OSeXGBP50L1xqrlMixElCtXoLNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vh8T2inOJ25IQEKjOC6j5qkkV3kczuPBsJF+LxTgu5g=;
        b=HGlUZ6Fl/19mrc6fuWZS9vInUO7pmSBr2MSPkXXSz4kN7ZivK0GnLKcVB+FakRpoos
         4gfgmDUj/vLnmpFlRipmP4VsOa+oRhF2NptcH+/FbwdzP08v809yhYmeDjpKg4J4SUHt
         /y5HcQDhsqpzzgcoYOM3YM4gJvm750+vNxnR5tWrw0xVQJdI01WUtr/UKL61uQDsqi54
         Qe7/9FBKW0sdp1kqo9FkVNiGz6mzeNYC5FuhHGP7+xawXLZmbmahBefPUA7sMtRWmpxW
         EvOwc0VjroxFvmgVSbqeBPOlBWMly6LCxugKaBqP//6jivoA8adqnZTSabczMOmG4ftV
         4KeA==
X-Gm-Message-State: AA+aEWYNsF1LZXXV5dzC/dVQghWTRfq88jJf0jMhOoozzeNjUHMITsPa
        A5xfh2xGh89evz1coYeUy2YfSmmcYCc=
X-Google-Smtp-Source: AFSGD/VPCSGuC8pMs+PreP3xNbcMViX+ftSbPl/ahrb/XPI4ZrWQIUkOJ7w02/ZYlENSRvBJyLha9A==
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr21365375plo.130.1545246267108;
        Wed, 19 Dec 2018 11:04:27 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l3sm32197657pga.92.2018.12.19.11.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 11:04:26 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:04:25 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        msavaliy@codeaurora.org, ryandcase@chromium.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix wrap around of TX
 buffer
Message-ID: <20181219190425.GC109358@google.com>
References: <20181219181747.118278-1-mka@chromium.org>
 <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE=gft7BV=M4wpk304yhDV11ddNJSFGDYu8TRW3WOtDPLrRmnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:49:26AM -0800, Evan Green wrote:
> On Wed, Dec 19, 2018 at 10:17 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Before commit a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix
> > softlock") the size of TX transfers was limited to the TX FIFO size,
> > and wrap arounds of the UART circular buffer were split into two
> > transfers. With the commit wrap around are allowed within a transfer.
> > The TX FIFO of the geni serial port uses a word size of 4 bytes. In
> > case of a circular buffer wrap within a transfer the driver currently
> > may write an incomplete word to the FIFO, with some bytes containing
> > data from the circular buffer and others being zero. Since the
> > transfer isn't completed yet the zero bytes are sent as if they were
> > actual data.
> >
> > Handle wrap arounds of the TX buffer properly and ensure that words
> > written to the TX FIFO always contain valid data (unless the transfer
> > is completed).
> >
> > Fixes: a1fee899e5bed ("tty: serial: qcom_geni_serial: Fix softlock")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Oh nice, so this did end up being your problem with corrupt
> characters?

Yes

> Strange though, I still would have expected this bug to
> result in inserted serial characters, rather than edited ones.

You are right here, initially I interpreted that some bytes changed,
but actually we observed inserted bytes, and later missing ones at the
end of the transfer.

> Either way, this looks good to me.
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks!
