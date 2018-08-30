Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FDBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCF52082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCF52082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeH3WMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:12:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbeH3WMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:12:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8693AFD8;
        Thu, 30 Aug 2018 18:08:53 +0000 (UTC)
Date:   Thu, 30 Aug 2018 20:08:49 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
Message-ID: <20180830180849.nmh646ehnolphq4v@suse.de>
References: <20180829201659.GA29801@roeck-us.net>
 <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
 <f6d9bdcd-98a6-fcf2-5308-936ffd714ea7@roeck-us.net>
 <20180830113059.qj6yvw4ggktc7yex@suse.de>
 <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:20:22AM -0700, Guenter Roeck wrote:
> Excellent.
> 
> In case it matters: I can use the same 32-bit efi image to boot a 64-bit kernel
> without problems.

Okay, I tracked it down. The 32-bit EFI code switches the CPU to the
read-write version of the GDT which is not mapped in the user
page-table. This obviously faults when the kernel entry/exit code
restores the segment registers.

Without a mapped GDT the #PF and #DF handlers also can't be started, so
the machine triple-faults. Below diff fixes it for me, I'll send a
proper patch tomorrow.

diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 324b93328b37..892edb4664fb 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -87,7 +87,7 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 {
 	struct desc_ptr gdt_descr;
 
-	gdt_descr.address = (unsigned long)get_cpu_gdt_rw(0);
+	gdt_descr.address = (unsigned long)get_cpu_gdt_ro(0);
 	gdt_descr.size = GDT_SIZE - 1;
 	load_gdt(&gdt_descr);
 
