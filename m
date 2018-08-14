Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB9DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B0217BC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775B0217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeHNLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:20:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44821 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:20:53 -0400
Received: by mail-qk0-f193.google.com with SMTP id v17-v6so12820912qkb.11;
        Tue, 14 Aug 2018 01:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZUIzkYPG2ljFmU6mNBTyY4zyg8uB0bo9CyuX0+3OMw=;
        b=QxoMQJwCepiL/kSOrteAiNvKJXG6CBomnT3vKKohVwyyCM0gFnPATyettpaaZoKqPH
         Qrios9HgnfSwaY0FME4ixj5higPFGMOVP72SRafOKhFwrYf70FQWqPotSsW50YBUfHe+
         WtJjgl3h9vXkVBqjFVDRJkO4CTj4IjkXMx1YShQMrLUkcjl7pxCf3IImK3QGlqRW6xZa
         ci9XfSXrY5IkNqwjbBne4P3z8+wvcGC7pMLYxr5/bFezScMpI2AG9ZKjTOwN3L+KFzgJ
         hxdjJWkA3ihy6mxoOU6qHmlw7Gl10wIKrx+qKkpZqULSU+rTSgnk4sM/2yJDV7q03GxJ
         Joaw==
X-Gm-Message-State: AOUpUlFPrdYwQc8TO0Te7sOFxtShDO0w7k0gU3jomFJ2WntuoWior+vR
        12+/3NxMWGcTjpKOsLozxfp5CKfLA078HsJxqKE=
X-Google-Smtp-Source: AA+uWPw56AvfVA0kFj3SUeTHaKLhZUyJjgE/Ln1dVYH0j8Iyb2a4fJn95WwH/EtRUtcg0vLH+lrIe8FZP3yV8cC0V40=
X-Received: by 2002:a37:8786:: with SMTP id j128-v6mr18133049qkd.32.1534235683910;
 Tue, 14 Aug 2018 01:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180813212108.2442868-1-arnd@arndb.de> <20180814105237.64b01528@ajaysk-VirtualBox>
In-Reply-To: <20180814105237.64b01528@ajaysk-VirtualBox>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 10:34:27 +0200
Message-ID: <CAK8P3a3bk7urG9zO=F1NtH8hTnGQQ_Hk0qq=o8fmeYY_nEyy5w@mail.gmail.com>
Subject: Re: [PATCH] staging: wilc1000: revert "fix TODO to compile spi and
 sdio components in single module"
To:     ajay.kathat@microchip.com
Cc:     aditya.shankar@microchip.com, ganesh.krishna@microchip.com,
        gregkh <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 7:22 AM Ajay Singh <ajay.kathat@microchip.com> wrote:
>
> Hi Arnd,
>
> On Mon, 13 Aug 2018 23:20:33 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > The TODO item named "make spi and sdio components coexist in one
> > build" was apparently addressed a long time ago, but never removed
> > from the TODO file. However, the new patch that tries to address it
> > actually makes it worse again by duplicating the common parts of the
> > driver into two separate modules rather than sharing them. This also
> > introduces a build regression when one of the two is built-in while
> > the other is a loadable module:
>
> Thanks for sharing your inputs and submitting patch.
> I have also submitted a patch to address the compilation error[1].
> We can ignore my patch and proceed with your changes.
>
> [1].https://patchwork.kernel.org/patch/10563873/

That patch seems useful regardless, as it removes dead code,
but I'd still prefer to revert the 9abc44ba4e2f ("staging: wilc1000:
fix TODO to compile spi and sdio components in single module")
commit for the other reasons I explained.

> In my understanding, even when the common part is compiled separately,
> the wilc1000-sdio/wilc1000-spi module still expects separate instance of
> common part for each of them because of use of static variables.
>
> Shouldn't it be correct to compile the components required for SDIO and
> SPI separately and then get rid of use of global variables to support
> running of SDIO/SPI module at same time?

What your patch does is to change the behavior so that for loadable
modules, you get two copies of each global variable and function,
but for built-in drivers, you still only get one. The old behavior was
arguably better here because at least it was consistent and always
shared the common part.

> > In order to have multiple instances working (sdio, spi, or mixed),
> > all such variables need to be dynamically allocated per instance and
> > stored in 'struct wilc' or one of the structures referenced by it.
> >
>
> Actually, I have been locally working on this patch for a while now
> and I will submit a patch to avoid use of most of global and static
> variable soon.

Ok, very nice!

      Arnd
