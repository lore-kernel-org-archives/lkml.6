Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A19C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12A12083E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="knuktajb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12A12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKOMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:12:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51951 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeKOMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:12:19 -0500
Received: by mail-it1-f195.google.com with SMTP id f84-v6so5882703ita.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE4/LR38JL0XHDSAaadS2KXyKURyuNsWg/bnBKhGqdk=;
        b=knuktajb4ImdZxQsT0K5u9rIXXMkT+wo02DPb9ysE7sM5LOrv12FET6QqqgmtyZiRf
         koKxMaJuB+8AV9pxwR1EZ9RmuVc6tbvtUJxVLoIjLjE0609cT3nM6LAxatXGZuCFDsow
         X4lhjEr7R8KBU3KopXawi355anz3/gSCB4FNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE4/LR38JL0XHDSAaadS2KXyKURyuNsWg/bnBKhGqdk=;
        b=pBiWgIuUSRUEVRoYo5S7B1uOgmGabFJh7I+Pzb4LRIsnH0sBSjLCMUdzKtr4GQaaKq
         jbpC93WdDkKv6rWnja2ZpbRz+t/nPh+ikFIJiVNcf3381drlqJI351Aqc/fGrlcaUIX8
         muIs7JQmT9LdaSG4dMWoudIy6uH6ikAXeuscCPuR7bsFy2uXZXLpViZERCl0SNp+2//P
         i2+ozpgGfm+mLkT7jzqHp05xPrKULRgOcUe1sucy0r1FmSLjP4dDves1LgwSzkYsnoxC
         UiDo79onMcVLFaJIOfV33eDsUdNsCU/FP2daDvyjNRdOxGj69/UKHibShU43oAoGMLbv
         CgwA==
X-Gm-Message-State: AGRZ1gL4Sw23+mv5j9ImZJK2JD9LIe14ccpydkUkzltN95ySDPQWiK2t
        DOFC/2sgievzcN5QoAkdNoLwEn7YDoY=
X-Google-Smtp-Source: AFSGD/VdzOMmH0x7SSc4guHiFzQI/jXSHzvBYUSR9dm8iOSnEHFFHb/R1llbTDRakNrORryDavtOnQ==
X-Received: by 2002:a24:9582:: with SMTP id m124-v6mr4006890itd.109.1542247589643;
        Wed, 14 Nov 2018 18:06:29 -0800 (PST)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id s22-v6sm8526343iog.67.2018.11.14.18.06.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 18:06:28 -0800 (PST)
Received: by mail-it1-f178.google.com with SMTP id o19so17963953itg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:06:28 -0800 (PST)
X-Received: by 2002:a24:9582:: with SMTP id m124-v6mr4006824itd.109.1542247587657;
 Wed, 14 Nov 2018 18:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20181110.085826.230851261@genki.is> <m24lcpjjss.fsf@linux-m68k.org>
 <20181110.201050.925673938@genki.is> <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com> <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
 <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
 <20181113190335.GA50985@google.com> <878t1w7hzi.fsf@igel.home>
In-Reply-To: <878t1w7hzi.fsf@igel.home>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 14 Nov 2018 18:06:16 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMuovgar22Z=sTcY=EV4KFtpwpjgdFOqvqAUYZEykzcWw@mail.gmail.com>
Message-ID: <CA+ASDXMuovgar22Z=sTcY=EV4KFtpwpjgdFOqvqAUYZEykzcWw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     schwab@linux-m68k.org
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>, sky@genki.is,
        yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 2:03 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Nov 13 2018, Brian Norris <briannorris@chromium.org> wrote:
>
> > +             } | grep -qv '^\(.. \)\?scripts/package'; then
>
> \? is a GNU extension, so if you want to stay portable you need to
> switch to ERE.

Ack. That's what I get for reading the GNU man pages... I'll send a v3.

Thanks,
Brian
