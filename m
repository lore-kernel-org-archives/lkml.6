Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD51520862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dDtU+Og2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD51520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeKFDux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:50:53 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33725 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbeKFDux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:50:53 -0500
Received: by mail-vs1-f67.google.com with SMTP id p74so5737382vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+o+MD3BcE5IMA5ji84urbWnkmt7F6r15XTbanAxDQA=;
        b=dDtU+Og2tLIBVMNPaO5WHWsnXDqUXbCPCN1kqj/aq3L66kP8JvVeCAnnmc36M6FhoG
         kByDLk+VKz1pUoJWpg++G6aIEGDQEH9TYJXr6BxILG805Y0pNqpiDi7wThDZMbO/4AO0
         MKDXqCvXOyd5uP8CwVruzjiFXmomcCS4DO6JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+o+MD3BcE5IMA5ji84urbWnkmt7F6r15XTbanAxDQA=;
        b=mu1G6VRteW8i3oW4ORtsLsixHDQ29hTTmtsm07J/WVd9HURllFaq0gEdss0M564UsW
         8dF9dUP5h0xbWY5Gh+xQ3h7xuWD7luy71Zd/kvRHrO/6u22ZhVDMygNqASYyS/mht11e
         sp9YNMsD4+yRQA8XsiZGW21wTiavUzww27VCn6TQABfhnzucUXpd312jDCfDEZJwhKFH
         OLkWu5hgc3OUwyoHmUhEWXVg3UlvOXIZsTdN/wKS328I4vdMJoGJXVO6g/0QHW94psAw
         HfwqiEnvmDsJ5o6tj+v+9ygu2nfOo5nJpkW/GOqEE8JcetFEnr/tj2m7IGy/0uIr4/tJ
         FpXQ==
X-Gm-Message-State: AGRZ1gKhhkrwPtcIU2MbQQJSGRUv1/zsJUeWHxpQZTcsV+f/v+lHPsUq
        /aFOO5UR0nkFjXOOtOvwV/vQ2Fri1KY=
X-Google-Smtp-Source: AJdET5ccax8814GZUiNgcayzjEq2wvZAy9ScegdalNrBIsHcpFPKT4Als1PDThwzy0qVag5nC1AbWw==
X-Received: by 2002:a67:3a1c:: with SMTP id h28mr5476166vsa.218.1541442596632;
        Mon, 05 Nov 2018 10:29:56 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id u18sm1322902uan.17.2018.11.05.10.29.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 10:29:55 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id v24so3543516uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:29:55 -0800 (PST)
X-Received: by 2002:a9f:386c:: with SMTP id q41mr1330884uad.27.1541442595175;
 Mon, 05 Nov 2018 10:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20181023010707.153647-1-ryandcase@chromium.org>
In-Reply-To: <20181023010707.153647-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 5 Nov 2018 10:29:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XGwyUEN3U-SzFB_VOLJ3LMcMttugKz7skgvMaBjt3H_w@mail.gmail.com>
Message-ID: <CAD=FV=XGwyUEN3U-SzFB_VOLJ3LMcMttugKz7skgvMaBjt3H_w@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
To:     ryandcase@chromium.org, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

On Mon, Oct 22, 2018 at 6:07 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Address remaining comments from original driver patch series
>
> * Move RD_FIFO_CFG to be ordered corretly
> * Expand spinlock comment
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

No huge deal (obviously) but I noticed that you landed a batch of
similar patches last night but didn't land this one.  Did it fall off
your radar or is there some other reason not to land it?

Thanks!

-Doug
