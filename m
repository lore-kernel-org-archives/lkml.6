Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C47B7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C26208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NSDlJSaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C26208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935247AbeFLQ66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:58:58 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47032 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933693AbeFLQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:58:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so24329089qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DRy9pplTN8nTNEvnCsKAF87Dwe6SuTgxGlK8B9jr/es=;
        b=NSDlJSaft2hOnuRqlC1IEJdrm62XImm4kx5DqMxUThV9/NVgpB/qbi4X4HoGN9/er4
         zyHHBHZeiz5EuU86nzJz3Rvdh+5G+CWMkHRn24bvSQ90/28FcgzSbeWWRM0IsprYxt48
         oa9wb0KbCqmSZU1gl5VTlUvIQZ14sjigK5gMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRy9pplTN8nTNEvnCsKAF87Dwe6SuTgxGlK8B9jr/es=;
        b=mxKCKmwZ1a/GEDd3HVaxaolaNzpIYBTiojYDza58ed6eTDOaCH67gdSbzO3vCEAe/l
         YKThN9DOLL4EYMI8V+BqeRYT1BvqTkXODZtbp+hfnKxfrsYMEVV09o3lHPYa3x1Er+fk
         DLaqyPPJwgmGgZJPjMyZWLVFO4zZmlOg8Fkn7Piv5xiRs3Y9xnChmC74QThLTYtBKGng
         fghyIr7sQS9Y/1AXpdNKIp+wCeXXcWD43StbJLjgON8ZZpUrJ4p6CQnBfQp4dvSr5Ghm
         CWhMLpdqvFTi5s2gjOk7opnsntWPxzTFc9RiquUvA+LpGfFAZteORz6ZZmgFMOzvW34m
         mzqQ==
X-Gm-Message-State: APt69E1f9+59rVnCFOUYc+I26KCca1FHyAi7Mk5LBGJhDeOsFbKGSdGu
        bObW9bfCSdfNUbZGTr/QhTvwpw==
X-Google-Smtp-Source: ADUXVKKecthHG5qQh4fl1TrKx7VBtqVxp7iTgOKaSfylSkQLuCIhIPk+RNOGAu6Gl7WgUDFpXbRW/Q==
X-Received: by 2002:a0c:d175:: with SMTP id c50-v6mr1286476qvh.1.1528822733458;
        Tue, 12 Jun 2018 09:58:53 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z64-v6sm472061qke.66.2018.06.12.09.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:58:52 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] PCI: iproc: Disable MSI parsing in certain PAXC
 blocks
To:     poza@codeaurora.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-4-git-send-email-ray.jui@broadcom.com>
 <8f6d7771baec3f56e0ccf5efd0efe2a2@codeaurora.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c44bf00c-b412-2cd1-75ee-7541bc775173@broadcom.com>
Date:   Tue, 12 Jun 2018 09:58:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8f6d7771baec3f56e0ccf5efd0efe2a2@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 1:29 AM, poza@codeaurora.org wrote:
> On 2018-06-12 05:51, Ray Jui wrote:
>> The internal MSI parsing logic in certain revisions of PAXC root
>> complexes does not work properly and can casue corruptions on the
>> writes. They need to be disabled
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c 
>> b/drivers/pci/host/pcie-iproc.c
>> index 680f6b1..0804aa2 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -1197,10 +1197,22 @@ static int iproc_pcie_paxb_v2_msi_steer(struct
>> iproc_pcie *pcie, u64 msi_addr)
>>      return ret;
>>  }
>>
>> -static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 
>> msi_addr)
>> +static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 
>> msi_addr,
>> +                     bool enable)
>>  {
>>      u32 val;
>>
>> +    if (!enable) {
>> +        /*
>> +         * Disable PAXC MSI steering. All write transfers will be
>> +         * treated as non-MSI transfers
>> +         */
>> +        val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>> +        val &= ~MSI_ENABLE_CFG;
>> +        iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>> +        return;
> can be dropped.


No it cannot be dropped. Please review the code carefully.
