Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89516C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA62086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPw9Uhu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCA62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390150AbeKQDOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:14:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37314 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeKQDOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:14:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so11374590wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ONQVY+T1AaVdTBtZy6BR2S+m2uvJLC8/vjef3UkuJsc=;
        b=aPw9Uhu19dujwnvoqAbNvT4mrjD44VB/DOWFzo9asAT4MI2gLuPQCVzH4vdQxb6ytK
         aAme99sxH4twoaneKnxT9VISLjsx6EQBz4rC9uHVt6eA5CRwzuP9MkvxbFKKzMxTQm6z
         7EJziP/TzvZdZFuO4808K4sopJXwqvdoj/dng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ONQVY+T1AaVdTBtZy6BR2S+m2uvJLC8/vjef3UkuJsc=;
        b=XT+OPHa4TgzqtCVtqfF8Y7u9PgAsN82vqkPXA1U+mrHqILlbgNIbOcF0Y3i394yQad
         8vryJ8iGHZEGmAzzcwSbhSWrU+iRuyHK7PujBVHFvdGo4eFDHQQygibElwBDPNxJ0OiS
         TTrGH/ZUysh+IQJJf2XfJ0WE26DzpvG5zrukEvj7nor5p6ANap7D4hsP4nlBlUPz6Pm8
         Vj3qMZMJfNzIo3F+KJ2LqfdzITkJcG2ypyGrDFfoeM3yofRL2YbPyTjh3x7ZcFFsU6AI
         GtTtPuiVNPm8S8ZTTlGfg1+pnQLMMaP062SZw8ZxUidluyikC5QzERc2p24zRrkPt+fW
         8nrA==
X-Gm-Message-State: AA+aEWayMcUWtrpmV0hkNLQtbGkNn8yG/f89m0VpT4mywqLsqs0p0rlE
        A8Tp3Ta2EB/SAfe9aWMKyuExyg==
X-Google-Smtp-Source: AFSGD/UdheeIonrlityn0dgo+//1XWoRYdXB0jlXQeggi3lrNS27WJ/29qsX/NGx9ad9VJPFtlhHgQ==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr8385670wrt.327.1542387695882;
        Fri, 16 Nov 2018 09:01:35 -0800 (PST)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o15-v6sm24138673wrw.47.2018.11.16.09.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 09:01:35 -0800 (PST)
Subject: Re: [PATCH v2 RESEND] usb: dwc3: core: Fix ULPI PHYs and prevent
 phy_get/ulpi_init during suspend/resume
To:     Felipe Balbi <balbi@kernel.org>, Roger Quadros <rogerq@ti.com>,
        linux-usb@vger.kernel.org
Cc:     vigneshr@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        "linux-stable # = v4 . 13" <stable@vger.kernel.org>
References: <1515667087-4110-1-git-send-email-rogerq@ti.com>
 <ee73347b-e996-4052-6a9d-dd94edd4a61a@ti.com>
 <606dbc68-2014-8590-ce47-83c175d4cd41@linaro.org>
 <87efbm92zi.fsf@linux.intel.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <027608c0-8d2d-42ab-5125-76b86f286d2b@linaro.org>
Date:   Fri, 16 Nov 2018 19:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87efbm92zi.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15.11.2018 10:09, Felipe Balbi wrote:
> 
> Hi,
> 
> Todor Tomov <todor.tomov@linaro.org> writes:
> 
>> Hello,
>>
>> After I apply this patch on 4.14 (or receive it with 4.14.70) I see a regression with
>> the Qualcomm QUSB2 phy driver. I'm testing on a Dragonboard 820c.
>> In boot log I get:
>>
>> [    4.525502] phy phy-7412000.phy.6: QUSB2PHY pll lock failed: status reg = 0
>> [    4.529232] phy phy-7412000.phy.6: phy init failed --> -16
>> [    4.536170] dwc3 7600000.dwc3: failed to initialize core
>> [    4.541743] dwc3: probe of 7600000.dwc3 failed with error -16
>> [    4.549979] phy phy-7411000.phy.5: QUSB2PHY pll lock failed: status reg = 0
>> [    4.552843] phy phy-7411000.phy.5: phy init failed --> -16
>> [    4.559606] dwc3 6a00000.dwc3: failed to initialize core
>> [    4.565181] dwc3: probe of 6a00000.dwc3 failed with error -16
>>
>> I can provide a full log if needed.
> 
> please do. Also, try mainline and let us know if the problem

This is the full log on 4.14.69 + this patch: https://paste.ubuntu.com/p/N5WdHw47QC/
I also managed to get a log from 4.20.0-rc2 and I see the same error: https://paste.ubuntu.com/p/jz6fvYyZh6/

> persists. Why do you get -EBUSY from the PHY driver?

Maybe I could have proposed a fix if I knew but I don't know.

Best regards,
Todor

> 
> - 
> balbi
> 

