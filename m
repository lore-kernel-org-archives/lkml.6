Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7922C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC1F223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eIWlKhBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC1F223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeHJRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:36:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeHJRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:36:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so4664970pfh.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=RzBJh2pCesdUeThBNw6Tgs3r6tBnzuw7rOd88a3tkVs=;
        b=eIWlKhBmzgpWrTPuxeJ7JKmpLZmIUC4lGzns/FkNCpCaq1HSC49Nkm+Q9G8w3XYyi9
         jbI+LHwz9LrKKqlgOSZ2G/XXOkp7t89/S55edk+9HBt7n/W8MUC7tfA/yc1oMl7k1tHk
         ILkqzdlhZOL90r5Ha0cyGOLV0bv0cSKIujTGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=RzBJh2pCesdUeThBNw6Tgs3r6tBnzuw7rOd88a3tkVs=;
        b=o4tzqtjsqsmmvVMj5A6A1diE4kbvztoW3fetuiYKTzNsuh9amLNmo2RZu+3I+aSmeq
         Wm/v2esUEwOfmuIdIpXE9Ccen1/nxOA3wznA75l87TKJyNKPzAYOyOxcR4tkRuciL8qh
         n8I8WcnjQqB5hs3oOvzHm4iLyiRwwWv40UDy4074pmFuTGgh11l6J69RUHeT+FJ2bl6X
         QJRxF1wh+e8Q8htIMeGWxLkJapeZxCEm4gQDzSkOLrNYQiMFjPxvWNeGZkE1Dd07Dpnj
         gRrzH8sdMkPf3YMj/fIJML3SBnqY8muvwxneomzZiyhmQ7miZdkD9ivCNn34kOzbNo71
         fZLA==
X-Gm-Message-State: AOUpUlE1/v1ZSUlm+DxrOKOwTNEV6UFtqlaaLG25x5YuNSLFDbRLRp+m
        vVf+Ip6KWUHcsSeW/6dpWTu0gg==
X-Google-Smtp-Source: AA+uWPz5I7z5Mwhgwb0rLTmGAFPc7uo3M0/gpTUvUV0M0iKUNKC7vuBUExMVh/QPL60gxaZBRtuXAQ==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr6729153pgh.175.1533913592167;
        Fri, 10 Aug 2018 08:06:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id l71-v6sm17976327pgd.70.2018.08.10.08.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 08:06:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marc Zyngier <marc.zyngier@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <86wosypsvr.wl-marc.zyngier@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801194538.GA6422@codeaurora.org> <86wot9wb9u.wl-marc.zyngier@arm.com>
 <20180802065104.GA27850@codeaurora.org> <86sh3xw7m9.wl-marc.zyngier@arm.com>
 <20180802125827.GB27850@codeaurora.org>
 <153370830708.220756.4595316550560511917@swboyd.mtv.corp.google.com>
 <20180808072632.21f076b6@why.wild-wind.fr.eu.org>
 <153383585322.220756.9422019201626837843@swboyd.mtv.corp.google.com>
 <86wosypsvr.wl-marc.zyngier@arm.com>
Message-ID: <153391359077.37448.3410612264580038499@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Date:   Fri, 10 Aug 2018 08:06:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc Zyngier (2018-08-10 00:45:12)
> On Thu, 09 Aug 2018 18:30:53 +0100,
> Stephen Boyd <swboyd@chromium.org> wrote:
> > =

> > Quoting Marc Zyngier (2018-08-07 23:26:32)
> > > =

> > > Level interrupts should be taken care of without doing anything, by t=
he
> > > very nature of being a level signal.
> > =

> > Right. I suspect we'll still need to configure the PDC to actually wake
> > up on the level triggered signal though so PDC needs to be told to
> > unmask the line.
> =

> Surely this can be done at suspend time with the PDC driver tracking
> the interrupts that are configured as a wake-up source (although it
> needs to track an interrupt that is logically connected to the TLMM,
> which sucks).

The PDC also needs to be configured for wakeups from deep CPU idle
states where the GIC and TLMM are powered down. Lina, can you confirm
this?

Hooking system suspend in that case won't work. Is your hope that we can
avoid using hierarchical irqdomains here entirely?

