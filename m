Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F64322419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bfW1Lym/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F64322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeKMHVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:21:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44250 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeKMHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:21:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so8902540lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0yEikNCGazYDPqwgw7wR/BALKwwaoxGeMLD6r05xJgc=;
        b=bfW1Lym/wSdBcLJCJ1vcosz1HIrpoLJ4tIQ2xVktBxtAW0JhSMg2WCi+Rglm/Frmj/
         NAa5vfvJjqab5I+CtNqLA10mIlpAH0AcrUYt963m+q8ZKGzxunWN4RiWuERYKoXE1h7p
         o+h2v10veIXfc+IYKjXsNpE+q1hzEmWTE1zYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0yEikNCGazYDPqwgw7wR/BALKwwaoxGeMLD6r05xJgc=;
        b=H1Im+/PznWdJXumwAZ+maWVoj9jNq9hObDLZ75QRemRuLZ1gFBUq053N2HFmHySDUl
         dHJCWG1GPgpoC0ULqClXIbaUHEt8e/EthZZb4sRscbVGhONvMy5F8oGYHbZVRO7ctHpC
         L4/Ox8aCqI3gKilL0UOiqxJqGp28394QtZ0IZQ9MpPRohTG0R7USbb/+fwZyKWfgBaSS
         +tSHbE+AV50OO7357VqTMUuqK5B+cAgm4gTtHhmnz1QOirjOqlvJSGz8tf0Drv/xEPKH
         fvD/3rg8JwXUXr99yEVyiDEot4DVkj7QmUdm2bMu2OMlyKEZoYxsYt2+q2EG/xahKAH1
         27WA==
X-Gm-Message-State: AGRZ1gLGLoErkq4wp5/onUbsA47ru/qRzY9yGWs6mk5uPrAbfh+OeQ8Z
        Nb41C8IZXVVbgI92yaQGEga9JN9/vRM+ibaAN7LJgQ==
X-Google-Smtp-Source: AJdET5csoYlGylO2rkufCRrT2cTho3O9yYWCQQL64vDcN3I6oar6zk7Y4yUbafo7TW+ev0YMtCikFA6+1dwmu96o9Ek=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr1677894ljd.4.1542057959492;
 Mon, 12 Nov 2018 13:25:59 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com> <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
In-Reply-To: <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Nov 2018 22:25:47 +0100
Message-ID: <CACRpkdZwgZ=PmX3PEpR-F76BZ5g9hzvQYc_3QfFYhHvBHqp4Tw@mail.gmail.com>
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     dachaac@gmail.com
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        oleg@kaa.org.ua, Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 1:02 AM Vesa J=C3=A4=C3=A4skel=C3=A4inen <dachaac@g=
mail.com> wrote:

> Couldn't we have here multiple variants that would then be chosen based
> on device tree definition?

It needs to be subsystem specific or something.
What you say make sense for things based on device
tree.

The problem hit me on an Intel laptop with several
USB keyboards.

OK maybe I am stupid for plugging in two USB keyboards,
but we should definately support it. Input/HID supports it
well.

Yours,
Linus Walleij
