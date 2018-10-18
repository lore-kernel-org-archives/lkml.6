Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39719C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2920866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gBU5MIM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJSGPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:15:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42805 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:15:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id p74-v6so12489105ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RflRliasJmTsjfk2Lq2b1UxNQSt2S82qbmyMUz0CRrI=;
        b=gBU5MIM09vpiigNh+kYwp/D0Qm3xuT89M1reo7NH+uK4arqGkgtAyOMP1lffRpbE9U
         dGGQLWOgGLAFPRzgAuHkwOxCYGeiGOh18TXmzHe7EE9brDjTfVIXts0qejOJW67ZbHPy
         2kAHxalO6NVBOV1niRmxXlvwdKZ9wtNBpxeJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RflRliasJmTsjfk2Lq2b1UxNQSt2S82qbmyMUz0CRrI=;
        b=X0EEBdPW38w+MaB5eyFsB+USJbmw3bkXN9Fw1qwnIE8kdwZwgz0bp7AdOKu+F8S8Lp
         xF5zlWME5EIFNli9KRwkkYQJs69GbqMBNbnp1aEPCpQAy0bqnXGdp52tgwXsvHL5+WYc
         eWLAq4UfBhH2xDC+PfrgxT7yGNoVFEgyMNhD8COAFdlAnKmXrrAeCb+tUYDVBHaGZkz3
         i3EJ0mUGThWOk/LV15qmFCCP2950mOiNcWcWylf8hl1N0atftHT5CfeQFSZs1HjTAeS1
         XcesKD3Ia2sOG/QkQ80VdtHo8kNoA+5kCkoSNu2ZRblMcCCtRHh8QOrQlEdtsMdzolqU
         QISQ==
X-Gm-Message-State: ABuFfogKEqWT/FnxvV+ZY3g1mB4xN0dutbHiv2JAGnYMu484kkNwoFpk
        03F/7a/XMC6vMgRtuVSNJ38KgQGmBRs=
X-Google-Smtp-Source: ACcGV60t/eTKQsnmyXTMGBUpKrfm9S7gGhAgJbXtmTcOsf7p5tazJW+2alrMt/RahfBCOHwBS8uzRQ==
X-Received: by 2002:a25:1e88:: with SMTP id e130-v6mr20937214ybe.123.1539900730879;
        Thu, 18 Oct 2018 15:12:10 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id t137-v6sm4967767ywe.1.2018.10.18.15.12.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:12:08 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id y76-v6so12457434ywd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:12:08 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr21258361yws.168.1539900727824;
 Thu, 18 Oct 2018 15:12:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 15:12:07
 -0700 (PDT)
In-Reply-To: <20181018220124.GA14768@roeck-us.net>
References: <20181018185616.14768-1-keescook@chromium.org> <20181018220124.GA14768@roeck-us.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 18 Oct 2018 15:12:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+aQ_Na7nQAEdo1_vGzj7hAVdsmcZeRsOm0we8OtDD4WQ@mail.gmail.com>
Message-ID: <CAGXu5j+aQ_Na7nQAEdo1_vGzj7hAVdsmcZeRsOm0we8OtDD4WQ@mail.gmail.com>
Subject: Re: [PATCH pstore-next v2 0/4] Refactor compression initialization
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Oct 18, 2018 at 11:56:12AM -0700, Kees Cook wrote:
>> Sai noticed pstore wasn't catching early crashes, so Joel fixed it
>> by moving init earlier again (with compression init done later). I
>> refactored things a bit to avoid modular build problems noticed by
>> Guenter. And while doing this work, I also improved /proc/iomem labels
>> after Dan helped me get NVDIMM working so I could meaningfully test the
>> very early crash handling.
>>
>> Thanks everyone!
>>
>
> This version fixes the compile failure. pstore also still works with the
> series applied on top of v4.19-rc8; tested on a Chromebook.
>
> Tested-by: Guenter Roeck <groeck@chromium.org>

Awesome, thanks!

-Kees

-- 
Kees Cook
Pixel Security
