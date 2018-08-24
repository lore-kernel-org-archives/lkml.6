Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4061AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3444208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGfn9e/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3444208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeHXTs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:48:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39067 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHXTs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:48:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so4755971pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=PPE6Zxv/FDDaxTVGwSy1NgBMRQCXOg9I+/o9ERtEu6M=;
        b=JGfn9e/H6p53ZHueAVx2IDkAZBsIzNX43T704PkRi+2kNw26IN/AVZIGlubbrExZAM
         EfoGko9I8HRcGAZqvBArpngBscSUK/bHeYALOHTSrSPQ3quXwqzxioHJZMIlqO2YMW2z
         eL8c+lBcIgB5pgjnoJspgP5iMlBrqIgkUf1Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=PPE6Zxv/FDDaxTVGwSy1NgBMRQCXOg9I+/o9ERtEu6M=;
        b=mXMum2PqCaIsSmgsYVt+YNcs0xaOEpJKb4I+X5fYCfNGsmYvX9m6ELbVbn3Afbe043
         7oUOKHcqRkGBsaL9bgktui96tBHhzpHRnzoZH7ZwX3sSQZPwERlSEnysQ/ROmgNl5QRk
         7N1PacGuq6RRklvmuc4MAKAdcsG0QRsje6TZKItOkNLUlFFeVeNFh2yMudDXl+sCEMWz
         vRGEe04o2bl3vk61axCCYL9tPUUknS1Trl2rqIJFxT2GjeI35jG0+CqeH5o/dEHM04qq
         raPRl7YZpySEPpjqDpTYhizs5jlpSoPdu2COnuk118LZb/TfM4Llo3QQCtVhj4EJF1f9
         45xg==
X-Gm-Message-State: APzg51CFSVojiNdXfvIN+OPZJGDvmolMqfqOEWpIwml52v7JR8NScVG+
        vhN3EQJGC8TdblgSYxlahJWmUw==
X-Google-Smtp-Source: ANB0VdYyHENAUxrgCnGUFNxVEgyWOUdBH+wXwFAy9eIRnQCRxyd/RBHIy4Gn+IvwpBR4h02AwAUHYQ==
X-Received: by 2002:a62:2459:: with SMTP id r86-v6mr2680122pfj.31.1535127218793;
        Fri, 24 Aug 2018 09:13:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id v20-v6sm15379800pfk.12.2018.08.24.09.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 09:13:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180822173629.202885-4-dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, tfiga@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-4-dianders@chromium.org>
Message-ID: <153512721757.28926.8065711677671939620@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845-mtp: Add nodes for USB
Date:   Fri, 24 Aug 2018 09:13:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-22 10:36:29)
> Set the various nodes to "okay" and hook up the regulators.
> =

> NOTE: For now the main USB port (the one that goes out the Type C
> connector) is forced to host.  Eventually someone will need to get the
> Type C detection hooked up and get this all integrated with the
> PMI8998 PMIC.  The reason for forcing to "host" in the meantime is
> that this will leave us with one "host" and one "peripheral" port.
> =

> In order for host mode this to work, we assume that the bootloader
> left things configured enough for us.  Apparently the magic for that
> is is to do these writes on pmi8998:
> - pm_comm_write_byte(2, 0x1153, 0x2C, 0);
> - pm_comm_write_byte(2, 0x1152, 0x07, 0);
> - pm_comm_write_byte(2, 0x1140, 0x00, 0);
> - pm_comm_write_byte(2, 0x1140, 0x01, 0);
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

