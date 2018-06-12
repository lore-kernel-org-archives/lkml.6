Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C56B8C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18D2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pseue5oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933916AbeFLASz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:18:55 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42353 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933489AbeFLASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:18:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so22131770qty.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iq/P/rbEfe8hyigEgjAKodEn+tzLxnORAlI/+6TSCIQ=;
        b=Pseue5oAQ6TT1IGocO+he+fnUOW1xXClbD/6izRj5xEUcCSwaZOiauw+DCQHI56yma
         BgT4bXYJ0Hy4Glq+4GV/W+kIRJ7uS41GVt77bzQv61JtP7pDyswmCSrAVrUw0rXBBzFw
         Zr9LGEewNMa2ebwOF7C8JIziNhgxf1UXrMlbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iq/P/rbEfe8hyigEgjAKodEn+tzLxnORAlI/+6TSCIQ=;
        b=V6RkAsOYHAkhF3jNuC/IKLH3ySDr6pitz1YKqB42preP1Q7iuc6SWQAbKs1vmZGKgV
         U3mh+jIxYDsu37mh51Qn3NXdtawhG0eTrZ8CC9+hDjn86xQwAcbC5kWKCmghtVAld1lN
         HaNLSuwYi/CcrCLAog52IdsXKZNh55umUaY9l17GwdhYpE+DzPIi6YS1Vmu0Ri9DmQj+
         UMel8G1/NNFBchnQedSpgyXWZ49ZPm4ZY2TefBkw1w0LmXFDzjc3JJjbxdSy761WLhrH
         L/i1jwRTudakfL9h2aQdM8nTF9/ijTrLXho0EYH9Hv4bMuVQ1JiX8vrX0xFOzKl+YLdd
         MH5g==
X-Gm-Message-State: APt69E3KgjoS2qm1JCEqbWTRmg6zhrUWR6DV3pLn/LFYZHz0LxXzkJBB
        bACe/SS7CPpDFkO/5yZTk8fFFg==
X-Google-Smtp-Source: ADUXVKISyASEMc9AYcDsjeHvFCXBTHWx5btCpIHKkaiu5F1qFjjrEjqpAHxKFUgMdHCKWp9ctNRxlw==
X-Received: by 2002:aed:359d:: with SMTP id c29-v6mr1363787qte.240.1528762732693;
        Mon, 11 Jun 2018 17:18:52 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b38-v6sm4419217qta.96.2018.06.11.17.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:18:51 -0700 (PDT)
Subject: Re: [PATCH INTERNAL 2/3] PCI: iproc: Fix up corrupted PAXC root
 complex config registers
From:   Ray Jui <ray.jui@broadcom.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-3-git-send-email-ray.jui@broadcom.com>
 <20180530172733.GN39853@bhelgaas-glaptop.roam.corp.google.com>
 <715d8746-1b68-4342-6258-7d9c1b5035bc@broadcom.com>
