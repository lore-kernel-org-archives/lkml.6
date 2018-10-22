Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA8C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8453E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 05:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKUgI+5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8453E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJVOI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:08:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35367 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJVOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:08:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id 14so34827079oth.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 22:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nqz9QZKNlZNwwu6JfebYKHe8/J0Dec7REuwIbBJwNbI=;
        b=eKUgI+5QgKp7x/H2o67gSNgKwkBKFRiT9FmhiElNcS9ESJQYX7e4bjSMeqVJB7gXNp
         KezUxz3ddE0NlW+LD8tO8y5y4huh8se2pVLpfve/oznQKSPn9EcEl9Bj0fJFJf44fviN
         GqxO/IjPpPHz4jZZLN824G0zz+kSc/omdUe50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nqz9QZKNlZNwwu6JfebYKHe8/J0Dec7REuwIbBJwNbI=;
        b=L+D/6BZre/45Jl7cFXq3Ac9qUxCtSVLXgjvJjpJpFpmwLuPxJoZn42V+SlM6t72frD
         9fgV0mD0BEk3l7t086cWP+3qK2GmaU8dxQf6Z1b5Afj59XVoRZ4ZvaZjObWPO/yxl1Wy
         5bx7YmzbtHXlzIPeeioEHrPAdVq7zTXb9rKzLOcNa88VhRElekRPi8M96FMcQAR8pv8h
         Fi9hX/bSF4Hu7F8CWaZsuk6kNYsPoN8b3loq7zwgsB9Fuc3XDG1d4NZKvAzTtaLTJhmb
         BNZcSxvVPb7PnCn7PeC55Yp6NYSghyA5Yu8Qa7G8Yk0L15vvlKcXJ0roavtjRkNXCxfG
         Fr0g==
X-Gm-Message-State: ABuFfohobqmBoYtQoUjNIiTEa6oJrFTASJMrVc/BmvAwaYuFCDqe5Slx
        TqNzuKiw+tBeb9+lkegOhzO3v0cjnYV5a+e/
X-Google-Smtp-Source: ACcGV61iS/2gkKkOz8MsRpvQZw8mPHFZINvcJF2569aNyRptVDI0okTIwNIRy2fHrU8vTQ0MebQX1Q==
X-Received: by 2002:a9d:522d:: with SMTP id e45mr28930168oth.91.1540187516328;
        Sun, 21 Oct 2018 22:51:56 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id u21sm11817585ota.81.2018.10.21.22.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 22:51:56 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id e17-v6so31216418oig.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 22:51:55 -0700 (PDT)
X-Received: by 2002:a54:4390:: with SMTP id u16-v6mr24069433oiv.186.1540187514727;
 Sun, 21 Oct 2018 22:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Oct 2018 14:51:43 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWxUNyJEkAUATa7BiXgU1JefoxFseXuaLb+_XsLish8Pw@mail.gmail.com>
Message-ID: <CAPBb6MWxUNyJEkAUATa7BiXgU1JefoxFseXuaLb+_XsLish8Pw@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Venus updates - PIL
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On Wed, Oct 17, 2018 at 10:18 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> This version of the series
> * updates the tz flag to unsigned
>
> Stanimir Varbanov (1):
>   venus: firmware: register separate platform_device for firmware loader
>
> Vikash Garodia (4):
>   venus: firmware: add routine to reset ARM9
>   venus: firmware: move load firmware in a separate function
>   venus: firmware: add no TZ boot and shutdown routine
>   dt-bindings: media: Document bindings for venus firmware device
>
>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>  drivers/media/platform/qcom/venus/core.h           |   6 +
>  drivers/media/platform/qcom/venus/firmware.c       | 235 +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>  7 files changed, 274 insertions(+), 43 deletions(-)

The series:

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
