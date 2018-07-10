Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DDC2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DDC2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933246AbeGJDoO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:44:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40270 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932939AbeGJDoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:44:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E827A7A9;
        Mon,  9 Jul 2018 20:44:06 -0700 (PDT)
Received: from [10.119.48.106] (unknown [10.119.48.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 494CB3F5A0;
        Mon,  9 Jul 2018 20:44:06 -0700 (PDT)
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <6074707.jx9F3QFrWC@aspire.rjw.lan>
 <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
 <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <218e4339-477d-eb0d-6007-764c8e24229f@arm.com>
Date:   Mon, 9 Jul 2018 22:44:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/09/2018 04:28 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 9, 2018 at 10:45 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> Hi,
>>
>> First thanks for the patch..
>>
>> On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
>>>
>>> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm experiencing two problems with commit 5088814a6e931 which is
>>>> "ACPICA: AML parser: attempt to continue loading table after error"
>>>>
>>>> The first is this boot failure on a thunderX2:
>>>>
>>>> [   10.770098] ACPI Error: Ignore error and continue table load
>>
>>
>> [trimming]
>>
>>>> ]---
>>>>
>>>> Which does appear to be the result of some bad data in the table, but it
>>>> was working with 4.17, and reverting this commit solves the problem.
>>>
>>>
>>> Does the patch below make any difference?
>>>
>>> ---
>>>    drivers/acpi/acpica/psobject.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> Index: linux-pm/drivers/acpi/acpica/psobject.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
>>> +++ linux-pm/drivers/acpi/acpica/psobject.c
>>> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
>>>          ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
>>>          walk_state->aml = walk_state->parser_state.aml;
>>> +       if (!walk_state->aml)
>>> +               return AE_CTRL_PARSE_CONTINUE;
>>> +
>>
>>
>> Well this seems to avoid the crash, but now it hangs right after on the
>> "Ignore error and continue table load" message.
> 
> Well, maybe we should just abort in that case.
> 
> I'm wondering what happens if you replace the return statement in the
> patch above with
> 
> return_ACPI_STATUS(AE_AML_BAD_OPCODE)

Yes, that is where I went when I applied the patch but I used 
AE_CTRL_TERMINATE, which terminates the loop in acpi_ps_parse_loop() and 
that appears to successfully finish/terminate the initial parsing pass. 
But, it then crashes in acpi_ns_lookup called via the 
acpi_walk_resources sequences that goes through ut_evalute_object() due 
to the path/scope_info->scope.node being ACPI_ROOT_OBJECT (-1) and 
bypassing the null check. Adding a ACPI_ROOT_OBJECT check as well as the 
null checks in acpi_ns_lookup results in a successful boot. Tracking 
down how the terminate (or whatever) is leaving the info->prefix_node 
(in acpi_ns_evaluate) set to ROOT_OBJECT instead of null, is something I 
don't yet understand.

Anyway, I tried Using BAD_OPCODE rather than TERMINATE and it seems to 
have the same basic result as PARSE_CONTINUE.


