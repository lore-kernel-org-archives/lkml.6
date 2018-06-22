Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B087C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98F9245C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScbGlXLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98F9245C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934411AbeFVQ2V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:28:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41276 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934164AbeFVQ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:28:19 -0400
Received: by mail-qk0-f195.google.com with SMTP id w23-v6so3971419qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5kmVNfIncQct/1v90nkVOICvnUXSbbDADzsgaEaP7QU=;
        b=ScbGlXLYsAAG76fgKkydjALCO9Po5J1tlHJ63M38vlJHmGBcjnA+oYhHAOFDs4nsGL
         tsoTUlCZseE4ppWHQLFffIop3yGb25BTQRYQCT60LIleAXCZTeDJbHlu6y8nzA1fG45H
         kbc4PPtPVGyz+VUDeaIx9AhJHzTVY0vK/7Bcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5kmVNfIncQct/1v90nkVOICvnUXSbbDADzsgaEaP7QU=;
        b=ipF/AMEFXujS39B9Bfwf2Bqvdb7pimZPeztDm8OoF4PTc7irFiOMD8zMhEebgBpXYw
         QZv0nut6q1qggB6P0oQwr+Smy8JNhYZiP9DA19mMr9lkPLFTErokr6TyBwgES+QkcrRy
         hQwRq4f+4xDZmpDT9cIOmxWuS3xOCPpdtlNStgv4gCQjA+qTNI0vqSNN2UVQ6onH7lxL
         p3kHoeRxZvaXddIrEgf+P222YpdYP9791mbojZxqXSLiD/xFWQ56v6C2KlaOoWevBd/Q
         u4PAT2EmvO5R6mPEblsJrFzAz3yVblk+vle1IYaO7J4C8WTJPdtX8nSb19UroiNSFAg4
         Qyvw==
X-Gm-Message-State: APt69E1NgWAqHu9UnzSUU/dgaL6tN4UQpGRBle487ohC9MaAraNxrbeP
        sd3KBkLtjZQdcSj7zvTRGO6Er5v4u2o=
X-Google-Smtp-Source: ADUXVKI0qdKNf3mScJlTDzvIhrzEwGE4MBF4KuoZ3nLkOdZlTRFYg7z0kh9MPyoH7mG1AnUMpRX9bA==
X-Received: by 2002:a37:4142:: with SMTP id o63-v6mr1929399qka.287.1529684899255;
        Fri, 22 Jun 2018 09:28:19 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id g18-v6sm6021128qtg.59.2018.06.22.09.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:28:18 -0700 (PDT)
Date:   Fri, 22 Jun 2018 12:28:17 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
cc:     Adam Borowski <kilobyte@angband.pl>, Dave Mielke <Dave@mielke.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
In-Reply-To: <20180622165927.68679862@alans-desktop>
Message-ID: <nycvar.YSQ.7.76.1806221222340.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180619130953.bxil552igfkckjmr@angband.pl> <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr> <20180621014317.ebslk3gwvpq3k6sq@angband.pl> <20180621022137.GB18453@beta.private.mielke.cc>
 <20180622015445.7r5u5nn6ofhd4k57@angband.pl> <20180622165927.68679862@alans-desktop>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Alan Cox wrote:

> > The other point is a quite pointless assumption that existing scrollback is
> > "optimized".  Even vgacon mostly uses software scrollback these days, as the
> > amount of VGA display memory is really small.
> 
> All of our console driver code is horribly unoptimized for most of
> todays hardware. Long ago I did look at what was needed but it's a
> seriously non-trivial change. In particular
> 
> - Console I/O occurs under enough locks to keep fort knox safe. That
>   means it's very very hard to accelerate
> 
> - The logic is plain wrong for a lot of modern video. We shouldn't be
>   scrolling, we should be rendering the current backing text buffer at
>   video refresh rate or similar and if the source of the updates outruns
>   us it doesn't matter - we don't have to draw all the glyphs as if we
>   were fast enough they would have been a blur anyway.

My executive summary from what you say is that there is no longer an 
advantage to maintain a central vga-style glyph buffer in the core 
console code, right?


Nicolas
