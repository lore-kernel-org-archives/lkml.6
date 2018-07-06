Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3DCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B5A2254A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ExAg5t5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B5A2254A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGFWrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:47:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37088 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeGFWrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:47:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id t79-v6so7104420qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O9bZ9H80dzAEyHkfzXPpYt32pKrlgAejB6hA9VXi2+4=;
        b=ExAg5t5ezKfiDUKRiUpeF8vbKQ9EE4SKlYAc2AYfUFFHjKBff9p+zJlHZvLLgvIXhv
         57QT42JlgS/LBsVDxQ3ZFJnWy0KO29T7BGS/qjjugMRHpBzovRsH+Gda0okh2rHmkO0V
         li+a/603Hd6ZyCYk2Iwh12XSb18KY7cIr1exA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O9bZ9H80dzAEyHkfzXPpYt32pKrlgAejB6hA9VXi2+4=;
        b=jhyGMwMjtVHw4bIZtX4TnwUqUta2953oh5u5MlOP9Q3TdI+Ng3aGqWPwan8ezL513z
         Ae2WVqE6RJvuSuaWAr6hBNJACFoorZKP1bY6FAai4MxzJyzagXfzBlgSMnz9UV0Gg/bx
         OjZhGnJ+V8kEtBfgsDaQ+myreelkKGvixYS5sV/N1SrxYO8P4GWhccpM0ReOf+t6nitL
         ae96gAJiDts6iprYsotaW6JEMGOkvssMIo54DxznMqYsGavjmX7xyeJLwhDVOdPanVoJ
         3ZmOIwSR8hwn/y6eTAnkAngqt3EqCZ6/fVzhrSuusQ/Hq5qs7wd12MJBYHbFxn7FQ3v1
         jzfw==
X-Gm-Message-State: APt69E0+rxQKlZZ0SWvxkEwgTiYM/1spQghakoT9sYtBzOTiFaSdCBAg
        /Hm0M9W5s03WJhR+tYhivBZfmA==
X-Google-Smtp-Source: AAOMgpdZutWutZIa+9rSSoAe7mJ+5bigEKEepFOxMX7v691tgqhZ4NbecM8czsGAZYPW/DEdO7BtiQ==
X-Received: by 2002:a37:4792:: with SMTP id u140-v6mr10526938qka.100.1530917231204;
        Fri, 06 Jul 2018 15:47:11 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5608442qtg.38.2018.07.06.15.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 15:47:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <20180706162034.GA14923@red-moon>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <bfc6d35e-6184-7354-14f6-fb37844cc4ee@broadcom.com>
Date:   Fri, 6 Jul 2018 15:47:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706162034.GA14923@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 7/6/2018 9:20 AM, Lorenzo Pieralisi wrote:
> On Mon, Jun 11, 2018 at 05:21:02PM -0700, Ray Jui wrote:
>> This patch series improves the Broadcom PAXC support by 1) adding more
>> quirks for specific versions of PAXC controllers; 2) adding logic to
>> reject internally unconfigured physical functions from the embedded
>> network processor acting as endpoint; 3) reducing verbose print level
>> in the outbound/inbound mapping code
> 
> Nit: commit log sentences must be terminated with periods, that's valid
> for all patches in your series inclusive of this cover letter, I can
> change them myself but pointing this out so that you will be able
> to do it yourself next time.
> 
> Lorenzo
> 

Got it. I'll make sure commit message sentences are terminated with 
periods in the future.

Thanks a lot!

Ray

>> This patch series is based off v4.17 and is available on GIHUB:
>> repo: https://github.com/Broadcom/arm64-linux.git
>> branch: sr-paxc-v2
>>
>> Changes since v1:
>>   - consolidate 2 PAXC related patch series into 1
>>   - change the way how the capability list corruption is handled, per
>> recommendation from Bjorn. Now handle and fix up the corruption at
>> the config register read
>>   - rebase to v4.17
>>
>> Ray Jui (5):
>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>
>>   drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>   drivers/pci/quirks.c          |   3 +
>>   3 files changed, 144 insertions(+), 26 deletions(-)
>>
>> -- 
>> 2.1.4
>>
