Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB0C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903620875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7903620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJFQ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 12:59:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726409AbeJFQ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 12:59:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92538ACD8;
        Sat,  6 Oct 2018 09:56:34 +0000 (UTC)
Date:   Sat, 6 Oct 2018 11:56:27 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
Message-ID: <20181006095627.GA30555@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
 <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
 <20181003113435.GB4436@zn.tnic>
 <dac69aae-27cf-9c93-a0ee-b65e241e1dd6@redhat.com>
 <20181004190221.GA17667@zn.tnic>
 <0d1c112c-37b7-ee9d-b3d6-6d8e3df02d78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d1c112c-37b7-ee9d-b3d6-6d8e3df02d78@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:52:26PM +0800, lijiang wrote:
>      b. add the parameter "mem_encrypt=on" for kernel command-line to grub.cfg, if
>         this machine has SME feature. And also add crashkernel=xx, which will reserve
>         memory for kdump.

Ok, I'm doing the simpler crashkernel= cmdline:

crashkernel=256M

That says:

[    0.011918] Reserving 256MB of memory at 640MB for crashkernel (System RAM: 262030MB)

> Step 5: reboot, and then load the crash kernel image and kdump initramfs.
> 
>      a: When SME is enabled, i use this command to load them:
> 
>         #kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initramfs-4.19.0-rc6+kdump.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap mem_encrypt=on console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

Ok, did that, my cmdline is:

~/bpetkov/src/kexec-tools/build/sbin/kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initrd-4.19.0-rc6+ --command-line="root=/dev/mapper/ubuntu--010236012132--vg-leap15 rd.lvm.lv=ubuntu--010236012132--vg-leap15/root rd.lvm.lv=ubuntu--010236012132--vg-leap15/swap splash=silent showopts console=ttyS5,115200 console=tty0 debug ignore_loglevel log_buf_len=16M nr_cpus=1 irqpoll maxcpus=1 reset_devices vga=normal mem_encrypt=on LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

Verified it loaded ok:

$ grep . /sys/kernel/kexec_*
/sys/kernel/kexec_crash_loaded:1
/sys/kernel/kexec_crash_size:268435456
/sys/kernel/kexec_loaded:0

> Step 6: trigger panic by sysrq
>         #echo c > /proc/sysrq-trigger

Did that and I got into the kdump kernel with SME. So I'd guess your kdump
kernel command line was needed - I was missing a bunch of switches and
remote-debugging a box kexecing is not fun.

So thanks a lot for the detailed steps, I'm putting them to my notes.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
