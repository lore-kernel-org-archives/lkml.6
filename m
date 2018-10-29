Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A3CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0FF20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HsmE2vZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0FF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeJ2LAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:00:05 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46917 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeJ2LAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:00:05 -0400
Received: by mail-yb1-f195.google.com with SMTP id f15-v6so2307755ybq.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 19:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VP0GWv2bw0aeD0+KwHs1rYGI9t0xv3YTgzKRdbb3SCw=;
        b=HsmE2vZenbdpJv2icObZ1Q+GBe7a+Kf/hNLhzLHl2ok9BGKhQWF9TK9LGZezdonFwh
         HSakt5bzpQkeShMDyiqAGGBNxtZ7oxxsx9CuqV8hiyrWv9xcAKdcGr6YMu2r05tlZ9UQ
         LzbXkR4HADz/dCiLqZ7Mu8P2T0ML92AGi9uNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VP0GWv2bw0aeD0+KwHs1rYGI9t0xv3YTgzKRdbb3SCw=;
        b=BdepsPU52+yboKKBVFZZTglsm6JmNfevVCxKxsdOlOgleA30lE1etSVFe+u3cv9l0X
         2pL9HEv+X/pkfwvoHaydXyzwXMqDqg5CtA2COkk/D6c7QgWy+dBFrou/Qcq8thREmcIh
         J0OP1Wedg/burCtsT42xdVc3VMKrkIgfjPdt6Yh7/b9IfP4qOxE3AnNsUCEkILhtpaVe
         06iAcg/6Q8lS+Z23EYV+4SZ8s5eGwFi7kleMhIdOXqagCFZXCxY5kVAD/eVcRGJo4hh5
         EU02VP3pqo/O9T/k7C1kTs1tcLhF66NmtWGuUrr6dSghPgkly8a3na/SnDrj09eeIPXX
         ZgAA==
X-Gm-Message-State: AGRZ1gJvXMg3f2BxNVQXTABvnxAfCHNQ4QEQ3mc//2Bu7Him/vtPVY+V
        saEau/XYlnEEwi/3p25szcCynyVkyJw=
X-Google-Smtp-Source: AJdET5dtA7EZChSP0wPAVqy5bSK5Vnv9Z9xDcfH55tYt87t0TQ2xLRa9ty/UZS3uRY8b7DY89xIgHw==
X-Received: by 2002:a25:1657:: with SMTP id 84-v6mr11802426ybw.420.1540779210776;
        Sun, 28 Oct 2018 19:13:30 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id p7-v6sm7880869ywd.75.2018.10.28.19.13.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 19:13:29 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id v77-v6so2753268ywc.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 19:13:29 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr12556313ywp.407.1540779208567;
 Sun, 28 Oct 2018 19:13:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Sun, 28 Oct 2018 19:13:26
 -0700 (PDT)
In-Reply-To: <20181012112259.56f3c44f@bbrezillon>
References: <20181010184533.691620-1-arnd@arndb.de> <20181012111603.0d03e043@bbrezillon>
 <CAK8P3a1zYoGtfe6PVEM-oLNxXQAt12iiNR1ZLiaGvrY5LFKwwA@mail.gmail.com> <20181012112259.56f3c44f@bbrezillon>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 28 Oct 2018 19:13:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLS5sEFgM1Vzri+cAONYKUqdXbahyNUU1xvRF0cbZrX1w@mail.gmail.com>
Message-ID: <CAGXu5jLS5sEFgM1Vzri+cAONYKUqdXbahyNUU1xvRF0cbZrX1w@mail.gmail.com>
Subject: Re: [PATCH] mtd: sa1100: avoid VLA in sa1100_setup_mtd
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 2:22 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Fri, 12 Oct 2018 11:19:52 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Fri, Oct 12, 2018 at 11:16 AM Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> >
>> > Hi Arnd,
>> >
>> > On Wed, 10 Oct 2018 20:44:50 +0200
>> > Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > > Enabling -Wvla found another variable-length array with randconfig
>> > > testing:
>> > >
>> > > drivers/mtd/maps/sa1100-flash.c: In function 'sa1100_setup_mtd':
>> > > drivers/mtd/maps/sa1100-flash.c:224:10: error: ISO C90 forbids variable length array 'cdev' [-Werror=vla]
>> > >
>> > > As far as I can tell, there is an upper bound on the number of resources
>> > > that can be passed, based on the number of CS lines on the bus.
>> > > In practice, all boards we support have either one or two resources,
>> > > but using six to be on the safe side has no extra cost.
>> >
>> > Why not dynamically allocate cdev instead? That removes any kind of
>> > guessing on the max value, and it shouldn't hurt much since this code is
>> > in the probe path.
>>
>> Fine with me as well, If you prefer that one, please just add
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>
> Oh, I thought I'd let you send a v2, but I can do it if you prefer.

Olof just pointed out to me that neither fix landed for this? What's
needed for this?

Thanks!

-- 
Kees Cook
