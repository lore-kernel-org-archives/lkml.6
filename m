Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7C9F6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3228F208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CBGCNGrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3228F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbeFLQ44 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:56:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38876 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933792AbeFLQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:56:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id x34-v6so24353430qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKtL4BdEqszxcGWUvt5ctEeNmfHOlT43ITc5Dpt8XZU=;
        b=CBGCNGrgazEVb73HcyGyb/P/yskqPMLLQwwEXAA/YT8nxSs9FGsb0sNoi1oAx0Yg1Z
         CJ4LnhrPExahnHADwAObQ94F+ORb1bgrVbqpD75XUIZ2z/PhNFCE7qqdVyHgeP2nAOae
         AWGRiQx+va9bc4pKsT8RYOow4/lXSeEQZ8FuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKtL4BdEqszxcGWUvt5ctEeNmfHOlT43ITc5Dpt8XZU=;
        b=s9xHFJd9I8ylF9wdgH5od3xbX2KMR4KAdduZZUbkewnIoSWKmRzNPBrDZIzGR5W0tu
         vbKG/b5f+8mITtxm2FbBSfCUPvA7d7FxPnNDJzGQTCi7Wevpk6NyRLQQ9N9phFZT+g4M
         +5LLfzNFdtbyjbdMT7Mddwq3DDKd7gujZ+8wWlYLGI/Qrw5e9M8GwhOje0cX7zrKz08C
         rkXvW9hR1v4y1w8rERYl+x2Lu9zvW3dqIM1WiY9qLoyqmTWrGNA9NOVY0oJtJEBG5U7F
         l62sC5xnh1Afztg6srOY59q90ObiY0CLm4KTZ2/DSxAzNaPq5iIhWy5VEY4c57CWVGyH
         /NwA==
X-Gm-Message-State: APt69E2zrHA1GOpvlT1leksgyYGwWsxiQ6+pKiYvKu78iVIZM4IEfIp/
        ggpNhMm5OU+ssdOzvzd9TBngxg==
X-Google-Smtp-Source: ADUXVKK7eLQ2AIeAqURpUzl+c2JZ0r+gSGnQr07m0t1mDxh1JWk0Dj8o/QEwQCgMGTYJdm1p22MR5Q==
X-Received: by 2002:a0c:a083:: with SMTP id c3-v6mr1262706qva.107.1528822610678;
        Tue, 12 Jun 2018 09:56:50 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h126-v6sm402154qke.50.2018.06.12.09.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:56:49 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] PCI: iproc: Fix up corrupted PAXC root complex
 config registers
To:     poza@codeaurora.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, linux-pci-owner@vger.kernel.org
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-3-git-send-email-ray.jui@broadcom.com>
 <2bafb8ae70029279a1849fb68a020d18@codeaurora.org>
 <1f059e9b5ebeabf6f5a7e11a134221ae@codeaurora.org>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <330f9f0d-761a-706b-2a58-2ae15f2e0105@broadcom.com>
