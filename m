Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17938C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BD20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahg2Lcty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85BD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeKZTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46117 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so17845122wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Le7vlzz0eUH8ajrM3OemFqfUuBPVHlGdIodKi7uwVc=;
        b=ahg2LctyKY+mrTu8vwitvoysSQpZEYGM0aweO4DZgF3Q+Ls+axFn9B6tHgMC3tkgNh
         6F34sjO/uLSZ/Mc9CdFAsUGMSLgEyd7OKZXBwHflgcdcdk97UoN703EugCQOSPeVXPDF
         wsWGe5ve9yGnZIT4dXz449tI8IiNXHACohQTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Le7vlzz0eUH8ajrM3OemFqfUuBPVHlGdIodKi7uwVc=;
        b=na0XqZCZW0Ax+tMdrkfuGdsc6FSX13OGfPYUEbMYp74MppbVzLUfnJoZUypzsTTNAm
         ljuIz1rszt9wXQTNc5PeETKdw3uGy3d1hSQsmA5c94ZoljCsuGWpGL1+XSKgoyoFsDX+
         EtUxebGDkbhLl+asSGddSXyww3y5wjk+PJ/T4LSvI9WVTWlm+LbMOFjtJiVfUZmd+W24
         cICLgfV6fBB3xcE12wG1UWxmoARnUiPoD+g2+Dr7MVYdfMfbw1F6VBK7xiTqn4EmVgi0
         /wWcOvXQ/lE8eZD7ustUYpU2O485FKax48ujd+Q/4z+Tb5XgCCW+eXLHuS10dPN/LBvt
         64gQ==
X-Gm-Message-State: AA+aEWZRuCo3Q0AKxUsjrmQfCW/mv9TeNn34fi4T4QLTniPQA9yVlhq2
        SuiocpkOmhsmcdtdkHodZWo2JhIgkeQ=
X-Google-Smtp-Source: AFSGD/X2x1K1hgiFoNxhdx88H2BaNaRQmmtMQdg5gvXIqEN9TVWYcVPNDaaC9Juy3/siGIXMOIvkaA==
X-Received: by 2002:adf:8228:: with SMTP id 37mr22160871wrb.160.1543220872657;
        Mon, 26 Nov 2018 00:27:52 -0800 (PST)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id q12sm34490113wrx.31.2018.11.26.00.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:27:51 -0800 (PST)
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
Message-ID: <08ebcaea-45c4-d277-9585-97045960e83a@linaro.org>
Date:   Mon, 26 Nov 2018 10:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <027608c0-8d2d-42ab-5125-76b86f286d2b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On 16.11.2018 19:01, Todor Tomov wrote:
> Hi,
> 
> On 15.11.2018 10:09, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Todor Tomov <todor.tomov@linaro.org> writes:
>>
>>> Hello,
>>>
>>> After I apply this patch on 4.14 (or receive it with 4.14.70) I see a regression with
>>> the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
>>> In boot log I get:
>>>
>>> [    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
>>> [    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
>>> [    4.536170] dwc3 7600000.dwc3: failed to initialize core
>>> [    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
>>> [    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
>>> [    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
>>> [    4.559606] dwc3 6a00000.dwc3: failed to initialize core
>>> [    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16
>>>
>>> I can provide a full log if needed.
>>
>> please do. Also, try mainline and let us know if the problem
> 
> This is the full log on 4.14.69 + this patch: https://paste.ubuntu.com/p/N5WdHw47QC/
> I also managed to get a log from 4.20.0-rc2 and I see the same error: https://paste.udwc3_phy_setupbuntu.com/p/jz6fvYyZh6/
> 
>> persists. Why do you get -EBUSY from the PHY driver?
> 
> Maybe I could have proposed a fix if I knew but I don't know.

I have done some debugging but I still cannot understand it completely.

What I see is that if the PHY interface is configured first (dwc3_phy_setup)
then the PHY init (qusb2_phy_init called by dwc3_core_soft_reset) fails
with "pll lock failed". If we move dwc3_phy_setup after dwc3_core_soft_reset
as it was before this patch, it works.

Do you have any ideas why this happens or how to solve it?

Thank you.
Best regards,
Todor
