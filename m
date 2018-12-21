Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B9720989
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391513AbeLUSwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:52:24 -0500
Received: from foss.arm.com ([217.140.101.70]:56798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbeLUSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:52:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1D380D;
        Fri, 21 Dec 2018 10:52:23 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25A03F575;
        Fri, 21 Dec 2018 10:52:21 -0800 (PST)
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
To:     Borislav Petkov <bp@alien8.de>, David Arcari <darcari@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
 <20181220192447.GG31403@zn.tnic> <1691682.ckC9UJvgEr@aspire.rjw.lan>
From:   James Morse <james.morse@arm.com>
Message-ID: <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
Date:   Fri, 21 Dec 2018 18:52:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1691682.ckC9UJvgEr@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2018 11:17, Rafael J. Wysocki wrote:
> On Thursday, December 20, 2018 8:24:47 PM CET Borislav Petkov wrote:
>> + James.

Thanks,

>> On Wed, Dec 19, 2018 at 11:50:52AM -0500, David Arcari wrote:
>>> From: Lenny Szubowicz <lszubowi@redhat.com>
>>>
>>> In __ghes_panic() clear the block status in the APEI generic
>>> error status block for that generic hardware error source before
>>> calling panic() to prevent a second panic() in the crash kernel
>>> for exactly the same fatal error.
>>>
>>> Otherwise ghes_probe(), running in the crash kernel, would see
>>> an unhandled error in the APEI generic error status block and
>>> panic again, thereby precluding any crash dump.

I bet that was fun to watch!


>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 02c6fd9..f008ba7 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
>>>  {
>>>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
>>>  
>>> +	ghes_clear_estatus(ghes);
>>> +
>>>  	/* reboot to log the error! */
>>>  	if (!panic_timeout)
>>>  		panic_timeout = ghes_panic_timeout;
>>
>> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Patch applied, thanks!

Great!

Do we need to ghes_ack_error() too?

With the location cleared the new kernel will never find the records, and
firmware can never re-use that location because it wasn't ack'd. The upshot is
RAS records can't be generated for the kdump kernel. The acpi spec talks about
use of the memory, so I don't think its fair for it to use this to disarm a
watchdog.

I think we can live with this as the kdump kernel isn't going to handle RAS
errors for the bulk of memory anyway.


Thanks,

James
