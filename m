Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37152C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA587214AB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA587214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHYLm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:42:28 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:29851 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHYLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:42:28 -0400
Received: from belgarion ([90.89.234.36])
        by mwinf5d41 with ME
        id TL4B1y0020nnJME03L4BRP; Sat, 25 Aug 2018 10:04:17 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 25 Aug 2018 10:04:17 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        lee.jones@linaro.org, kernel@collabora.com, heiko@sntech.de,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Fix brightness levels for non-DT case.
References: <20180824155402.2822-1-enric.balletbo@collabora.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 25 Aug 2018 10:04:10 +0200
In-Reply-To: <20180824155402.2822-1-enric.balletbo@collabora.com> (Enric
        Balletbo i. Serra's message of "Fri, 24 Aug 2018 17:54:02 +0200")
Message-ID: <87h8ji98jp.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> writes:

> Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> linearly to human eye")' allows the possibility to compute a default
> brightness table when there isn't the brightness-levels property in the
> DT. Unfortunately the changes made broke the pwm backlight for the
> non-DT boards.
>
> Usually, the non-DT boards don't pass the brightness levels via platform
> data, instead, they set the max_brightness in their platform data and the
> driver calculates the level without a table. The ofending patch assumed
> that when there is no brightness levels table we should create one, but this
> is clearly wrong for the non-DT case.
>
> After this patch the code handles the DT and the non-DT case taking in
> consideration also if max_brightness is set or not. The default table is
> only created when neither, brightness-levels and max_brightness, are
> set.
>
> The patch also fixes another issue found by Robert. Before this patch
> looks like a division by 0 was possible when state.period returned 0 by
> pwm_get_state(). This is because pwm_get_state() was called before
> pwm_apply_args() so state.period was not initialized. The patch moves
> the pwm_apply_args() call before any call to pwm_get_state().
>
> Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
