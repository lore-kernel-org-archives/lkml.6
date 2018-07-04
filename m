Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE94240A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aD8Bvwzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE94240A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932995AbeGDFCo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:02:44 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38287 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeGDFCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:02:43 -0400
Received: by mail-qk0-f193.google.com with SMTP id y4-v6so2268633qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 22:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1LZruMcg47bYls9EI2Mg8lBCZYNEkiTlxZLEzqXmFss=;
        b=aD8Bvwzm5HeS3TDA9wcrZZKrf3SjtZHVXYdlIxqC174gNKlPl2y1LbC8QaGnjHiwnI
         6KmTvk2hLuyLiP9yss+CTUgmPUR/6Xd6wdspxsRVlPDFrKwSntm52sVyqvskMxY9CqeU
         IY0o0kUCa5qykj2Sbk93iVoGZO9LDxbY9pknI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1LZruMcg47bYls9EI2Mg8lBCZYNEkiTlxZLEzqXmFss=;
        b=VKOPDXoQmsXp76Gpp/c1aV/WzKGYCOmcRj5snik9n/ef6Yt92ZM4mULcaLgqZrOMoG
         gIUu+ywy/pjnTd7RZ45FkLR4olZ52WFzFgJ+LoQpk/YrsTo0m+A1+jsRtme/vaXozyrY
         LqMvr23HJipG25uqtof05TnJr/x0hH6bRlJeuAcfAQIqWjiMNQkb2ILrxjjDLiGZ6MmH
         0bya5lcUIEbaF5Jafd31WRCe0CiVbJe9Oyx5JmjSzA0mdMp0dHQhNbHNx9yiImEOv1oz
         wpeFfSwTRmt8mcIhuGeWVfVRpLutWP2GzU9BKkf9AqiqQ3PBzA8JQKNIyDQUl7BwkP07
         3bSA==
X-Gm-Message-State: APt69E1NTvqlBQlM2tFYu1tTNpebSoL5tHPK+/vFCrB+KUtxgJ/2zDsO
        X1j1/YLmVLCeUA7BakjhX6ECJQ==
X-Google-Smtp-Source: AAOMgpeWWHwdoZ8WrB2WRJNU7d9XbWHKwKLGYAyRqjAx8/ggbVqYy3XGo0BoJUJyDDBEhdFBwYga4g==
X-Received: by 2002:a37:13e6:: with SMTP id 99-v6mr398305qkt.252.1530680562478;
        Tue, 03 Jul 2018 22:02:42 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h10-v6sm210060qtm.48.2018.07.03.22.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 22:02:41 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Improve Broadcom PAXC support
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <45945371-3cd7-102d-bb47-69a60435542b@broadcom.com>
 <20180621164821.GA14519@e107981-ln.cambridge.arm.com>
 <e573bad0-05b1-c00f-8815-6ebe26218f05@broadcom.com>
Message-ID: <dfc2a3d4-dbdb-5ebc-c000-b824d4d2075d@broadcom.com>
Date:   Tue, 3 Jul 2018 22:02:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e573bad0-05b1-c00f-8815-6ebe26218f05@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

A friendly reminder: Have you had a chance to help to review the patch 
series below?

Thanks,

Ray

On 6/21/2018 11:22 AM, Ray Jui wrote:
> Hi Lorenzo,
> 
> On 6/21/2018 9:48 AM, Lorenzo Pieralisi wrote:
>> On Wed, Jun 20, 2018 at 10:26:28AM -0700, Ray Jui wrote:
>>> Hi Lorenzo/Bjorn,
>>>
>>> Could you please help to review this patch series when you have time?
>>>
>>> I believe I have addressed major comment in v1 from Bjorn and 
>>> answered all
>>> questions from Lorenzo.
>>
>> I will have a look next week, sorry for the delay.
> 
> Thanks a lot. Much appreciated!
> 
> Ray
> 
>>
>> Thanks,
>> Lorenzo
>>
>>> Thanks,
>>>
>>> Ray
>>>
>>> On 6/11/2018 5:21 PM, Ray Jui wrote:
>>>> This patch series improves the Broadcom PAXC support by 1) adding more
>>>> quirks for specific versions of PAXC controllers; 2) adding logic to
>>>> reject internally unconfigured physical functions from the embedded
>>>> network processor acting as endpoint; 3) reducing verbose print level
>>>> in the outbound/inbound mapping code
>>>>
>>>> This patch series is based off v4.17 and is available on GIHUB:
>>>> repo: https://github.com/Broadcom/arm64-linux.git
>>>> branch: sr-paxc-v2
>>>>
>>>> Changes since v1:
>>>>   - consolidate 2 PAXC related patch series into 1
>>>>   - change the way how the capability list corruption is handled, per
>>>> recommendation from Bjorn. Now handle and fix up the corruption at
>>>> the config register read
>>>>   - rebase to v4.17
>>>>
>>>> Ray Jui (5):
>>>>    PCI: iproc: Activate PAXC bridge quirk for more devices
>>>>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>>>>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
>>>>    PCI: iproc: Reject unconfigured physical functions from PAXC
>>>>    PCI: iproc: Reduce inbound/outbound mapping print level
>>>>
>>>>   drivers/pci/host/pcie-iproc.c | 159 
>>>> +++++++++++++++++++++++++++++++++++-------
>>>>   drivers/pci/host/pcie-iproc.h |   8 +++
>>>>   drivers/pci/quirks.c          |   3 +
>>>>   3 files changed, 144 insertions(+), 26 deletions(-)
>>>>
