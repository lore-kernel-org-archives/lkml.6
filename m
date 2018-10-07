Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1FC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830D52088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 06:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830D52088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJGNPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 09:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbeJGNPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 09:15:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DAC93082E4B;
        Sun,  7 Oct 2018 06:09:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA84F36FA;
        Sun,  7 Oct 2018 06:09:29 +0000 (UTC)
Subject: Re: [PATCH v8 RESEND 0/4] Support kdump for AMD secure memory
 encryption(SME)
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20181002114012.GB29859@zn.tnic>
 <43da68b1-fda0-c033-39e1-907d01f13354@redhat.com>
 <20181003113435.GB4436@zn.tnic>
 <dac69aae-27cf-9c93-a0ee-b65e241e1dd6@redhat.com>
 <20181004190221.GA17667@zn.tnic>
 <0d1c112c-37b7-ee9d-b3d6-6d8e3df02d78@redhat.com>
 <20181006095627.GA30555@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1ae4de5d-4857-4804-10ae-d415e79d861e@redhat.com>
Date:   Sun, 7 Oct 2018 14:09:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006095627.GA30555@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 07 Oct 2018 06:09:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月06日 17:56, Borislav Petkov 写道:
> On Fri, Oct 05, 2018 at 01:52:26PM +0800, lijiang wrote:
>>      b. add the parameter "mem_encrypt=on" for kernel command-line to grub.cfg, if
>>         this machine has SME feature. And also add crashkernel=xx, which will reserve
>>         memory for kdump.
> 
> Ok, I'm doing the simpler crashkernel= cmdline:
> 
> crashkernel=256M
> 
> That says:
> 
> [    0.011918] Reserving 256MB of memory at 640MB for crashkernel (System RAM: 262030MB)
> 
>> Step 5: reboot, and then load the crash kernel image and kdump initramfs.
>>
>>      a: When SME is enabled, i use this command to load them:
>>
>>         #kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initramfs-4.19.0-rc6+kdump.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap mem_encrypt=on console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"
> 
> Ok, did that, my cmdline is:
> 
> ~/bpetkov/src/kexec-tools/build/sbin/kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initrd-4.19.0-rc6+ --command-line="root=/dev/mapper/ubuntu--010236012132--vg-leap15 rd.lvm.lv=ubuntu--010236012132--vg-leap15/root rd.lvm.lv=ubuntu--010236012132--vg-leap15/swap splash=silent showopts console=ttyS5,115200 console=tty0 debug ignore_loglevel log_buf_len=16M nr_cpus=1 irqpoll maxcpus=1 reset_devices vga=normal mem_encrypt=on LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"
> 
> Verified it loaded ok:
> 
> $ grep . /sys/kernel/kexec_*
> /sys/kernel/kexec_crash_loaded:1
> /sys/kernel/kexec_crash_size:268435456
> /sys/kernel/kexec_loaded:0
> 
>> Step 6: trigger panic by sysrq
>>         #echo c > /proc/sysrq-trigger
> 
> Did that and I got into the kdump kernel with SME. So I'd guess your kdump
> kernel command line was needed - I was missing a bunch of switches and
> remote-debugging a box kexecing is not fun.
> 
> So thanks a lot for the detailed steps, I'm putting them to my notes.
> 

It's my pleasure.
Also thanks for your patience and help.

Regards,
Lianbo