Date:   Tue, 12 Jun 2018 09:56:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1f059e9b5ebeabf6f5a7e11a134221ae@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 5:23 AM, poza@codeaurora.org wrote:
> On 2018-06-12 13:57, poza@codeaurora.org wrote:
>> On 2018-06-12 05:51, Ray Jui wrote:
>>> On certain versions of Broadcom PAXC based root complexes, certain
>>> regions of the configuration space are corrupted. As a result, it
>>> prevents the Linux PCIe stack from traversing the linked list of the
>>> capability registers completely and therefore the root complex is
>>> not advertised as "PCIe capable". This prevents the correct PCIe RID
>>> from being parsed in the kernel PCIe stack. A correct RID is required
>>> for mapping to a stream ID from the SMMU or the device ID from the
>>> GICv3 ITS
>>>
>>> This patch fixes up the issue by manually populating the related
>>> PCIe capabilities
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> ---
>>>  drivers/pci/host/pcie-iproc.c | 65 
>>> +++++++++++++++++++++++++++++++++++++++----
>>>  drivers/pci/host/pcie-iproc.h |  3 ++
>>>  2 files changed, 62 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc.c 
>>> b/drivers/pci/host/pcie-iproc.c
>>> index 3c76c5f..680f6b1 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -85,6 +85,8 @@
>>>  #define IMAP_VALID_SHIFT        0
>>>  #define IMAP_VALID            BIT(IMAP_VALID_SHIFT)
>>>
>>> +#define IPROC_PCI_PM_CAP        0x48
>>> +#define IPROC_PCI_PM_CAP_MASK        0xffff
>>>  #define IPROC_PCI_EXP_CAP        0xac
>>>
>>>  #define IPROC_PCIE_REG_INVALID        0xffff
>>> @@ -375,6 +377,17 @@ static const u16 iproc_pcie_reg_paxc_v2[] = {
>>>      [IPROC_PCIE_CFG_DATA]        = 0x1fc,
>>>  };
>>>
>>> +/*
>>> + * List of device IDs of controllers that have corrupted capability 
>>> list that
>>> + * require SW fixup
>>> + */
>>> +static const u16 iproc_pcie_corrupt_cap_did[] = {
>>> +    0x16cd,
>>> +    0x16f0,
>>> +    0xd802,
>>> +    0xd804
>>> +};
>>> +
>>>  static inline struct iproc_pcie *iproc_data(struct pci_bus *bus)
>>>  {
>>>      struct iproc_pcie *pcie = bus->sysdata;
>>> @@ -495,6 +508,49 @@ static unsigned int iproc_pcie_cfg_retry(void
>>> __iomem *cfg_data_p)
>>>      return data;
>>>  }
>>>
>>> +static void iproc_pcie_fix_cap(struct iproc_pcie *pcie, int where, 
>>> u32 *val)
>>> +{
>>> +    u32 i, dev_id;
>>> +
>>> +    switch (where & ~0x3) {
>>> +    case PCI_VENDOR_ID:
>>> +        dev_id = *val >> 16;
>>> +
>>> +        /*
>>> +         * Activate fixup for those controllers that have corrupted
>>> +         * capability list registers
>>> +         */
>>> +        for (i = 0; i < ARRAY_SIZE(iproc_pcie_corrupt_cap_did); i++)
>>> +            if (dev_id == iproc_pcie_corrupt_cap_did[i])
>>> +                pcie->fix_paxc_cap = true;
>>
>> and I think this code will try to fix up every time config space is read.
>> Does this get corrupted often, randomly ?
>> Can it not be solved by using one time Quirk ?
>> and if not Quirk, you dont want to be setting pcie->fix_paxc_cap =
>> false somewhere
>>
>> besides, pcie->fix_paxc_cap = true; is set if PCI_VENDOR_ID is read 
>> first.
>> and rest cases stay with the assumption that PCI_VENDOR_ID will be 
>> read first.
>> which is infact read first during enumeration
>> (that is the assumption code is making), but that is safe assumption
>> to make I think.
>>
> 
> ok I see that Bjorn has suggested to fix it this way instead of Quirks.
> will just mark

Right, and there are benefits with this approach like Bjorn has 
explained. We now have consistent lspci and config dump output using 
this approach.

> 
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> 
>>> +        break;
>>> +
>>> +    case IPROC_PCI_PM_CAP:
>>> +        if (pcie->fix_paxc_cap) {
>>> +            /* advertise PM, force next capability to PCIe */
>>> +            *val &= ~IPROC_PCI_PM_CAP_MASK;
>>> +            *val |= IPROC_PCI_EXP_CAP << 8 | PCI_CAP_ID_PM;
>>> +        }
>>> +        break;
>>> +
>>> +    case IPROC_PCI_EXP_CAP:
>>> +        if (pcie->fix_paxc_cap) {
>>> +            /* advertise root port, version 2, terminate here */
>>> +            *val = (PCI_EXP_TYPE_ROOT_PORT << 4 | 2) << 16 |
>>> +                PCI_CAP_ID_EXP;
>>> +        }
>>> +        break;
>>> +
>>> +    case IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL:
>>> +        /* Don't advertise CRS SV support */
>>> +        *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>>> +        break;
>>> +
>>> +    default:
>>> +        break;
>>> +    }
>>> +}
>>> +
>>>  static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int 
>>> devfn,
>>>                    int where, int size, u32 *val)
>>>  {
>>> @@ -509,13 +565,10 @@ static int iproc_pcie_config_read(struct pci_bus
>>> *bus, unsigned int devfn,
>>>      /* root complex access */
>>>      if (busno == 0) {
>>>          ret = pci_generic_config_read32(bus, devfn, where, size, val);
>>> -        if (ret != PCIBIOS_SUCCESSFUL)
>>> -            return ret;
>>> +        if (ret == PCIBIOS_SUCCESSFUL)
>>> +            iproc_pcie_fix_cap(pcie, where, val);
>>>
>>> -        /* Don't advertise CRS SV support */
>>> -        if ((where & ~0x3) == IPROC_PCI_EXP_CAP + PCI_EXP_RTCTL)
>>> -            *val &= ~(PCI_EXP_RTCAP_CRSVIS << 16);
>>> -        return PCIBIOS_SUCCESSFUL;
>>> +        return ret;
>>>      }
>>>
>>>      cfg_data_p = iproc_pcie_map_ep_cfg_reg(pcie, busno, slot, fn, 
>>> where);
>>> diff --git a/drivers/pci/host/pcie-iproc.h 
>>> b/drivers/pci/host/pcie-iproc.h
>>> index 814b600..9d5cfee 100644
>>> --- a/drivers/pci/host/pcie-iproc.h
>>> +++ b/drivers/pci/host/pcie-iproc.h
>>> @@ -60,6 +60,8 @@ struct iproc_msi;
>>>   * @ep_is_internal: indicates an internal emulated endpoint device 
>>> is connected
>>>   * @has_apb_err_disable: indicates the controller can be configured 
>>> to prevent
>>>   * unsupported request from being forwarded as an APB bus error
>>> + * @fix_paxc_cap: indicates the controller has corrupted capability 
>>> list in its
>>> + * config space registers and requires SW based fixup
>>>   *
>>>   * @need_ob_cfg: indicates SW needs to configure the outbound 
>>> mapping window
>>>   * @ob: outbound mapping related parameters
>>> @@ -85,6 +87,7 @@ struct iproc_pcie {
>>>      int (*map_irq)(const struct pci_dev *, u8, u8);
>>>      bool ep_is_internal;
>>>      bool has_apb_err_disable;
>>> +    bool fix_paxc_cap;
>>>
>>>      bool need_ob_cfg;
>>>      struct iproc_pcie_ob ob;
