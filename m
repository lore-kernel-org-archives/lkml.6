Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947CDC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53A20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E53A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754469AbeGIK4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:56:43 -0400
Received: from foss.arm.com ([217.140.101.70]:56824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754432AbeGIK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:56:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D917C7A9;
        Mon,  9 Jul 2018 03:56:41 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7403F318;
        Mon,  9 Jul 2018 03:56:38 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] arm64: kexec,kdump: fix boot failures on acpi-only
 system
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, mark.rutland@arm.com,
        al.stone@linaro.org, graeme.gregory@linaro.org,
        hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20180709000750.22172-1-takahiro.akashi@linaro.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <f52f8607-ed7e-40fd-002c-13cb34bb0396@arm.com>
Date:   Mon, 9 Jul 2018 11:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709000750.22172-1-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 09/07/18 01:07, AKASHI Takahiro wrote:
> Patch#2 and #3 addresses kdump case. Ard's patch [4] needs to be applied
> preliminarily.

I missed this, and was then surprised by [0], when I tested kdump.

Could you re-post this with all the dependencies in the series? These changes
need to be tested together and merged at the same time, otherwise kdump can't be
tested and we risk the maintainer picking up broken code.


Thanks,

James


[0] failed kdump boot on Seattle
------------------%<------------------
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
Unable to handle kernel paging request at virtual address ffff2007
Mem abort info:
  ESR = 0x96000021
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000021
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
pgd=00000080ffdfd803, pud=00000080ffdfc803, pm3
Internal error: Oops: 96000021 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G S                4.18.0-1
Hardware name: AMD Overdrive/Supercharger/Default string, BIOS RO6
pstate: 10400005 (nzcV daif +PAN -UAO)
pc : acpi_ns_lookup+0x550/0x740
lr : acpi_ns_lookup+0x2f8/0x740
[...]
Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
Call trace:
 acpi_ns_lookup+0x550/0x740
 acpi_ds_load2_begin_op+0x568/0x87c
  acpi_ds_exec_begin_op+0x50/0x388
 acpi_ps_build_named_op+0x1cc/0x3dc
 acpi_ps_create_op+0x4f4/0x864
 acpi_ps_parse_loop+0x40c/0x133c
 acpi_ps_parse_aml+0x1f4/0x5a8
 acpi_ps_execute_table+0x24c/0x2e0
 acpi_ns_execute_table+0x354/0x408
 acpi_ns_parse_table+0x5c/0x94
 acpi_ns_load_table+0x40/0xf8
 acpi_tb_load_namespace+0x31c/0x510
 acpi_load_tables+0x48/0x13c
 acpi_init+0x170/0x5c8
 do_one_initcall+0xc0/0x2b0
 kernel_init_freeable+0x3d4/0x484
 kernel_init+0x10/0x118
 ret_from_fork+0x10/0x18
Code: f90037a2 aa1303e0 97dfd654 f94037a2 (b9400260)
---[ end trace d678006368422baa ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00b
------------------%<------------------
