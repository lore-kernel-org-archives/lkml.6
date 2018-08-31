Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF60120839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BkSA/of5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF60120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHaEy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:54:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36685 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaEy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:54:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so4673584pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=QtmUSTioJfPRDth94DgM8bgtGACSeezblmDSI5Y8oFs=;
        b=BkSA/of5vBIrc6RmgbFI7lkLdj7rf8zFxGdiTyJ9QMV/tFWWY9WWVRvPuLVFmP9kPS
         sWF/CHsTrVSxUV2vm5RdQ+kEcsRIS48yHvPy/HszkKkEDo9jVBMF6iau+6CTuimSudOB
         cmhh3WJ1JF0nPKKg5vsoG95DkreOtHGDynsqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=QtmUSTioJfPRDth94DgM8bgtGACSeezblmDSI5Y8oFs=;
        b=F4z9mqj85EGOC1T0T5U93dugyoydNr5xeFRUpsHIJPR7W7iJ69teFDYOY6QyNW0wbC
         FJrt7QXCCHPz0T3kPYuQGu6nyK5aZnRIqTXZzHn2oan4mW0JtvOfHQzGj22OOEb5eDXa
         3UWu5h1sTzFinDZr+UYzH26/fx6F1QrATUq+NtzNEBWdPlnKiMNqOZRRinE36O+kYc2d
         qKsHE9Go6vBfdlj6s35XD+W24YuRdfTPs0uLqSqiE4Uq+MsHXWPmgf740Y89aOVcwx65
         712fy5XflIwTYLZ9wZmBUpRfxxftcxttPu/UTx7cV6SKRuRqCglsOm/0QF1WBQBvwRUf
         8eQg==
X-Gm-Message-State: APzg51CEbeH7MIM4Pf2YBEq4T5sCyszJcg/TAE+9e05oZH3HDV2DZvF3
        P0VgX5Dwxvb52E5gsEypyRDWKNDq/dI=
X-Google-Smtp-Source: ANB0VdbQh3e9qbVsTd2Pqn0R5PqY+gct58qgx6wvsWIlAt7GangnB2Stw4TucP/dhmyXy6l1f6Cpqw==
X-Received: by 2002:aa7:831b:: with SMTP id t27-v6mr13009992pfm.81.1535676577606;
        Thu, 30 Aug 2018 17:49:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 203-v6sm11979391pgb.14.2018.08.30.17.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 17:49:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mka@chromium.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Cc:     Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Message-ID: <153567657639.93865.10810620274753191329@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date:   Thu, 30 Aug 2018 17:49:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dilip Kota (2018-08-24 03:42:15)
> +
> +static int __maybe_unused spi_geni_suspend(struct device *dev)
> +{
> +       if (!pm_runtime_status_suspended(dev))
> +               return -EBUSY;

This looks odd. Why are we doing this? The i2c driver had a recent fix
from Evan squashed in that removed this logic so that suspend wouldn't
be called twice. Can this driver support the direct_complete PM
mechanism instead? Maybe that works to make this check unnecessary and
also allows us to avoid suspending subdevices and resuming on system
resume? It would be good if the i2c/uart/spi drivers could all agree on
how to handle this.

> +       return 0;
> +}
> +
> +static const struct dev_pm_ops spi_geni_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
> +                                       spi_geni_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, NULL)
> +};
> +

