Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1128C2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lqpG/Qy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1128C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJaBqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:46:30 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33011 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeJaBq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:46:29 -0400
Received: by mail-vk1-f195.google.com with SMTP id l186so3186276vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7WyZk2MiYDpQjBokCNGWJhjCkFFLbpltiYvwpeT22o=;
        b=lqpG/Qy0UGgJecDPwqwuK+39YpDXT/Y9h1Ge2aXbkRirC7oquyVAaR8JDUyaoEi40S
         M3cpSqN5XwnC+G13yg/R4eu8NU9b43mQdFs74Tp/T7pBt4atRMpplxINJadSGXHkhv20
         tazARDfFv61sV7szvLWKMxUrYj6izebhkIxcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7WyZk2MiYDpQjBokCNGWJhjCkFFLbpltiYvwpeT22o=;
        b=LQ14VmE7EB93SzNBJxfO/PAq1X/9A7uT5r2aoMjvjqFxIC9PK3/O6sx5c+zdv/fMVE
         zlDojzUHfLX4man6oC0CtoTVe0fGn8GviggieYH0qMXLTSaCm9LJdjtbNhxjY8UbKeBs
         svBJmpwrUUixpPTh5dMwzzhHn7MKQ+JrVMq+BTajnkL3PyybFHaVO2PNU6SoHpceHROO
         bVCppnQMZmoCAIwx79b6QFBPjXAQSlvtrQ0dy0GPCu5U8wo7g5SQIACy8fSr7GubebBm
         tSBXswxrM5xmamSNdT7l3EnPOrbP3HoT+iDqFebZOZdwYs0W0Om5fKxQuzknahvuJ9Z4
         EhTA==
X-Gm-Message-State: AGRZ1gKgr1WBjVM1XmaRrbzX0tjikGnWNSbf03HukNvq8qCfxM4pk14j
        U3fD4kPEDFhA942fjaUbpHPncaVcVNo=
X-Google-Smtp-Source: AJdET5dS6MDnWXydIoIeepG0OBb7ueUdg4AWvA4MoJQKazZwUL0P6lx7I9tBJBViAxye9hlYESnQew==
X-Received: by 2002:a1f:3103:: with SMTP id x3mr4204327vkx.80.1540918334314;
        Tue, 30 Oct 2018 09:52:14 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id e64-v6sm4468445vka.15.2018.10.30.09.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:52:13 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id q15so8158937vso.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:52:12 -0700 (PDT)
X-Received: by 2002:a67:6642:: with SMTP id a63mr8241598vsc.42.1540918332122;
 Tue, 30 Oct 2018 09:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com> <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
In-Reply-To: <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Oct 2018 09:52:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViA_0Vpv+oUTHxUFfdoKftMN58wFxcbdYp2mF8SdULew@mail.gmail.com>
Message-ID: <CAD=FV=ViA_0Vpv+oUTHxUFfdoKftMN58wFxcbdYp2mF8SdULew@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending since I accidentally clicked back to HTML and lists all bounced.  :(

On Tue, Oct 30, 2018 at 9:24 AM Raju P L S S S N <rplsssn@codeaurora.org> wrote:
>
> On 10/24/2018 12:06 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
> > <rplsssn@codeaurora.org> wrote:
> >> +               idle-states {
> >> +                       entry-method = "psci";
> >> +
> >> +                       C0_CPU_SPC: c0_spc {
> >
> > nit: all these nodes should have dashes instead of spaces in the node
> > names (labels can still have spaces).  AKA:
> >
> > C0_CPU_SPC: c0-spc {
>
> Sure. I will change this. (However, from device tree specification v0.2,
> I see that Table 2.1 mentions underscore as valid character for node.
> Please correct me if I'm missing something)

You're right that I don't see it there.  I've always heard that they
are allowed but discouraged.  One place that mentions this:

https://elinux.org/Device_Tree_Linux

> Linux conventions
> * node names
>   * use dash "-" instead of underscore "_"

That same site points that the majority of people use dashes in node
names instead of underscores.

-Doug
