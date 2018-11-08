Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3808ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7706520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7706520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKICbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:31:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35143 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeKICbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:31:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so2663829qka.2;
        Thu, 08 Nov 2018 08:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/r2pkmkSdytf8ArSse1xG1oINIbNgF2IBwly2XdtLSM=;
        b=CKkq+Bnha5GPO/pHs2OKdTcHWMs9qLQaWCmDjhLDU68Ho+11QB1H+B3f0pMBog2R2C
         rLojGQxtuOAckTAlEKuBsCKgUyoXGSQ75e6TMblZUSQN9X1Y322RTDvYe8gtIYVHE+/6
         9a4qYaIXZ7OHCQhdMYNfbJWVtFxj6DQTL2txtVaJIyTIy2pWEC3dNGNt9m5B/nUFU5OH
         5u67HSP96gsZB/OR6QNUP17N9z72G7MLXPhkW+dooOpULD5TB+p7gfEniFQlBNpfyWkW
         fmGgkL/zW2fSH+QvpksIcn/c52g4inajo+J0hQxOmDjgPVrz81ebVCVxMNKQVV7We/0M
         dwGw==
X-Gm-Message-State: AGRZ1gL15lE5pZfW/hHgtf9+5drA5q3pfDlGlazgPmChvfy4nO5V6vx/
        nkyXjYRlJvmyxijoUazbEn7TpCU2r9u0s/8AjB8=
X-Google-Smtp-Source: AJdET5f0+LsipQZIjl1jQJwxMKKfg4heXFulrsmEoYn1bKbocwZOfSlModat2pgUr/beDw/cGDipi4q8OLEd5TsPGP8=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr5322062qvj.161.1541696083229;
 Thu, 08 Nov 2018 08:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
 <CAGngYiXEsg-6MXK60s8gOq2d8LGq+USTk1FC3GYqy2TQheaxHg@mail.gmail.com>
In-Reply-To: <CAGngYiXEsg-6MXK60s8gOq2d8LGq+USTk1FC3GYqy2TQheaxHg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 17:54:10 +0100
Message-ID: <CAK8P3a1q-09=5z4KZPWdpT-T=Tg244HpyN1Cd5=0pDGkQV7aPA@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:47 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I see this is called from the interrupt handler at the moment, which
> > means you cannot call sleeping functions, but it also means that
> > the timeout may never happen because the timer tick IRQ cannot
> > get through. That means you may have to change the irq handler
> > logic, e.g. to try this a few times but then defer to a bottom half
> > if it fails for a long time.
>
> Touche ! Yes, this is very likely a big problem.
>
> What if I converted the interrupt handler into a threaded interrupt handler?
> That would allow the timer tick to get through, correct?

Yes, with a threaded IRQ handler, the tick comes through, and you can
use a sleeping function to back off between the retries.

        Arnd
