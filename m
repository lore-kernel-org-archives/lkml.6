Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE3E20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfAOVTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:19:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39509 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733166AbfAOVTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:19:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id c21so2478554qkl.6;
        Tue, 15 Jan 2019 13:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmQjDqHJG7rtxz6sQA1HKmY7UbAa3sA/y/aq6/3rjdg=;
        b=MHBjpEC/h100zR6DKSoG+q4Wuas5SPJ3+tN/3q3z5gvAVJr4uTSVBuFe/EG9eC9zxJ
         bElu3B35kkSUeSahOEWnLUFB9+H2h0pRa0EoJxGXdM/q3YstWNXoMHZ1mqebHqcvzYgp
         DzA/4J0R19drDLkqhjg0FrR9hVLuJdzBU8iKMZ2ecPpUCJmKsz0PXHBpe86FcRIyiI0U
         gh6QA6OX3f619wNJ1F1X5otyh12jkYd8fPzlnqRoo796thoPUkjD6hyfEs/SkN4rENcE
         UCuXJztLQCULqvudu2fRFabjAHVDVNti9zISom8ns/cOdZUMFiT0JY6pb0y4ZYIMzUKi
         DGZw==
X-Gm-Message-State: AJcUukd+E9olt1Tkf9FJ4F9oerBDJdOvW3XOCUtDy0Nougf+44R7wIJ5
        u32f0hi9Iq1FgGe5jDxwdj9REQb5Xcze/r5P8vI=
X-Google-Smtp-Source: ALg8bN7y/TTQlSeLMf42YbV3UXvIbbMD0skMXFMfbF3L7WUdKnjaollAsUBT6lfFxtuk7TBeUaw8pXDlbrU1g+dA/TY=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr4316487qke.173.1547587184128;
 Tue, 15 Jan 2019 13:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
In-Reply-To: <20181229183514.24644-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jan 2019 22:19:27 +0100
Message-ID: <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com>
Subject: Re: [PATCH] input_event: Provide override for sparc64
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 7:35 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:

>         struct timeval time;
>  #define input_event_sec time.tv_sec
>  #define input_event_usec time.tv_usec
>  #else
>         __kernel_ulong_t __sec;
> +#ifdef CONFIG_SPARC64
> +       unsigned int __usec;
> +#else
>         __kernel_ulong_t __usec;
> +#endif
>  #define input_event_sec  __sec
>  #define input_event_usec __usec
>  #endif

Sorry for not having looked at this earlier, I just realized that this
is a mistake
in user space: uapi headers are not allowed to reference CONFIG_* symbols,
since the headers are supposed to be configuration independent and the
CONFIG_* namespace might clash with user space identifiers.

The correct check appears to be

#if defined(__sparc__) && defined(__arch64__)

      Arnd
