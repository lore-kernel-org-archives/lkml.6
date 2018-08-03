Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A14C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981BC21748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 23:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m8TfMP2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981BC21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbeHDA6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:58:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39748 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbeHDA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:58:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id a134-v6so5185029lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxEclpyOYuFQ7Rl9MmPDan1lmq0pPsaRMMW7EHhiPW4=;
        b=m8TfMP2hN5da+QqFb6sdRZSAEXsq5TTZ3Cj3zU+zyo2TDXlPxKMT0a0p+6W/Xda1OL
         wyGUo49XvdooeEpu6s1FpQSRhb4c9U9RKvM7SePaFbvdW7kn3jLZaQ5j39OmJ7V2O+Q+
         OMjpgb3gwwfuOgBrKrUBKLckm8Sp38uuOa/34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxEclpyOYuFQ7Rl9MmPDan1lmq0pPsaRMMW7EHhiPW4=;
        b=G24mPRgZtxyUOGsEJJJUSOBtpj7ZK2CLSej+7a3egZtJ33j7+g5bOdvYo14knnsgil
         ulrIFeGR/+6XlFR3WmlafoAktoCIc7tkhQEkwF6u5LJKBkgtIrMt3tY6CTtqvCNPjKLp
         o0v7M+8EpFxU2Pp58UYIMXEEZo3ISLH+E5Or1eM2EEJNoFvvo167DLMSXsQlAR6dVjPe
         /2l0nHrzUdyibyAEdXLrIP7AQ8RysS0JAuObB3vD53RyYTb31rbv+tn0riF5LeDi9Ud+
         /SveB7ttMYOncfSlAIxuFNdqZTgWiuX3i99855MKWBuabFEpFLqxbkOsTriNCDbZ5Kdw
         CEUA==
X-Gm-Message-State: AOUpUlE1Ho5YkmGQlgL+BkInU1lZSuwF5bauUerYkfE0NuJOMVp0HV0j
        84P1GOrmYpJUjxfx9vub/BpzZreKi50=
X-Google-Smtp-Source: AAOMgpendJbLJx1N+k7y6r+Xx+HUxjXL9oSBX+i98ZPTkMIO+H6HiiuDGrR++tQDMY+uOrRtG/lbeg==
X-Received: by 2002:a19:9a81:: with SMTP id c123-v6mr6098175lfe.106.1533337222407;
        Fri, 03 Aug 2018 16:00:22 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id g63-v6sm1080146lji.79.2018.08.03.16.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 16:00:21 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j8-v6so5176392lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 16:00:19 -0700 (PDT)
X-Received: by 2002:a19:d484:: with SMTP id l126-v6mr5556118lfg.28.1533337219239;
 Fri, 03 Aug 2018 16:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-7-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-7-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 3 Aug 2018 15:59:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft6eTnCm2CoUkhG8COHC+rMdrWGf2A+PqZYB+gq4djm5xQ@mail.gmail.com>
Message-ID: <CAE=gft6eTnCm2CoUkhG8COHC+rMdrWGf2A+PqZYB+gq4djm5xQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in msm8916 based
> platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/Kconfig        |   5 +
>  drivers/interconnect/Makefile       |   1 +
>  drivers/interconnect/qcom/Kconfig   |   9 +
>  drivers/interconnect/qcom/Makefile  |   2 +
>  drivers/interconnect/qcom/msm8916.c | 510 ++++++++++++++++++++++++++++
>  5 files changed, 527 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>

Reviewed-by: Evan Green <evgreen@chromium.org>
