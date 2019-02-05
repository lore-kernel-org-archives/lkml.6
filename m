Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272CEC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075BF20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfBERbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:31:37 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfBERbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:31:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E55FEBD;
        Tue,  5 Feb 2019 09:31:35 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDEC93F719;
        Tue,  5 Feb 2019 09:31:27 -0800 (PST)
Subject: Re: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
To:     Rui Zhao <ruizhao@microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
 <MW2PR2101MB09708B7F11BDEE6755CC9F03B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <efc7fba8-dbff-844c-2995-28cbd5f015c0@arm.com>
Date:   Tue, 5 Feb 2019 17:31:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB09708B7F11BDEE6755CC9F03B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 23/01/2019 22:08, Rui Zhao wrote:
> On Wednesday, January 23, 2019 10:36 AM, James Morse wrote:
>>> If firmware enables it, they're suppose to handle the interrupt.

>> Ah, so you still have resident firmware!
>> How come your firmware trusts linux not to turn off the memory controller?!
>> These things are usually protected by trust zone so the OS can't pull the memory from under firmware's feet.

> We have firmware to config the memory controller and want to have an EDAC driver to report ECC status.

> Could you please elaborate a bit on the security concern on this approach? Like some malicious app/driver can access
> memory controller registers can cause issue? 

I'm remembering this:
https://lore.kernel.org/linux-arm-kernel/9b9c4cd5-4428-c08d-d4a3-7352c6c80583@arm.com/

Robin Murphy wrote:
| [ For anyone interested, it puts the DRAM controller into sleep mode.
| The kernel can't even panic if all the memory suddenly disappears :D ]

This would be a problem if you need your Secure-world software needs to keep
working, and depends on the memory behind this controller.

It might be that your secure-world software only uses some other memory, in
which case this wouldn't matter.
It may be linux _is_ your secure-world software, in which case it wouldn't
matter either.


> What's the recommend approach if Linux won't be able to access memory controller
> registers? Have firmware do the ECC 
> status monitoring and some sort of driver to query ECC status from firmware?

If Linux runs in the normal-world, can't you use trust-zone to prevent Linux
from accessing the memory controller?

If you did this, you'd need to handle the UE interrupts in firmware, and
wouldn't be able to use this driver in linux. Your platform hasn't gone this
way, so I guess one of the above cases applies.


Thanks,

James
