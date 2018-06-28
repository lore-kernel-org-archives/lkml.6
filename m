Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B26C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259AE2714B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259AE2714B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeF1JRV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:17:21 -0400
Received: from foss.arm.com ([217.140.101.70]:43472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934758AbeF1JRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:17:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2FA180D;
        Thu, 28 Jun 2018 02:17:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8135C3F266;
        Thu, 28 Jun 2018 02:17:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 947EF1AE4DED; Thu, 28 Jun 2018 10:17:57 +0100 (BST)
Date:   Thu, 28 Jun 2018 10:17:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] arm64/kernel: jump_label: switch to relative
 references
Message-ID: <20180628091757.GA10751@arm.com>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-4-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627160604.8154-4-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:06:02PM +0200, Ard Biesheuvel wrote:
> On a randomly chosen distro kernel build for arm64, vmlinux.o shows the
> following sections, containing jump label entries, and the associated
> RELA relocation records, respectively:
> 
>   ...
>   [38088] __jump_table      PROGBITS         0000000000000000  00e19f30
>        000000000002ea10  0000000000000000  WA       0     0     8
>   [38089] .rela__jump_table RELA             0000000000000000  01fd8bb0
>        000000000008be30  0000000000000018   I      38178   38088     8
>   ...
> 
> In other words, we have 190 KB worth of 'struct jump_entry' instances,
> and 573 KB worth of RELA entries to relocate each entry's code, target
> and key members. This means the RELA section occupies 10% of the .init
> segment, and the two sections combined represent 5% of vmlinux's entire
> memory footprint.
> 
> So let's switch from 64-bit absolute references to 32-bit relative
> references: this reduces the size of the __jump_table by 50%, and gets
> rid of the RELA section entirely.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/jump_label.h | 16 ++++------------
>  arch/arm64/kernel/jump_label.c      |  6 +++---
>  3 files changed, 8 insertions(+), 15 deletions(-)

Looks good, cheers:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
