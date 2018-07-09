Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E49C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCCB20849
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCCB20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeGIUpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:45:04 -0400
Received: from foss.arm.com ([217.140.101.70]:37554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933209AbeGIUpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:45:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27EF680D;
        Mon,  9 Jul 2018 13:45:02 -0700 (PDT)
Received: from [10.119.48.106] (unknown [10.119.48.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4D03F589;
        Mon,  9 Jul 2018 13:45:01 -0700 (PDT)
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     erik.schmauss@intel.com,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <6074707.jx9F3QFrWC@aspire.rjw.lan>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
Date:   Mon, 9 Jul 2018 15:45:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6074707.jx9F3QFrWC@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First thanks for the patch..

On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
>> Hi,
>>
>> I'm experiencing two problems with commit 5088814a6e931 which is
>> "ACPICA: AML parser: attempt to continue loading table after error"
>>
>> The first is this boot failure on a thunderX2:
>>
>> [   10.770098] ACPI Error: Ignore error and continue table load

[trimming]

>> ]---
>>
>> Which does appear to be the result of some bad data in the table, but it
>> was working with 4.17, and reverting this commit solves the problem.
> 
> Does the patch below make any difference?
> 
> ---
>   drivers/acpi/acpica/psobject.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/acpi/acpica/psobject.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
> +++ linux-pm/drivers/acpi/acpica/psobject.c
> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
>   	ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
>   
>   	walk_state->aml = walk_state->parser_state.aml;
> +	if (!walk_state->aml)
> +		return AE_CTRL_PARSE_CONTINUE;
> +

Well this seems to avoid the crash, but now it hangs right after on the 
"Ignore error and continue table load" message. I would post the DSDT 
but I'm borrowing this machine, and I understand the firmware to be an 
early release, so...

Anyway, now that I have access again, i'm turning up the debug 
messaging, let me see if that points at whats causing the hang.


Thanks,



