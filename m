Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D09C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44523BF3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC44523BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeGBWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:30:20 -0400
Received: from foss.arm.com ([217.140.101.70]:40556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbeGBWaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07F8618A;
        Mon,  2 Jul 2018 15:30:19 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F3513F2EA;
        Mon,  2 Jul 2018 15:30:18 -0700 (PDT)
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
Date:   Mon, 2 Jul 2018 17:30:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/02/2018 04:52 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 2, 2018 at 11:41 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> Hi,
>>
>> I'm experiencing two problems with commit 5088814a6e931 which is "ACPICA:
>> AML parser: attempt to continue loading table after error"
>>
>> The first is this boot failure on a thunderX2:
>>
>> [   10.770098] ACPI Error: Ignore error and continue table load
>> (20180531/psobject-604)
>>      [   10.777926] Unable to handle kernel NULL pointer dereference at
>>      [   10.950199] Call trace:
>>      [   10.952663]  acpi_ps_peek_opcode+0x1c/0x40
>>      [   10.956797]  acpi_ps_create_op+0x54/0x278
>>      [   10.960842]  acpi_ps_parse_loop+0x1b4/0x6c8
>>      [   10.965063]  acpi_ps_parse_aml+0xe0/0x2b4
>>      [   10.969108]  acpi_ps_execute_table+0xa0/0x104
>>      [   10.973505]  acpi_ns_execute_table+0x120/0x194
>>      [   10.977989]  acpi_ns_parse_table+0x34/0x68
>>      [   10.982122]  acpi_ns_load_table+0x4c/0xbc
>>      [   10.986169]  acpi_tb_load_namespace+0x1d4/0x240
>>      [   10.990744]  acpi_load_tables+0x50/0xbc
>>      [   10.994614]  acpi_init+0xb8/0x374
>>      [   10.997959]  do_one_initcall+0x54/0x208
>>      [   11.001829]  kernel_init_freeable+0x224/0x300
>>      [   11.006229]  kernel_init+0x18/0x118
>>      [   11.009747]  ret_from_fork+0x10/0x18
>>      [   11.013354] Code: aa0003f3 aa1e03e0 d503201f f9400661 (39400020)
>>      [   11.019535] ---[ end trace 2bd8068593cf8acc ]---
>>      [   11.024195] Kernel panic - not syncing: Fatal exception
>>      [   11.029488] SMP: stopping secondary CPUs
>>      [   11.033480] ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> Which does appear to be the result of some bad data in the table, but it was
>> working with 4.17, and reverting this commit solves the problem.
> 
> But this commit fixes another regression which was more widespread.
> 
> Apparently, we can't work around all of the errors in the tables out
> there at the same time. :-/

NP, Let me see if I can come up with a way to harden the 
parse_loop/create_op code enough that it doesn't crash the machine.

> 
>> Also the messages now newly being prefixed with '\n' are slightly corrupted
>> like:
>>
>> "3ACPI BIOS Error (bug):"
>>
>> because the KERN_XXX macro is being encoded after the CR which keeps it from
>> being processed correctly.
> 
> Yes, that's a known issue which should be fixed in -rc4.

Oh.. Yes I see that now, thanks.
