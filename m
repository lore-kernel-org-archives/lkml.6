Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEC1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E3420854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="WV3k9bsM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjZyFJLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E3420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeGUUJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:09:49 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42621 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbeGUUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:09:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so26860227oib.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IMFNHJpDL2DshnWzpv0pGrmTVRS9jq/JLdlJbBy/+PQ=;
        b=WV3k9bsMwPQH5EdqrtQYIXCpoj6xSXlOW/7VvZKxZgYQV68PZfmhW5PJRGdufsE8tA
         ErFJlo77iVR0l4FSyOEoc2o1ik6YhX8dUZYiEHBP4N5SK6X94vzpth/m3MEX9h+9YXb3
         ZknGXDiq5b9ukCXgqdrMXbgZLW6F5QjKKlG6ktAO4Vl25/HoKeSqaJ3joNB3a7bryM23
         wKSf6JcmezDUL+FpplQaUgtY82lcVX5goOW3tfQ4MDjwwOk/d8iINOWdWb9Q+0uBKCQd
         WdJVp91UGjMd+EZ8Jlv+dBH0ucptQIXn2WSD/3qmm/rJbxBRdBZEntowexd4S7wCK7/F
         vTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IMFNHJpDL2DshnWzpv0pGrmTVRS9jq/JLdlJbBy/+PQ=;
        b=TjZyFJLOwPwjvsKRncW2Tb0n90mPBpGuEzBPq2Dql/e/D78r5Ufv4PBHKXixh3R0qA
         ZNCKyQnO6LZAInIV/3uOolZu9M4zpbvZ/0PfnFX539HF2T4dDMdnxSW3n8I3tfbzJ1Oe
         Y9nvM2A4FT0LtyLm3Y6w2Iyl0ex5CTJH8reOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IMFNHJpDL2DshnWzpv0pGrmTVRS9jq/JLdlJbBy/+PQ=;
        b=cMJmydI2FUgQMjGTqgopSKKBGA18LcB6vtthz9L45UZxSnpUcpKKYOEY7I23vdwtx3
         S3+feYO4R3G7qB0S1UDn22DRgrZmvPaqwqmsnPpRR7mXdGi4ZYGfivA77PZJoCE/yfjg
         UNWRD5hCz1ZOD5eUh9wN0IRi9X87q316aTMSGHCsg+45SxOYJAbsUZnHpn4s5vfXdetN
         thgQ6OolbwCZ8w/GcmvGs6Q8pNN2JUqEo7ny3Ew9c/z4Eh1KBwREydJVd9ebBc3l83PE
         DagftLnZ8km76cMd2PPHwxClqwGzpQmPYNopilmuasYVMLs9kNY3O2VhlQYHVURLIlGW
         EIvQ==
X-Gm-Message-State: AOUpUlGi6PvquuZDrpyKULSTgoMOPjF77EloOPf6rKQM+ywRvRwjT92B
        Jiz1uM42wfupQvySAIrjxtwZjePdczKdhwub8jcM31n9
X-Google-Smtp-Source: AAOMgpedlceDsBuePcZTO/MnkS2ss1TGrpC1Hs3RIdY8Ci/vfk/gTH/4UozvlNoqEemj/Ee97ybtaidLFAYxOa4izU8=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr2683449oie.68.1532200560779;
 Sat, 21 Jul 2018 12:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 12:16:00
 -0700 (PDT)
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sun, 22 Jul 2018 00:46:00 +0530
X-Google-Sender-Auth: N65xZxHul8CQV2-BjnFbuTzMJ_8
Message-ID: <CAHLCerNubEr0bV8a4pyTQ6cQcKjR5wRq34Vgoe=eagi1L0EmPQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] thermal: tsens: Refactoring for TSENSv2 IP
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Eduardo: Please consider this a gentle ping to understand how
this will get merged.

Andy, I guess you'll take the DT patches 2,4 and 7 and the rest will
go through Eduardo's thermal tree?

Regards,
Amit

On Wed, Jul 18, 2018 at 12:13 PM, Amit Kucheria
<amit.kucheria@linaro.org> wrote:
> Here is a repost of the series. There have been no code changes since v6,
> just improving comments, patch descriptions, documentation. The series does
> the following:
> - Some code moves to allow code sharing between different SoCs with v2 of
>   the TSENS IP,
> - a generic qcom,tsens-v2 property as a fallback compatible for all v2.x.y
>   platforms,
> - new platform support (sdm845)
> - a cleanup patch and
> - a DT change to have a common way to deal with the SROT and TM registers
>   despite slightly different features across the IP family and different
>   register offsets.
>
> Changes since v7:
> - Fix couple of typos in spelling
> - Add review tags
> - Move the DT documentation patch before the code changes
>
> Changes since v6:
> - Fix comments and patch descriptions as per Doug's review
> - Rename tsens to thermal-sensor in DT
> - Add various review tags
>
> Changes since v5:
> - Actually fix unit addressses for the two tsens blocks as per Stephen's
>   comment.
>
> Changes since v4:
> - Revert back to a single fallback bindind qcom,tsens-v2 as per Rob's
>   suggestion.
> - Rework how old (unsplit SROT and TM address space) DTs are handled by
>   needing a 0x1000 offset but still sharing common code in tsens-v2.c
> - Remove the patch to added TRDY checks while we investigate Matthias'
>   reports
> - Fix unit addressses for the two tsens blocks as per Stephen's comment.
>
> Changes since v3:
> - Introduce qcom,tsens-v2.4.0 property and make qcom,tsens-v2 a
>   fallback, compatible property.
> - Rename ops_v2 to ops_generic_v2
>
> Changes since v2:
>
> - Based on review, moved tsens-8996.c to tsens-v2.c and changed
>   corresponding function names, struct names to allow for generic tsensv2
>   platforms
> - All v2 platforms will now only need to use the qcom,tsen-v2
>   property
> - Added a DT patch to initialize tsens driver on sdm845, now that
>   4.18-rc1 will contain an sdm845.dtsi
>
> Changes since v1:
> - Move get_temp() from tsens-8996 to tsens-common and rename
> - Change 8996 DT entry to allow init_common() to work across
>   sdm845 and 8996 due to different offsets
>
> Amit Kucheria (7):
>   thermal: tsens: Get rid of unused fields in structure
>   dt: thermal: tsens: Document the fallback DT property for v2 of TSENS
>     IP
>   thermal: tsens: Add support to split up register address space into
>     two
>   arm64: dts: msm8996: thermal: Initialise via DT and add second
>     controller
>   thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
>   thermal: tsens: Add generic support for TSENS v2 IP
>   arm64: dts: sdm845: Add tsens nodes
>
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 14 ++++++++--
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++++
>  drivers/thermal/qcom/Makefile                      |  2 +-
>  drivers/thermal/qcom/tsens-common.c                | 12 ++++++++
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 32 ++++++++++------------
>  drivers/thermal/qcom/tsens.c                       |  3 ++
>  drivers/thermal/qcom/tsens.h                       |  8 ++++--
>  8 files changed, 88 insertions(+), 30 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (64%)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
