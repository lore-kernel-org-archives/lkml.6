Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6AA75C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20337208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="BakT3tsU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVOgkht3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20337208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755038AbeFNKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:24:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43309 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754937AbeFNKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:24:30 -0400
Received: by mail-oi0-f66.google.com with SMTP id t133-v6so5154750oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wnflG2aBnyI8GjFoUmfOpIre9X1X/Xm32vc4nkC5Mos=;
        b=BakT3tsUx43+taYp42f8FVxjI0JAN5FF7L2NdzjYIE+E94+AkZ5iZD7PEhpel5emps
         8dO7Ylo8O1Fn80VRlX4d2RNf44GlwAAM/UFXd7cBmGWMkT1J+hCVpHJ9pHF3khQRaCAW
         v6+dW4NfZtSZUoP3RyntpvetwTnqZrpMlzcTbjLQTvKzGhMujQbcn8aEN7cbiN6ZrhYP
         dmjX/HCQQL2b+sCEWd+gHttDyFQ1CLqNkgIMgL7nKocLrhlv4hLVjxzL8o1hyXeG9rAC
         pToOf0sDFxkTq6jmmReEWODeFrS4SpECIBkDE5qYcZTP/kaUcsU+Nir5l//quaKaqyi+
         oIOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wnflG2aBnyI8GjFoUmfOpIre9X1X/Xm32vc4nkC5Mos=;
        b=jVOgkht30VfKVqnYeU9MJoVXx+GJq3VjFwlSp27fIcnBzA+Iwda/xneXrCbojr/TzS
         Q8Em3nNaCByDKnn5lUIG2rueMxjyW/RkjmAm34c8yjF2vKniDrsq0XbqYw71lh+03q+U
         /Sa411feLo7nocZ7AHyVDieJk/bdqOqLA1T0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wnflG2aBnyI8GjFoUmfOpIre9X1X/Xm32vc4nkC5Mos=;
        b=bpxgs0+R5eVvosdMNbDkuB3rQ0x3fxadqFDVbib5XN6bQuM595A+lu0wGUdDFajJKc
         Zv4j47YcunKjaOcl/EdC4tlJQrd+wCjHH1YsZTVDo+CUtcUv3a3ohfPxfJ+B/SBSgi7x
         PvtTnf4QARWZDysWS1zTiUwlTJtjHsCVPR+Asm8LwvwkdxRALvNFBa6qyqiq9lTxd0EX
         se/oilK3ah0QLejCUiXD8EO/8tJN7t86EvLcGX7w2hk39pXJFri5QudapOV2g/kjdyCE
         YJZXTGk/PTHf91UnldxGWXVHdGnJXg9nbi+ZrsQTXVxHxNsgWyBOtRO2ImGgHEBROyyI
         X14Q==
X-Gm-Message-State: APt69E3yVg6YGaZYuAIELBRaIiPpzEoxrrfAm5xjKJ267beZnnz5w+VT
        4B8ULxSW0YiMala5Ju/N0Mm7YmxXAKra83DcGGDoRA==
X-Google-Smtp-Source: ADUXVKIzX+2h+IDpKsSxro1Gj+p+isUTQSjCxWImXanML+hiFNiDGhBFNyYptCdMviaasb5fTWvImp3YvXLOk4gX+l0=
X-Received: by 2002:aca:d655:: with SMTP id n82-v6mr793593oig.287.1528971869417;
 Thu, 14 Jun 2018 03:24:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:24:28
 -0700 (PDT)
In-Reply-To: <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
 <f048a97d1599a54aef3d00126a379f4e5c937057.1528799892.git.amit.kucheria@linaro.org>
 <CAFp+6iEnep3ogEkdfmaSOn_2w+09huae2NOwBF1o7-vn3iQMCA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 14 Jun 2018 13:24:28 +0300
X-Google-Sender-Auth: DiFYi7riYBRLC2uoVjA-w5gA0dI
Message-ID: <CAHLCerOn=_29CAx0sdmyxt62duWOb5LfUvrAcWf7bBsE8OR_1g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] thermal: tsens: Add support for SDM845
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 9:48 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Amit,
>
> On Tue, Jun 12, 2018 at 4:24 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> SDM845 uses the TSENS v2 IP block
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---

<snip>

>> +
>> +static const struct tsens_ops ops_sdm845 = {
>> +       .init           = init_common,
>> +       .get_temp       = get_temp_tsens_v2,
>> +};
>> +
>> +const struct tsens_data data_sdm845 = {
>
> Just a minor nit. 'static' here?

Thanks for the review.

This file just went away in favour of a common tsens-v2.c that will
support all v2 SoCs. I'll be sending out an updated patchset soon.

>
>> +       .ops            = &ops_sdm845,
>> +};
>
> [snip]
>
> Thanks & Regards
> Vivek
