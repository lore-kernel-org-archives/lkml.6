Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621E920658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KaLdsozt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621E920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeHVVEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:04:20 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37794 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeHVVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:04:20 -0400
Received: by mail-ua1-f68.google.com with SMTP id y10-v6so1560247uao.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ks07jzVj/xpLWkbzR2B5nmIx+2mXHIiPNVmKk1opz/M=;
        b=KaLdsozteGPu025lBHBAQc3d211npcsvQ7x/sveG5dJx7jUzN8v0dAb817HEESUrb0
         1xcglwDVSQVsqgMTfC17zQUyZjfnSWCHCeiig5RcHSU2JUS0bABTpGODFvjMAXl3j8en
         ciMPjwog6grxb4I7/7v3il8NkTyWbuPDmdmiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ks07jzVj/xpLWkbzR2B5nmIx+2mXHIiPNVmKk1opz/M=;
        b=rqV1YmMJg9KUoaQregXvYh+TvQbl5xikKTP+m+20ZIPYR7+nJ/Puc0Va9AhHStNnMF
         2ODJro6fUOX1ZxW/0rFv/GtMuosRsXXpP/2lnjf3VX39I+dD+X8AzEVKOZ4uHRAlwD+F
         irjJlC8KJiwOMMEakZmgLa558Mo9yKLvs+y5LXesI/OqePdPpHvL5GxOAkjE8Cr7ce5s
         PPG0F3RKXEjYYwBSLCEovgb+2bvDnY+lv6Ge0X4Bxlm2To+vxYtDJkY3Qna3cyjvB8R+
         +BQNU8QEhuNcbSuQbl4BgWCoEQ03IbdpgAlXf2xhEgOEZ9z7UfuixKDD6U86zao7euek
         pRhw==
X-Gm-Message-State: AOUpUlHctTz2114eymSiSmxG+uhn0orXK6pMeE6OhWoLk4micExxupRy
        Wy4Hx6lgqzm9NU11gV/NsIonUKeXcv4=
X-Google-Smtp-Source: AA+uWPym5nASf0RSsCLTd/wrIEceTvYerMdZRkRauDtMSn5ayVDvTyJb1+5uZYYOecl39T+CxnuHHw==
X-Received: by 2002:ab0:a25:: with SMTP id q37-v6mr36989650uah.22.1534959510841;
        Wed, 22 Aug 2018 10:38:30 -0700 (PDT)
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com. [209.85.213.51])
        by smtp.gmail.com with ESMTPSA id j11-v6sm933399uah.46.2018.08.22.10.38.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:38:29 -0700 (PDT)
Received: by mail-vk0-f51.google.com with SMTP id b14-v6so1267902vke.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:38:29 -0700 (PDT)
X-Received: by 2002:a1f:c541:: with SMTP id v62-v6mr34668794vkf.99.1534959508960;
 Wed, 22 Aug 2018 10:38:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:1f05:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 10:38:28
 -0700 (PDT)
In-Reply-To: <153478912722.28926.1278085207557745493@swboyd.mtv.corp.google.com>
References: <20180810215150.82490-1-dianders@chromium.org> <20180810215150.82490-3-dianders@chromium.org>
 <153478912722.28926.1278085207557745493@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Aug 2018 10:38:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VY-n2maPD6Pyy-XQqppPrTnN2yM9SxsFEhmY0FZ9U8mg@mail.gmail.com>
Message-ID: <CAD=FV=VY-n2maPD6Pyy-XQqppPrTnN2yM9SxsFEhmY0FZ9U8mg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 20, 2018 at 11:18 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Douglas Anderson (2018-08-10 14:51:49)
>> @@ -20,6 +21,450 @@
>>         chosen {
>>                 stdout-path = "serial0:115200n8";
>>         };
>> +
>> +       vph_pwr: vph-pwr-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vph_pwr";
>> +               regulator-min-microvolt = <3700000>;
>> +               regulator-max-microvolt = <3700000>;
>> +       };
>> +
>> +       /*
>> +        * Apparently RPMh does not provide support for PM8998 S4 because it
>> +        * is always-on; model it as a fixed regulator.
>> +        */
>> +       vreg_s4a_1p8: pm8998-smps4 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vreg_s4a_1p8";
>> +
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <1800000>;
>> +
>> +               regulator-always-on;
>> +               regulator-boot-on;
>
> Can vin be vph_pwr? That would properly model this.

Yes, good suggestion.  Fixed in v3.

-Doug
