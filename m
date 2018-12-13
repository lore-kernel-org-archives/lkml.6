Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19816C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8civZMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeLMWFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:05:32 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33185 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:05:32 -0500
Received: by mail-vk1-f194.google.com with SMTP id d201so835423vka.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeZKUHeZsRXeocXkkjnJ+EGX0Nlp4kQwGd/Re4z+QPw=;
        b=i8civZMh6J3Vq5lpx/ADXFdxBi8QCWsdVjd/TEhmKsNEyjucYP0bWz+N78b+6Mamu/
         NKEULhNEcS8Ltyi+fkis1jT1hKeuJKAldvXWRf1z8+F4rs5LpN/Oc4Y05Le68T8HiH4S
         OgEiChO7fnJ4iXBfgYZ20tT1SxHeWbwipZhys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeZKUHeZsRXeocXkkjnJ+EGX0Nlp4kQwGd/Re4z+QPw=;
        b=GqXmHcocuPkDu4ZvfSX9oNR6gflj3JhgAjyppZRQsLe6lzxgmqCv5hFvD06DBseP0R
         F9CM7jEyDnYs8M0KY6PqSrKaXsOhJ4O33ISXirWvMExgSWf/Sq7ocBqaS4hC0DJgqqkd
         4IkYtdtGwwkPpvsezIqaeOlrLPwWUa1bqswz5K5Ksf1KyV8HluZ3rk9lrDxuhWjrAZx8
         e+3L+0ALDtT7fwZ5cyPiKwMJHkl4qE3VAtqOi0aS7XmgD7pssKurjOtDMjV2kHD5pwwe
         fdobSBeKobgDSMawTwSMGLI5mMuejF78c0LArBAudBtnWrYU36jeEBoLjkniwieY/SJv
         /zfg==
X-Gm-Message-State: AA+aEWZztmrmTwrJzCx7PuFNz4qgPs4ZT80qcO+65NwZYIXQae6+fEf3
        XJbPDgu6tMNNBoVQqDcxMKdV7ZudXWY=
X-Google-Smtp-Source: AFSGD/Vb1V8PLP1Lyt/IgO99dHVw3F51oc0Lh9/U28cT1f0k6eykY8Qv3hn5F+QvvkTzpIrBE/VpJA==
X-Received: by 2002:a1f:2542:: with SMTP id l63mr234835vkl.81.1544738730717;
        Thu, 13 Dec 2018 14:05:30 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id w20sm2714104vsh.2.2018.12.13.14.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 14:05:30 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id n10so2147031vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:05:30 -0800 (PST)
X-Received: by 2002:a67:dd11:: with SMTP id y17mr256765vsj.111.1544738729733;
 Thu, 13 Dec 2018 14:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20181120210828.12590-1-sibis@codeaurora.org>
In-Reply-To: <20181120210828.12590-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Dec 2018 14:05:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WC7UQnNsbqwevhxML2Xmq3z4c7uiJ8ddn4tE2H3zAHZg@mail.gmail.com>
Message-ID: <CAD=FV=WC7UQnNsbqwevhxML2Xmq3z4c7uiJ8ddn4tE2H3zAHZg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: Add power-domain bindings
 for Q6V5
To:     sibis@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Ohad Ben Cohen <ohad@wizery.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 1:08 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 14947562bc67..bd9f4882fcf0 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -75,6 +75,17 @@ on the Qualcomm Hexagon core.
>         Definition: reference to the regulators to be held on behalf of the
>                     booting of the Hexagon core
>
> +- power-domains:
> +       Usage: required

Assuming I understand correctly, presumably you want to say that it's
required to list _either_ power-domains or supplies.  Right now you
have the bindings saying that you need both regulators and
power-domains on all boards.


> +       Value type: <phandle>
> +       Definition: reference to the cx, mx and mss power-domains to be held on
> +                   behalf of the booting the Hexagon core
> +
> +- power-domain-names:
> +       Usage: required
> +       Value type: <stringlist>
> +       Definition: must be "cx", "mx", "mss"

Comparing to the patch you posted at
<https://lkml.kernel.org/r/20181127085828.17908-1-sibis@codeaurora.org>,
it seems like maybe you also need "aop" listed here?



-Doug
