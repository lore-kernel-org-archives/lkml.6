Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B36923C27
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bHPTx9+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B36923C27
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeGDPoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:44:13 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40984 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbeGDPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:44:11 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so4845304qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hYwPKtihTpEXmQYCKtq0F7eogr4/7MzU34tTS7ViA08=;
        b=bHPTx9+Z7dq8uk+SK5jSPcICx3GPjKyeo0kSqoWPt1c5H9TlW83t7qv9y8rHpvI7V8
         T4SDvvn1PtuSfEZ338trmIWT1ZlVHvhhwprKqYcnr88lvT2fi10iFpfdqjFJbm+jVnvY
         UbjWVGLhV84KhOdltErsz5fZiDxiCkSEWFwpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYwPKtihTpEXmQYCKtq0F7eogr4/7MzU34tTS7ViA08=;
        b=kOb4kJNlgt/z5pcFY4H8eLjXBzmT2qtpdlsmOT/ZVzhhc4FuRt8WKinvmVwGOH2KrI
         qYctHcXlk6y+0b88aTfRU6d/cypqzSHO+/I69RAJfekIP4oOTnGxMd7HtJCjLW/B2FjS
         7EGyW2iIskWyKMYSEoipUm0YNl/oY2KdZgNZtWzrzLWIx1Vpe7QlDpNwWGuEQlYIG1XZ
         vetb/qrTCJSN0CrO0t6fk24xtHIncBMYmyNKnyo+dmBghyyb/G1Zl6lfsNuODWLbnB7t
         tCyKJIUflMK0nK0X/zjEliYMr+vPhonEjAwf5B7/1Htlmywy1TBKc8F3ALcY39HXVWrv
         3ehQ==
X-Gm-Message-State: APt69E0kaXDNrAgj56PbHMKI0gFHug8jYAUvWDj727eL41Hq7QVKV590
        16KUg5We1uJfKtW8WDAqmXcnsA==
X-Google-Smtp-Source: AAOMgpeCPx0RMDlSISipuwoGqXX8twPlsrBsmVHCTnOhG66ZVgPcvzymr7rYoLFvsmORW2U6PVCkBA==
X-Received: by 2002:ac8:6601:: with SMTP id c1-v6mr2111825qtp.343.1530719050999;
        Wed, 04 Jul 2018 08:44:10 -0700 (PDT)
Received: from [10.136.8.248] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h184-v6sm2394448qkd.80.2018.07.04.08.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 08:44:09 -0700 (PDT)
Subject: Re: [PATCH INTERNAL 3/3] PCI: iproc: Disable MSI parsing in certain
 PAXC blocks
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, poza@codeaurora.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
 <1526577692-21104-4-git-send-email-ray.jui@broadcom.com>
 <ad41ea7f16414a83a2b3d7e6192bcf79@codeaurora.org>
 <20180518135614.GA18605@e107981-ln.cambridge.arm.com>
 <e433f2cf-63c5-37c3-f7ef-15ff0aa67e4f@broadcom.com>
 <20180521133305.GB1443@e107981-ln.cambridge.arm.com>
 <073832d4-88a0-efa1-2da8-5e07479e51e0@arm.com>
 <d8988a30-f604-f00d-cc8f-db01b4def3c9@broadcom.com>
 <20180704151254.GA12996@red-moon>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <66542c4a-3f56-0f75-db80-f7c05609c177@broadcom.com>
