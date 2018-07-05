Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F092402F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OvpbIr70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F092402F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeGEOHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:07:25 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40267 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeGEOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:07:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id p129-v6so2991539ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BEjkV8fY/tNZByxiXUqLWgP6BoOGkgEDJNi1i3BJyE=;
        b=OvpbIr70mu8Dz5VVr4HVghj115xEVAhLYmQa3T2IdYfK3x1NEOpCQ3Iu3KAXEnxqOZ
         HgdPYwdKN+hPRiqUKZ8e3JEJVAgUg2eS6cLEEANUZ5A39yAzpL1N6FlqNznn/4Ws2ru4
         LUt8WVSqQIacqW4s/W4pyKiOhv3+xSLRS7afc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BEjkV8fY/tNZByxiXUqLWgP6BoOGkgEDJNi1i3BJyE=;
        b=SGZspPNLqfH+X9w3Cs/cmGkoQCh+FZmkzeDSTUvosGn/eHRwoFku9IyZJp7gHOCrxm
         dcocSZ+sVEgui6LFAhiNiBiEKQGKBOYQ0Y2xrkabQmACNkOy6q7V/oAl2Ap0Rgz20BNS
         t/NU0obc0JwiIDZLD94JDH4rF1QjPH5+FSywi3vNYpkqjfwbyBYNsH0IxJcp4VYMjOrx
         NBlgTfGB4e2+YAqpHdXmnKk8qanOzQuA7XwnTmfxN2blRspKe3GOj85J81mBkYowDDcI
         17Jl4CmhFa9oL3sjFbs6jcBscRdfS7SZ1SpIxBbmg6mQkoZuF+MQlZBNCPoiP8Du1v26
         EbXw==
X-Gm-Message-State: APt69E0khUO4V0azceFl9KetEknkoCHIuPo2ukmHiN8GIerXRj2hxjm+
        2Fs2QyUw1RdNLqMvWwDGBoSpLx65WOI=
X-Google-Smtp-Source: AAOMgpdSe7xEovr/F8RWjxzxtEuMmSZDSqf1NfiZRDpFaZslbRyczjX1MONo12mIBooanlbSzqTTGw==
X-Received: by 2002:a81:a742:: with SMTP id e63-v6mr2868905ywh.393.1530799642415;
        Thu, 05 Jul 2018 07:07:22 -0700 (PDT)
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com. [209.85.161.175])
        by smtp.gmail.com with ESMTPSA id k65-v6sm2249581ywd.13.2018.07.05.07.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:07:20 -0700 (PDT)
Received: by mail-yw0-f175.google.com with SMTP id t198-v6so2998412ywc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:07:19 -0700 (PDT)
X-Received: by 2002:a0d:ddc8:: with SMTP id g191-v6mr2990126ywe.145.1530799639380;
 Thu, 05 Jul 2018 07:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 5 Jul 2018 23:07:07 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
Message-ID: <CAAFQd5CQCF=QvTgq8v6K6W6C0Cy27CzHsMxQn+FnML97w9xnCw@mail.gmail.com>
Subject: Re: [PATCH v5 00/27] Venus updates
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org, Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Thu, Jul 5, 2018 at 10:05 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi,
>
> Changes since v4:
>  * 02/27 re-write intbufs_alloc as suggested by Alex, and
>    moved new structures in 03/27 where they are used
>  * 11/27 exit early if error occur in vdec_runtime_suspend
>    venc_runtime_suspend and avoid ORing ret variable
>  * 12/27 fixed typo in patch description
>  * added a const when declare ptype variable
>
> Previous v4 can be found at https://lkml.org/lkml/2018/6/27/404

Thanks for the patches!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
