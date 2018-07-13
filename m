Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB747ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F5D2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lJAqj9XU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O/HWoP8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F5D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeGMQXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:23:52 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43515 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGMQXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:23:52 -0400
Received: by mail-vk0-f67.google.com with SMTP id d74-v6so18468606vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tC4o0HYJWq/jiNmYhxXIvLIllksvu1gVAL8vJ6b9qdE=;
        b=lJAqj9XUn2DP3tBKWifHZSWWLpcDZgT5pd4H0uaX+DTrdHFiRk2gZmLHIAsPMfD12b
         6666QZQE30HOOS6VBff7uuUUDLBkdHeri5tOQiJhFHCIinuFPVqAzfVwtTk+odjhwkvz
         eXvTxvFDvbdLPmjt5fYbM8A5flGUQx6GPsLY1qS/hZSojwDMV/MR3kCdbBR/8VV6A4K1
         Q+XNGt6zGFY7xtWcyN3upQ0A0MMYltsJECzrPulJMLrv1zD5vniF77LhioxgSPHeylmN
         ft3azwL5JHasNu//jxIhb4yq8ZgkWw/3ZlDScKYdvF2tjt6N8VRm1XwiQDoWnQ+HaXZ0
         bhaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tC4o0HYJWq/jiNmYhxXIvLIllksvu1gVAL8vJ6b9qdE=;
        b=O/HWoP8dmt9iZvLMUvHkGtcWG3WR4CUQMFF+pX4h1w3lv2GWnTYhFbzlDVv9d2Qx8R
         RydutPzC9FbhCxT3YI7LOBggQz4ZxLoYzH5OTRH2CzFuYfQ/MJi10kIzwhug7oaT3EHt
         YQNhuFYeJdYTeM88j48daUfAjPV7T2/bxTdnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tC4o0HYJWq/jiNmYhxXIvLIllksvu1gVAL8vJ6b9qdE=;
        b=cpC+/8hHJ0ZH05ZtGlO+clWKbkpN7BIe+AOk2MF1hrtBbIQJoYWDuaZiTZjnH0BnFu
         ubT3Sepa0gX762rRJtS+RqOJDyyM+sYHHnhQ9ztxraWIts6HFFnFi9u6QF2VrTp5Ww6t
         N4j9MsWcKfhgLYvr4f3D3R3OXTkuvzTUtiRbZqXxxgkTGSW920ukuMvENCLZcrWPMR3R
         ZbxJlEKmp1+T0OM9UGN0o5ZYDhGmm4VosXmzIWMhCPYhX6Gb+QO6CYuPlHTTG0JdKOu5
         vL7YobhIGBWwvLpnCXEJOBsapmXjjo4fwKEIXFfQXaKV+UreY7SomuI7LZsEwG0U2reJ
         VT1g==
X-Gm-Message-State: AOUpUlHnIWW7Os9iTpXak7ri0ex5bupknUpoyR5n0H+0MfqCWtPCZsef
        181jOFgfuU2o4GwTuoSNyVjC5bdlTv/cKZ55XjMNAQ==
X-Google-Smtp-Source: AAOMgpdQr/aKzry6BzBuAJB34JbMLWDH4TBCFsI7eUFLyqQ857u0zTyCQ1N1prMDdQPPjaI5kzdOpP+WenpxX90GXCo=
X-Received: by 2002:a1f:d744:: with SMTP id o65-v6mr4061849vkg.101.1531498115476;
 Fri, 13 Jul 2018 09:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:4d02:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 09:08:34
 -0700 (PDT)
In-Reply-To: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
References: <20180709212522.187257-1-mka@chromium.org> <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 13 Jul 2018 09:08:34 -0700
X-Google-Sender-Auth: OqjUwJrIA_djz4smm3UWprHW7X8
Message-ID: <CAD=FV=UVUO+xhTxET_MHuk6CsSfsfRFr_ZUzM0AKW5zzMfk98A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2018 at 9:00 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
>> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> index 92bed1e7d4bb..7eea94701b23 100644
>> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> @@ -11,6 +11,13 @@
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>> +               pm8998_temp: temp-alarm@2400 {
>
> Are we sorting this file based on node name or unit address? Otherwise
> patch looks good.

My preference would be:

* Anything where we're defining a new node with an address: sort by the address.

* If we are defining nodes without addresses: sort by node name (not by label!)

* In general I'd prefer to see addressless things before things with addresses.

* If we are overriding nodes that were defined in a parent makefile:
sort by the name of the parent label we refer to.


...so I think Matthias's sort order in this case is correct / consistent.


-Doug
