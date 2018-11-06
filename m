Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9820827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iEYuFhGR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mc46Nkvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF9820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbeKGDRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:17:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbeKGDRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:17:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 26C1060591; Tue,  6 Nov 2018 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541526687;
        bh=3pydGgseVOh8qzszlmwXRs8KbQJa8kox0KVqIwonH18=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iEYuFhGRNYOfj6w4/eQTGSbiSN9CyrATldeV6H6qg1pVDJASFlt9Tr1Tl2O63IOh5
         AwoLN0ZllduXI2HClLwRIdrQzjYvRgf8mSqMUvWx52kvaVxer962kXpJwXqtJQ1fH9
         /eI1nBNBgLtnWGchpjU7lYZXQv6yT6ZDIA7c5OI0=
Received: from [192.168.0.104] (unknown [183.83.73.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94956601D7;
        Tue,  6 Nov 2018 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541526686;
        bh=3pydGgseVOh8qzszlmwXRs8KbQJa8kox0KVqIwonH18=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mc46Nkvl/0rmAh2gW6DrcsDGzUDsF7qftubjUl/kBkWrGNrgOJjun0xlI+d5o5B9T
         1j+b9UeG/Ay9f+5aWaa6RZeocYHMmQxs/rjE5bg70WusmqM6lNoSqJtx0m+ITpSPCZ
         OUnpP53UphAn5lME5grxiLmlD4wVna70FYCD4j3A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94956601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V3 2/2] mmc: sdhci-msm: Re-initialize DLL if MCLK is gated
 dynamically
To:     Doug Anderson <dianders@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
 <1541073999-11752-3-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=U7FGn0Jt_63SJ0zeU9u4vh5J9EFtbLHGtjGOUV7AceKw@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <ed0de1bd-d2f5-a1e6-9799-52f3a6ad91f4@codeaurora.org>
Date:   Tue, 6 Nov 2018 23:21:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U7FGn0Jt_63SJ0zeU9u4vh5J9EFtbLHGtjGOUV7AceKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2018 2:03 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Nov 1, 2018 at 5:08 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>>   static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>>          .mci_removed = true,
>> +       .restore_dll_config = false,
>> +       .var_ops = &v5_var_ops,
>> +       .offset = &sdhci_msm_v5_offset,
>> +};
>> +
>> +static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
>> +       .mci_removed = true,
>> +       .restore_dll_config = true,
>>          .var_ops = &v5_var_ops,
>>          .offset = &sdhci_msm_v5_offset,
>>   };
> One last thing: are there actually any "v5" controllers that _don't_
> require restoring the DLL?  Since "sdm845" is currently the only v5
> controller maybe just set "restore_dll_config = true" for all v5
> controllers and when there's a new v5 controller that doesn't need it
> then match off the SoC-specific compatible string.  As per my review
> of the bindings patch IMO you should include both the "v5" and the
> SoC-specific string for SDM845 (and all future SoCs) so you could make
> the generic v5 case do this...
>

Yes. QCS404 is one of the target which uses "V5" controller and it 
doesn't need restoring of DLL.
I checked your comments on bindings patch. Will update it in the next 
patchset.

> -Doug

Thanks,
Veera
