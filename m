Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18371C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD67F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD67F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeK3W1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:27:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33987 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeK3W1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:27:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id r14so5481361qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ll1kc8Xwn4G3wy4Bd1OO1vOg6O1R70XztYLb+6T9vGc=;
        b=L+I6Gv8jyUx2KEr0GnEdRVF/gCYsf/2xTobvuHTnbwYvjOpQaNrno1aTRbCEPjOShD
         g1ybXjW9bniUCZ5WghZiEE59xnSId3mGGT8Yc+p6Ytsf9gpEwUI7CF5o+Mq8LEBmrnXT
         fMtihYybAMuSXYVQogMi50DIcEGPiW9J+n4tknyHhqFm7YuiTdhPd5PzDFNb4k4sJtR7
         FbhZSnvaMP95efY+MgJstMQZcahW3986eCpss937fUQoRcx03cnPEsHgHKw5mehmsbxm
         t2+YUAhiv6Bg3+aRVUT15h169b1WRMKgn2GPkw2PguP/SqV/w8NOsmRkhmk0l9+xJMhQ
         hRiQ==
X-Gm-Message-State: AA+aEWZJWbUUe1gbL9TlXKDGzSWIrlrIR5/ojQJlKo4qU4N7UTrG1+M2
        t8C7RmAkSYMmVfVKncNjnpqbAtX+lYEsm94zjBSu2A==
X-Google-Smtp-Source: AFSGD/UiGbeFePAmeWW+QNugp85Amxw88sEdMShj8Zpc5sbliEUhPAs74pTRY66NF81OONA5G/bRbfGFQ6PQn7EN33w=
X-Received: by 2002:a0c:81b5:: with SMTP id 50mr5124708qvd.166.1543576695740;
 Fri, 30 Nov 2018 03:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20181130064617.67920-1-chiu@endlessm.com>
In-Reply-To: <20181130064617.67920-1-chiu@endlessm.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 30 Nov 2018 12:18:03 +0100
Message-ID: <CAO-hwJKAnHqPi7aOGqKET+_JKnXmvdwOyhtH4nLeqS+-K8597Q@mail.gmail.com>
Subject: Re: [PATCH] HID: input: support Microsoft wireless radio control hotkey
To:     chiu@endlessm.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> The ASUS laptops start to support the airplane mode radio management
> to replace the original machanism of airplane mode toggle hotkey.
> On the ASUS P5440FF, it presents as a HID device connecting via
> I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
> send hid report up via I2C and switch the airplane mode indicator
> LED based on the status.
>
> However, it's not working because it fails to be identified as a
> hidinput device. It fails in hidinput_connect() due to the macro
> IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
> as a legit application code.
>
> It's easy to add the HID I2C vendor and product id to the quirk
> list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> can be more generic to support such kind of application on PC.

Sounds good, but while you are at it, can you please:
- fix the kbuild warning
- rewrite the whole line to use macros,
- make the macro prettier by inserting new lines were required
- and define the missing macro:
  0x000d0006 -> HID_DG_WHITEBOARD

Maybe we should keep the ranges definitions with raw values and put a
comment on the side with the names.

Cheers,
Benjamin

>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  include/linux/hid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d44a78362942..f4805f605fed 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -836,7 +836,7 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
>
>  /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
>  /* We ignore a few input applications that are not widely used */
> -#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
> +#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || || (a == 0x0001000c) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
>
>  /* HID core API */
>
> --
> 2.11.0
>
