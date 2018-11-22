Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE7EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28CE20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28CE20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392835AbeKVSk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:40:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37741 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeKVSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:40:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so6390208qkd.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npOzd6lhU/Ux04c7JLeacYowob0jiNymra/wMlciylE=;
        b=H7NrXAZxEOfOpEBQofsOkVKSZVP03N9Rx8Q56Hip99EurV3aV4tM0BTPJkDRpveEN1
         UBCE5l+m/noaEAyHliY2D0Ue/ZAHWqx8ou5gW+ceRp2DpdThHns+p7bIUvVd7/vjYoqD
         ggD8zhXHk7vCvKpGp/37keF4tcyB7GrTBeoyncpe9QvV9HD0IBGi9dMJSFoy/ioBsJN3
         eW+02UkP1U3NLdphP64rKpeNWF7VjfsMVScZcEUoSIeXFf4BMOIQ95uSUR1/VaH0FX3b
         cWUSsJCdt3Q0RKo9BKcX2fHPVkGF9QbMcVr0soZ/PadNp+u74m5aEV1uK0ZjKnJontYe
         1OXQ==
X-Gm-Message-State: AA+aEWby5Ukr8LxRH+LsxYhdGbHksjHZC6qU0Yi//+3ARlEpOp1w/qTF
        6QCU/fATSrbA8mz8cH8S5SgOmGgP5Tr15iBi8GMxhw==
X-Google-Smtp-Source: AFSGD/UcJPs5jN21H79AMq6G1OMart1f3Maz9w8gO6JbOZiJyrOf1EKoXoUMEQ0D0t6bsOOEs2Vl0VvgBDQAwr3QHkM=
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr8507347qkf.194.1542873727339;
 Thu, 22 Nov 2018 00:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 22 Nov 2018 09:01:55 +0100
Message-ID: <CAO-hwJKBEUMBcSE-oCGAtxt0iaboN6ObvzgBnCtWmb2XiUM-5g@mail.gmail.com>
Subject: Re: [PATCH 0/7] HID: revert the Logitech High Resolution wheel support
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, hcutts@chromium.org,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 4:27 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> It turns out that the implementation of the high resolution support of
> Logitech wheels is rather incompatible with the mice from Microsoft.
>
> We had a lengthy discussion off-list and the summary is quoted in 7/7.
>
> The TL;DR, we need to revert the current series before it gets out in
> a released kernel and work on a better approach for 4.21.
>
> This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
> and Peter, but I wouldn't mind a public ack before I push this to
> the for-linus branch.
>
> Dmitry, I chose to also revert "Input: Add the `REL_WHEEL_HI_RES` event code"
> as the documentation needs to be updated.
> I would understand if you rather keep the patch that way and we just update
> the doc. This would help synchronizing the trees. So please tell me if you
> want 7/7 in the series or not (I'll reshuffle the commit message to have
> the summary from Peter).
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (7):
>   Revert "HID: input: simplify/fix high-res scroll event handling"
>   Revert "HID: logitech: fix a used uninitialized GCC warning"
>   Revert "HID: logitech: Use LDJ_DEVICE macro for existing Logitech
>     mice"
>   Revert "HID: logitech: Enable high-resolution scrolling on Logitech
>     mice"
>   Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling
>     acceleration""
>   Revert "HID: input: Create a utility class for counting scroll events"
>   Revert "Input: Add the `REL_WHEEL_HI_RES` event code"
>
>  Documentation/input/event-codes.rst    |  11 +-
>  drivers/hid/hid-input.c                |  44 ----
>  drivers/hid/hid-logitech-hidpp.c       | 309 +++----------------------
>  include/linux/hid.h                    |  28 ---
>  include/uapi/linux/input-event-codes.h |  10 -
>  5 files changed, 28 insertions(+), 374 deletions(-)
>
> --
> 2.19.1
>

The series is now applied. Thanks everybody for the quick answers.

Cheers,
Benjamin
