Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845AEC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93F20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIFRf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:35:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39151 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeIFRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:35:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so12057530qtk.6;
        Thu, 06 Sep 2018 06:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd6B9hBGPfUlsRQzvASpzMPsRipPR27aNpPGe9G44r8=;
        b=jQrJF5XJFlDmoZJFY+RMlkj7ioN9azsZTgp7TToPYp8B+el8oAVd+2mYn6Se9NH527
         zE0BRL36cvUDZ5AT1yVSqZvyrl/WsNLoipnbY/6dFSDW1gheyoJlg4rZtHqJnP4PBBpk
         Y9c91bAsUTMdgC0pe2WiMhWekLx9BYOtpH7rqdmj2T7XU/a6RqJwdlMZJsmKbGUM3iW/
         XrVKE0Umt6AZjijjYM8CRzGixVWXMSUBkNa4YgE4uPSSC4P5jeCdrIMIY98Hxpb5CUAY
         cYsGuJk5t3S119XgaabsmoMQnytvmUYTE9bkWV9MtnujRJZk6DGPlrkcfY8S0W9CIVp4
         ljmw==
X-Gm-Message-State: APzg51B7gKY3GzcIxPu5CxBVjBrOglKJkpFMOcDOrU5LS50SIYYrsCSw
        0ecag46fi4+Y0vUMLOp465P7/Eh0LXzK4SquJsA=
X-Google-Smtp-Source: ANB0VdaV/UxVhnkkk4omB/k59mW/8BLHGoqFEu4f0WRwZC5S1fIJeK/sRglGQdh6+IytbGSB0JOFTyHmmwfS+QaMqEk=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr1916187qtg.213.1536238802725;
 Thu, 06 Sep 2018 06:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com> <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon> <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon> <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon> <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com> <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com> <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
In-Reply-To: <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 14:59:46 +0200
Message-ID: <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Przemyslaw Gaj <pgaj@cadence.com>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:43 PM Przemyslaw Gaj <pgaj@cadence.com> wrote:
>
> Hi Boris, Vitor,
>
> This repository does not contain full kernel sources, but it should be enough to discuss mastership request feature.
> https://github.com/przemekgaj/i3c-linux/commit/d54fe68a9d3e573c0c454a2c6f1afafc20142ec5
>
> Please keep in mind that this is initial version, but mastership works correctly. I added one property to DT to reflect relationship between masters.
> It is possible to request mastership on demand (using sysfs. Useful in case when Linux machine is equipped only with secondary master controller) or automatically change operation mode when device driver wants to read/write something from/to device.
>
> I'm sure I will have to rework something because this was implemented on sources from PATCH v4. I saw that Boris released v7 yesterday :)


Can you explain the reason for having a user space interface and DT property?
I thought we had concluded earlier that we wouldn't need that, but it's possible
that I missed something in the discussion since then.

      Arnd
