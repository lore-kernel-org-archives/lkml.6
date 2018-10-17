Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956A32148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956A32148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbeJQO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:57:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43505 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJQO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:57:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id p34-v6so18929809lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyRTlU7dUazYBNZfdRoBS3BJUOLw+w6qfmZrPKhB8jU=;
        b=ILKYBFYra/uhDxsdtPwdKSqRad7WuQfWSJZzFdu9sjYOYXqo4ZmKH41L6vmAgjsN48
         O2MO1vAmT5MiUI6UzxGP5ipjssd81xw4lDnznlNxPMEhCnDbz/nxVoI0nLirXmF6mk/k
         LLEqU/01cFN634yOimAf16ZgyXrDLsqKE13rE2mkDm846LtGiYp144xEHJK9HI9CM+w5
         uuNoQ4OVz77qAmHeCMQRNuK7IvZy7WZtcAMe3f4dMxAhhh3n0EzQ1XhU2f1ic+dl1c2l
         ktrBEa7D5tm2V8QOkNW8Qp1ySDBqNUHk0lox9NRt0XWoo/aG0VtrQSmthOF1mHWztMUF
         Bj7w==
X-Gm-Message-State: ABuFfohWqBGFmmNK8Yv5At54mzSpkJNePIiNplO3ZSDsQ8RufvWrG0GX
        uwUbLW4EP8aD2wB7K2nY3g7U1Ad8XXK9p6+P8AU1xA==
X-Google-Smtp-Source: ACcGV60pEVldjnyGDPiE2Y/3oWu8d2nuOaD+VgBE7dkGihbVMtl2TmPRbZvzWXyzHKGtBMpv9hUNW1GKxJ6HxPkuh9I=
X-Received: by 2002:a19:cd81:: with SMTP id d123-v6mr9994859lfg.104.1539759803759;
 Wed, 17 Oct 2018 00:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20181017001443.GA232819@dtor-ws>
In-Reply-To: <20181017001443.GA232819@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 17 Oct 2018 09:03:12 +0200
Message-ID: <CAO-hwJL1QEASk37NuYwkHhmW9N4pGWULnizpHi+4=65OdXe4yQ@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics - avoid using uninitialized variable
 when probing
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:14 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> synaptics_detect() does not check whether sending commands to the
> device succeeds and instead relies on getting unique data from the
> device. Let's make sure we seed entire buffer with zeroes to make sure
> we not use garbage on stack that just happen to be 0x47.
>
> Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/mouse/synaptics.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d55e..5e85f3cca867 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -99,9 +99,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
>  int synaptics_detect(struct psmouse *psmouse, bool set_properties)
>  {
>         struct ps2dev *ps2dev = &psmouse->ps2dev;
> -       u8 param[4];
> -
> -       param[0] = 0;
> +       u8 param[4] = { 0 };
>
>         ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
>         ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> --
> 2.19.1.331.ge82ca0e54c-goog
>
>
> --
> Dmitry
