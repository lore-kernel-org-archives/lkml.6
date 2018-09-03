Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA466C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EC020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EC020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeICNRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:17:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54602 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeICNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:17:47 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=[192.168.0.145])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwkgs-0004TL-Gb; Mon, 03 Sep 2018 10:58:34 +0200
Date:   Mon, 3 Sep 2018 10:58:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V2 4/6] x86/efi: Add efi page fault handler to fixup/recover
 from page faults caused by firmware
In-Reply-To: <1535881594-25469-5-git-send-email-sai.praneeth.prakhya@intel.com>
Message-ID: <alpine.DEB.2.21.1809031053340.1349@nanos.tec.linutronix.de>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com> <1535881594-25469-5-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Sep 2018, Sai Praneeth Prakhya wrote:
> Kernel panics/hangs because the memory region requested by the firmware
> isn't mapped, which causes a page fault in ring 0 and the kernel fails
> to handle it, leading to die(). To save kernel from hanging, add an efi
> specific page fault handler which detects illegal accesses by the
> firmware and
> 1. If the illegally accessed region is EFI_BOOT_SERVICES_<CODE/DATA>,
>    the efi page fault handler fixes it up by mapping the requested
>    region.
> 2. If any other region (Eg: EFI_CONVENTIONAL_MEMORY or
>    EFI_LOADER_<CODE/DATA>), then the efi page fault handler freezes
>    efi_rts_wq and schedules a new process.
> 3. If the access is to any other efi region like above but if the efi
>    runtime service is efi_reset_system(), then the efi page fault
>    handler will reboot the machine through BIOS.
> 
> Illegal accesses to EFI_BOOT_SERVICES_<CODE/DATA> and to other regions
> are dealt differently in efi page fault handler because, *generally*
> EFI_BOOT_SERVICES_<CODE/DATA> regions are smaller in size relative to
> other efi regions and hence could be reserved and can be dynamically
> mapped. But other EFI regions like EFI_CONVENTIONAL_MEMORY and
> EFI_LOADER_<CODE/DATA> cannot be reserved as they are very huge in size
> and reserving them will make the kernel un-bootable.
> 
> The efi specific page fault handler offers us two advantages:
> 1. Avoid panics/hangs caused by buggy firmware.
> 2. Shout loud that the firmware is buggy and hence is not a kernel bug.
> 
> Finally, this new mapping will not impact a reboot from kexec, as kexec
> is only concerned about runtime memory regions.

No. This is just a horrible hack to make completely bogus firmware work and
never fixed.

The proper thing to do is to have a minimal page fault handler which does:

 1) Yell loudly if that ever happens

 2) Handles the reboot request gracefully

 3) Freeze and disable the EFI mess for all other cases

That does not require any hackery to make these mappings work from atomic
context and keeps the mess confined to the EFI code where it belongs.

Ideally we just blacklist the offending system and be done with it.

Thanks,

	tglx
