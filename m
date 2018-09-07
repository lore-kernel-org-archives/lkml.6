Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D9CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2272075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QjcFShu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIGWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:15:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37563 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:15:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20-v6so12089644edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Z1YMRrU/FQyqfiboUt8taPDvf8Sggr9eSXlW6WY8gw=;
        b=QjcFShu0bydD+igxb04K1ddN8TaGgijfv0otArl/N1txXzCsHCeMKasRRHahHqQPZe
         uxx6UaU/QRVZ+JRJ1XLdSmT0A7bghrD6HQeM8uEZDC7JOPCbNTHI9zbQZsfgSQHNGYJc
         nS/gI91tVLzQs7dI4Kfs/e45uGvF+aDQwduEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Z1YMRrU/FQyqfiboUt8taPDvf8Sggr9eSXlW6WY8gw=;
        b=MzX9BdiSyMjZszRvl+7rszRGj7fsQo44bfAUad52RuUmrBf1YGFVTwB8zWGDwHQw7W
         PN2wIqQrSuhOQ9f0+IU0dLLfWp2U3BmshBtp0BYETZW8lYZ9rVLBnQ3zYykzNOyD9hng
         H/QUE2/mM6+n8yn7ZrVrRJoeFKAUPWhn67TjES3rfeIcg8Swliue/S6dNOXd1LCdIyca
         VvO4B8uNptqTYqnDK8og/+3VBK7buEvkX+9sBipKnClz7jxNcWdYgTbuaq1SZ6DEWhWu
         5U6GxEyfv1544Q1y5lnzE7Ad898TTVY12rsiml7mvwA7SWZ9TxBODWF5svfLkhdm81HO
         ekrg==
X-Gm-Message-State: APzg51AigsUm2UAojO1TGkpTK9vxEYPHTAcfJ+n++kJI4Ih9A9y0vM4K
        FyL0uqrl/umBAiUP0/3fI24OWwWUn2I=
X-Google-Smtp-Source: ANB0VdZWBnGaKKHnn1c++F001ZmeKKuvpipPLosLYXEVClMtpqwlzD+jOHQ6UQiq/o/AkwB9YTanwg==
X-Received: by 2002:a50:87fb:: with SMTP id 56-v6mr10029354edz.68.1536341609256;
        Fri, 07 Sep 2018 10:33:29 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id p28-v6sm5688628eda.85.2018.09.07.10.33.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:33:28 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id v16-v6so15706359wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:33:28 -0700 (PDT)
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr6413598wrp.184.1536341607627;
 Fri, 07 Sep 2018 10:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com> <20180907103450.13890-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-7-benjamin.tissoires@redhat.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Fri, 7 Sep 2018 10:33:15 -0700
X-Gmail-Original-Message-ID: <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
Message-ID: <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
Subject: Re: [PATCH 6/7] HID: logitech-hidpp: support the G700 over wireless
To:     benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>,
        simon@mungewell.org, Olivier Gay <ogay@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, 7 Sep 2018 at 03:35, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> The G700 is using a non unifying receiver, so it's easy to add its support
> in hid-logitech-hidpp now.
> [snip]
> @@ -3671,6 +3671,9 @@ static const struct hid_device_id hidpp_devices[] = {
>         { /* Solar Keyboard Logitech K750 */
>           LDJ_DEVICE(0x4002),
>           .driver_data = HIDPP_QUIRK_CLASS_K750 },
> +       { /* G700 over Wireless */
> +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
> +         .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },

As someone who's new to the codebase, it seems rather confusing to me
that HIDPP_QUIRK_UNIFYING would be present here for a device that
doesn't use a Unifying receiver. Am I misunderstanding, or should we
consider renaming the quirk or adding some clarifying comment?
(Similarly for the G900 in the next patch.)

>
>         { LDJ_DEVICE(HID_ANY_ID) },
>
> --
> 2.14.3
>

Thanks,

Harry Cutts
Chrome OS Touch/Input team
