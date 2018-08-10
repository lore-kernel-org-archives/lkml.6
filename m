Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E921219C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTDYrOMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E921219C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHKB4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:56:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34018 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKB4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:56:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so5055308pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=LAyp1To/rzRpokUCCV8Q9E/81SIcUTUb9xypbQ3b0MU=;
        b=bTDYrOMj3arptqSnqosqKFyEmQ/2xgdm2cN2goPo7W7Zl4g3QJpZ+fJ8Q1csUbtpYM
         gtoj/UZpTrul7dXh0iUJbG2yk17YPe1Uwu4LhGzifMFzOFUZxkG8JicMtk7bTOLCymA7
         bGSk8IWNjroe9OfVLT6o/DRaZboRWUGSxMyrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=LAyp1To/rzRpokUCCV8Q9E/81SIcUTUb9xypbQ3b0MU=;
        b=M+Xptg26N374gRsMo6+r7Xn590XRN3ZyfjrNPviEccDajSUBKL7Gk/sbnkugKcI/Nu
         kIJ8kjjAgTU8u7vpU0By9skcmieP0CXDtWVvwYmj/XdJlWLcTCFL6jlt/cl40asDSDK2
         3/H9Xrkp+UVVHJ7sakaa3IYrzGkcA5YSg/i0Im5rsQThkFhS8DpwPvDz3r+TgAcg3qSM
         efD4VaVhIXiIoGQpuoOKYyC2xma3LZpmRCes3BdJG7uhVz8Jes5jusiG1txCsrPPKR6y
         LYJAQl9IKcHV61mubsaT8kU0yX2DmipqsuLBNTXjSdhaJJ4nKz9XnJRqq1MrOIVOFg1x
         zA7g==
X-Gm-Message-State: AOUpUlGPuxNgZrn7mPCm/nTqbmRbR252hmUXh0Zurv2YJpVwV26d8KGy
        qztgaFb0c1dPP8diJPPcMQRaEw==
X-Google-Smtp-Source: AA+uWPyZ0FqqQzmONZH3zdnR1drHPC91mjQOxn3s1etDoJf4RF2+4SY89ODVzcD+FeaPxxqOt/Wp4g==
X-Received: by 2002:a63:5e45:: with SMTP id s66-v6mr8262152pgb.151.1533943487019;
        Fri, 10 Aug 2018 16:24:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v89-v6sm26288329pfj.22.2018.08.10.16.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 16:24:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <153386966793.37448.12640092735399834661@swboyd.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-8-swboyd@chromium.org>
 <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
 <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com>
 <CAODwPW84FYK3k5=n4gQ4EPJExhQ59LCEi31ZYi2Bq2y9FH_E_A@mail.gmail.com>
 <CAODwPW8+QSittJdNLWpWKU=JNJa5bssMHQ4ER4CfnUAWaL1JGA@mail.gmail.com>
 <153386966793.37448.12640092735399834661@swboyd.mtv.corp.google.com>
Message-ID: <153394348544.37448.7231279350981818561@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for exclusive
 access
Date:   Fri, 10 Aug 2018 16:24:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-08-09 19:54:27)
> What's with the top posting? ;-)
> =

> Quoting Julius Werner (2018-08-09 16:44:43)
> > Actually, looking at what IO_STRICT_DEVMEM really does, would it
> > really prevent userspace accesses to these areas? Because it seems
> > that it only prevents accesses to areas marked as IORESOURCE_BUSY, and
> > while I can't fully follow how the kernel assigns that, comments
> > suggest that this is only set when "Driver has marked this resource
> > busy".
> =

> Requesting the memory region as is done in this patch marks it as busy.
> =

> > =

> > So after you make the change to the other patch where we immediately
> > unmap the coreboot table again at the end of the probe() function,
> > shouldn't it become available to userspace again even with
> > IO_STRICT_DEVMEM set?
> =

> Yes, if we unmap the region immediately after devices are populated then
> this whole point is moot with the assumption that this code isn't
> running at the same time as the cbmem utility. I've done this already
> and it is working on arm. I still need to build/boot/test on an x86
> platform which I should be able to do tomorrow.
> =


I tried my latest version of the patches (unplubished so far) and those
work on x86 with cbmem. So things look good and we don't need to keep
the mapping around.

