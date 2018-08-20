Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E921473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot5GXT4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7E921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeHTVAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeHTVAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:00:00 -0400
Received: from [192.168.0.114] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08BC121473;
        Mon, 20 Aug 2018 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534787006;
        bh=7tLkMFMr/o1N3ZqcMkPOIu4owKJjoZO0QGPq1ozaRqk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ot5GXT4Dsb7t2drWPVjq2eQiN6sGX21NGjWA4DmeZduYbHkGLQl7QAREctjau7ih0
         BSbBgMzLa5k5TE9WtgpHR9cEzx+t/sHwd0MNpnrJCyDQq/4oT7AG+p5WP+d0Rsr5Pu
         HcwOIMYJNpl01zsTAwPWN1jTifZXBrqGZ24sF/8s=
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
 <20180820082150.r4q47ppqqclaschd@wunner.de>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <38fd0d0a-6d60-c8db-f155-e6078260513b@kernel.org>
Date:   Mon, 20 Aug 2018 13:43:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820082150.r4q47ppqqclaschd@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/2018 4:21 AM, Lukas Wunner wrote:
> On Fri, Aug 17, 2018 at 11:51:10PM -0700, Sinan Kaya wrote:
>> +static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)
> 
> The return value isn't checked, so this could return void.
> 

Sure, I can do that.

> 
>> @@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
>>   
>>   	pciehp_check_presence(ctrl);
>>   
>> +	/* We want exclusive control of link down events in hotplug driver */
>> +	pciehp_control_surprise_error(ctrl, false);
>> +
>>   	return 0;
> 
> Hm, if the platform firmware hasn't granted native hotplug control to OSPM,
> or if some other hotplug driver than pciehp is used, shouldn't surprise down
> be ignored by error recovery as well?  If yes, the mask would have to be set
> in generic code somewhere in drivers/pci/probe.c I guess, based on the
> is_hotplug_bridge bit in struct pci_dev.

I could move this code if we know that is_hotplug_bridge flag is set
regardless of OS hotplug driver control or not.


> 
> (Interestingly, PCI_ERR_UNCOR_MASK is already changed in probe.c by
> program_hpp_type2().  That seems to be ACPI-specific code, which kind
> of begs the question why it's not in pci-acpi.c?)

Yes, you can tell the OS what AER mask to set following hotplug
insertion via ACPI HPP table especially if you remove a hotplug bridge.
This is used during ACPI hotplug.

> 
> Thanks,
> 
> Lukas
> 

