Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC5C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D217320831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSuERPl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D217320831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeKUE2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:28:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35571 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUE2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:28:21 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so1629983vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCWxHZpGgpLPRRug+L0t42SX6pJ6+2nuE1YxQWzHt2g=;
        b=YSuERPl9QyC0VEwjz+dkLSGlg1+9/77lesdqe9XVbLO3v7H5eNyduE+uj2c0U/Mt4E
         z/Q+SEY0dVfyjbl3dHpyBSTRZ2aNDBM6CxP++jwh43jNCVRYfYGVIDDo/NI8T1bsu1JQ
         FVNc7bVtH2nRYN3F6giFd0ccHyz4Njsl9xWB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCWxHZpGgpLPRRug+L0t42SX6pJ6+2nuE1YxQWzHt2g=;
        b=MfEwWn73JY1g0b0mmXwrw9/g+zZKp0P5n8lRY3jvcYwRGnsG1tauCxgoJEYxchQczZ
         rc8ogSyOhtzAEY9wj05HUNEQJAp+ahdl6/cymmAvzGFFRE7i+nsJiLjVilTNLNlCvcaS
         6jkTOEKzMHyRXe4XqBTlU18zI9XjmPVE3KOeTduRGi+WNX40QFi0Z9upr7KAPy5hsuD8
         Xxo5T5aIzLwarZZb5zmG+pya5TLVtDYUi1lZZzdn1o54earStFrhuzfbxg6EO75HepoU
         IeikunnUXMTZtpxQwXlF4AJilnl4rjMeSIxFsOvEIyDg9CXFP4G3YnsLLeY9NCPIzLKs
         Vi+w==
X-Gm-Message-State: AGRZ1gLEtOfOV4TNm6kUf9KEDmC5tq5I++aDeQV9hASFhY5THjekGYYr
        ysPjdhWEIWb/o7q2PZwv+iDbntm0rK4=
X-Google-Smtp-Source: AJdET5d4VbIt8hkP/ABeekNrU+x7QB0c3twS/BUsDyzKbfpXkG+h39Mcfh639kja1B2fJWZIBPcx6g==
X-Received: by 2002:a67:4d4f:: with SMTP id a76mr1157054vsb.167.1542736677511;
        Tue, 20 Nov 2018 09:57:57 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id c24sm6790654uao.17.2018.11.20.09.57.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:57:55 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id g68so1604578vsd.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 09:57:54 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr1287830vsc.149.1542736673729;
 Tue, 20 Nov 2018 09:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-5-dianders@chromium.org>
In-Reply-To: <20181120002654.1891-5-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 09:57:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UaQGt53iN-1satgEcTAQocwCXXaSL_BvtcMOoEJNDSEg@mail.gmail.com>
Message-ID: <CAD=FV=UaQGt53iN-1satgEcTAQocwCXXaSL_BvtcMOoEJNDSEg@mail.gmail.com>
Subject: Re: [PATCH 5/7] regulator: core: add enable_count for consumers to
 debug fs
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 4:27 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Now that consumers all keep track of their own enable count, let's add
> it into the regulator_summary.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/regulator/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

For breadcrumbs, this patch is now squashed into ("[PATCH v2 1/2]
regulator: core: Only count load for enabled consumers") AKA
<https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org>

-Doug
