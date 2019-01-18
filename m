Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A128C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2602087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9IzUZWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfARNcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:32:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37688 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfARNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:32:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so11653969ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mO+zplovGLvdBHr95yPUprqS4aeUd/JsEOAqo8TwYI=;
        b=f9IzUZWhRORgCJI3gwI4BlHy4vzTMcOim9xsd9FuK1f84DdAfW/W++KigA6a0ZH8OC
         WFPgkVoOW4jt6dGC/JLfAbcCO2ofHd94XLr3Df/QXCGkJ37xz0h32RdWYgMmfcGvZ0UY
         YZBzIRD3Mh9yOh2Ba4C1rqeJO0SK4lHgEST74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mO+zplovGLvdBHr95yPUprqS4aeUd/JsEOAqo8TwYI=;
        b=BybUDNV0hfijtzLQYTSkxBneQ+wAXcAuOqcXgDYEp6JtrHa4ScdnPbKw+okOHDktX6
         5l7ZPkepOkSOTdimwKHbeA0iccjpbOepzy8/nJ2QQKSzxiLwMc2o4V1LaniBaqf0VxCO
         yRgd1TeefqWw/CyNZUi8EV4WXns6uvpDuWWXWlx/ljKB4cRZbHKDGfLW6UHDEAz13FTa
         U6fCJ576fKiWc8JVtptx5HMN4Phxcis8Zb+M0onzUB5eRtC3IJddDrvvjt2wf+D/yNKU
         pZaXlsWZsdo9bP3OY05IQDKLnqUa9ejz6oV4zTCAGffxV7Dax6oTJ+/BfG0TXitOZepB
         GtNg==
X-Gm-Message-State: AJcUukdueyvazY6ZknHQuBS0xINICg9ZwzwfyBic0GrL8tqbjHgH8hAZ
        Yduoywbky4MUOKN4CgXdf09AzPDH6yciaHqmJPMdmRdGAFm7/w==
X-Google-Smtp-Source: ALg8bN54Q85NkadKPdON+4Q1cEUSgw1zitcp+DGaMmi+UYpGrocgGxJwXgVXb0ws5erFjx5UURUWi+hxB7QecovJncU=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr12061693ljc.66.1547818325591;
 Fri, 18 Jan 2019 05:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20190110100922.20280-1-dietmar.eggemann@arm.com>
In-Reply-To: <20190110100922.20280-1-dietmar.eggemann@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Jan 2019 14:31:53 +0100
Message-ID: <CACRpkda2r3owKH7cCf-E=G2baeQ8JVRseEeLqeJwjziNDzMF5g@mail.gmail.com>
Subject: Re: [PATCH] arm: fix a migrating irq bug when hotplug cpu
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:09 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Arm TC2 fails cpu hotplug stress test.
>
> This issue was tracked down to a missing copy of the new affinity
> cpumask for the vexpress-spc interrupt into struct
> irq_common_data.affinity when the interrupt is migrated in
> migrate_one_irq().
>
> Fix it by replacing the arm specific hotplug cpu migration with the
> generic irq code.
>
> This is the counterpart implementation to commit 217d453d473c ("arm64:
> fix a migrating irq bug when hotplug cpu").
>
> Tested with cpu hotplug stress test on Arm TC2 (multi_v7_defconfig plus
> CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y).
> The vexpress-spc interrupt (irq=22) on this board is affine to CPU0.
> Its affinity cpumask now changes correctly e.g. from 0 to 1-4 when
> CPU0 is hotplugged out.
>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Looks solid to me(TM)

I would proceed to put it into Russell's patch tracker along with Marc's
ACK so Russell can process it, see:
http://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
