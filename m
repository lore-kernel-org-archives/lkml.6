Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF28CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868D620875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868D620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJEMt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeJEMtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 81A9C30001E8;
        Fri,  5 Oct 2018 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A15D117CCB;
        Fri,  5 Oct 2018 05:52:32 +0000 (UTC)
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
From:   lijiang <lijiang@redhat.com>
Message-ID: <0d1c112c-37b7-ee9d-b3d6-6d8e3df02d78@redhat.com>
Date:   Fri, 5 Oct 2018 13:52:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004190221.GA17667@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 05 Oct 2018 05:52:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月05日 03:02, Borislav Petkov 写道:
> On Thu, Oct 04, 2018 at 05:33:14PM +0800, lijiang wrote:
>> I have tested the patch again based on upstream 4.19.0-rc6, it works very well.
> 
> How have you tested this?
> 
> Please describe the steps in detail.
> 

There are eight steps:

Step 1: prepare for test tools, you might refer to the cover-letter.
     a. makedumpfile
     b. crash-7.2.3
     c. kexec-tools-2.0.17

     Compile and install these test tools.

Step 2: make sure that the kernel option is enabled if this machine has SME feature.
        CONFIG_AMD_MEM_ENCRYPT=y 

Step 3: apply these patches based on upstream v4.19-rc6, compile and install kernel
        #git am xxxx.patch
        #make ARCH=x86_64 -j32
        #make ARCH=x86_64 modules_install -j32
        #make ARCH=x86_64 install

Step 4: configure kdump and modify some parameters for SME
     a. configure kdump.conf
        #cat /etc/kdump.conf
        path /var/crash
        core_collector makedumpfile -l --message-level 1 -d 31

     b. add the parameter "mem_encrypt=on" for kernel command-line to grub.cfg, if
        this machine has SME feature. And also add crashkernel=xx, which will reserve
        memory for kdump.

Step 5: reboot, and then load the crash kernel image and kdump initramfs.

     a: When SME is enabled, i use this command to load them:

        #kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initramfs-4.19.0-rc6+kdump.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap mem_encrypt=on console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

     b: When SME is disabled, i use this command to load them:

        #kexec -p /boot/vmlinuz-4.19.0-rc6+ --initrd=/boot/initramfs-4.19.0-rc6+kdump.img --command-line="root=/dev/mapper/rhel_hp--dl385g10--03-root ro rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap mem_encrypt=off console=ttyS0,115200n81 LANG=en_US.UTF-8 earlyprintk=serial debug irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

Step 6: trigger panic by sysrq
        #echo c > /proc/sysrq-trigger

Step 7: check whether the vmcore has been created.

[root@hp-dl385g10-03 linux]# ls -al /var/crash/*
/var/crash/127.0.0.1-2018-10-05-01:20:20:
drwxr-xr-x. 2 root root         44 10月  5 01:20 .
drwxr-xr-x. 3 root root        107 10月  5 01:20 ..
-rw-------. 1 root root 1179265928 10月  5 01:20 vmcore
-rw-r--r--. 1 root root     126571 10月  5 01:20 vmcore-dmesg.txt

/var/crash/127.0.0.1-2018-10-05-01:35:21:
drwxr-xr-x. 2 root root         44 10月  5 01:35 .
drwxr-xr-x. 4 root root        144 10月  5 01:35 ..
-rw-------. 1 root root 1084270120 10月  5 01:35 vmcore
-rw-r--r--. 1 root root     125578 10月  5 01:35 vmcore-dmesg.txt

Step 8: check whether the crash tool can parse the vmcore
     a. When SME is enabled.
        #crash vmlinux /var/crash/127.0.0.1-2018-10-05-01\:20\:20/vmcore

crash 7.2.3++
Copyright (C) 2002-2017  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

WARNING: kernel relocated [308MB]: patching 85986 gdb minimal_symbol values

      KERNEL: vmlinux                                                  
    DUMPFILE: /var/crash/127.0.0.1-2018-10-05-01:20:20/vmcore  [PARTIAL DUMP]
        CPUS: 32
        DATE: Fri Oct  5 01:19:40 2018
      UPTIME: 00:04:04
