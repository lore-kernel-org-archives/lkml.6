Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370ADC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504D21884
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J36rpdpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504D21884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbeGEKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:16:21 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:46061 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeGEKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:16:19 -0400
Received: by mail-yw0-f181.google.com with SMTP id 139-v6so2767410ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N1xG/esxq1r3Qc7Q8EmpmXtJRXHP59yWdQ3SRUaJPbQ=;
        b=J36rpdpocNBJvMHUCbrMiJvIfXbk83ZejO0aUwotyZuC4KzbSPOtIdEoICIs37c8LU
         kJf2R1IkmDGl9RxLOrkrBbcDCCzM0EyDuQWQKYtMap/XBAU60iSrgAPM4hxKq4X22Xkh
         Cx/8ZguzQq1aTtsVI67JviFdIDG6UjqWNFN5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N1xG/esxq1r3Qc7Q8EmpmXtJRXHP59yWdQ3SRUaJPbQ=;
        b=WnbOOY5hfsHSh8hrt5UtAwnNV6DwKQF0pSvejdbA6k9Ji/7COYL2ui6eZjRf2z5/l8
         ooFkpgnnLNCDLXlT0+Pmq6HP79eL7ZMSYACch0m2nHFkUTXB6eLk7+Q+wm6wN/sh+n30
         b+NMnFJi5dJ61lQYo38VRNmQMW7faI1bo/T4EwLYyJWhNukU49sUsxJcWISR/hroTLSq
         zjWbJGmt2Au4ykWh2QFE+4xAU8KQhfkJBgGOnpqf8Z+NRrAWJfWcL6C14bq1Wu0EhRjV
         BXMJlV9HPt5zrT4qgKeX/EJdnXJvnjzvn51LlrRBlpfrPgQeZF92p5eD+TIswEUcKg/p
         +/+A==
X-Gm-Message-State: APt69E08Q0rGYAuY0Hi8Lp6H/JQZzxS2U5O4e3TE6R+QCvCEFaImq/eW
        qYig33JN9hWJsmwV7D/VZAV8gqaXz3o=
X-Google-Smtp-Source: AAOMgpdMu1rEDV2q6nL9Kp5VyEXTlEwI1XPTxF7o12SlNQiKjg0jCYy5QoM+4x5tVoxYMYiIij+IgQ==
X-Received: by 2002:a81:1e51:: with SMTP id e78-v6mr2459135ywe.20.1530785778381;
        Thu, 05 Jul 2018 03:16:18 -0700 (PDT)
Received: from mail-yb0-f181.google.com (mail-yb0-f181.google.com. [209.85.213.181])
        by smtp.gmail.com with ESMTPSA id a16-v6sm231154ywa.83.2018.07.05.03.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 03:16:17 -0700 (PDT)
Received: by mail-yb0-f181.google.com with SMTP id a2-v6so3004598ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 03:16:17 -0700 (PDT)
X-Received: by 2002:a25:7456:: with SMTP id p83-v6mr2672016ybc.500.1530785776786;
 Thu, 05 Jul 2018 03:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 5 Jul 2018 19:16:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D9e8Skiwbdz5y7WU_BNddVKgFTErmcbb_E2yQ0+RAsCg@mail.gmail.com>
Message-ID: <CAAFQd5D9e8Skiwbdz5y7WU_BNddVKgFTErmcbb_E2yQ0+RAsCg@mail.gmail.com>
Subject: Re: [PATCH v4 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Thu, Jun 28, 2018 at 12:27 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi,
>
> Here is v4 with following changes:
>
> - fixed kbuild test robot in 12/27.
> - fixed destination of memcpy in fill_xxx functions.
>
> v3 can be found at https://lkml.org/lkml/2018/6/13/464
>

With the comments posted by Alex fixed, please feel free to add:

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
