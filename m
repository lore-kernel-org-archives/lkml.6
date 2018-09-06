Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD28C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BA820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVVPg+LE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BA820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeIFW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:28:44 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43590 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeIFW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:28:44 -0400
Received: by mail-ua1-f65.google.com with SMTP id f4-v6so9654209uao.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j0KTUpMbzck7Ek6EJZ6GN1mWsI/9/nrLWHUUGC+8dV8=;
        b=SVVPg+LE4ocHNKU4uB4eOtdu34765KVb2V5vMbm/o+cnlwW6uJlxNOXlCxxERQGxm5
         kloKWbsgK6NgjHLyqYcg+JDXPQ1LqXsEgsCs8xQD1RDr/aU5g7egOZV4L27scwnUGzAg
         xEeKg0dWePb1Ih1xEjZPtWiiJbuciag2k3W3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j0KTUpMbzck7Ek6EJZ6GN1mWsI/9/nrLWHUUGC+8dV8=;
        b=djE2X/+1Rucsy8u45pTxpLwoU0K4tbXOI1TSAetyMQdAvsLW0sCdnWrCa5Rqv0jLxu
         3Sbf2fEhyvP/AzqxJxmPlO0ed9qevW8/BJvagedIWlYZ0SkuUujFt9DBUqoQ8g5rTXSe
         Ohs9l97N3Ft/jHDCs0DPEE+xHfhH9L5UjA76OsZIZoS+qyy0Qgg3k8PkxCWE7gvkf+/l
         5W6pI2jLoVw4imcwyJqvOU8nqaK6W0PR1mzQL3dNrCZr1Fa/VgoghVf9INz0Xd+uNq/N
         Fs3bHN/MiiseCIIvtl8Iz5AHhi1b4KCqhe2GnvXCwpYerJFYrrLdCmroiiyVS4C2N/GL
         FsjQ==
X-Gm-Message-State: APzg51BGJQLaOkhub6vHtU127i6MNSVU93KwXYbo/Isuo7JnE7QMcyOl
        Cu7/kYvF3K6UtAAPdFL0g+WRyVMTxxo=
X-Google-Smtp-Source: ANB0VdYd5isR55dAWStq5aeqw36RLDF1dAJF+gVqCIL5hiXPrT4qRQq71+0CfXUfyVWy/qjT+6j1DQ==
X-Received: by 2002:a67:9814:: with SMTP id a20-v6mr1480333vse.54.1536256328930;
        Thu, 06 Sep 2018 10:52:08 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1222057vkf.34.2018.09.06.10.52.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 10:52:08 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id m11-v6so9634066uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 10:52:07 -0700 (PDT)
X-Received: by 2002:a1f:ac08:: with SMTP id v8-v6mr1318266vke.32.1536256327401;
 Thu, 06 Sep 2018 10:52:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 10:52:06 -0700 (PDT)
In-Reply-To: <20180901221953.21666-1-bjorn.andersson@linaro.org>
References: <20180901221953.21666-1-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 10:52:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VE5gYyivgy=OrZV6g0UrtYfZZ+CGv7DV+v5be3teVSdw@mail.gmail.com>
Message-ID: <CAD=FV=VE5gYyivgy=OrZV6g0UrtYfZZ+CGv7DV+v5be3teVSdw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: pm8998 and pmi8998 regulators
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Sat, Sep 1, 2018 at 3:19 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> Add regulator definitions for pm8998 and pmi8998 regulators on the MTP.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 216 ++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)

I'm curious why you chose to post this instead of reviewing and/or
building upon the patch I sent up at
<https://lkml.kernel.org/r/20180822173629.202885-3-dianders@chromium.org>.
Compared to mine, yours:

* Seems to have a few rails named differently LDO22 is named
"vreg_l22a_2p95" in your DTS but "vreg_l22a_2p85" in mine as one
example.  The schematics I have (from Dec 5, 2017) show it as 2p85.

* Is missing "regulator-initial-mode".  We can debate this if you want.

* Is lacking many alternate names for rails.  We can debate this also
if you want.

* Have a few voltage values different.  If you have better info than
me we should update to yours.  Diffing against yours does make me
believe that perhaps LDO14 should be listed as 1.88 V in my patch.

* Is lacking pm8005.

Anyway, let me know.  If you provide a review of my patch I'm happy to
spin it with your feedback.


Thanks!

-Doug
