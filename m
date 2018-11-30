Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF7C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CDD20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 01:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xzKkLNSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CDD20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeK3MJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeK3MJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 07:09:35 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6809A2146F;
        Fri, 30 Nov 2018 01:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543539727;
        bh=KK5k0pzTObpUzakdBmfER3QGnjqssQrfk33KN4O3inQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xzKkLNSmukAla+88rHZKmE9E9a5zQjmrR8tYLKMW5kZ/7MED1cPChm2mVFe2vSJKP
         KSBR5L9uZQAYSa+7myQwmEsG4pxKpRNRdNkbVBIJ/QzH04S+nvus99Ghmptzs8zuVf
         10UVArGMwCbWI7Rh83mOt2jFJpbEh34pZBw+DYrU=
Received: by mail-qt1-f171.google.com with SMTP id t13so4255188qtn.3;
        Thu, 29 Nov 2018 17:02:07 -0800 (PST)
X-Gm-Message-State: AA+aEWZXiRAcEy2xbBPMxbwXnlD4gKmjxkByQBH1g5z8wclnAVAwhEic
        lKm9aEO5hpqaYwMa+XGtFhDJrUvMMR5m/AF11g==
X-Google-Smtp-Source: AFSGD/W4VOgcKPF/a6OCA+UTYMqM4yLrPXG5MeJ/ZLol2DMMUoCzh2YzzYeIybG+ZCUNMgCpofrw+HdO5X8RLw6T/+8=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr3723310qvb.218.1543539726606;
 Thu, 29 Nov 2018 17:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20181106183609.207702-1-sboyd@kernel.org> <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com> <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
In-Reply-To: <154353772392.88331.16937191244549721858@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Nov 2018 19:01:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Message-ID: <CAL_JsqJuZAr7ndznrUu0cuM7DpB5A7ixjJ+vZ97s5G4xz0sVow@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/device: Add a way to probe drivers by match data
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 6:28 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Stephen Boyd (2018-11-07 10:37:31)
> > appropriate structure with to_platform_device() or to_i2c_client()?
> >
> > So the example would become
> >
> >   struct of_driver_probe_func {
> >         int (*probe)(struct device *dev);
> >   };
> >
> >   struct of_driver_probe_func mtk_probes[] = {
> >         mtk_probe1,
> >         mtk_probe2,
> >         mtk_probe3,
> >   };
> >
> >   struct platform_driver mtk_driver = {
> >         .driver = {
> >                 .name = "mtk-foo";
> >                 .of_match_table = mtk_match_table,
> >                 .of_probes = &mtk_probes;
> >         },
> >   };
> >
> > And the probe functions might need to container_of() the device pointer
> > to get the struct they know they need. The probe function could also be
> > added to of_device_id and then we would have to look and see if that
> > pointer is populated when the device is matched in generic device code.
> >
>
> I guess I'll go down the path of extending the of_device_id structure?

Unfortunately, I don't think you can change of_device_id as it's part
of the kernel ABI.

Rob
