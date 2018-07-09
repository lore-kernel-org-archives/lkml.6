Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A0220844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fz+isJ0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A0220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeGIXL0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:11:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44532 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932821AbeGIXLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:11:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so1564904pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWfylivQU2p7qN4G3gizYGOtE1qId/SCsxhHPXYAMik=;
        b=fz+isJ0w1IdiGXF2ERJ4v6jm6XECnrAf4HAfD5PLI1jOv90Pz47VythSpEXc4UwjGv
         URdFWPf28bOZErO/Av+J5IuKTwchLNCUOm0dlpTmoiyC2tN0QHQM8bjMGF0YHYEJxiV+
         /XH6oU8ptywUrwLZFZ87j6qP6M7t4nCsP8T7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RWfylivQU2p7qN4G3gizYGOtE1qId/SCsxhHPXYAMik=;
        b=cn4+fW5zdvna7KBiPIUUPa8nUQ6IU6FL6I9qyO6yowQZY+Q22QgsbuPDJk7WDY46/A
         ESRLqZk+HK1RcDkquJnmD+BF70eTzSb6LfXnWxFaYQ2RoPBDeBgeWPia1oEizDr3s+Cw
         Ky+dfGorS997Y45ue8XCYjNCDGMNE20yMuSBXtiJmHEWjQ/Sq7JDOlfqPZP7Sly3LrOf
         9xoUTi7eYo1Vs6dW4CVt03a63Tgz64Og61gfCnZr16cFv+ZHeIeQIWLG1CDO+jhkr57Q
         dd0KFWIWRWk0Hle606BaZtMxB+x++WkcfGqppHJDTZIF0neyRaHcSKiudjpoSgWt5Ydp
         WUQQ==
X-Gm-Message-State: APt69E2l3DSHxrBGyDD8NoY66y1IJ6/rt8KuS/FqjDOs275EMIg9Tloz
        l/k9YP5VHXuUudvl8iSEe6RORw==
X-Google-Smtp-Source: AAOMgpeVD1avF4ZVyHIUXr9NfjsxXfRVBGeQh7V0qEzqIbbsGWe6Rr8TZ26Bk0h+z/YW7dQ9QFKrlg==
X-Received: by 2002:a62:ea14:: with SMTP id t20-v6mr23257742pfh.117.1531177882795;
        Mon, 09 Jul 2018 16:11:22 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id v6-v6sm57980987pfa.28.2018.07.09.16.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:11:22 -0700 (PDT)
Date:   Tue, 10 Jul 2018 08:12:42 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, tbaicar@codeaurora.org,
        bhsharma@redhat.com, dyoung@redhat.com, mark.rutland@arm.com,
        al.stone@linaro.org, graeme.gregory@linaro.org,
        hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: kexec,kdump: fix boot failures on
 acpi-only system
Message-ID: <20180709231240.GV28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
References: <20180709000750.22172-1-takahiro.akashi@linaro.org>
 <f52f8607-ed7e-40fd-002c-13cb34bb0396@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52f8607-ed7e-40fd-002c-13cb34bb0396@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:56:36AM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 09/07/18 01:07, AKASHI Takahiro wrote:
> > Patch#2 and #3 addresses kdump case. Ard's patch [4] needs to be applied
> > preliminarily.
> 
> I missed this, and was then surprised by [0], when I tested kdump.
> 
> Could you re-post this with all the dependencies in the series? These changes

No problem, but I wonder why applying patch#2 didn't fail without
Ard's as apparently the context for the given hunk is different.
---
        efi_memmap_unmap(); <== here

+       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
...
---

-Takahiro AKASHI

> need to be tested together and merged at the same time, otherwise kdump can't be
> tested and we risk the maintainer picking up broken code.
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] failed kdump boot on Seattle
> ------------------%<------------------
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Added _OSI(Linux-Dell-Video)
> Unable to handle kernel paging request at virtual address ffff2007
> Mem abort info:
>   ESR = 0x96000021
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000021
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> pgd=00000080ffdfd803, pud=00000080ffdfc803, pm3
> Internal error: Oops: 96000021 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 1 Comm: swapper/0 Tainted: G S                4.18.0-1
> Hardware name: AMD Overdrive/Supercharger/Default string, BIOS RO6
> pstate: 10400005 (nzcV daif +PAN -UAO)
> pc : acpi_ns_lookup+0x550/0x740
> lr : acpi_ns_lookup+0x2f8/0x740
> [...]
> Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> Call trace:
>  acpi_ns_lookup+0x550/0x740
>  acpi_ds_load2_begin_op+0x568/0x87c
>   acpi_ds_exec_begin_op+0x50/0x388
>  acpi_ps_build_named_op+0x1cc/0x3dc
>  acpi_ps_create_op+0x4f4/0x864
>  acpi_ps_parse_loop+0x40c/0x133c
>  acpi_ps_parse_aml+0x1f4/0x5a8
>  acpi_ps_execute_table+0x24c/0x2e0
>  acpi_ns_execute_table+0x354/0x408
>  acpi_ns_parse_table+0x5c/0x94
>  acpi_ns_load_table+0x40/0xf8
>  acpi_tb_load_namespace+0x31c/0x510
>  acpi_load_tables+0x48/0x13c
>  acpi_init+0x170/0x5c8
>  do_one_initcall+0xc0/0x2b0
>  kernel_init_freeable+0x3d4/0x484
>  kernel_init+0x10/0x118
>  ret_from_fork+0x10/0x18
> Code: f90037a2 aa1303e0 97dfd654 f94037a2 (b9400260)
> ---[ end trace d678006368422baa ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00b
> ------------------%<------------------
