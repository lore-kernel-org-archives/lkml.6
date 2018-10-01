Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35969C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042AC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042AC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeJANhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:37:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33093 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeJANhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:37:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id z21-v6so1995089ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+dU8ZCnGv46rrkFmsknFoLKJ88xN7pyss/unD2nJz0=;
        b=TZny9qUNy/+qjW/DThbu1Uhp/szcU/MmeZEb8QXp6ZzpS+47ZYlkfDOuowCLa0+zsT
         eCrjUtsqo8sKvGL95wQNPr9xrzXHYNP21vshBSsIugA/V7VPAskYdmysB7+BmVpgbg6e
         OxWGPLA9WYdgk87bfxLL/TCHFHMrfE28WzSYWREB9O4Ylwv81dkeWV6alzfCNz/Etikv
         hz9vXyD1nm7CuIvPwuYdBQSgPV84oMjWDbnDLMDWsqj4rEJQ2+KPrSW4Pbjp86p0kUsu
         EZMRuuznx956PyfIQ4d1ydRjkV1Th1UEHsAo0Je4evOBLXYlRUYn8AaA7i8uSEcmgGVU
         RBEQ==
X-Gm-Message-State: ABuFfohx5YeuoiB2/qWR+GoS2D/a1fHoA06kaBiTtfNM9cYuyDi+IN6u
        lj+gskHTlCrWhXjW12QTA95arnMdc9muSg7nfSJeGg==
X-Google-Smtp-Source: ACcGV634g0rqavsEKkRvxWKvwYkEqFCfH1KUUM5gQLZCZyA5BE6bvmiMucAL+JY8oQnTWBO8/y+V3gpR3U8HszB718k=
X-Received: by 2002:a2e:9d50:: with SMTP id y16-v6mr622062ljj.136.1538377264241;
 Mon, 01 Oct 2018 00:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
In-Reply-To: <20181001035313.21453-1-kai.heng.feng@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 1 Oct 2018 09:00:52 +0200
Message-ID: <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the device
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 5:53 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
> although it works in display manager.
>
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
>
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.

I think you want something similar to
https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=807588ac92018bde88a1958f546438e840eb0158

>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index f3076659361a..ff5682cc1bce 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>
>         if (ret)
>                 dev_err(&client->dev, "failed to change power setting.\n");
> +       else
> +               msleep(20);

We shouldn't have this error in the first place, so adding a timeout
will just add a band-aid on top of an other issue.

I really think the solution from Anisse would work in your case and
will be nicer.

Cheers,
Benjamin

>
>  set_pwr_exit:
>         return ret;
> --
> 2.17.1
>
