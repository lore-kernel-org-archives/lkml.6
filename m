Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF22170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF22170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeHNL27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:28:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46488 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:28:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id 191-v6so12825115qki.13;
        Tue, 14 Aug 2018 01:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6TsHUQuKi7AvOXDscfx+1m7+XmwhUOlQZ2QM6OG9wc=;
        b=S4yuKrAoXP6hKpE0M1957YdpTpUToSmx+GcwQBKGvL4tEX5vqP+P685+oenFLiZbbE
         Sb5q9uUiYdDk0sEDT310ssmSUBVQPoAx3q5I8qRv4APagYatNXLWD0PR1zaOLLeZ9QfH
         v3R9CVwjLkp5W1gwFdwq2r+DviaOhgIypSDrcDn00ybtVHdAzhoYjLUcoWrE0JvVQHLL
         wlIVWzxb6wDKNecWZHZ18hOKRzymsB/GjMGLEZCVDfW737dmuvd2pc9jahS94/RBXirW
         N443a5wLemk2XsITrntdwwo2FT7WeeS710nTmExNHPOPI9pPyTyIzoSuw93Y2CA6T6uD
         AyAQ==
X-Gm-Message-State: AOUpUlGQlEcxcSyUUvQHdRQT4zGPEpTBi2T7pdC0CkgJodCfSk5i8bas
        k58mEukOag/z4fcIS5g6CVbQsi+RRAaTYN0hq1Q=
X-Google-Smtp-Source: AA+uWPzStheYQP1HRKNUf+FV9mryx4QlVH6q3sGsaNPD4bhkjQKw7KUvB2ntyz+hD2YmAS8jeh9rI7h96zU2ASZr0LI=
X-Received: by 2002:a37:2a65:: with SMTP id q98-v6mr18580360qkh.174.1534236168243;
 Tue, 14 Aug 2018 01:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180813220419.4168133-1-arnd@arndb.de> <60279ff9-95a7-c2d8-dcd3-6e505c22a0e6@redhat.com>
In-Reply-To: <60279ff9-95a7-c2d8-dcd3-6e505c22a0e6@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 10:42:31 +0200
Message-ID: <CAK8P3a3QwP9qA-sjCn8UFKHPFzku0epxi6BWETpH9YTEfjQ5jA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, jeremy@jcline.org,
        Kees Cook <keescook@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 9:22 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Arnd,
>
> On 14-08-18 00:04, Arnd Bergmann wrote:
> > When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
> > warning because of an incorrect set of #ifdef guards:
> >
> > drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]
> >
> > Replacing the #ifdef with an IS_ENABLED() check shuts up the error
> > and simplifies the logic.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hmm, so now you're counting on dead code elimination to remove
> references to unavailable symbols.

Generally depending on dead code elimination is very reliable, as this
is easy for gcc to get right. However, you are right that this is actually
an exception since the MODULE_DEVICE_TABLE() entry will keep
a reference around that prevents the compiler from eliminating it.

> I'm not sure I like this and
> since Marcel has also indicated the does not like this fix I
> believe we need another fix.
>
> I will write another fix for this.
>

Ok, thanks!

      Arnd