Message-ID: <7e7ce21e-b39d-0d9e-1d75-7d0e2e432e48@broadcom.com>
Date:   Mon, 11 Jun 2018 17:18:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <715d8746-1b68-4342-6258-7d9c1b5035bc@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/30/2018 10:43 AM, Ray Jui wrote:
> Hi Bjorn,
> 
> On 5/30/2018 10:27 AM, Bjorn Helgaas wrote:
>> On Thu, May 17, 2018 at 10:21:31AM -0700, Ray Jui wrote:
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
>>> PCIe capabilities based on readings from the PCIe capability structure
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Anup Patel <anup.patel@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   drivers/pci/quirks.c | 95 
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 95 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 47dfea0..0cdbd0a 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2198,6 +2198,101 @@ 
>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, 
>>> quirk_paxc_bridge);
>>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, 
>>> quirk_paxc_bridge);
>>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, 
>>> quirk_paxc_bridge);
>>>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, 
>>> quirk_paxc_bridge);
>>> +
>>> +/*
>>> + * The PCI capabilities list for certain revisions of Broadcom PAXC 
>>> root
>>> + * complexes is incorrectly terminated due to corrupted 
>>> configuration space
>>> + * registers in the range of 0x50 - 0x5f
>>> + *
>>> + * As a result, the capability list becomes broken and prevent 
>>> standard PCI
>>> + * stack from being able to traverse to the PCIe capability structure
>>> + */
>>> +static void quirk_paxc_pcie_capability(struct pci_dev *pdev)
>>> +{
>>> +    int pos, i = 0;
>>> +    u8 next_cap;
>>> +    u16 reg16, *cap;
>>> +    struct pci_cap_saved_state *state;
>>> +
>>> +    /* bail out if PCIe capability can be found */
>>> +    if (pdev->pcie_cap || pci_find_capability(pdev, PCI_CAP_ID_EXP))
>>> +        return;
>>> +
>>> +    /* locate the power management capability */
>>> +    pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
>>> +    if (!pos)
>>> +        return;
>>> +
>>> +    /* bail out if the next capability pointer is not 0x50/0x58 */
>>> +    pci_read_config_byte(pdev, pos + 1, &next_cap);
>>> +    if (next_cap != 0x50 && next_cap != 0x58)
>>> +        return;
>>> +
>>> +    /* bail out if we do not terminate at 0x50/0x58 */
>>> +    pos = next_cap;
>>> +    pci_read_config_byte(pdev, pos + 1, &next_cap);
>>> +    if (next_cap != 0x00)
>>> +        return;
>>> +
>>> +    /*
>>> +     * On these buggy HW, PCIe capability structure is expected to 
>>> be at
>>> +     * 0xac and should terminate the list
>>> +     *
>>> +     * Borrow the similar logic from theIntel DH895xCC VFs fixup to 
>>> save
>>> +     * the PCIe capability list
>>> +     */
>>> +    pos = 0xac;
>>> +    pci_read_config_word(pdev, pos, &reg16);
>>> +    if (reg16 == (0x0000 | PCI_CAP_ID_EXP)) {
>>> +        u32 status;
>>> +
>>> +#ifndef PCI_EXP_SAVE_REGS
>>> +#define PCI_EXP_SAVE_REGS     7
>>> +#endif
>>> +        int size = PCI_EXP_SAVE_REGS * sizeof(u16);
>>> +
>>> +        pdev->pcie_cap = pos;
>>> +        pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>>> +        pdev->pcie_flags_reg = reg16;
>>> +        pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
>>> +        pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
>>
>> Is there any way you can fix this in iproc_pcie_config_read() instead,
>> by making it notice when we're reading a corrupted part of config
>> space, and then returning the correct data instead?  Is it just the
>> next capability pointer that's corrupted?
> 
> Let me look into that and I'll get back.
> 
> Thanks,
> 
> Ray
> 
>>
>> If you could fix it in the config accessor, lspci would automatically
>> show all the correct data (I think lspci will still show the wrong
>> data with this patch).
>>

I managed to get this fixed within iproc_pcie_config_read(). By doing it 
this way, as you suggested, now lspci and dump of 
/sys/bus/pci/devices/xxx:yyy:zzz.w all show correct data.

I'll send out v2 of the patch series with the fix.

Thanks!

Ray


>> The quirk seems like a maintenance issue because anything that calls
>>
>>    pci_find_capability(pdev, PCI_CAP_ID_EXP)
>>
>> will get the wrong answer.
>>
>>> +
>>> +        pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
>>> +        if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
>>> +            PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
>>> +            pdev->cfg_size = PCI_CFG_SPACE_SIZE;
>>> +
>>> +        if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
>>> +            return;
>>> +
>>> +        state = kzalloc(sizeof(*state) + size, GFP_KERNEL);
>>> +        if (!state)
>>> +            return;
>>> +
>>> +        state->cap.cap_nr = PCI_CAP_ID_EXP;
>>> +        state->cap.cap_extended = 0;
>>> +        state->cap.size = size;
>>> +        cap = (u16 *)&state->cap.data[0];
>>> +        pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_RTCTL,  &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_LNKCTL2, &cap[i++]);
>>> +        pcie_capability_read_word(pdev, PCI_EXP_SLTCTL2, &cap[i++]);
>>> +        hlist_add_head(&state->next, &pdev->saved_cap_space);
>>> +    }
>>> +}
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 
>>> PCI_DEVICE_ID_NX2_57810,
>>> +            quirk_paxc_pcie_capability);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd,
>>> +            quirk_paxc_pcie_capability);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
>>> +            quirk_paxc_pcie_capability);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
>>> +            quirk_paxc_pcie_capability);
>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
>>> +            quirk_paxc_pcie_capability);
>>>   #endif
>>>   /* Originally in EDAC sources for i82875P:
>>> -- 
>>> 2.1.4
>>>
