Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3978823E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T109R1AK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LuK+MQ05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3978823E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeGCPey (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeGCPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 377B460B62; Tue,  3 Jul 2018 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632090;
        bh=/sFXxC1yZa1JqkXMSraxENa3Hwbg8cye9rvBaj5inJ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T109R1AKr5M7Dm6OLP3w1ChX0KW8nWZOpJoBq0Uov50LNyA+0lgJsBb2ARt8iWdby
         U36MGGSvZfuaKTjHvKTyv1uKGZglhpoDRYFNw61laDin8KLXfDpLX3ByIEji3AbnVx
         pCGfDRcrBOUjj3mtIZRloiK6M3f0Mjt2z+qruCKs=
Received: from [192.168.0.117] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C90EC60B68;
        Tue,  3 Jul 2018 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530632088;
        bh=/sFXxC1yZa1JqkXMSraxENa3Hwbg8cye9rvBaj5inJ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LuK+MQ05EQuZbXGVUIG4IhGzQ1SwplDX7aps6fZqtRho0gvNhAD+9iuG6z6GMxaq7
         3xSU3oytagrCr25DU6GaBkJ/yNlMVSfw10A12CL5BlQcfDv8kOJ9SeFG/nCBlql1ms
         fejw1ZWjk+CiRQbs0gHf18J+t++/J7PgewZuuNNI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C90EC60B68
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To:     Lukas Wunner <lukas@wunner.de>
Cc:     poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
 <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
 <20180703135956.GA18639@wunner.de>
From:   Sinan Kaya <okaya@codeaurora.org>
Message-ID: <42e72f83-3b24-f7ef-e5bc-290fae99259a@codeaurora.org>
Date:   Tue, 3 Jul 2018 11:34:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703135956.GA18639@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2018 9:59 AM, Lukas Wunner wrote:
> On Tue, Jul 03, 2018 at 09:31:24AM -0400, Sinan Kaya wrote:
>> Issue is observing hotplug link down event in the middle of AER recovery
>> as in my previous reply.
>>
>> If we mask hotplug interrupts before secondary bus reset via my patch,
>> then hotplug driver will not observe both link up and link down interrupts.
>>
>> If we don't mask hotplug interrupts, we have a race condition.
> 
> I assume that a bus reset not only causes a link and presence event but
> also clears the Presence Detect State bit in the Slot Status register
> and the Data Link Layer Link Active bit in the Link Status register
> momentarily.
> 
> pciehp may access those two bits concurrently to the AER driver
> performing a slot reset.  So it may not be sufficient to mask
> the interrupt.
> 
> I've posted this patch to address the issue:
> https://patchwork.ozlabs.org/patch/930391/

Very interesting!

I missed this completely.

I know for a fact that bus reset clears the Data Link Layer Active bit
as soon as link goes down. It gets set again following link up.

Presence detect depends on the HW implementation. 

QDT root ports don't change presence detect for instance since nobody
actually removed the card.

If an implementation supports in-band presence detect, the answer is yes.
As soon as the link goes down, presence detect bit will get cleared until
recovery.

It sounds like we need to update your lock change with my proposal.

lock() in mask_irq() and unlock() in unmask_irq()

> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
