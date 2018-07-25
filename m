Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C4BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F80D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NZ/kLbVJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpooiTmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F80D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeGZAf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:35:26 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38802 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbeGZAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:35:26 -0400
Received: by mail-vk0-f65.google.com with SMTP id k82-v6so4647781vkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QWbEh4P/wPHjv5e/Ij0sIRzK9gmOkaO7jpB9b+pGH9M=;
        b=NZ/kLbVJhlXpPM4zWDLl964pt3eyn2QH5o02u/H5F/U69JrlE2ARvQwQu4zetFc/lh
         mMrVAuhZ43yK5ua5WGLvbfLXhHk8A1KIG9vpYrDbd6/ubKikNClg9iIVae02sZHQxdXu
         ++jypt+I32YlvmlQvVkaMW4KQWOUKhdap8d1hvq3m5cx840wcpn3Tch7jjC5wnklhB4j
         Aa3rd49BE3oY4i/t1mbmplYzYVzNvGuiNuQiHzftHYfIC/MitajwSDSO5rnXEZj6b0AR
         Ke2Xo3VLnKkpUkHIosr1gLYrWeazTiU4AHV02xaxEs9kcSJgK8SC+K8qTqCg3MZ5g32f
         YcLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QWbEh4P/wPHjv5e/Ij0sIRzK9gmOkaO7jpB9b+pGH9M=;
        b=LpooiTmXYmLxokZOS4qjDZ8qsNtD8H+oG1Q/lr7KE4jd9a6NfO/NvWt0WKYukhL5b1
         gfZe7oUbbUeUlTjJ0jepBYm1tx4DMV9byutKnn5sKF4WQgJqyt5yQnUrgJoltw7spM0m
         azhdmDYc/ZeFvUWPh7Hnm+t/QoCgb0SxChEug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QWbEh4P/wPHjv5e/Ij0sIRzK9gmOkaO7jpB9b+pGH9M=;
        b=j9a1M4EV1pmLv5h6bdplx6AohkOWZWJgWaBJgh9/+v6Y5QmF795tGSChonXUvAInDp
         +IPwBGoQV6qFMPbH6wM4aF5ZJb03lQsc3XD7hb0g+O5smKZ0aVklQPeHqNjzfHcQ2uej
         4OBCWRYKw9OXs6COu6bd67hUpduuBQV0AbE/nexLsR4+LDg/mvSPZ4Jhsm6KHBKUcB4F
         AD37uUgzJs95cv5KrFx9i1q+Pp9Ktmwsvx0mRoilh4VGc4yYTYEWlCRaLn8ON18xj13V
         Pewr5e32RwFGZi6sz2TZdsjKHFvvWejPwHWAcmL5x5qKLiWDo5LIOODfJdPEB5vrg/NF
         Wdcw==
X-Gm-Message-State: AOUpUlHX6X32CM9zDrHBnDIwfZH3OeRMrRK0ufJRvD/qAEN+jC1b9zz+
        l6vD3Rzdx3L/kkvYEfMIn4ShShzmORK9aZj+LxeMcQ==
X-Google-Smtp-Source: AAOMgpc2XAyq30C/9nuC7/Si2QzeeYP6+Y1g6HYXzAbFq2xnqABPkusMzBJauGs9Kv4Y4q0nk4hxgvKilj9GXnc/X7w=
X-Received: by 2002:a1f:a784:: with SMTP id q126-v6mr14902571vke.70.1532560888983;
 Wed, 25 Jul 2018 16:21:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 16:21:28 -0700 (PDT)
In-Reply-To: <20180724234636.57137-3-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org> <20180724234636.57137-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Jul 2018 16:21:28 -0700
X-Google-Sender-Auth: X-U7ngNcLScjOiVHgafNQpImqqE
Message-ID: <CAD=FV=UATTxDxjtL7keOV9RDcPaT00+D8VXMFFaUixeKopJnmg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> The thermal zone uses spmi-temp-alarm as sensor, the trip points
> correspond to the PMIC thermal stages 1 and 2. The critical trip
> point at 125=C2=B0C disables the partial PMIC shutdown at stage 2.
>
> Without an IIO input the sensor only reports a limited number of
> temperatures:
>
> - 37=C2=B0C for temperatures below 105=C2=B0C
> - 107=C2=B0C for temperatures >=3D 105=C2=B0C and < 125=C2=B0C
> - 127=C2=B0C for temperatures >=3D 125=C2=B0C
>
> (the numbers correspond to a stage 1 threshold of 105=C2=B0C)
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v5:
> - removed 'stage2-shutdown-disabled' property from spmi-temp-alarm
> - updated commit message
>
> Changes in v4:
> - updated trip point temperatures to match stage 1 and 2 ones
> - disabled stage 2 shutdown
> - updated commit message
>
> Changes in v3:
> - moved 'thermal-zones' node to the beginning of the .dtsi
>
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105=C2=B0C hardware trip point as critical trip point
> - reduced number of trip points to 2
> - lowered temperature of passive trip point
> - updated trip point names and added labels
> - updated commit message
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Looks great!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
