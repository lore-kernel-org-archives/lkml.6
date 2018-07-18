Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28395ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAF52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXhiQ90P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAF52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeGRXQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeGRXQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:16:32 -0400
Received: from [10.82.11.234] (unknown [131.107.147.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1EE02075A;
        Wed, 18 Jul 2018 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531953389;
        bh=AXC6YtV0sCec71pczlGeHGa//w3TEadfxCGex+TUQLM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QXhiQ90PeicBlUMf4cIDcVSjsaZVQbsN7oK4emLVLGCs6FzwJif4m1D+H2hXGOStI
         FyH7cYkcisr0qkL/fZIDBN+K2NogZ9gW45IzoS8uUiruNbKEyvvT82DBO8Wg8h/VZZ
         bQ2k5Z2B1ZYQ56gii/HAciOWPogjhrxghGwfFTKg=
Subject: Re: [PATCH V5 5/6] PCI: Deprecate pci_reset_bus() and
 pci_reset_slot() functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
 <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
 <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <3d664a22-7362-07ec-584d-b38829a22ba2@kernel.org>
Date:   Wed, 18 Jul 2018 15:36:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718223027.GI128988@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2018 3:30 PM, Bjorn Helgaas wrote:
> On Mon, Jul 02, 2018 at 06:58:54PM -0400, Sinan Kaya wrote:
>> pci_reset_bus() and pci_reset_slot() functions are not being used by
>> any code. Remove them from the kernel in favor of pci_try_reset_bus()
>> and pci_try_reset_slot() functions.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   drivers/pci/pci.c   | 55 ++---------------------------------------------------
>>   include/linux/pci.h |  2 --
>>   2 files changed, 2 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index a31e6db..7e3f2e9 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
>>   EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
>>   
>>   /**
>> - * pci_reset_slot - reset a PCI slot
>> + * __pci_try_reset_slot - Try to reset a PCI slot
>>    * @slot: PCI slot to reset
>> - *
>> + *`
> 
> Is this "*`" intentional or a typo?  I can't find it in kernel-doc.rst
> (but it's full of ` and maybe I missed it).

Typo.

> 
> I do see a few other occurrences in the code, although they look like
> typos to me:
> 
>    $ git grep "\*\`" | grep -v Documentation
>    arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
>    arch/mips/cavium-octeon/octeon-usb.c:	 *`	0x1 = Big endian
>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:/*`
> 
