Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98EB20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iDPBl8Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98EB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIEC1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:27:43 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34068 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeIEC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:27:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id y134-v6so1882599ywg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=U4fJw3KY25GzMWmJjtGTs5BT5E95exnjBJVpoj4koZw=;
        b=iDPBl8Bw67yHJ8YIyXEJ0g7FLgvWpgAJH+E+nVbkRKA5Y5pUaNcB+GUA0poGjGbkfy
         9w4FZMlTtoic96iR3IpI7vwTnFh8Rw2kP0TFLzqzlVV8Pk+ZyxqI+5tzg0fHBE6oOq2k
         vvPNLpcS93Rcahjn60ML8yItzrVwMX09JV+WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=U4fJw3KY25GzMWmJjtGTs5BT5E95exnjBJVpoj4koZw=;
        b=SLd6WWfq66L3atqRtNicYuc4Zs+OPQtZhGvy6AL8HC/1VBc23dB3URRsVV4FkGNxmw
         JS08YxpKECbbXxPO4CHfm51JEKZuXs7ptJxKs3yP8o5/XGdlmGC/8ovMAaiqa5cKijgh
         EkZkQdCxjsTZscdPl4NAy/18O2lcNN0NB3a9ylZsYN0MT6R4hwiFPuXvWbpeiJ3xuOLR
         w8ByEUiFiDMpJlJKH8vIv5uypyz4nQwTeDi3hKuEfi+z1mgK4k4eNQ5/aX42Som45kJs
         /3IFHlHOX6X4Nuh22q5L+JFNqIMRmqEpLJWqP/JxChBu5wIJiWBDzXsfP4HEXFmLaIZ4
         rRoQ==
X-Gm-Message-State: APzg51CPcJhWbIdDoyD9EwehNUOXPmJxOucW8f4DJhJlLqYSk1mJhMM2
        SyhVMN0rV4Q49Ss0++MnnC3uzw==
X-Google-Smtp-Source: ANB0VdZmFTt0wzbg015NiRlE4KWdS5xyLATVRDp7mLNSx4/t9n1aEXl0C6SVPBvTg3b+YJflU7NPww==
X-Received: by 2002:a0d:f0c4:: with SMTP id z187-v6mr19048397ywe.68.1536098438224;
        Tue, 04 Sep 2018 15:00:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id e126-v6sm9681267ywf.72.2018.09.04.15.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 15:00:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180904210934.GA23990@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <153509896098.28926.3622217918056498792@swboyd.mtv.corp.google.com>
 <20180824171432.GM5081@codeaurora.org>
 <153540005334.129321.18196967002233663397@swboyd.mtv.corp.google.com>
 <20180904210934.GA23990@codeaurora.org>
Message-ID: <153609843656.119890.7258329648640765778@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Date:   Tue, 04 Sep 2018 15:00:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-09-04 14:09:34)
> On Mon, Aug 27 2018 at 14:01 -0600, Stephen Boyd wrote:
> >
> >Can't we just configure a different chained IRQ handler with
> >irq_set_chained_handler_and_data() for each of the GPIO IRQs that are
> >handled by PDC to be the interrupts provide by the PDC irq controller
> >that match the GPIOs? And then set their parent irq with
> >irq_set_parent() for completeness? And also move those GPIOs from the
> >existing msm_gpio irqchip to a different PDC gpio irqchip that does
> >nothing besides push irqchip calls up to the PDC irqchip? Then we don't
> >even have to think about resending anything and we can rely on PDC to do
> >all the interrupt sensing all the time but still provide the irqs from
> >the GPIO controller.
> >
> Seems like the irqchips need to be in hierarchy for this to work, which
> is not the case with TLMM and the PDC, currently.
> =


Why? Does something mandate that the chained irq is also the
hierarchical parent irqchip?

