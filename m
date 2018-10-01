Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3B2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3B2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeJAPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:10:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37634 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:10:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id 63-v6so2087852ljs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRnTjTIEIRIRtE1EbcFwClNmtgk9EoMR0HnoFed8QUI=;
        b=iCIRhvHhMG/MOsjiCVL7fyx0Exk0Ohr6aH3tgyKHsWykl6kF8N+aMmQcJuCd+Fw9WH
         vZ092vUx6hA6RACAQqCNT8m9HlLYggcu4iunE+o8BxZ/+cxYQ17mZ0ELYwc6tfpY7GOT
         pI+4ywpwef8qYoZSvEasftpjfyBpOHfpZNUdekLOkAWW1bCUYI+0vVkwm2lsAK1jfvFi
         /Ush0oswZJOa3/J72HjPRl+yAgCFRx10yb72UgS3ypkHVjqzP2M6nu7mplMqIjo94JWr
         L1LACM/+9aMkPhMkmNZZFvKo6J5E5kEmoSeG1Jn11Ma5UW1oUgnLlErKBiJzmBtTOJrc
         NTcg==
X-Gm-Message-State: ABuFfoiHiMUQQXyUrVRj7/xTJ0Q+ZVTYrJRiKDAGxL5ORHq8VHA84riR
        pfAZdjXrd+Enbs1FumAFFYYJ7aMLDWwkQunqfh5eGg==
X-Google-Smtp-Source: ACcGV60FIf0O0K/DKz+VrBxesx7K2S5DR6nk/lTtj+epfz9LWkeVldbBdnjOOBGMAIyjD42tVsWrbWO/DHaxxC0FWtE=
X-Received: by 2002:a2e:98c2:: with SMTP id s2-v6mr3345871ljj.19.1538382849622;
 Mon, 01 Oct 2018 01:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <5bafa31a.1c69fb81.ff018.dc43@mx.google.com>
In-Reply-To: <5bafa31a.1c69fb81.ff018.dc43@mx.google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 1 Oct 2018 10:33:57 +0200
Message-ID: <CAO-hwJKWbdB5FyDTofn2U4f9Eqvhe4t3YXap1oQrMZXmym2Qjw@mail.gmail.com>
Subject: Re: [PATCH] drivers: hid: Remove dead storage
To:     tapaswenipathak@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 6:06 PM Tapasweni Pathak
<tapaswenipathak@gmail.com> wrote:
>
> Remove storing of return value of ntrig_version_string function
> to ret as it is a dead storage and not used afterwards.
>
> Found using Facebook's Infer. Build tested it.
>
> Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
> ---
> There is another option to instead check for non zero return
> value for ntrig_version_string() as a successful completion
> of the function. ntrig_version_string() returns the length
> of output printed by sprintf() after converting the raw firmware
> code into a 5 comma separated numbers.

If you really want to fix this, I would prefer the alternative above.

Just one nitpick: please make sure ntrig_version_string() returns
either 0 (success) or a negative error.
Then in ntrig_report_version(), if the returned value is non null,
output a hid_warn() instead of leaking a non allocated buffer.

Cheers,
Benjamin

>
>  drivers/hid/hid-ntrig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 43b1c72..22aebf4 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -159,7 +159,7 @@ static void ntrig_report_version(struct hid_device *hdev)
>                               USB_CTRL_SET_TIMEOUT);
>
>         if (ret == 8) {
> -               ret = ntrig_version_string(&data[2], buf);
> +               ntrig_version_string(&data[2], buf);
>
>                 hid_info(hdev, "Firmware version: %s (%02x%02x %02x%02x)\n",
>                          buf, data[2], data[3], data[4], data[5]);
> --
> 2.7.4
