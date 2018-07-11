Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E84120C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qca7qo9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E84120C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbeGKQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:57:48 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42417 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387689AbeGKQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:57:47 -0400
Received: by mail-qk0-f195.google.com with SMTP id 26-v6so3345788qks.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8MawT6/lVl3lTLS0vgnKT9s27x5bdYQ2FFiKZv0TqRs=;
        b=Qca7qo9/cnb68OGGY79xDClkrBYKPA9cAy5TzSDdFRIxqIhOa0W3lcw98aI0alyk6M
         d2zChPDAzxYVC8jAEqQeAP16PbcssvZ5nl2j8i4kv9blbOO+g28Pd9g72mxTUnDZiJE7
         Cs7HmAPEAKmkpWbsa+nUpKz5IFdZa0wjVlq9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MawT6/lVl3lTLS0vgnKT9s27x5bdYQ2FFiKZv0TqRs=;
        b=QYgCxEC3nskeoytZwilbaFnw1dDE+lsldfol8a0Z3l90oNL7OERu12zuyqOE4kqWph
         CAkWouNXRJ0Q94JxRCC71KfDNxu1miIAjYG9MADz9oVKYa2Eq07lhKVb+tjcb6weXute
         gFLeTUHLNK3Q234Xau4nmAyKq3+pCxMZWlcLqmB7EtNX0dqGJ9e18zTHO3xZ9Z3RGND3
         UjHTDzdMNjmJ82HHVM+cVvk+4sEikwdil790wEqAL6RUFTA/7YYVzIATi6iGOGql7Vnz
         Hvr+Se0OM65ISaagIYnUnCfbx3otgOGCGPQ0muEfDmxZ9OWOEeMDCuJJVPXKP00k+Fnr
         DgeQ==
X-Gm-Message-State: APt69E26yjrUHRaFNUcBHHSJB5LxpV6j0K+/IcguliJf/LYRlREuc4ar
        VUbbSH5Q7WDPcuiYIl8rSNR9jw==
X-Google-Smtp-Source: AAOMgpcGmS1pXsWOxIWs1VPydmo6B593EYTdv9uwCvkFVUCtaE90irtwhgkeg9DToGrkfsfJR9ZQSg==
X-Received: by 2002:a37:b001:: with SMTP id z1-v6mr26752065qke.156.1531327955425;
        Wed, 11 Jul 2018 09:52:35 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f64-v6sm22170592qkf.2.2018.07.11.09.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:52:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
 <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <6a931918-f5ba-1b80-658d-1f7ed1e8c84e@broadcom.com>
Date:   Wed, 11 Jul 2018 09:52:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/11/2018 6:11 AM, Bjorn Helgaas wrote:
> On Mon, Jun 11, 2018 at 05:21:03PM -0700, Ray Jui wrote:
>> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
>> the following PCIe device ID:
>> 0xd750, 0xd802, 0xd804
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> 
> Because this quirk_paxc_bridge() mechanism is already established,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thanks!

> BUT, I would push back on quirk_paxc_bridge() if it were new code.
> 
> I think it would be much better to implement this in the driver's
> config accessors so lspci would show the correct things and the
> generic code that deals with pcie_mpss would work unmodified.
>

Noted.

I agree with you. I'll find time to improve this by moving them into the 
driver's config accessors in the future, after v4.19.

>> ---
>>   drivers/pci/quirks.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 2990ad1..47dfea0 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
>>   }
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>>   #endif
>>   
>>   /* Originally in EDAC sources for i82875P:
>> -- 
>> 2.1.4
>>
