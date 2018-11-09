Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D38420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D38420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKISWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:22:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38836 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeKISW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:22:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so307682qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EfkSVT3PSCGZ051H2Al5+5ADEWvCvtco0N6M08ggxU=;
        b=UkVrCuP0yL4+eCZpERQf29MLoaME0fenKymeEtc+6ke7SaWQfVvs4QNjpsVql9Y7EL
         2bZbCO/yKxJY81xaInE0qn8DbVJ7ch+HUxJmIHfbZReXr0Lm/uDIZxUEHJlSQj4xOefM
         3ezkOZxea05Y9McSiKscn7uwFlWr5daF/Q5+1Xej4oJmluj99BAJX2I9hzJrZj3mU5fT
         CB8FxJpCeSrggIg6HvwQCX+FU3gR0BZzWRjACvhjmiaJtoxRWeq+e7PpiMP+HabSfB2a
         pwabH16oa1CchIvbX9GznqJ9UQgeztBGZ5EprmNO0d0l1h8+5VV14gRdYtZxWxCEZ7Bn
         qxUw==
X-Gm-Message-State: AGRZ1gJdvio/zg8ev0s4XE6BaE7CZogiBaZ6Rqt234DdwgLRJ/hIP7JO
        CyK7TzKE814iFqcD6STryLoxFsna/YaVveltTyDGkQ==
X-Google-Smtp-Source: AJdET5fE985QMIoaEWarJ53S3P/R8yM1d0CDwlJOIHLyVjYej1d0WPEwSaFUdG5EoD1ORKDplhXxbmDPAZ8Vl2yaKzE=
X-Received: by 2002:a37:9d8a:: with SMTP id g132mr7714984qke.192.1541752976667;
 Fri, 09 Nov 2018 00:42:56 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1811082237460.21975@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1811082237460.21975@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 9 Nov 2018 09:42:44 +0100
Message-ID: <CAO-hwJJehHLJfgrQvbrW0_bOTTeH-v1qhZK0p0WZCuVDR1wsKw@mail.gmail.com>
Subject: Re: [PATCH] HID: hidraw: enforce minors_lock locking via lockdep
To:     Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:38 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> From: Jiri Kosina <jkosina@suse.cz>
>
> lockdep is much more powerful enforcing the locking rules than code comments,
> so let's switch to it.
>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---

Looks good to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hidraw.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
> index 4a44e48e08b2..cf2af069204f 100644
> --- a/drivers/hid/hidraw.c
> +++ b/drivers/hid/hidraw.c
> @@ -107,8 +107,6 @@ static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count,
>
>  /*
>   * The first byte of the report buffer is expected to be a report number.
> - *
> - * This function is to be called with the minors_lock mutex held.
>   */
>  static ssize_t hidraw_send_report(struct file *file, const char __user *buffer, size_t count, unsigned char report_type)
>  {
> @@ -117,6 +115,8 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
>         __u8 *buf;
>         int ret = 0;
>
> +       lockdep_assert_held(&minors_lock);
> +
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 ret = -ENODEV;
>                 goto out;
> @@ -192,6 +192,8 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
>         int ret = 0, len;
>         unsigned char report_number;
>
> +       lockdep_assert_held(&minors_lock);
> +
>         if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
>                 ret = -ENODEV;
>                 goto out;
> --
> Jiri Kosina
> SUSE Labs
>
