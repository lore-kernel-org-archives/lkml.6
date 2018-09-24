Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBD321473
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBD321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIXHIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeIXHIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:08:07 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78CD021471;
        Mon, 24 Sep 2018 01:08:24 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] System call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <b42ac34f-ab67-5d5c-1d6f-354af40773d8@linux-m68k.org>
Date:   Mon, 24 Sep 2018 11:08:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On 21/09/18 01:06, Firoz Khan wrote:
> The purpose of this patch series is:
> 1. We can easily add/modify/delete system call by changing entry
> in syscall.tbl file. No need to manually edit many files.
> 
> 2. It is easy to unify the system call implementation across all
> the architectures.
> 
> The system call tables are in different format in all architecture
> and it will be difficult to manually add or modify the system calls
> in the respective files manually. To make it easy by keeping a script
> and which'll generate the header file and syscall table file so this
> change will unify them across all architectures.
> 
> syscall.tbl contains the list of available system calls along with
> system call number and corresponding entry point. Add a new system
> call in this architecture will be possible by adding new entry in
> the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>          - System call number.
>          - ABI.
>          - System call name.
>          - Entry point name.
>          - Compat entry name, if required.
> 
> ARM, s390 and x86 architecuture does exist the similar support. I
> leverage their implementation to come up with a generic solution.
> 
> I have done the same support for work for alpha, microblaze, sparc,
> mips, parisc, powerpc, sh, sparc, and xtensa. But I started sending
> the patch for one architecuture for review. Below mentioned git
> repository contains more details.
> Git repo:- https://github.com/frzkhn/system_call_table_generator/
> 
> Added an extra patch to keep __IGNORE* entries in asm/unistd.h.
> 
> Finally, this is the ground work for solving the Y2038 issue. We
> need to add/change two dozen of system calls to solve Y2038 issue.
> So this patch series will help to easily modify from existing
> system call to Y2038 compatible system calls.
>
> Firoz Khan (5):
>    m68k: Rename system call table file name
>    m68k: Replace NR_syscalls macro from asm/unistd.h
>    m68k: Added system call table generation support
>    m68k: uapi header and system call table file generation
>    m68k: added __IGNORE* entries in asm/unistd.h

Built and tested on a couple of m68k/ColdFire targets,
m520x (no MMU) and m5475 (with MMU). Load and run on real hardware,
no problems found. So for m68knommu/ColdFire:

Tested-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


>   arch/m68k/Makefile                      |   3 +
>   arch/m68k/include/asm/Kbuild            |   1 +
>   arch/m68k/include/asm/unistd.h          |  10 +-
>   arch/m68k/include/uapi/asm/Kbuild       |   1 +
>   arch/m68k/include/uapi/asm/unistd.h     | 385 +-----------------------------
>   arch/m68k/kernel/Makefile               |   2 +-
>   arch/m68k/kernel/syscall_table.S        |  14 ++
>   arch/m68k/kernel/syscalls/Makefile      |  37 +++
>   arch/m68k/kernel/syscalls/syscall.tbl   | 369 +++++++++++++++++++++++++++++
>   arch/m68k/kernel/syscalls/syscallhdr.sh |  39 ++++
>   arch/m68k/kernel/syscalls/syscalltbl.sh |  28 +++
>   arch/m68k/kernel/syscalltable.S         | 403 --------------------------------
>   12 files changed, 502 insertions(+), 790 deletions(-)
>   create mode 100644 arch/m68k/kernel/syscall_table.S
>   create mode 100644 arch/m68k/kernel/syscalls/Makefile
>   create mode 100644 arch/m68k/kernel/syscalls/syscall.tbl
>   create mode 100644 arch/m68k/kernel/syscalls/syscallhdr.sh
>   create mode 100644 arch/m68k/kernel/syscalls/syscalltbl.sh
>   delete mode 100644 arch/m68k/kernel/syscalltable.S
> 
