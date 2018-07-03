Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6240EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD2C24D3B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD2C24D3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeGCIN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:13:58 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37817 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753835AbeGCINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:13:55 -0400
Received: by mail-qk0-f170.google.com with SMTP id t79-v6so519031qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VUxrYlkhLwclZtZG0gVRoTyNf6AUAukIXhqzK4jm45E=;
        b=rZFJm2rTIE4zT/HHEsw/bEBRZES/1R50dNa/0HGJ5GEBWlCjPWeZYlpD0MUJyylCFk
         AneyYlKzS7pNWXXrARepMDC/bo8gjupNSJbBCF14tXOkqqyD/GlZS52DNucJTRSg8Rx7
         TLPYzOzmMLr0GW6cIADZ92DwXkKwKsVbus8UBa7Ug5C1mirysRG3g8zrrSjAMafmDvcy
         7E0VHERXUNaezNceeRLBv3QyqI7elPOkDRXRKVaoNDQ8GkugYRExNYXKllCEfmGTz0qR
         co130jlb7ZuVmaRNcPWujFl0hvtOv+JZf+DQwDS5kRKbFDxcA9xdv2so8dcbzONpkqT2
         IAxw==
X-Gm-Message-State: APt69E1SFIhmG2EmAsGZKTa6v3tRKr+TwqZQWiyr78s+9sLLzMKJFctR
        tBgdkpg/ddTBTGuqrD9G3DOOdmR3VluExmBP214N0Q==
X-Google-Smtp-Source: AAOMgpeQ2Su5AiEVWutqdvvCfpkopPzkaWBgDxulyG38SdH5aLi0WzBPemAdEt7QZnqz/rTIJOHXafgdCS5/3F5co4A=
X-Received: by 2002:ae9:e009:: with SMTP id m9-v6mr23436150qkk.320.1530605634837;
 Tue, 03 Jul 2018 01:13:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2fca:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 01:13:54 -0700 (PDT)
In-Reply-To: <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com> <29ad484c1b357fd7fd670a6f252d097677b808f8.1530402641.git.joeypabalinas@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 3 Jul 2018 10:13:54 +0200
Message-ID: <CAO-hwJLPm2UgqYU7CgsqX1CNp5JjHu0mZJp-kZnPmZ2qhi1CxQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] HID: multitouch: drop reports containing invalid values
To:     Joey Pabalinas <joeypabalinas@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

On Sun, Jul 1, 2018 at 2:19 AM, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
> Avoid processing reports containing invalid values to reduce
> multitouch input stutter.
>
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
>
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index c0654db0b736543ca0..08b50e5908cecdda66 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -694,10 +694,19 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>  {
>         if ((td->mtclass.quirks & MT_QUIRK_CONTACT_CNT_ACCURATE) &&
>             td->num_received >= td->num_expected)
>                 return;
>
> +       /* drop invalid values after counting them */
> +       if (td->curdata.x == 0xffff &&
> +                       td->curdata.y == 0xffff &&
> +                       td->curdata.w == 0xffff &&
> +                       td->curdata.h == 0xffff) {

You can't really use plain values like that. There is a tiny chance
these values are valid on an other device.
IIRC, MS spec says that we should ignore out of band values if they
are tagged as such. Such input are tagged with NULL values
(http://www.usb.org/developers/hidpage/HID1_11.pdf page 31) and MS
spec mentioned this.

All in all, if you have this bit set, you need to compare the value
with the logical_max/min for each field.

I never encountered a device that required this, so you are probably
the lucky one :)

Cheers,
Benjamin

> +               td->num_received++;
> +               return;
> +       }
> +
>         if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
>                 int active;
>                 int slotnum = mt_compute_slot(td, input);
>                 struct mt_slot *s = &td->curdata;
>                 struct input_mt *mt = input->mt;
> --
> 2.18.0
>
