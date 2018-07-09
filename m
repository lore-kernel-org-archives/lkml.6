Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925A7C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E1420896
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="EdbbYSZ0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="adTljXDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E1420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeGIL1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:27:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42197 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIL1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:27:31 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so35179262oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+3Dibvkjf6xFMPNQUp+H2c3MyVhrYI4YrvvcpI0pcsc=;
        b=EdbbYSZ09eLDNIMZeFnBd6k8GBtAOhhxByCbOeVFW6SBswCC3BHZq0SrnzT9ZERYuj
         NHXMXmQRCHaeuq8nzxUuH8mayrDd2d99oGZpwEhtjuMfiHbAAH7nehSo6EtsL2M0xmnN
         7ZGr+OlRUYd08DgwkTOo5V4i4ctwWv/6r47mx69yd4uPl7ossUaqTJpcghqgoxXCBpnp
         yyj+Qq6AzI3GGWQMyFF3KaXuC3N8lIYi52lqoddFxlgi14r5/IpX2ic2WL1c/N/Z4w6/
         IEnLoPqE111nochAIzv/QnGlEA04GNizUApMTnJJWdRoAa1x1qOvtc8OI5Ii1KD547zo
         wf1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+3Dibvkjf6xFMPNQUp+H2c3MyVhrYI4YrvvcpI0pcsc=;
        b=adTljXDl4bdX5uQIrtz6IOPMV4zjK4vx1cbm7yI6dqVxGC9oGkPeo4W6uwVZta03Tf
         dDe1ai04tLqfqJmu8LQfOcQbkNOCVTUehx3L6BJG9ZE49mOyFHEHI7iCBEwL/lX8UDfN
         BHGn2ZswKGj0STsHUoMmd+r6eyTHwdIh3KIKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+3Dibvkjf6xFMPNQUp+H2c3MyVhrYI4YrvvcpI0pcsc=;
        b=sA9cdpyLq+/VdKXjdMi7Ujw5+WhRe+dfZzTnzdXLUfxajCBovDcxxqxodPZPPTiDOn
         sZK6ceC2eOz1L+qR5Z1KSV1TMD677dD+rQjHCBUjexriMOEHta0tGZ0JcabHTLavWN0C
         IPzvOzmzD0mN8t3/Vo5VOxATGQV15wDSJQcvhkOn9skc0azQxWY1SLrujelOWA4JBtiD
         obJyzpx5pJ7868iBqyum3cKpBEk/agmjU3wGSIkqTgf2Vlxy/EHuRkyqDS9qzDLF4O/8
         ZN7wkePFb5dY0nAXk7o5T7AiBKFPO6u//OI7JE5V0pbQ7VxKlwSZSyOtbFKtI+uACJIc
         VjDw==
X-Gm-Message-State: APt69E3uglIzvV1c3txxQFMffuFofF30asHWjin8o0/3ANkhbtNTJSnh
        6xIeVbIc7/j4LwWDXomuueZp2PGZ0WFnfXq3z6wfOQ==
X-Google-Smtp-Source: AAOMgpeUqc2YV2WuY9PpU5oQqEayl+hMt1I4vZWo6DP+Tke7o+xoaXIbP7559DAQk8jM+G57YgOlQhyD2a8GoJrodAs=
X-Received: by 2002:aca:b1c1:: with SMTP id a184-v6mr25286786oif.182.1531135650806;
 Mon, 09 Jul 2018 04:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 04:27:29 -0700 (PDT)
In-Reply-To: <153089827550.143105.2506072427444330254@swboyd.mtv.corp.google.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
 <153089827550.143105.2506072427444330254@swboyd.mtv.corp.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 9 Jul 2018 16:57:29 +0530
X-Google-Sender-Auth: vOl4oxl14szmK8aED0LlV-gA-8U
Message-ID: <CAHLCerMDxhFkoK_yXznOi-ZnDskiD0-xtqEb9Pz5MRFTdbx1ew@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>, smohanad@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 11:01 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Amit Kucheria (2018-07-02 05:44:09)
>> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
>> sensors.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index cdaabeb..edf8505 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -221,6 +221,22 @@
>>                         #interrupt-cells = <2>;
>>                 };
>>
>> +               tsens0: tsens@c222000 {
>
> These unit addresses should match the first reg property, not the second
> one.

Fixed in v5. Thanks.

>> +                       compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                       reg = <0xc263000 0x1ff>, /* TM */
>> +                             <0xc222000 0x1ff>; /* SROT */
>> +                       #qcom,sensors = <13>;
>> +                       #thermal-sensor-cells = <1>;
>> +               };
>> +
>> +               tsens1: tsens@c223000 {
>> +                       compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
>> +                       reg = <0xc265000 0x1ff>, /* TM */
>> +                             <0xc223000 0x1ff>; /* SROT */
>> +                       #qcom,sensors = <8>;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
