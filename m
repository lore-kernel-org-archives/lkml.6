Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F909ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC2921479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXcVpSOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC2921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbeIVB6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:58:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37871 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391371AbeIVB6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:58:02 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so12980360ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7EpUvi+T8MrC31QM6OhDhjM/N/cghP7Ph1PgseG1nBA=;
        b=NXcVpSOuM+pvgWh9lIYATmUVDlWQjzIz+3RBgRNJTzaS21XKmyVwT5Ww6cbb3lDhRP
         iz0o3+CgukZNorjUNf1sPYBzlnbCfJTBkaQ7gXB4wmZthZW//WQvX91iXzHGoQTxjsC2
         VbJOiJNX9vmTKxgHGPdBeoTn+LEq2tjEFbzVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7EpUvi+T8MrC31QM6OhDhjM/N/cghP7Ph1PgseG1nBA=;
        b=rMGI3FePEZMBgqwwMFEgY0RrSE8ExBGPhL9LuFDFIwqqT3DGrZ5DWEP0+WwoQRxV02
         18vSOHiFP4OipPkFyCJj+vyBcaQheSNoEAyT+cyR8fJIjoV1BTisxiK8y4Ypbvl1C4As
         mSBoiQKuM9ShUyvpfqLNa1WBIn/Yi8HtwawVm/ZkAPyeUBWMsXlCD6th1nsQeQl188p3
         nMMllOKbuY5VpCPUxKT0cAERQni3RAC5qH8pFKAsrxT6H4R56PKcMNFnlMAjv9V2Wrkm
         AFB+fO2M/zLBb7+acziSjrrs446rggNoA+C7R2deiDssts197EyEdv//S7Yz/64nXePS
         qstw==
X-Gm-Message-State: APzg51D3FQwswwWRmnnLIJRtRp/XrGCvxY2OcyjOUdgnxXoPhfZb4NVM
        /ZPtdIeO/QyUA0+7U0wxX2NqdC3qRnY=
X-Google-Smtp-Source: ANB0VdZVUTNy29/9pjZMcyWSffZdeb+QzXNp+3H4Nkip+aTbj7ANLTR0XFxgenKFTHmX9B4LuBcw7A==
X-Received: by 2002:a2e:9057:: with SMTP id n23-v6mr3595630ljg.44.1537560455220;
        Fri, 21 Sep 2018 13:07:35 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id i86-v6sm2453157lfb.67.2018.09.21.13.07.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:07:33 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y17-v6so12963921ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:07:32 -0700 (PDT)
X-Received: by 2002:a2e:5554:: with SMTP id j81-v6mr780096ljb.53.1537560451968;
 Fri, 21 Sep 2018 13:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org>
 <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com> <8f26b82c-b966-11d3-4fb6-0137a0a8cd4a@codeaurora.org>
In-Reply-To: <8f26b82c-b966-11d3-4fb6-0137a0a8cd4a@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 21 Sep 2018 13:06:54 -0700
X-Gmail-Original-Message-ID: <CAE=gft52RWSibZRPukRX_L7ACOSUnqHc0FbsoCSvzAr=My-1kA@mail.gmail.com>
Message-ID: <CAE=gft52RWSibZRPukRX_L7ACOSUnqHc0FbsoCSvzAr=My-1kA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 3:32 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Hi Evan,
>
>
> On 9/21/2018 5:45 AM, Evan Green wrote:
> > On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> >> From: Vijay Viswanath <vviswana@codeaurora.org>
> >>
> >> The load a particular sdhc controller should request from a regulator
> >> is device specific and hence each device should individually vote for
> >> the required load.
> >>
> >> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> >> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> ---
> >>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> index 502b3b8..3720385 100644
> >> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> >> @@ -26,6 +26,11 @@ Required properties:
> >>          "cal"   - reference clock for RCLK delay calibration (optional)
> >>          "sleep" - sleep clock for RCLK delay calibration (optional)
> >>
> >> +Optional properties:
> >> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
> >> +                                       BUS_OFF states in power irq. Should be specified in
> >> +                                       pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> >> +                                       Units uA.
> >>   Example:
> >>
> >>          sdhc_1: sdhci@f9824900 {
> >> @@ -37,6 +42,7 @@ Example:
> >>
> >>                  vmmc-supply = <&pm8941_l20>;
> >>                  vqmmc-supply = <&pm8941_s3>;
> >> +               qcom,vqmmc-current-level-microamp = <200 22000>;
> >>
> >>                  pinctrl-names = "default";
> >>                  pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
> >> --
> >> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
> >>
> > Aren't the regulator load levels pretty coarse? Would it be safe to
> > say that pretty much all sd/mmc devices need the high powered mode, or
> > are there really some devices that can get by with LPM all the time?
> > -Evan
> The load levels here are min and max supported by the regulator. To
> cover all devices
> we do set it to max load. We can't make any assumptions on this,  as
> peak current may vary
> from device to device.

Hi Veera,
If it were up to me, I would just assume all devices need high power
mode for BUS_ON and low power mode for BUS_OFF, and skip adding this
binding until you actually came up with a device that needed lower
power mode for BUS_ON, or high power mode for BUS_OFF (when would that
be, anyway?) Are there any actual use cases you've seen that need
different values in here?
-Evan
