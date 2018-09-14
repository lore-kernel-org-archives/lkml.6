Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73426ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E61B20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E61B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeINVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:13:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43911 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINVNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:13:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id 130-v6so5415348qkd.10;
        Fri, 14 Sep 2018 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s7RlBW0pdBhhP/mIz7Uul0lZDaLHtTzw65VCm2EcuM=;
        b=g8macBi7/7RZoEGMWSBrlSz+LWXICVgCJfVqEb9f0udskbBwiQzr14xIljfE2YqxCx
         kGPktpNrqoiTDwhBgxmDaRnPx6KoW/5odvCvtz/ewlYB63D2CHRiscXMyxMA4tdl4bBu
         HAP/3e45cwjT1CHxL/LzYCpXuzTuMh/y7sNIz1tjYPdhufVRiDNDxmzSmoXJ8vLw1bap
         hOJ7Cni6uEUj82m4VPMPJtziuvgrMh+GgsLjXf60hKDNhHDiUfedmwKqVOkSLqv2bGrR
         NRmbKKCBFLHG1fxp5KjTTZFYomvZ+od5fDXnnSGi8w7ZPoh6SacdR7Tb0yGNUBOyqwiY
         2EFQ==
X-Gm-Message-State: APzg51AjdhSD9Isu+kt1lABXL/K79ZVJt4DBDFNVmdocbUjd6Dfl6Sru
        MGL9pSjqfUPazeb7lr8xxuZ07uzmZ5VhhPtC5UQ=
X-Google-Smtp-Source: ANB0Vdb3sMyBwi0qC6l1z6VWN1zxjFntUaWYAiqZWmuF33ZaBc8/oZEgc5deL97j5iSThyaUaetq0kFKUObE1qeRO0E=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr6272384qkc.291.1536940677183;
 Fri, 14 Sep 2018 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180901204721.13117-1-deepa.kernel@gmail.com> <20180901204721.13117-4-deepa.kernel@gmail.com>
In-Reply-To: <20180901204721.13117-4-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 17:57:41 +0200
Message-ID: <CAK8P3a1zQBQz1ZtNZzkceut4k3eLjOjCwvOtBdEmc9cTsaFz+g@mail.gmail.com>
Subject: Re: [PATCH 3/5] ppoll: use __kernel_timespec
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 10:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> +
> +       /* We can restart this syscall, usually */
> +       if (ret == -EINTR) {
> +               restore_user_sigmask(sigmask, &sigsaved);
> +               ret = -ERESTARTNOHAND;
> +       }

I need a little help understanding this part: In the two existing copies of that
function, you have changed it to

        restore_user_sigmask(sigmask, &sigsaved);
        if (ret == -EINTR)
                ret = -ERESTARTNOHAND;

in the previous patch, but the new new copies you add here do

       if (ret == -EINTR) {
               restore_user_sigmask(sigmask, &sigsaved);
               ret = -ERESTARTNOHAND;
       }

Is that intentional, or did you accidently leave a version in here that
you had changed afterwards?

       Arnd
