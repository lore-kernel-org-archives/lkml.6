Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474482081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lML6ZFrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474482081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeK2KZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:25:46 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45631 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeK2KZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:25:46 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so297807edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPa1B6y27bHZKtcOSjLrx4EqxDXN1BhBpeXonQJoZNo=;
        b=lML6ZFrLt3mx0y4ptSux2CHu2KC1fbq/WOEOMdieMeym4eEf/T1k9RpvqWmOOSvLy3
         SQvpy0WN6zNBCwKDspbWzWGMge7NCEXaAx30zzECyVcwpn3LXboQl9Fdb3ppcmZXwcyP
         ELEY4KLyOiuMZTBIQkwPruKxrdxUaMyyzRo6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPa1B6y27bHZKtcOSjLrx4EqxDXN1BhBpeXonQJoZNo=;
        b=eIhxRzckmVaXa9+9UHo/Ayv90gQeOoXwyhodNW8G8zXHcpigeHY1BMBx4XkqXz0uqc
         ZLjjrLhYhDJxeyS+6BiyhaZ28sJSjNtSzM/ICAKreTurg9YF9jrXS9IikAomzmafy5mK
         Mo1AbxzNdnxS/9yQrxf9nl0SnLHJxsya5GFQE3FKc5vvAjng30unSe1ldItCPPiRZYs/
         uVjUHbexmLuoMmzfaHF7ofdoFKhuR/3zHYEFA2bEdhylG5626WMyPlfzUqSxqhISiTks
         r0UKX7tcnLKpHYL+yEgXPtkn5jILnr4P9EDS06Ppf2uc0IOBAIzlM9PSg3DUqqnyJJ83
         wsUg==
X-Gm-Message-State: AA+aEWaUVagWUWph82bwo9m5Hto5kELyBzhuvo/jSZQS2hoo8ZoQ9afv
        QOW7d1r4VK+nNh6eBK9NnZZ72Ynm4dQ=
X-Google-Smtp-Source: AFSGD/UDW+G7nxvTNC6EqeLaoewu9jPxBcD0PWBr8yY9pWtu29ExgLC8dloBCkPkeEO/bdLyR0/4Bg==
X-Received: by 2002:aa7:ca0d:: with SMTP id y13mr31371803eds.285.1543447347709;
        Wed, 28 Nov 2018 15:22:27 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id z2sm107609edd.4.2018.11.28.15.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 15:22:26 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id k198so355330wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:22:26 -0800 (PST)
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr142623wmj.105.1543447345788;
 Wed, 28 Nov 2018 15:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Wed, 28 Nov 2018 15:22:14 -0800
X-Gmail-Original-Message-ID: <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com>
Message-ID: <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com>
Subject: Re: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 at 22:34, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> [snip]
> Devices tested:
> - Microsoft Comfort Optical Mouse 3000
> - Microsoft Sculpt Ergonomic Mouse
> - Microsoft Surface mouse
> - Logitech MX Anywhere 2S
>
> The following devices were tested for the HID feature and didn't have it:
> - Logitech G500s, G303
> - Roccat Kone XTD
> - all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
>   workstation that I could find in the local office
> - Etekcity something something
> - Razer Imperator
> - Microsoft Classic IntelliMouse
> - Microsoft Surface Mobile Mouse

I just tested the patches with the Microsoft Comfort Optical Mouse
3000. I also tested with the Microsoft Surface Precision mouse [0],
and like the Surface Mobile mouse it didn't seem to report the HID
feature (at least, it was only reporting REL_WHEEL_HI_RES changes of
120 in evtest).

For the series:
Acked-by: Harry Cutts <hcutts@chromium.org>
Verified-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team

[0]: https://microsoft.com/en-us/p/surface-precision-mouse/8qc5p0d8ddjt
