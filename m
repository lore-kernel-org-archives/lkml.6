Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09AF2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09AF2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeHVNrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:47:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbeHVNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9FD44023ECB;
        Wed, 22 Aug 2018 10:23:18 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4F32166BA1;
        Wed, 22 Aug 2018 10:23:14 +0000 (UTC)
Date:   Wed, 22 Aug 2018 18:23:10 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mike Galbraith <efault@gmx.de>, Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
Message-ID: <20180822102310.GA19827@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
 <1533800010.5087.71.camel@gmx.de>
 <20180809091333.GA8008@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8KKwNkUdx7tSxEosRvydxmQ2yaasHRJn_LcHPs7p2UYQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 10:23:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 10:23:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/18 at 03:39pm, Ard Biesheuvel wrote:
> On 9 August 2018 at 11:13, Dave Young <dyoung@redhat.com> wrote:
> > On 08/09/18 at 09:33am, Mike Galbraith wrote:
> >> On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> >> > Hi Mike,
> >> >
> >> > Thanks for the patch!
> >> > On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> >> > > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> >> > > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> >> > > that and a useless allocation when the only mapping we can use (1:1)
> >> > > is not available.
> >> >
> >> > At first glance, efi_get_runtime_map_size should return 0 in case
> >> > noruntime.
> >>
> >> What efi does internally at unmap time is to leave everything except
> >> efi.mmap.map untouched, setting it to NULL and turning off EFI_MEMMAP,
> >> rendering efi.mmap.map accessors useless/unsafe without first checking
> >> EFI_MEMMAP.
> >
> > Probably the x86 efi_init should reset nr_map to zero in case runtime is
> > disabled.  But let's see how Ard thinks about this and cc linux-efi.
> >
> > As for efi_get_runtime_map_size, it was introduced for x86 kexec use.
> > for copying runtime maps,  so I think it is reasonable this function
> > return zero in case no runtime.
> >
> 
> I don't see the patch in the context so I cannot comment in great detail.

The patch is below:
https://lore.kernel.org/lkml/1533737025.4936.3.camel@gmx.de

> 
> In any case, it is better to decouple EFI_MEMMAP from EFI_RUNTIME
> dependencies. On x86, one may imply the other, but this is not
> generally the case.
> 
> That means that efi_get_runtime_map_size() should probably check the
> EFI_RUNTIME flag, and return 0 if it is cleared. Perhaps there are
> other places where EFI_MEMMAP flag checks are missing, but I consider
> that a separate issue.

Yes, I also agree with to check EFI_RUNTIME_SERVICES. There is no point for
efi_get_runtime_map_size to return a value other than 0 in case EFI_RUNTIME_SERVICES
is not set ie. via efi=noruntime

Is below patch acceptable?  The copy function can be changed to return
an error in case map size == 0, but that can be done later along with
the caller size cleanups in kexec code
---------------------------------------------------------------------------

efi: check EFI_RUNTIME_SERVICES flag in runtime map copying code

Mike reported a kexec_file_load NULL pointer dereference bug like below:
[    5.878262] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[    5.879868] PGD 800000013c1f1067 P4D 800000013c1f1067 PUD 13aea7067 PMD 0 
[    5.881225] Oops: 0000 [#1] SMP PTI
[    5.882068] Modules linked in:
[    5.882851] CPU: 0 PID: 394 Comm: kexec Kdump: loaded Not tainted 4.17.0-rc2+ #648
[    5.884333] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    5.885843] RIP: 0010:memcpy_erms+0x6/0x10
[    5.886789] RSP: 0018:ffffc9000058bd00 EFLAGS: 00010246
[    5.887899] RAX: ffff880138e050b0 RBX: 00000000000980b0 RCX: 0000000000000ba0
[    5.889304] RDX: 0000000000000ba0 RSI: 0000000000000000 RDI: ffff880138e050b0
[    5.890977] RBP: ffff880138e04000 R08: 0000000000000017 R09: 0000000000000002
[    5.892524] R10: 0000000000099000 R11: 00000000000052d0 R12: 0000000039400200
[    5.893967] R13: ffff880138e05000 R14: 0000000000000ba0 R15: ffffc90000a4d000
[    5.895378] FS:  00007f167c9e6740(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
[    5.896953] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.898143] CR2: 0000000000000000 CR3: 000000013c3ec002 CR4: 00000000001606f0
[    5.899542] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    5.900962] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    5.902552] Call Trace:
[    5.903267]  efi_runtime_map_copy+0x28/0x30
[    5.904956]  bzImage64_load+0x59d/0x736
[    5.906881]  ? arch_kexec_kernel_image_load+0x6d/0x70
[    5.908243]  ? __se_sys_kexec_file_load+0x24b/0x750
[    5.909352]  ? _cond_resched+0x19/0x30
[    5.910286]  ? do_syscall_64+0x65/0x180
[    5.911229]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.912365] Code: 90 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 
[    5.916235] RIP: memcpy_erms+0x6/0x10 RSP: ffffc9000058bd00
[    5.917507] CR2: 0000000000000000
[    5.918762] ---[ end trace 5cf4c4b3b93d7fdd ]---

Changing efi_get_runtime_map_size to return 0 in case runtime is
disabled.

Also moving to check EFI_RUNTIME_SERVICES in efi_runtime_map_copy 

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 drivers/firmware/efi/runtime-map.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- linux-x86.orig/drivers/firmware/efi/runtime-map.c
+++ linux-x86/drivers/firmware/efi/runtime-map.c
@@ -138,12 +138,18 @@ add_sysfs_runtime_map_entry(struct kobje
 
 int efi_get_runtime_map_size(void)
 {
-	return efi.memmap.nr_map * efi.memmap.desc_size;
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		return efi.memmap.nr_map * efi.memmap.desc_size;
+
+	return 0;
 }
 
 int efi_get_runtime_map_desc_size(void)
 {
-	return efi.memmap.desc_size;
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		return efi.memmap.desc_size;
+
+	return 0;
 }
 
 int efi_runtime_map_copy(void *buf, size_t bufsz)
@@ -163,7 +169,7 @@ int __init efi_runtime_map_init(struct k
 	struct efi_runtime_map_entry *entry;
 	efi_memory_desc_t *md;
 
-	if (!efi_enabled(EFI_MEMMAP))
+	if (!efi_enabled(EFI_RUNTIME_SERVICES))
 		return 0;
 
 	map_entries = kcalloc(efi.memmap.nr_map, sizeof(entry), GFP_KERNEL);

