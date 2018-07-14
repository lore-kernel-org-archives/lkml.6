Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699C3208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnhekdDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699C3208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeGNIoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:44:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40789 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeGNIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:44:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so26267369edq.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2xohJjmIwJsNrxjziaK4N4QIyVCKNt2hWRrYPzEKwI=;
        b=cnhekdDlXb778hu3c8B2XmDZkq7tDJ2C3VELEEkEYhOizc27WRCWLfB8hY0smC6AWe
         DQ8GrlgaBXdJbTjcq65ziA0TQTfLgkTxnYhD8zhuWOrMh6PFFaHKVWjQFUF6JE4QbV/R
         hhsM6ZuC/cbn2u3+8lLM+3hRK9OstvdM1clE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2xohJjmIwJsNrxjziaK4N4QIyVCKNt2hWRrYPzEKwI=;
        b=KkdnScS4T7c6GgzQLznriVaHwabbfbFmQBuyqg7Ig6RFL2XtADnGkBkOdCfLjiFqy7
         dCpB6B4jgXgXDK/vgmTCW1o8hWxWfygGDdeuH+byYfgEu1nQrPWyAWWhHvW1a/5MVWi+
         nclzFkmVaUjVBMW7aD2HWFRX5BpVaH4Orh8f2wkQaTlgIC4A9zuEwR64BEhM0PHu3g0B
         GaQPqsxN2JvWbSuQZrQhfrp4CvYyZBVpylWJw6fAz1OeqPJi6Dxds+n36M5lPQfzs8ic
         95/bOnJfdMhWcSOWw7r9G2KbSWqDu/pyzfcSDaIcbha/nukk6QZVckYxsL4WDzpXKBSP
         bL6Q==
X-Gm-Message-State: AOUpUlH+v5U/Iq5J3RyKA1Yb30GYZZWrF1bDkKOermTloEHC9cXLCsUF
        SThFIAzL5lr3+JkEuYMXkGtt4VPzPMKKEQ==
X-Google-Smtp-Source: AAOMgpdjFECdcaoFx2Ubn3yMjysEH5fr0z3Y8ZkGEEjmHRRTQNBGu8UxP+ELRxdIDbLUe5yhFU1mcA==
X-Received: by 2002:a50:8f05:: with SMTP id 5-v6mr9949210edy.192.1531556761218;
        Sat, 14 Jul 2018 01:26:01 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id h7-v6sm690175edj.82.2018.07.14.01.25.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:26:00 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b15-v6so27186884wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 01:25:59 -0700 (PDT)
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr7374943wrg.249.1531556759686;
 Sat, 14 Jul 2018 01:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
In-Reply-To: <20180714055816.223754-12-toddpoynor@gmail.com>
From:   Dmitry Torokhov <dtor@chromium.org>
Date:   Sat, 14 Jul 2018 11:25:47 +0300
X-Gmail-Original-Message-ID: <CAE_wzQ8GSXb=6Jt1imJyLKSfspVnjOuYb+YOuGenr6R916G4Vw@mail.gmail.com>
Message-ID: <CAE_wzQ8GSXb=6Jt1imJyLKSfspVnjOuYb+YOuGenr6R916G4Vw@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     toddpoynor@gmail.com
Cc:     rspringer@google.com, jnjoseph@google.com, benchan@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        frankhu@chromium.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        toddpoynor@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>
> From: Todd Poynor <toddpoynor@google.com>
>
> Always allow root to open device for writing.
>
> Drop special-casing of ioctl permissions for root vs. owner.
>
> Reported-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>

I think this patch is good as is, but as a followup you should create
a patch that supports user namespaces, i.e. replaces
capable(CAP_SYS_ADMIN) with ns_capable(...) in gasket_open() so you
can allow containers to control the device, if necessary.

Reviewed-by: Dmitry Torokhov <dtor@chromium.org>

Thanks,
Dmitry
