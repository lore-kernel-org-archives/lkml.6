Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE270C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53D20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbd+kBQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B53D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbeGKPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:01:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32811 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732901AbeGKPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:01:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id t21-v6so19626717lji.0;
        Wed, 11 Jul 2018 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t7AMsOxvDeSre+Tex1LGD/XMykGtGcPi9xH6DhXWpxQ=;
        b=jbd+kBQw1rI4M6urUsjkUObPcpKbbfLlp+gAbKn83ZjNCAGmROWCna3s2sBFPqrl+H
         duAlCh9pWxCyH++vLW0ktAu3sA+ql7aTVP2sIRUiCQBcIy8X6spFTHz+hmC9ZBlsj444
         JGwfwIcoVldZKBFTN9qtEUZbSHPfC46loILl+wZcqDzRyhs/iBQL36mJXUxisEruTHua
         N0W92vJJBPdoMFhpJL35CjYsoLPC7Inepx1rFwArkzAra6fo0KkOXrqfrwGulrhEZyoS
         zDqyIskDN52IMpMSWRO9hKuLwud4RL//YtUiQwynS5+Kgx6aNT5QWk93PFNkTbukWu9x
         hjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t7AMsOxvDeSre+Tex1LGD/XMykGtGcPi9xH6DhXWpxQ=;
        b=Veeka1BkPpbFIdw4pBVZFwY76Qb/ZWmy59i7I4H9+zu6Hr87iYjpYK4eEDjrjFnfXy
         3eaKMM2ECACPo/yYSZhdXiXW58V3BclQLHnU3KX+ZApSdRhcairi4bJkuuckfaeCImGo
         KQKuc/n06IsiitvOA7ho0LXqcUOItWY7qgXTqoXFtztTNOAML/evRHpFKp3L5nWm2jBD
         QUFDp3/qFXtmhipPQTbf80gwNtO6Y98SUwOGmfBNCkujG8jbiPtRRUkKflIASuxtRCfu
         kSNzUActoDMJAYfcLa6XDEdA+rLEF9PM1A7/9IjfB8RcY7pRtnA7f+haYzJOmPftLqHI
         d/gg==
X-Gm-Message-State: APt69E2YIidGe1/NIZCTr0GcMmPLq99woJR6TBAf32tCVdCDW4nheutg
        rnEin6LU1jdAlAE9fpc9f70L3zTO6GYH45xRKdM=
X-Google-Smtp-Source: AAOMgpfR//jhMnleVw3oASAi3YaOd90JvSKdaIbc+J5HkvxGCBI1LQPrWqcP/k2GhJ2UDkYYWKIgP6aS2b4feBGUgnw=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr18111510ljr.38.1531321002834;
 Wed, 11 Jul 2018 07:56:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:56:41
 -0700 (PDT)
In-Reply-To: <20180711164529.3388d045@bbrezillon>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-5-boris.brezillon@bootlin.com> <CAK8P3a1gyvvpKdVV+STOJXd-=BFdiFF638F0agXur0kLYP7ksw@mail.gmail.com>
 <20180711164529.3388d045@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:56:41 +0200
X-Google-Sender-Auth: elpcySNQZniJv1Ex4LLbpKsyMOo
Message-ID: <CAK8P3a2VWLnyforyjroywEwmttEq3eaPov8dGWKVw+GQs-MzcQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/10] dt-bindings: i3c: Document core bindings
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:45 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Wed, 11 Jul 2018 16:10:10 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Fri, Jun 22, 2018 at 12:49 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > A new I3C subsystem has been added and a generic description has been
>> > created to represent the I3C bus and the devices connected on it.
>> >
>>
>> > +I2C devices
>> > +===========
>> > +
>> > +Each I2C device connected to the bus should be described in a subnode. All
>> > +properties described in Documentation/devicetree/bindings/i2c/i2c.txt are
>> > +valid here, but several new properties have been added.
>> > +
>> > +New constraint on existing properties:
>> > +--------------------------------------
>> ...
>> > +  + third cell: should be 0
>>
>> What for? Just to be future-proof, or do you have something specific
>> in mind here?
>
> Even if I2C devices only need 1 cell, I3C devices need 3 (1 for the
> static address and 2 for the PID). Since both type of devices are
> described under the same bus node, and we can have different
> #address-cells, I had to put 0-padding in the last cell.

Ok, got it.

    Arnd
