Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495162082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9eIlTkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495162082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeLAJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:26:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37609 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:26:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so5217586lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wC9ZKEvzEze3qYC4AB5mfujvI54Rr1+VViVcCt3YLBo=;
        b=d9eIlTkHByKse018F6Mp5XH5oa6NzgUttLJ2OgdgogauSOGhUfQL8quvEaKMTPo3p/
         jDcTAXmanJYSMtBgLglq6VLnm0SxB0xUB8y9+wP/Kn4Lt876+3G85kgs14DSTBTCbicQ
         POr9kZ+mcQnz+lZzenUb3LwwaY9VbZrtKCaF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wC9ZKEvzEze3qYC4AB5mfujvI54Rr1+VViVcCt3YLBo=;
        b=LcTTuFLuoRu6U/i0nmGgu4t46TWunjM+wEu+h+dhCjBdh6MYabhGTx9X5KGHVrrUXF
         e7XMNCpOAUXPE7HOPMb9wfS+b7zC8gtkteLLTKemJrdAx9MEXTwNtTQ2sEt9mjH6dqd0
         vlzlC5m+Q5foIryiCCRhw+oqKgFIa/aQAGxj0Nd1OO+KZB8zADoXE6jjQiGfHBijAava
         zOvpX5nQuqUEwERdT2lzmUWwoKMdTLTqdz+WLRbVjeC7LTYcnvDm6UJDTL2jTphebyj/
         CmJkKluUwLBx5OEkfZ++Hdsuf+WK/to3q5nhQi209hRgEUxMymnL6NvMgvluCk19ubO2
         DrOw==
X-Gm-Message-State: AA+aEWY7SJifeLKiAJgRc8e1Y7OGEFojC4nqojDU3ZMtSf7tEO2t4IWE
        IQBr6ijDRrmvLadxJJme1tShe8YM30zTdwrvmF2qfw==
X-Google-Smtp-Source: AFSGD/XDPTE8YHWFsFnCe7l0xR1/LSGDTbhs5JQjKnhlelZCBR0Cp217HWhsrZsi7oLvTe1/vqQSr3vQreZ2aOMhVl0=
X-Received: by 2002:a19:c801:: with SMTP id y1mr4473095lff.53.1543616151391;
 Fri, 30 Nov 2018 14:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-2-ckeepax@opensource.cirrus.com> <20181123142544.GI2089@sirena.org.uk>
In-Reply-To: <20181123142544.GI2089@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Nov 2018 23:15:39 +0100
Message-ID: <CACRpkdaoFVFKAEiXkMX2-E2qaaZmoTLWwXfei-Mf0LdGSReBxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] regulator: Only free GPIOs if the core requested them
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:

> However even with patch 3 I think it'd be better to base this off the
> rest of Linus' series for converting to descriptors (which is currently
> sitting waiting for some more testing) since that will convert
> everything to descriptors and so remove the code that's doing requests
> in the core entirely.

I have made the "real" (or so I think) solution to this problem which
essentially hardens the core so that it very explicitly takes over the
descriptor from the driver.

I'm just having it spin a bit around the 0day build servers (they
don't seem to respond right now). I built all patched drivers
I could easily configure in locally.

I am planning to respin the rest of the cleanups making the core only
handle descriptors on top of it.

Yours,
Linus Walleij
