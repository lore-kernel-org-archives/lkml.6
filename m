Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F34C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11CD20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livid.pp.ru header.i=@livid.pp.ru header.b="ChX+/8+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfAPTNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:13:37 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40922 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfAPTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:13:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so8486384qtf.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=livid.pp.ru; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O4Ox5t7gZr3BNqT4wDqOavrgJWtBvGiG11JwN1bp8U=;
        b=ChX+/8+gdUAK9lq7XLx38pORNXW1+48u/QBXWKDG5nthXpFL2mJFJTRMQSLjiVWj02
         MVD2A8mMtCd59PPFUFqjF03EFZHHqACyiqAXnecVASxM4KizPrshaGrIb0yzuiXzgx91
         tHv2Cobi39d+OomOUJ/gv4+fQESevk50q2zUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O4Ox5t7gZr3BNqT4wDqOavrgJWtBvGiG11JwN1bp8U=;
        b=sjYhNJ6Arc/n3MKyNLaY/FtMbNSQZfffhw1NaqCxdeL6CS6r/oy3jN2fLhdttynQnJ
         UMncpwUHNLq8hZsU5H4BeZHR821vlq7tbF+iDDPcwIZwvXW6GrWWE1mDv0yYiJLgYfiy
         PDBD5AgdujKNedA8cgtb2Y3JMsdjbIWDkjXib06gRp4WT0puBoXl1vXZqpKOxP09r9tp
         4V7Gf5VhBPgUww23o+UsHucMWaHXPy5pcWt9erCOyrCEyTklqDEWQ8tqg4gU15EfwXvF
         NbrYfCct28qiw9LSsONSpLLlseqmxXdCjpWEiLMjSupeXHyX4NPrFcovFoMy2XZcWo3A
         sd/w==
X-Gm-Message-State: AJcUukcA6wYwmtwBU2s/HYGJJTkvY1Vk1ehMLKbb0GwBSxlL3nk6uLKC
        W03eVKhKLCutLUJvMmcgHaTl1aXN5r9a+mpTQtVNxg==
X-Google-Smtp-Source: ALg8bN5UvA5w+yagy2ztvxuFzvFAZe9lnNCcHBoLmja2LDUZMas88FOXUCjXr8T90KZl1iXCLBkKWC8XogT6WP91u5A=
X-Received: by 2002:ad4:410c:: with SMTP id i12mr8237687qvp.219.1547666015583;
 Wed, 16 Jan 2019 11:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20190115161354.6806-1-root@livid.pp.ru> <C672AA6DAAC36042A98BAD0B0B25BDA94CB280EC@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <C672AA6DAAC36042A98BAD0B0B25BDA94CB280EC@BGSMSX104.gar.corp.intel.com>
From:   Nikolay Yakimov <root@livid.pp.ru>
Date:   Wed, 16 Jan 2019 22:13:24 +0300
Message-ID: <CA+A=rXGckxCsEPAG_DczMgLwS2+K3SXFUnHnXQrOOr+9WOWj9w@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix configuration selection issues introduced in v4.20.0
To:     "Gopal, Saranya" <saranya.gopal@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 at 07:24, Gopal, Saranya <saranya.gopal@intel.com> wrote:
>
> Hi Yakimov,
>
> As per UAC3 configuration, the first configuration will always be backward-compatible.
> So, there cannot be any UAC3-compatible device which has first configuration as UAC3.

Thanks for the clarification. I would argue though that not all
devices might adhere to the specification, so it's still probably a
good idea to check all configurations "just in case". I will not press
this point though.

> And secondly, the commit ff2a8c532c14 does not break the pre-existing logic.
> I also thought so much about moving the code above Ethernet check while preparing ff2a8c532c14.
> But, then, it doesn't break the existing logic and so decided against moving it.

It does seem to change the logic for RNDIS devices with multiple
configurations when RNDIS kernel module is enabled.

Consider an RNDIS device with multiple configurations (num_configs > 1)

Before f13912d3f014a, the following sequence would be executed:

1. i == 0.

if (i == 0 && num_configs > 1 && desc &&
        (is_rndis(desc) || is_activesync(desc))) {
    best = c;
}
else ...

The condition is true, so this branch is executed. The first
configuration is selected. Since it's the last condition (all the
remaining code in the loop body is in the else branch), the loop will
continue onto the next iteration.

2. i == 1.

if (i == 0 && num_configs > 1 && desc &&
        (is_rndis(desc) || is_activesync(desc))) {
    ...
}
else if (udev->descriptor.bDeviceClass !=
                    USB_CLASS_VENDOR_SPEC &&
            (desc && desc->bInterfaceClass !=
                    USB_CLASS_VENDOR_SPEC)) {
    best = c;
    break;
} else ...

If the second configuration is not vendor-specific, the first "else
if" branch would be executed, and the second configuration is
selected. The loop is exited on break.

After ff2a8c532c14, the following sequence would be executed:

1. i == 0.

if (i == 0 && num_configs > 1 && desc &&
        (is_rndis(desc) || is_activesync(desc))) {
    best = c;
}

The condition is true, so this branch is executed. The first
configuration is selected, but the loop body continues execution.

2. Still i == 0.

if (i == 0 && num_configs > 1 && desc && is_audio(desc)) {
    ...
}

A redundant check is preformed to check if the device is an audio
device. We already know it isn't.

3. Still i == 0.

if (i > 0 && desc && is_audio(desc)) {
    ...
}
else ...

A redundant check is preformed to check if (i > 0). We already know it isn't.

4. Still i == 0.

else if (udev->descriptor.bDeviceClass !=
                    USB_CLASS_VENDOR_SPEC &&
            (desc && desc->bInterfaceClass !=
                    USB_CLASS_VENDOR_SPEC)) {
    best = c;
    break;
}
else ...

The first "else if" condition is checked. Unless bDeviceClass is
USB_CLASS_VENDOR_SPEC (correct me if I'm wrong, but in most cases I
think it wouldn't be), that condition evaluates as true. The
configuration is selected (redundantly), and the loop is exited on
break.

The result is this:
Before f13912d3f014a, if an RNDIS device has non-vendor-specific
configurations after the first one, that one would be selected.
After ff2a8c532c14, the first configuration would always be selected
for RNDIS devices. Besides, there are several redundant checks in this
case, which is, if nothing else, confusing.

Hopefully I've explained my point clearly enough.

>
> Thanks,
> Saranya
