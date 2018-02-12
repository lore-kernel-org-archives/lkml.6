Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932726AbeBLEGP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 23:06:15 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32776 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932477AbeBLEGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 23:06:14 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36994962"
Subject: Re: [PATCH v3 0/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ebiederm@xmission.com>
CC: <mingo@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <joro@8bytes.org>, <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <caff6f56-d8e3-1c61-e23b-1d335b6771a2@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 12:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180209121008.28980-1-bhe@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 2BDF248AE763.AD285
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

One thing confused me.

The disconnect_bsp_APIC() may restore the interrupt delivery mode into
virtual wire mode. it uses the vector F as the spurious interrput, But,
IMO, using the vector 0xFF(SPURIOUS_APIC_VECTOR) may more suitable and
will give us more detail. Why the disconnect_bsp_APIC() use vector F
here?

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 25ddf02598d2..550deaad6a9a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2130,7 +2130,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
         value = apic_read(APIC_SPIV);
         value &= ~APIC_VECTOR_MASK;
         value |= APIC_SPIV_APIC_ENABLED;
-       value |= 0xf;
+       value |= SPURIOUS_APIC_VECTOR;
         apic_write(APIC_SPIV, value);

         if (!virt_wire_setup) {

Thanks,
	dou

At 02/09/2018 08:10 PM, Baoquan He wrote:
> A regression bug was introduced in below commit.
> commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
> 
> It caused the action to fail which we try to restore boot irq mode
> in reboot and kexec/kdump. Details can be seen in patch 0002.
> 
> Warning can always be seen during kdump kernel boot on qemu/kvm
> platform. Our customer even saw casual kdump kernel hang once in
> ~30 attempts during stress testing of kdump on KVM machine.
> 
> This is v3 post, patches are rearranged and changed according to
> Eric's suggestions.
> 
> Baoquan He (5):
>    x86/apic: Split out restore_boot_irq_mode from disable_IO_APIC
>    x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
>    x86/apic: Remove useless disable_IO_APIC
>    x86/apic: Rename variable/function related to x86_io_apic_ops
>    x86/apic: Set up through-local-APIC on boot CPU if 'noapic' specified
> 
>   arch/x86/include/asm/io_apic.h     |  9 +++++----
>   arch/x86/include/asm/x86_init.h    |  8 ++++----
>   arch/x86/kernel/apic/apic.c        |  2 +-
>   arch/x86/kernel/apic/io_apic.c     | 16 ++++------------
>   arch/x86/kernel/crash.c            |  3 ++-
>   arch/x86/kernel/machine_kexec_32.c |  7 +++----
>   arch/x86/kernel/machine_kexec_64.c |  7 +++----
>   arch/x86/kernel/reboot.c           |  3 ++-
>   arch/x86/kernel/x86_init.c         |  6 +++---
>   arch/x86/xen/apic.c                |  2 +-
>   drivers/iommu/irq_remapping.c      |  4 ++--
>   11 files changed, 30 insertions(+), 37 deletions(-)
> 
