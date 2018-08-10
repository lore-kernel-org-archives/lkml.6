Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65B223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7t6yUoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65B223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHKBCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:02:05 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34096 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeHKBCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:02:05 -0400
Received: by mail-ua1-f65.google.com with SMTP id r15-v6so3529964uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QC01R1ba0LEhnfvwAhC+XZJpVzD5SmFFIb2mvMqLbEA=;
        b=m7t6yUoL7irq6K+n8Z91uHaxYs5FX+hPrZPhpuseZ7oAlsId9KI/8cDYtaIItiDVo5
         qs9QXuOdVU2IAkl50rsb8ZkBmaAoDfiyyIH7NetvDO/07qjpvZDlQbidzXAs5USb67D9
         6wm2eY7nHGHXkFksOGsaCp4iLt1ekic0M+Eok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QC01R1ba0LEhnfvwAhC+XZJpVzD5SmFFIb2mvMqLbEA=;
        b=OPBr8G+fG9ZfYTNf+gaL2mzeQsFw+VcDcDkNUc/HtK+7PyKEHxm9mIsYGO+cwm6Mxz
         WP+izJf10HDJbLy7kfjAaGWbrP/W1IyDORFU2sck3BaRRMM1T9o0qWhVJN+yLQaIvMgg
         HIqx7lyAPKgW7x9+I7TDcSOd6fv9oLWCZTV/K/WQDymFZHwRQR0Vo+9Skmohi04EeiQU
         +sAfrvrziMxWgPzhhyOsT5tzChRrVWo/jA/VhB+l5PUEQU74ULNJIQRTGkJQS5LnwHEk
         HFLNvt63/aOcIoZXFs0kV8uvLCzyZL8YMUkWQQFOUDEVT4lqGiFufXAvhGuWRxS5ltIR
         RjUA==
X-Gm-Message-State: AOUpUlE0nZQqi7LrmZ61twSuFuiktm5q1wLux96RZVKWSxxFRuXq+aFE
        CQDF0IDoMapc4RwpdyVP0fn7kyZB1yY=
X-Google-Smtp-Source: AA+uWPzaFp+t8ybf7dYo4URL49pO4Rzud9xnLdG/q565h1TgD0hiwZp8Gw8CcTo3mUc2jgpoFqy/pA==
X-Received: by 2002:a1f:a6cf:: with SMTP id p198-v6mr5226597vke.148.1533940215293;
        Fri, 10 Aug 2018 15:30:15 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id r138-v6sm3195706vke.35.2018.08.10.15.30.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:30:14 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id f4-v6so3544470uao.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 15:30:14 -0700 (PDT)
X-Received: by 2002:a1f:3653:: with SMTP id d80-v6mr5278470vka.79.1533940213587;
 Fri, 10 Aug 2018 15:30:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 15:30:12 -0700 (PDT)
In-Reply-To: <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org> <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Aug 2018 15:30:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
Message-ID: <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, sricharan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 3:18 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Add device node for arm,mmu-500 available on sdm845.
>> This MMU-500 with single TCU and multiple TBU architecture
>> is shared among all the peripherals except gpu on sdm845.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index 6d651f314193..13b50dff440f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -58,3 +58,7 @@
>>                 bias-pull-up;
>>         };
>>  };
>> +
>> +&apps_smmu {
>> +       status = "okay";
>> +};
>
> When you spin this patch please put the above in the correct place.
> Since "a" sorts alphabetically before "i" then this should be just
> before the line:
>
> &i2c10 {

Sorry--one more thing I thought of after I sent this out...

Possibly you can drop this part of the patch completely and get rid of
the 'status = "disabled";' in sdm845.dtsi.  As I understand it you
really only want to mark things as disabled in the SoC dtsi file if
some boards might use this device and other boards wouldn't.  For
instance not all boards will have the SD card controller hooked up /
enabled so having that set to "disabled" in the SoC device tree file
makes sense.  ...but it's not a board-level question about whether the
SMMU is present--it's always there.  You don't gain anything by
forcing all boards to set status to "okay".


-Doug
