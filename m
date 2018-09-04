Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF934C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965A220659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965A220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIDQU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41781 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeIDQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id t39-v6so3542225qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAKJ+HpP/eytFNDkbTVLLQs8tADh9rwJ3yqwm+0vaeg=;
        b=GEr7/jOtvbGgMUMr11wBpOukR9HJACdlQ8HUO+MKbvW2NRA2nBgjoENpwrlqoa38FI
         0PKetvjQi0D41FrJ797iCEHp0iKArcAXnMnCwOmDiCk8To/rMaou0+uMPVRjyPUJcQ9w
         cdrbfsVbI1/Ol0rDW1n/cnIsDw9f6kGpK4n4++SEMEpVty2L2cZBRSLs1aoMnAXniSSm
         ofTwkB9IJ43lbpwZapvCqpxYpX/zQRv03bdXOdnWQk9gRfsQuCgPrRGYGfwWQjbEt0jr
         WOpPkh2uMdxKCVeeBRsuRh0TeqULHb+dArjPXPoA9+vIN9U6LI+03fngaEiG2bGrv0kZ
         2D9w==
X-Gm-Message-State: APzg51Cbbu6BkMjxiF2PZNyO437HiZzkb9J7g+2h9UdPHhFrOuoZiwM3
        EAceJVFBw+lhnPKJy6jrIN6WRwhzwAOllfBtRV++Xg==
X-Google-Smtp-Source: ANB0Vdb4ZaSO9u/xbU4Nh042taVASYtHy81/uC5fsqS6AKGff4zOO0QkPN7QzMgPalbdjdR5w8XYHoZGHYjKxjmWYe8=
X-Received: by 2002:a0c:d067:: with SMTP id d36-v6mr15108868qvh.216.1536062165078;
 Tue, 04 Sep 2018 04:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180831093604.5915-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 4 Sep 2018 13:55:53 +0200
Message-ID: <CAO-hwJKxAt95WTrNT6-SfejEpxZvv5aAgoF25SjTxuTmti=ZUQ@mail.gmail.com>
Subject: Re: [PATCH] Partially revert "HID: generic: create one input report
 per application type"
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:36 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> This partially reverts commit f07b3c1da92db108662f99417a212fc1eddc44d1.
>
> It looks like some mice are not correctly treated by
> HID_QUIRK_INPUT_PER_APP. Those mice have the following
> report descriptor:
>
> 0x05, 0x01,                    // Usage Page (Generic Desktop)        0
> 0x09, 0x02,                    // Usage (Mouse)                       2
> 0xa1, 0x01,                    // Collection (Application)            4
> 0x85, 0x01,                    //  Report ID (1)                      6
> 0x09, 0x01,                    //  Usage (Pointer)                    8
> 0xa1, 0x00,                    //  Collection (Physical)              10
> 0x95, 0x05,                    //   Report Count (5)                  12
> 0x75, 0x01,                    //   Report Size (1)                   14
> 0x05, 0x09,                    //   Usage Page (Button)               16
> 0x19, 0x01,                    //   Usage Minimum (1)                 18
> 0x29, 0x05,                    //   Usage Maximum (5)                 20
> 0x15, 0x00,                    //   Logical Minimum (0)               22
> 0x25, 0x01,                    //   Logical Maximum (1)               24
> 0x81, 0x02,                    //   Input (Data,Var,Abs)              26
> ...
> 0xc0,                          //  End Collection                     57
> 0x85, 0x02,                    //  Report ID (2)                      58
> 0x09, 0x01,                    //  Usage (Consumer Control)           60
> 0xa1, 0x00,                    //  Collection (Physical)              62
> 0x75, 0x0c,                    //   Report Size (12)                  64
> 0x95, 0x02,                    //   Report Count (2)                  66
> 0x05, 0x01,                    //   Usage Page (Generic Desktop)      68
> 0x09, 0x30,                    //   Usage (X)                         70
> 0x09, 0x31,                    //   Usage (Y)                         72
> 0x16, 0x01, 0xf8,              //   Logical Minimum (-2047)           74
> 0x26, 0xff, 0x07,              //   Logical Maximum (2047)            77
> 0x81, 0x06,                    //   Input (Data,Var,Rel)              80
> 0xc0,                          //  End Collection                     82
> 0xc0,                          // End Collection                      83
> ...
>
> Both the cursor position and the buttons are located in the
> same application collection (Mouse) and the kernel should
> only create one input device for those.
>
> However, for an undetermined reason, the kernel splits the
> device in 2, making systemd not tagging the second mouse
> with the coordinates only as a mouse. And then userspace
> ignores it which leads to a mouse where only the buttons
> are working.
>
> Until the quirk gets properly fixed, we should probably
> revert applying it to all of the generic devices and
> re-enable it when the root reason has been found.

Jiri,

I actually just got the proper fix today. I think it would be better
to directly take the fix instead of the revert and a revert of the
revert later.

I just need to make sure the tests are correctly handled and I should
be able to submit the patch today.

Cheers,
Benjamin

>
> link: https://bugzilla.kernel.org/show_bug.cgi?id=200847
> link: https://bugzilla.kernel.org/show_bug.cgi?id=200849
> link: https://bugs.archlinux.org/task/59699
> link: https://github.com/NixOS/nixpkgs/issues/45165
>
> Cc: stable@vger.kernel.org # v4.18+
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/hid-generic.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index 3b6eccbc2519..c25b4718de44 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -56,20 +56,6 @@ static bool hid_generic_match(struct hid_device *hdev,
>         return true;
>  }
>
> -static int hid_generic_probe(struct hid_device *hdev,
> -                            const struct hid_device_id *id)
> -{
> -       int ret;
> -
> -       hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
> -
> -       ret = hid_parse(hdev);
> -       if (ret)
> -               return ret;
> -
> -       return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> -}
> -
>  static const struct hid_device_id hid_table[] = {
>         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, HID_ANY_ID, HID_ANY_ID) },
>         { }
> @@ -80,7 +66,6 @@ static struct hid_driver hid_generic = {
>         .name = "hid-generic",
>         .id_table = hid_table,
>         .match = hid_generic_match,
> -       .probe = hid_generic_probe,
>  };
>  module_hid_driver(hid_generic);
>
> --
> 2.14.3
>
