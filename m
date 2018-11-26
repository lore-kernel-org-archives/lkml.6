Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1201AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67320672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRfdVFbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeK0EJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:09:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38409 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0EJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:09:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so16312456wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mF6QLMm9W8rvCicDMkzdJM95rye+1tmDZYbb3Dmgi8A=;
        b=fRfdVFbfIrjyrr4JiHtLA4KaBuG0TUq6BNiAvOAIFBfQFejyZByS8tXdttfMBPFFSA
         6tnbwmNGde+/Q7FgZdWG8I7kep2Fr97aPuj4UY3AxGuEZ7xcjPWvdNWZLHcBFlQlYD5f
         u31OMvu1k3xyVjjpZbmDfVmBNf1CXk0X+Gc8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mF6QLMm9W8rvCicDMkzdJM95rye+1tmDZYbb3Dmgi8A=;
        b=MV7ZTQgBLNFQg6mbq0MA0JB2ItKJPr9deS6d/y5e98HkCULe9q+0IF9futLBmzOCon
         Incp+plrgrF2p5bznyGuJbAJVL/EtK1qIForFAiHbb/OQf0lASGfwIU7olBdb6dPJy2v
         6I3b0PrFf8yX8gVDjsGEGxMOZ+zSRzT5SFDsJnljb/lCFdei7GK83wQcAyLWO6frJ2wX
         PyPldlDDUfDCeZ79C1VrsrrVowplq/BuxZ+yS+UVPMIAH48p3p4maXPBmFZSo3T/1IdA
         8KZh4ZC5+ub1g47HhbYXC10CGfK/NpVXI7r6G2nTXqbMtkGGoiT7bca2rdpbIBNCzwBG
         l9GA==
X-Gm-Message-State: AA+aEWYep2xzJXnuEG0iSSQtsNwfXEFUuY+DqxcuZxHAIINHd34yPKA+
        A2UXnpw3qHANOCs8+5phseiW8g==
X-Google-Smtp-Source: AFSGD/VcRk5KI5wv1fQanl2olEM/l4+IidRfS3YtX/SuH0UUokCtlB257z/xnpc1EdrUGBoWlNzKDw==
X-Received: by 2002:adf:b502:: with SMTP id a2mr18222514wrd.264.1543252471382;
        Mon, 26 Nov 2018 09:14:31 -0800 (PST)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id v133sm1938755wmd.4.2018.11.26.09.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:14:26 -0800 (PST)
Subject: Re: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent
 phy_get/ulpi_init during suspend/resume
From:   Todor Tomov <todor.tomov@linaro.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "linux-stable # = v4 . 13" <stable@vger.kernel.org>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com>
 <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com>
 <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org>
 <87efbm92zi.fsf@linux.intel.com>
 <027608c0-8d2d-42ab-5125-76b86f286d2b@linaro.org>
 <08ebcaea-45c4-d277-9585-97045960e83a@linaro.org>
Message-ID: <ca6e775c-98ce-abab-56e1-e40e673dd111@linaro.org>
Date:   Mon, 26 Nov 2018 19:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <08ebcaea-45c4-d277-9585-97045960e83a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 26.11.2018 10:27, Todor Tomov wrote:
> Hi Felipe,
> 
> On 16.11.2018 19:01, Todor Tomov wrote:
>> Hi,
>>
>> On 15.11.2018 10:09, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Todor Tomov <todor.tomov@linaro.org> writes:
>>>
>>>> Hello,
>>>>
>>>> After I apply this patch on 4.14 (or receive it with 4.14.70) I see a regression with
>>>> the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
>>>> In boot log I get:
>>>>
>>>> [    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
>>>> [    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
>>>> [    4.536170] dwc3 7600000.dwc3: failed to initialize core
>>>> [    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
>>>> [    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
>>>> [    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
>>>> [    4.559606] dwc3 6a00000.dwc3: failed to initialize core
>>>> [    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16
>>>>
>>>> I can provide a full log if needed.
>>>
>>> please do. Also, try mainline and let us know if the problem
>>
>> This is the full log on 4.14.69 + this patch: https://paste.ubuntu.com/p/N5WdHw47QC/
>> I also managed to get a log from 4.20.0-rc2 and I see the same error: https://paste.udwc3_phy_setupbuntu.com/p/jz6fvYyZh6/
>>
>>> persists. Why do you get -EBUSY from the PHY driver?
>>
>> Maybe I could have proposed a fix if I knew but I don't know.
> 
> I have done some debugging but I still cannot understand it completely.
> 
> What I see is that if the PHY interface is configured first (dwc3_phy_setup)
> then the PHY init (qusb2_phy_init called by dwc3_core_soft_reset) fails
> with "pll lock failed". If we move dwc3_phy_setup after dwc3_core_soft_reset
> as it was before this patch, it works.

I have found that during dwc3_phy_setup the PHY interface is configured
to suspend and this is what breaks the QUSB2 PHY initialization.
It seems that it can be fixed by adding the "snps,dis_u2_susphy_quirk"
quirk in device tree. If this approach proves correct, I'll send the
patch upstream.

Best regards,
Todor

> 
> Do you have any ideas why this happens or how to solve it?
> 
> Thank you.
> Best regards,
> Todor
> 

