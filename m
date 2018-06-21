Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003D8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C71E2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Amj/ftND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C71E2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFUQ2M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:28:12 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:57373 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933369AbeFUQ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:28:10 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 46F2F1E04F7;
        Thu, 21 Jun 2018 18:28:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529598489; bh=jDqZQZQrb0pYu2UCl6VV1fYwvvZL4rzmxub0PwvYy5g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Amj/ftNDx42mjaw0SdHNlul37QkAU404YiqjMYjYErfM0eOqBpzaUUirqQoaii9IF
         p4pcsV0Rjn4HLz6VoiKm08OgsZbmpVTKWjgJBjPkbKPxfDTUmlg2PJqvkGM9dkWzaQ
         DPxOGzn0e3cQC04TZ4W1Xn5+nZYdEC3mxj7NF3SA05L94p0L4S3pphgZVz1jqrNdF8
         wKrx1C4p8IzBTLXml+I0N7p15dXMFbAn4WfuAwkIhyIA5veMWwWwP81QZ/VlfLE5hb
         Z9rtiZPKkX4iL1C/I+Em/cbwpsZG3oHfFXCcbCa7L/t07MF3Qc89MSHBDjH68ihc4n
         Iak6wJ7qxBLlQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9807939C0;
        Thu, 21 Jun 2018 09:28:08 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 09:28:08 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 18:28:06 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 21 Jun 2018 18:28:06 +0200
Subject: Re: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "eugeniy.paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e1d274a5ed756f86ced3df50538ef8c7e67ef4b6.1529589452.git.gustavo.pimentel@synopsys.com>
 <f845c9f6-a020-5a4c-3a66-52e36c9f3d72@synopsys.com>
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Message-ID: <69393589-e549-29f0-6272-b263539b82e8@synopsys.com>
Date:   Thu, 21 Jun 2018 17:26:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f845c9f6-a020-5a4c-3a66-52e36c9f3d72@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2018 17:07, Vineet Gupta wrote:
> On 06/21/2018 07:06 AM, Gustavo Pimentel wrote:
>> Add PCI support to the ARC HSDK platform allowing to use the generic PCI
>> setup functions.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
> 
> Queued to #for-curr after minor fixed up to commit msg subject "ARC: [plat-hsdk]"
> 
> Curious, how exactly are you going to use PCI on hsdk ? What is the use case.

The ARC HSDK board is mounted on top of a HAPS DX7 or HAPS-80 using the HT3
connectors. The HAPS DX7 or HAPS-80 provides the PCIe Root Complex using the
Synopsys DesignWare PCIe IP.

Basically I'm migrating the existing use case from ARC AXS101 to ARC HSDK.

> 
>> ---
>>  arch/arc/plat-hsdk/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
>> index 19ab3cf..556bc5e 100644
>> --- a/arch/arc/plat-hsdk/Kconfig
>> +++ b/arch/arc/plat-hsdk/Kconfig
>> @@ -9,3 +9,4 @@ menuconfig ARC_SOC_HSDK
>>  	bool "ARC HS Development Kit SOC"
>>  	select CLK_HSDK
>>  	select RESET_HSDK
>> +	select MIGHT_HAVE_PCI
> 