LOAD AVERAGE: 0.18, 0.33, 0.16
       TASKS: 462
    NODENAME: hp-dl385g10-03.lab.eng.pek2.redhat.com
     RELEASE: 4.19.0-rc6+
     VERSION: #223 SMP Fri Oct 5 01:05:56 EDT 2018
     MACHINE: x86_64  (2095 Mhz)
      MEMORY: 31.8 GB
       PANIC: "sysrq: SysRq : Trigger a crash"
         PID: 9451
     COMMAND: "bash"
        TASK: ffff9d53c5f8c500  [THREAD_INFO: ffff9d53c5f8c500]
         CPU: 26
       STATE: TASK_RUNNING (SYSRQ)

crash> log
[    0.000000] Linux version 4.19.0-rc6+ (root@hp-dl385g10-03.lab.eng.pek2.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-34) (GCC)) #223 SMP Fri Oct 5 01:05:56 EDT 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.0-rc6+ root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=on crashkernel=2G,high rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000029920fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029921000-0x0000000029921fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029922000-0x0000000062242fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062243000-0x0000000062342fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000062343000-0x0000000062355fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000062356000-0x0000000062356fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000062357000-0x00000000623d5fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000623d6000-0x0000000062615fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000062616000-0x0000000062637fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062638000-0x0000000062697fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000062698000-0x0000000062757fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000062758000-0x0000000062758fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000062759000-0x0000000062789fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006278a000-0x000000006278cfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006278d000-0x00000000627d6fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000627d7000-0x00000000627d7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627d8000-0x000000006286afff] usable
[    0.000000] BIOS-e820: [mem 0x000000006286b000-0x000000006286efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006286f000-0x00000000682f8fff] usable
...
...
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] AMD Secure Memory Encryption (SME) active
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] ACPI: Core revision 20180810
...
...

     b. When SME is disabled.
        #crash vmlinux /var/crash/127.0.0.1-2018-10-05-01\:35\:21/vmcore

crash 7.2.3++
Copyright (C) 2002-2017  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

WARNING: kernel relocated [576MB]: patching 85986 gdb minimal_symbol values

      KERNEL: vmlinux                                                  
    DUMPFILE: /var/crash/127.0.0.1-2018-10-05-01:35:21/vmcore  [PARTIAL DUMP]
        CPUS: 32
        DATE: Fri Oct  5 01:34:44 2018
      UPTIME: 00:01:43
LOAD AVERAGE: 0.31, 0.20, 0.08
       TASKS: 456
    NODENAME: hp-dl385g10-03.lab.eng.pek2.redhat.com
     RELEASE: 4.19.0-rc6+
     VERSION: #223 SMP Fri Oct 5 01:05:56 EDT 2018
     MACHINE: x86_64  (2095 Mhz)
      MEMORY: 31.8 GB
       PANIC: "sysrq: SysRq : Trigger a crash"
         PID: 2093
     COMMAND: "bash"
        TASK: ffff9be9aa062e00  [THREAD_INFO: ffff9be9aa062e00]
         CPU: 12
       STATE: TASK_RUNNING (SYSRQ)

crash> log
[    0.000000] Linux version 4.19.0-rc6+ (root@hp-dl385g10-03.lab.eng.pek2.redhat.com) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-34) (GCC)) #223 SMP Fri Oct 5 01:05:56 EDT 2018
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.0-rc6+ root=/dev/mapper/rhel_hp--dl385g10--03-root ro mem_encrypt=off crashkernel=2G,high rd.lvm.lv=rhel_hp-dl385g10-03/root rd.lvm.lv=rhel_hp-dl385g10-03/swap console=ttyS0,115200n81 LANG=en_US.UTF-8
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000029920fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000029921000-0x0000000029921fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000029922000-0x00000000622dbfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000622dc000-0x000000006261bfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006261c000-0x000000006263dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006263e000-0x000000006269dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006269e000-0x00000000627d9fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000627da000-0x00000000627ecfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627ed000-0x00000000627edfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000627ee000-0x00000000627f1fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627f2000-0x00000000627f3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000627f4000-0x00000000627f4fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000627f5000-0x000000006286afff] usable
[    0.000000] BIOS-e820: [mem 0x000000006286b000-0x000000006286efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006286f000-0x00000000682f8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000682f9000-0x0000000068b05fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b06000-0x0000000068b09fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000068b0a000-0x0000000068b1afff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000068b1b000-0x0000000068b1dfff] ACPI NVS
...
...
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS0] enabled
[    0.000000] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000000] ACPI: Core revision 20180810
...
...

Regards,
Lianbo

> Thx.
> 
