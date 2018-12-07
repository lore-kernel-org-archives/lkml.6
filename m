Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E57C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D9E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D9E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLGNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:02:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42326 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLGNCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:02:10 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so4298328qtq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 05:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsZ6hqUSuRSY987fr167h6ZtzwlnsDcKrJQytNzCEaY=;
        b=CnYDJSK2sQqfkLsIHKQnuFF3BtNDFNw0zcG4youWeOdiboESTKRV1bJtli5vnPIN+t
         wNTqXCtTn1abYfJZ0tYwe0PVvKTqxxFw4MKgwQFk10W3+joxLF/pyi1yTH1PjfSto2Xn
         g7QMgUiBStFb90Dq9ZLKrtZN4J71eoOw306AJcxucZVhAU15H0Y7Y/8YqlAs++UXpDlq
         cA+bQQeUabF/tHo/IgvmLghIPxY6ppfUOUA+iurqqvVs55aNMUSPMeX/uuVez1WL7Yu6
         KUboH0auWRajoWK3hJxlUufrLGklvPy8AJM530mruUuq3/p3Pjd2YZeYm1SrG+wvOD+4
         pujw==
X-Gm-Message-State: AA+aEWbLOIf1mUIttAQ0NFTxPt9woGhlBBgPw74GzqSzbHfOpZ+u/yKK
        S3XGxU2MWkju8ok/+akDSpWtzQEb+vIKdZRJGtF8wA==
X-Google-Smtp-Source: AFSGD/Uw/XQwDdiLamdwkCZf87CRqAuaVaY4DiVrfMV632ryBGlSpISR7TY9JY1JaM+O/Y5Z7M0ZfsLZYltrhpAEA4w=
X-Received: by 2002:ac8:1a08:: with SMTP id v8mr1834875qtj.362.1544187728691;
 Fri, 07 Dec 2018 05:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20181203064621.69876-1-chiu@endlessm.com> <20181203064621.69876-2-chiu@endlessm.com>
In-Reply-To: <20181203064621.69876-2-chiu@endlessm.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 7 Dec 2018 14:01:56 +0100
Message-ID: <CAO-hwJKRsSDLSbjv44QRqqHCL4ynk6ncaJb+yE1DL-hrS-iJ4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: input: support Microsoft wireless radio control hotkey
To:     chiu@endlessm.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> The ASUS laptops start to support the airplane mode radio management
> to replace the original mechanism of airplane mode toggle hotkey.
> On the ASUS P5440FF, it presents as a HID device connecting via
> I2C, named i2c-AMPD0001. When pressing it, the Embedded Controller
> send hid report via I2C and switch the airplane mode indicator LED
> based on the status.
>
> However, it's not working because it fails to be identified as a
> hidinput device. It fails in hidinput_connect() due to the macro
> IS_INPUT_APPLICATION doesn't have HID_GD_WIRELESS_RADIO_CTLS as
> a legit application code.
>
> It's easy to add the HID I2C vendor and product id to the quirk
> list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> makes more sense to support it as a generic input application.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---

Thanks for the refresh of the series. It looks much better now.

I have scheduled this for 4.21. I am a bit hesitant in pushing changes
to 4.20 when they touch hid-input.c, especially when we are this late
in the process.

Cheers,
Benjamin

>  include/linux/hid.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ce5f996c8d3d..42079116fb61 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -840,7 +840,8 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
>  #define IS_INPUT_APPLICATION(a) \
>                 (((a >= HID_UP_GENDESK) && (a <= HID_GD_MULTIAXIS)) \
>                 || ((a >= HID_DG_PEN) && (a <= HID_DG_WHITEBOARD)) \
> -               || (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL))
> +               || (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL) \
> +               || (a == HID_GD_WIRELESS_RADIO_CTLS))
>
>  /* HID core API */
>
> --
> 2.19.1
>
