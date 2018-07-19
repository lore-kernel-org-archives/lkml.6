Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2664ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39F02084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 11:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39F02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGSMOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:14:01 -0400
Received: from foss.arm.com ([217.140.101.70]:48110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730053AbeGSMOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:14:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBCF97A9;
        Thu, 19 Jul 2018 04:31:16 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050CE3F246;
        Thu, 19 Jul 2018 04:31:14 -0700 (PDT)
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, bhupesh.linux@gmail.com,
        takahiro.akashi@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
Date:   Thu, 19 Jul 2018 12:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 18/07/18 22:37, Bhupesh Sharma wrote:
> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
> 
> makedumpfile user-space utility will need fixup to use this KASLR offset
> to work with cases where we need to find a way to translate symbol
> address from vmlinux to kernel run time address in case of KASLR boot on
> arm64.

You need the kernel VA for a symbol. Isn't this what kallsyms is for?
| root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
| ffff5404610d0000 B swapper_pg_dir

This is the KASLR address, the vmlinux has:
| root@frikadeller:~/linux/build_arm64# nm -s vmlinux | grep swapper_pg_dir
| ffff0000096d0000 B swapper_pg_dir


This is in the vmcoreinfo too, so you can work if out from the vmcore too:
| root@frikadeller:~# dd if=/proc/kcore bs=8K count=1 2>/dev/null | strings |
| grep swapper_pg_dir
| SYMBOL(swapper_pg_dir)=ffff5404610d0000


I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
to work out this offset. (you should expect the kernel to rename these symbols
at a whim).


Thanks,

James