Date:   Wed, 4 Jul 2018 08:44:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704151254.GA12996@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 7/4/2018 8:13 AM, Lorenzo Pieralisi wrote:
> On Tue, May 22, 2018 at 09:48:55AM -0700, Ray Jui wrote:
>> Hi Robin/Lorenzo,
>>
>> On 5/21/2018 7:26 AM, Robin Murphy wrote:
>>> On 21/05/18 14:33, Lorenzo Pieralisi wrote:
>>>> [+Robin]
>>>>
>>>> On Fri, May 18, 2018 at 12:48:28PM -0700, Ray Jui wrote:
>>>>> Hi Lorenzo,
>>>>>
>>>>> On 5/18/2018 6:56 AM, Lorenzo Pieralisi wrote:
>>>>>> On Fri, May 18, 2018 at 02:53:41PM +0530, poza@codeaurora.org wrote:
>>>>>>> On 2018-05-17 22:51, Ray Jui wrote:
>>>>>>>> The internal MSI parsing logic in certain revisions of PAXC root
>>>>>>>> complexes does not work properly and can casue corruptions on the
>>>>>>>> writes. They need to be disabled
>>>>>>>>
>>>>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>>>>>> ---
>>>>>>>> drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
>>>>>>>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/host/pcie-iproc.c
>>>>>>>> b/drivers/pci/host/pcie-iproc.c
>>>>>>>> index 3c76c5f..b906d80 100644
>>>>>>>> --- a/drivers/pci/host/pcie-iproc.c
>>>>>>>> +++ b/drivers/pci/host/pcie-iproc.c
>>>>>>>> @@ -1144,10 +1144,22 @@ static int
>>>>>>>> iproc_pcie_paxb_v2_msi_steer(struct
>>>>>>>> iproc_pcie *pcie, u64 msi_addr)
>>>>>>>>      return ret;
>>>>>>>> }
>>>>>>>>
>>>>>>>> -static void iproc_pcie_paxc_v2_msi_steer(struct
>>>>>>>> iproc_pcie *pcie, u64
>>>>>>>> msi_addr)
>>>>>>>> +static void iproc_pcie_paxc_v2_msi_steer(struct
>>>>>>>> iproc_pcie *pcie, u64
>>>>>>>> msi_addr,
>>>>>>>> +                     bool enable)
>>>>>>>> {
>>>>>>>>      u32 val;
>>>>>>>>
>>>>>>>> +    if (!enable) {
>>>>>>>> +        /*
>>>>>>>> +         * Disable PAXC MSI steering. All write transfers will be
>>>>>>>> +         * treated as non-MSI transfers
>>>>>>>> +         */
>>>>>>>> +        val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
>>>>>>>> +        val &= ~MSI_ENABLE_CFG;
>>>>>>>> +        iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * Program bits [43:13] of address of
>>>>>>>> GITS_TRANSLATER register into
>>>>>>>>       * bits [30:0] of the MSI base address register.  In
>>>>>>>> fact, in all iProc
>>>>>>>> @@ -1201,7 +1213,7 @@ static int
>>>>>>>> iproc_pcie_msi_steer(struct iproc_pcie
>>>>>>>> *pcie,
>>>>>>>>              return ret;
>>>>>>>>          break;
>>>>>>>>      case IPROC_PCIE_PAXC_V2:
>>>>>>>> -        iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr);
>>>>>>>> +        iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr, true);
>>>>>>>
>>>>>>> Are you calling iproc_pcie_paxc_v2_msi_steer() anywhere
>>>>>>> else with 'false' ?
>>>>>>> I see its getting called only from one place in current code
>>>>>>> iproc_pcie_msi_steer().
>>>>>>
>>>>>> It is called below with the false field to disable MSIs.
>>>>>> That's probably
>>>>>> one reason more to create a function to enable/disable MSIs instead of
>>>>>> adding a parameter to iproc_pcie_paxc_v2_msi_steer().
>>>>>
>>>>> Correct. Thanks for helping to explain.
>>>>>
>>>>>>
>>>>>> Which brings me to the question: what happens to those MSIs writes
>>>>>> when MSIs are disabled according to this patch ? Are they terminated
>>>>>> at the root complex ?
>>>>>
>>>>> Note the PAXC block parses MSI writes from our internally connected
>>>>> endpoints (i.e., an embedded network processor). The PAXC block examines
>>>>> these MSI writes and modifies the memory attributes (to DEVICE) of these
>>>>> data and then send them out to the AXI bus. These MSI writes
>>>>> will then be
>>>>> forwarded to the GIC (e.g., GICv2m, GICv3-ITS from ARM) for further
>>>>> processing. This is saying, PAXC itself does not process these
>>>>> MSI writes.
>>>>> They are processed by the GIC and associated interrupt will be generated
>>>>> form the GIC. PAXC's job is to parse and tag them properly so these MSI
>>>>> writes can reach the GIC, and at the same, reach the GIC at
>>>>> the right order.
>>>>>
>>>>> On some of these problematic PAXCs, we are being forced to
>>>>> disable this PAXC
>>>>> internal parsing logic. In this case, we set up static mapping with the
>>>>> IOMMU to modify the memory attributes of these MSI writes.
>>>>> These MSI writes
>>>>> are always designated towards a specific memory address (e.g.,
>>>>> on the GICv3
>>>>> based system, it's the address of the translator register),
>>>>> and that's why
>>>>> static mapping table can be set up to work around this.
>>>>
>>>> Which means, I presume, that there must be some code that somehow
>>>> somewhere in the kernel sets-up those mappings and it has to be related
>>>> to this patch, in which case I wonder why we enable the PAXC steering at
>>>> all given that this (hack) can be done through the IOMMU (and I assume
>>>> that on all PAXC platforms that do need MSIs there is an IOMMU IP
>>>> upstream the root bridge, otherwise I have no idea what will happen to
>>>> those MSI writes).
>>>
>>> If it's only rewriting memory attributes (FWIW it sounds like this
>>> thing is comparable to the AXI translation table of the PLDA root
>>> complex we have in Juno), then if the IOMMU is controlled by Linux
>>> the PAXC shouldn't be needed anyway. In that situation the
>>> GICv2m/ITS doorbell will be already mapped for the endpoint as
>>> device memory (and usually at some arbitrary address that the PAXC
>>> won't recognise anyway) - see iommu_dma_get_msi_page().
>>>
>>> If Linux *doesn't* know about the IOMMU, then the firmware should
>>> be free to set it up with a static 1:1 mapping of the PA space and
>>> leave it that way, provided Linux can't inadvertently stomp on
>>> those page tables later.
>>
>> Right, in our case, we had our ATF bootloader set up 1:1 mapping for
>> this. In this case, PAXC internal MSI parsing is completely disabled
>> (which is what this patch does for those PAXC blocks that have this
>> issue).
> 
> Ok so to sum it up, why does the PCI host bridge code has to deal with
> this steering at all given the discussion above ? Why can't we disable
> PAXC steering completely ?
> 
> Lorenzo
> 

Sorry I probably did not give enough information in our previous discussion.

Per recommendation from our ASIC team, we are advised to enable MSI 
steering in the PAXC block in the latest revision of our SoC (and 
therefore there's this patch to enable/disable MSI steering based on the 
root complex device ID).

Note PAXC is an highly custom, emulated root complex hard-wire connected 
internally to our embedded network processor (that acts as EP). Some 
special tagging in done in the firmware for the network processor to 
distinguish between data packets, completion, and MSI packets 
(data/completion in the perspective of our network processor), and 
inbound packets are re-ordered within PAXC to 1) ensure that they are in 
the correct order (e.g., completion and MSI needs to arrive after data), 
and 2) achieve extremely high performance (i.e., pure strictly ordered 
packets will actually result very poor performance). I don't know more 
details but the above is the high-level summary that explains why we 
need to enable PAXC based steering in the latest revision of our SoC.

Thanks,

Ray
