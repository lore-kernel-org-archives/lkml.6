Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2DBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0374820870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShKiuY4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0374820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeG3X2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:28:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbeG3X2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:28:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so14409700wrt.2;
        Mon, 30 Jul 2018 14:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWjasJr5e7KOkng2PLbjeRmPCO7dsWyfHHCicCqxM/M=;
        b=ShKiuY4C0EJR0eDo1PRW7/np7BYWIE1ywyPa9URpx8WiQ9Xw0PWytGNTfFZo/PaNTb
         felEqJka8oLCUt8/lt3e4a34Dc7cm0um8IFJDZK50WucKtC0+SkUy4EgEFZedYG8XOeg
         /Y+VzqxPvg4QHJsi8/1N8NgRRbwSITPcnipP+HcPC2gzdxCP41SLMkQ/G2xAMrpe3T1x
         oARJyD0IjYsTOIShizS7bDkfJImbgXVHBHUwio9kJLPkzzOVf8lQzR17PFloXo1BzhO2
         9NOOnVbd48q8YaHDzC8WMCL+BRs77qWgPQ5t1cpBZRYrXLkmyZLbFLAFy108g3KSG5Iu
         QICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWjasJr5e7KOkng2PLbjeRmPCO7dsWyfHHCicCqxM/M=;
        b=JkLtJaOqAlMQ8LQpeaNumYLDmvtYzfze6qchE0NWOoY6zIH7YCRRBaQ0ZFz+EbHAgH
         0tbepLPlQZ1zvhoTNBwo/LbC5AsgIR3I/BZhsDFTCtQOKrWwj0qj3nntcrGx4FgtjeVP
         CeT589YP0M82tiZMS0TbWjJz/lYqkm06UWcAfY7uLjVSmuGWekC8xU0Rql51t4CJ79Lt
         VEVSvHQ+sqHdXdLsrJ3LK0+ZeFb4YVhP6l/luDSAfDBDyFf+WcU+P4+b+ctQ7NzdwRP1
         Bd9R38qlekujrVFV7kzyw2SdcCKbwvKzdrd2K5sgQ+Ik/dNixfsJy0hfRAJarcFYBCBR
         6M9g==
X-Gm-Message-State: AOUpUlGjuZG94YEKrxXR6ZgC4k1aaSOobrBiWljnWBKaSS5WIAIFZBee
        /RPaBw2OqTrWXoseGQOPIn+IXp4V
X-Google-Smtp-Source: AAOMgpeoj2oFaodKPmWaLFSuiN/l4EUn2NSxot84pMystd/SHSh3xN1XwD27h1IwgLxaARp9EMqM4g==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr18898070wrr.236.1532987460349;
        Mon, 30 Jul 2018 14:51:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:d580:2cd1:953b:4fdd? (p200300EA8BD4D600D5802CD1953B4FDD.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:d580:2cd1:953b:4fdd])
        by smtp.googlemail.com with ESMTPSA id b13-v6sm20629958wrn.17.2018.07.30.14.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 14:50:59 -0700 (PDT)
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d4666725-b459-832d-fb29-25ce930debe2@gmail.com>
Date:   Mon, 30 Jul 2018 23:50:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.2018 23:30, Bjorn Helgaas wrote:
> [+cc Thomas, Christoph, LKML]
> 
> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> If we have a threaded interrupt with the handler being NULL, then
>> request_threaded_irq() -> __setup_irq() will complain and bail out
>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> being NULL and set IRQF_ONESHOT in this case.
>>
>> This change is needed to migrate the mei_me driver to
>> pci_alloc_irq_vectors() and pci_request_irq().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/
> 
Sure.

That's the related comment in __setup_irq():

 * The interrupt was requested with handler = NULL, so
 * we use the default primary handler for it. But it
 * does not have the oneshot flag set. In combination
 * with level interrupts this is deadly, because the
 * default primary handler just wakes the thread, then
 * the irq lines is reenabled, but the device still
 * has the level irq asserted. Rinse and repeat....
 *
 * While this works for edge type interrupts, we play
 * it safe and reject unconditionally because we can't
 * say for sure which type this interrupt really
 * has. The type flags are unreliable as the
 * underlying chip implementation can override them.
 */


>> ---
>>  drivers/pci/irq.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
>> index 2a808e10..a1de501a 100644
>> --- a/drivers/pci/irq.c
>> +++ b/drivers/pci/irq.c
>> @@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>>  	va_list ap;
>>  	int ret;
>>  	char *devname;
>> +	unsigned long irqflags = IRQF_SHARED;
>> +
>> +	if (!handler)
>> +		irqflags |= IRQF_ONESHOT;
>>  
>>  	va_start(ap, fmt);
>>  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
>>  	va_end(ap);
>>  
>>  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
>> -			IRQF_SHARED, devname, dev_id);
>> +				   irqflags, devname, dev_id);
>>  	if (ret)
>>  		kfree(devname);
>>  	return ret;
>> -- 
>> 2.18.0
>>
> 

