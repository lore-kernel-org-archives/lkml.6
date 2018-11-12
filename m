Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122E22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvjEgUZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0122E22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbeKMHS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:18:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37219 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbeKMHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:18:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so8929011lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YfcUWhbiXopGK/9rSaCgm4MLbRANrtwlieTA5iQh0Xw=;
        b=jvjEgUZyj/OHJWH8wSW8u1Ldy+J6zHQhz9WSkXAp3sL/7eCPsDtes79B5Qtjj4etSL
         RueMXLSfXgaBNnIta6XpSAxz7dIdSkLh3txFj4+1yNPQRwuNTvbEff8h/HLi1RIuXLU+
         JoTl5WeTAi//eFGu7OmnB3pvyXZkwAOWK9Ogs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfcUWhbiXopGK/9rSaCgm4MLbRANrtwlieTA5iQh0Xw=;
        b=K6YL9Ln0C9/tJV63o5Emj3YqQHbMtQVZ2fzTzcsxRW0Fj76m6D8BS06ieWQnKgVPig
         0EusjcDn6jjBRJtGeOK84FIsyMzPSNBchXaM6DUV3FkAlZKwk0P2Cmf0c2W23zpAgUAc
         5aZ1AVCuKsZGMUbeo28LJhKAKn1tVC7FQJDyxP8k7f4opz2bDbNlojJgIgamAj7cVLBt
         RVyef8kBbjDrAbhjBHV2tqS0GWeIgXLIfu0cBkflW8vdq6PBdOh2MkupkFcdmHAtOysA
         j528D8TwBX3+1Udu55+Yh+F9Z+skgiadis8pnFTFwGN6NH7DIKT77ziISdWBKEuHDZ3h
         H2wQ==
X-Gm-Message-State: AGRZ1gI31eL7JhoRhnnVTWZdwRsuCvwhLdxoKMdw7DP6KelMyEA8/nSH
        XADCC14ppYh7/dbN8kPne9i4Qv0QQ6zg/Hotx55I/w==
X-Google-Smtp-Source: AJdET5foLCKsgAroLYarFVv0OXhzCkXEiVn2AaQVmwFBdiBgyymHS7RcnR6JHlnrOLqBUf8pCZho/BkQyAdaAiSymPw=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr1668249ljc.97.1542057806069;
 Mon, 12 Nov 2018 13:23:26 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com> <20181111120234.GA28794@amd>
In-Reply-To: <20181111120234.GA28794@amd>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 12 Nov 2018 22:23:13 +0100
Message-ID: <CACRpkdYJNWC3RZXjCu+3EfRbPy6OyLLw-FivpFoe1p3ckHTCmg@mail.gmail.com>
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        oleg@kaa.org.ua, Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 1:03 PM Pavel Machek <pavel@ucw.cz> wrote:

> > -"devicename:colour:function"
> > +"colour:function"
>
> I don't think we want to do it in all cases.
>
> So, on my cellphone seeing lp5523:green:led is indeed not useful.
>
> But on notebook with usb keyboard attached, you need to keep the
> devicename to be able to distinguish capslock on internal keyboard and
> capslock on first USB keyboard and capslock on second USB keyboard.

I agree with Pavel.

I ran into this when connecting two identical keyboards to the
same machine. The driver worked fine up until it tries
to create two sysfs entries with the same name for capslock.
BOOM!

In this case I suggest "serialnumber:color:capslock" and
similar.

The important point is the string must be unique for each
plugged device.

Yours,
Linus Walleij
