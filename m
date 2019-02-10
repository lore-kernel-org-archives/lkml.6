Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E369C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A2F213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5hstnJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBJXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:21:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45754 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJXVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:21:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so14561688ota.12;
        Sun, 10 Feb 2019 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jx789uC5iRECBwrIemt5dIgsTq53x++f4li/ms0Xyb0=;
        b=U5hstnJcEISzfGhmmTct0Ja17dfBsJ0dZVplqj17HGJNtG93jRKLZKcVMsTov3myXK
         DXQyjNC9986VJvoBXnfMSIR20fr0LX5n7WvkCPQOilG+2RquMhgxZJdL9j9zbksGU3lq
         wyi8Dfs2kQ+psF1s8fAyigeUqaFINpG7nw0Y0cljEt/HMvlrA+vbrUA2FRtat2CfttB0
         M8ZI1BiQ99JxfcSx88KJE9ST8dKWWihPsPz1BOqWLxYng/22vu7sjae9NsBWrequZ1F8
         HDemVqf5EtAVxyr6ZyNsnfHq0J3OInxLeMNSXPOhFXYei5SAY5j+7iPNUXh5XKYj0hhq
         Lfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jx789uC5iRECBwrIemt5dIgsTq53x++f4li/ms0Xyb0=;
        b=NTbKc1rJFYa+zTVURH2bkjp/R54kNM6S8t7wBbyiAfYq/LriIGFTi6qtVnhNpens4L
         EXI3T5aZEBRcLpu9AA84d06A+hub/W84De+cU6IzdHqZl6KQrTEgr3IYOZ3Fk8cOzv5k
         jNfPRlIudbHQUykeV9JNOBXy7AUPmuFxWKkqMF5WMQhYWmF3oSnYMATf9hdpsH5GYjvK
         0r/bZTS136O9cg2pg++9Mldzp2gEJ/hutcUVgxijHXYEBltiVNhwl9xbYLn2SQ+vRAb4
         Ed8BY+pYQjn9uia3p5K91g3jr7YmP3rdrkMHiEbpM0yPMh418XlWJKXFL85iu5kOxYk0
         /QDw==
X-Gm-Message-State: AHQUAuZneVZmNDJNVrlP50sdBM4uwrx01k/NPCOOovuHdSu5veA5RnP9
        zKlCKUrUQd2N2J0wf6Tk0bqUvfCGrI4ybgT5h7g=
X-Google-Smtp-Source: AHgI3IYH+KZXX2aGNdVhIODfQiRVe8Xqq9UFVD85nlKit0HzOveoyhQ8P+1WE/PildwOj+6ZljFZI340SuScKxYJLWQ=
X-Received: by 2002:a9d:d21:: with SMTP id 30mr25219774oti.245.1549840898787;
 Sun, 10 Feb 2019 15:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20190209171925.GA24193@dtor-ws>
In-Reply-To: <20190209171925.GA24193@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 10 Feb 2019 18:21:27 -0500
Message-ID: <CAGngYiVjAX50R5HPnqqkxvWvbABWWnQ-3r3GAoiW=mb+OEUaqw@mail.gmail.com>
Subject: Re: [PATCH] Input: apanel - switch to using brightness_set_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Sat, Feb 9, 2019 at 12:19 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that LEDs core allows "blocking" flavor of "set brightness" method we
> can use it and get rid of private work item. As a bonus, we are no longer
> forgetting to cancel it when we unbind the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This is the blocking set_brightness callback after applying the patch :
(it's not immediately obvious when looking at only the patch)

struct apanel {
...
        u16    led_bits;
...
};

static int mail_led_set(struct led_classdev *led,
             enum led_brightness value)
{
    struct apanel *ap = container_of(led, struct apanel, mail_led);

    if (value != LED_OFF)
        ap->led_bits |= 0x8000;
    else
        ap->led_bits &= ~0x8000;

    return i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
}

ap->led_bits was previously used as a 'mailslot' between the
set_brightness callback and the deferred work, right?

After the patch, it's used only in this function. Maybe it could be
replaced by a local variable? As a bonus, that would make
the driver's private struct slightly smaller.
