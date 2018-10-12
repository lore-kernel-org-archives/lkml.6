Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D4C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C06206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C06206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeJMCl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:41:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36000 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJMCl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:41:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so12281649ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J28Hb242yDZErkKbMM8fY2/1sN1P9oMETglvfG+UgJ8=;
        b=YvMLUVak4z5HuVdUmU9SPchIcNNuFBQnxPUr28y0S1uAuXuWYObdAZ9OypEqOhvikH
         0/SuluNXihLKFXKQjj4P9ZoL/OVvf2WOLoIZ8fBT7GfV68MDIS1su8MkEI0PFAZLo6PC
         bP1EbKYZUCste/kzRDcvRIKxE+ynvdWtkXPSuPG8fubu8+Pk5AjEDPbmmPPw04TV6y4Q
         bRn236zen0WUfhyXphhs6nmd66eIb2/IRRWjUWhbM7crCnRfQJ2j0zYCP6TQ7h6cK4se
         IiBAmKSZ7YpAZx2KDetlQylOPGLiev3a1vE78gxLzGfBiOi3o1R0xACaajQqXLuWQnTj
         K2TA==
X-Gm-Message-State: ABuFfoiWfT75NdnZBRK/YNxkbsaCGrrhVkqA96DK0+yBZO0EZJ3nZ/et
        Wbww8609pnojDtntaDs5UhvsOz5of/Mf9EcWy5oa2w==
X-Google-Smtp-Source: ACcGV61BjssJnGDfZuqZRs/3A3niySR5cqMt1C2Gpb6lQgmeR/5u/EhqF2YaI65kmO1IwVundY/z3jfvPen9ClaUeY0=
X-Received: by 2002:a2e:574f:: with SMTP id r15-v6mr5222762ljd.106.1539371252721;
 Fri, 12 Oct 2018 12:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com> <20181012185342.GA35430@dtor-ws>
In-Reply-To: <20181012185342.GA35430@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 12 Oct 2018 21:07:21 +0200
Message-ID: <CAO-hwJKenvHpOQc6vjxDq0YZesLJVu1MXPuZ-iTSLKxJEbZeAQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from Lenovo
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 8:53 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Oct 12, 2018 at 04:24:08PM +0200, Benjamin Tissoires wrote:
> > Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
> > In the model I had (a pre-prod t480s I guess), the touchpad was behaving
> > fine.
> > However, it occurs that later production models don't expose the clickpad
> > information from I2C. The Windows driver gets all the information from PS/2
> > so we should do the same.
> >
> > The situation is even worse for the P52. Once of the query parameter function
> > fails, which means the touchpad doesn't even probe. This effectively kills
> > the touchpad, which is less than ideal.
> >
> > Dmitry, I am not sure if we should take those for stable in v4.18+.
> > I'd like to, but given the series is 5 patches, I don't know if this
> > will be acceptable.
> > We could revert in stable df077237cf55928f5 but that would mean
> > distributions will have to revert the revert if they want to provide
> > the I2C behavior.
> >
> > So, regarding stable: your call :)
>
> Heh ;) I think we have to fix it at least in 4.19 stable train. How
> about we merge it normally into 4.20, and let it cook there for a while.
> If there is no issues, then we can send it to 4.19 stable manually. How
> does this sound?
>

Sounds like a plan :)

Cheers,
Benjamin
