Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEACECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CAE21529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4ZK2q1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CAE21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbeITVW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:22:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40801 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbeITVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:22:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so4526231plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=5/KWV0UhE3ah6E+5zqHvE/6RmABQAWsrEzCkgy83pP0=;
        b=f4ZK2q1T3ANflH1w54H+UYFiO2qohNnAad5Um1IpjRH2WH6ynYcxYwsNVRcKxGcQtR
         1Tr4Zi4/ohPprilscnWObkK/xhMYsPBWcToVlDCWJ/uATFK96acrf2EDndeL8hRIIneR
         fztYv/X9d/CS6DSLVLxLuMrPasDlYpQbuudIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=5/KWV0UhE3ah6E+5zqHvE/6RmABQAWsrEzCkgy83pP0=;
        b=e4ZXZTTURseUr60mLVqXtjz4JPMVNsqP7Ea0uSOT8zOxw9IcdL8+vDta8JjHY726ZH
         1EqQrFhN11qBFe2ar95Xm2lep3kiPOFb2yge+7aLtKQQqv1UQL1ocxT2v2oYwwtFxAbt
         Ml3N1PpDLm9u2HXMNGWZztLSCQBmJNstvgPr+4QU3BjKldT8oqaF6swdVb9N2kYdq8i8
         +pztGbPklE2PrSKK8mqwR9HPRgdC5MIVHSdCo/uvC/AfQbSPzgi2B/e/y1HKpHoWdBcZ
         vPqg6zkHua8BE/i74EHn3Sje+yf+GH/+ARMIiMg34ZP8taMj06suYv2/B4g7FdkL+Sw4
         lHJw==
X-Gm-Message-State: APzg51A+jBacg5PK8oaI4ptAZrmI8wvQFOT0/OVfZ17fzASev0MjSNfM
        1HC3GjGO4ZsqlRpIUpbm811tQg==
X-Google-Smtp-Source: ANB0VdaKORNeyRjQQpneGIjM6yBwY6K+myAqqZENSBKwEvkJCyMEbbiqqj7nl7G2+Bxhc3SW63EuVg==
X-Received: by 2002:a17:902:b089:: with SMTP id p9-v6mr39964670plr.254.1537457934432;
        Thu, 20 Sep 2018 08:38:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 6-v6sm40351883pfs.58.2018.09.20.08.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 08:38:53 -0700 (PDT)
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
In-Reply-To: <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
Cc:     Dilip Kota <dkota@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-2-git-send-email-dkota@codeaurora.org>
Message-ID: <153745793237.119890.13694179827956631445@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V4 1/4] dt-bindings: soc: qcom: Remove SPI controller maximum
 frequency binding
Date:   Thu, 20 Sep 2018 08:38:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dilip Kota (2018-09-18 11:07:23)
> SPI controller driver should maintain the maximum frequency
> of the controller instead of relying on device tree bindings.
> Because maximum frequency is specific property of SPI
> controller.
> =

> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

