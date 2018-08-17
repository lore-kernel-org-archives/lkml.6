Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED003C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9042199E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E32UGrgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9042199E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeHRBcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:32:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43427 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeHRBcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:32:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so4059383pfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VFfDhWbVS5e+GcXg/1QosHbwhqNZCPItRpza38XzhM8=;
        b=E32UGrgXUHQIx4Aac/EXl8xN/bX5qhoXeDMIOHBCzPTcx16JAWmq7Ib3qGDnFKbVUg
         rkCa4MSxYlJZ/PP1JKty4LYg/Ce4Pg9r64sAxyUTMdMDj5ztJYJpyqrWgX1i9ILexzih
         gPfdlvnMBxt4tuivS9FkCB3Qb3K7qThoSE5cmHs5sXZ5qsxNzLPji4BHnnqDy+0amSuM
         9YiSipurJAH7IZBcEI5XC600Sa1O0zH7i/Ycr+9r+GKiIsBaqqXSojM6298QnEJedme2
         pbBopFuoDHkuygf/kKMiC6VN5CpWgEp6i0JqDKIhCaBCCcamYb5Qlv9OnA9cXpQZJqL8
         semg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=VFfDhWbVS5e+GcXg/1QosHbwhqNZCPItRpza38XzhM8=;
        b=niEjm2iyWyMbc+GKAzCbL07sgO4v26/c1FRAnFnJ3aK4FoezMDhnsSKfb1jhVZHLqI
         pYZoLno8vYOGmI3aMpKkxZ26xKeojKuETY4sLsS2HAt286WRqTG9Rkolx5xfBxsiVnRu
         y4GrCSIBhe43qrqJExBXQ8KgTaXtEIe1jJCZ/B9ClUBsSKXCzyb1GcE9ZowxVckyp6MD
         YS+ChXvVhNHN4Agd0q9+sG0kzXeKF7kfxDAafjPvIfI2BKuedDWilFYt6iUokSoT4zJx
         wDNf02U6o/CfB0ER8hv0Xbz3b4i3dFOlleqDN76VhYQn4Jq9sJ2+qqMGwmD+AH1H1p5p
         0dGA==
X-Gm-Message-State: AOUpUlFo8t11AfdK0UbW2IiIgtzrk5THuxhZWLLS8txmvFcLBYHPDzN7
        sBijXp3Bwa1sLJfSiTKVyLqSrz9o
X-Google-Smtp-Source: AA+uWPxTjT8X/fo646OhOhttYqcnb12+qPdciIZJOZzZCkAMw2OThjVbn02CS3kwfkfmej7Qrk0liw==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr38159190pfk.92.1534544855431;
        Fri, 17 Aug 2018 15:27:35 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a77-v6sm6290687pfj.38.2018.08.17.15.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 15:27:34 -0700 (PDT)
Date:   Fri, 17 Aug 2018 15:27:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        dvyukov@google.com, hughd@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE enabled
Message-ID: <20180817222733.GA18575@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following crash is seen in v4.4.148, v4.4.149, v4.9.120, and v4.9.121
with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y.

[    6.649970] random: crng init done
[    6.689002] BUG: unable to handle kernel paging request at ffffeafffa1a0020
[    6.689082] IP: [<ffffffff8116ba10>] page_remove_rmap+0x10/0x230
[    6.689082] PGD 0 [    6.689082] 
[    6.689082] Oops: 0000 [#1] SMP
[    6.689082] Modules linked in:
[    6.689082] CPU: 3 PID: 1132 Comm: mmtest Not tainted 4.9.121 #16
[    6.689082] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/204
[    6.689082] task: ffff88017a558c40 task.stack: ffffc900007a8000
[    6.689082] RIP: 0010:[<ffffffff8116ba10>]  [<ffffffff8116ba10>] page_remove_rmap+0x10/0x230
[    6.689082] RSP: 0018:ffffc900007abc18  EFLAGS: 00000296
[    6.689082] RAX: ffffea0005e58000 RBX: ffffeafffa1a0000 RCX: 0000000020200000
[    6.689082] RDX: 00003fffffe00000 RSI: 0000000000000001 RDI: ffffeafffa1a0000
[    6.689082] RBP: ffffc900007abc38 R08: 0000000000000000 R09: 0000000020800000
[    6.689082] R10: ffffea0005e51ec0 R11: 0000000000000000 R12: ffffeafffa1a0000
[    6.689082] R13: ffffc900007abdc0 R14: ffff880179426808 R15: ffffc900007abdc0
[    6.689082] FS:  0000000000000000(0000) GS:ffff88017fd80000(0000) knlGS:0000000000000000
[    6.689082] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.689082] CR2: ffffeafffa1a0020 CR3: 000000017a3f8000 CR4: 0000000000340670
[    6.689082] Stack:
[    6.689082]  ffffffff81138517 ffffea0005e50980 ffffeafffa1a0000 ffffc900007abdc0
[    6.689082]  ffffc900007abc68 ffffffff8118d52c ffff880179426808 0000000020200000
[    6.689082]  ffffc900007abdc0 ffffc900007abdc0 ffffc900007abd40 ffffffff8115e270
[    6.689082] Call Trace:
[    6.689082]  [<ffffffff81138517>] ? __alloc_pages_nodemask+0xd7/0x210
[    6.689082]  [<ffffffff8118d52c>] zap_huge_pmd+0xec/0x2a0
[    6.689082]  [<ffffffff8115e270>] unmap_page_range+0x7d0/0x8d0
[    6.689082]  [<ffffffff8115e3c4>] unmap_single_vma+0x54/0xd0
[    6.689082]  [<ffffffff8115e6dc>] unmap_vmas+0x4c/0xa0
[    6.689082]  [<ffffffff81166297>] exit_mmap+0xa7/0x130
[    6.689082]  [<ffffffff81193d8f>] ? __khugepaged_exit+0x6f/0x100
[    6.689082]  [<ffffffff8105a078>] mmput+0x38/0x100
[    6.689082]  [<ffffffff8106080c>] do_exit+0x25c/0xb10
[    6.689082]  [<ffffffff81061f1e>] do_group_exit+0x3e/0xa0
[    6.689082]  [<ffffffff81061f8f>] SyS_exit_group+0xf/0x10
[    6.689082]  [<ffffffff81002a9c>] do_syscall_64+0x5c/0xc0
[    6.689082]  [<ffffffff819a62be>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
[    6.689082] Code: 77 ff ff ff eb b8 be 13 00 00 00 4c 89 e7 e8 d8 40 fe ff 48 63 d3 eb b3 0f 1f 00 55 48 89 e5 41 55 41 54 53 48 
[    6.689082] RIP  [<ffffffff8116ba10>] page_remove_rmap+0x10/0x230
[    6.689082]  RSP <ffffc900007abc18>
[    6.689082] CR2: ffffeafffa1a0020
[    6.689082] ---[ end trace 62ac9ace190510cd ]---
[    6.689082] Fixing recursive fault but reboot is needed!

A test program to trigger the crash is attached, as are bisect results
and some additional information.

Upstream commit 19f5c49bbc3 ("x86/speculation/l1tf: Exempt zeroed PTEs
from inversion") does not fix the problem.

Many thanks to the syzcaller team for finding the problem and for providing
a reproducer.

Any help to track down the problem would be appreciated. This is out of my
league.

Thanks,
Guenter

---
#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

int main()
{
  syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
  syscall(__NR_madvise, 0x20a93000, 0x4000, 0xe);
  syscall(__NR_mremap, 0x20a96000, 0x1000, 0x800000, 3, 0x20130000);
  syscall(__NR_sigaltstack, 0x20341000, 0x20ef9ff8);
  syscall(__NR_mprotect, 0x20000000, 0x800000, 0);
  return 0;
}

---
# bad: [93e02ae4200184bab43ce29966e895826a756a37] Linux 4.9.120
# good: [8f21ecb4249a0914aea08bef1befca9019a3b44b] Linux 4.9.119
git bisect start 'v4.9.120' 'v4.9.119'
# bad: [a0695af3406ae2a08184bd47a9e948fe6f9858b9] x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug being present
git bisect bad a0695af3406ae2a08184bd47a9e948fe6f9858b9
# good: [1a4922e0f01d08a4789b1e17b195bc30bf234a3b] mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit 7 to bit 1
git bisect good 1a4922e0f01d08a4789b1e17b195bc30bf234a3b
# bad: [e0439285c628dea71517a1e77cab805d9134f898] x86/cpu: Remove the pointless CPU printout
git bisect bad e0439285c628dea71517a1e77cab805d9134f898
# bad: [e3923475ebb1b503668dfdb3ba90e2ebd46931e6] x86/speculation/l1tf: Limit swap file size to MAX_PA/2
git bisect bad e3923475ebb1b503668dfdb3ba90e2ebd46931e6
# bad: [33182fe97add6e83c195e9d0f7297a6499563b52] x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
git bisect bad 33182fe97add6e83c195e9d0f7297a6499563b52
# good: [60712274887fcd4ad5eb8e01796022b6b202143c] x86/speculation/l1tf: Protect swap entries against L1TF
git bisect good 60712274887fcd4ad5eb8e01796022b6b202143c
# first bad commit: [33182fe97add6e83c195e9d0f7297a6499563b52]
# x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation

---
qemu command line:

qemu-system-x86_64 \
	-kernel arch/x86/boot/bzImage -M q35 -cpu Broadwell-noTSX \
	-no-reboot -m 4G -smp 4 \
	-drive file=rootfs.ext2.l1tf,format=raw,if=ide \
	-nographic -monitor none \
	--append "root=/dev/sda rw console=ttyS0 console=tty"

CPU and machine don't really matter. I'll be happy to provide the
root file system if needed.

---
Configuration file:

# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_AUDIT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_CGROUPS=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CPUSETS=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_BLK_DEV_INITRD=y
# CONFIG_COMPAT_BRK is not set
CONFIG_PROFILING=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SGI_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_SMP=y
CONFIG_CALGARY_IOMMU=y
CONFIG_SCHED_SMT=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_MICROCODE_AMD=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NUMA=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_EFI=y
CONFIG_HZ_1000=y
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_HIBERNATION=y
CONFIG_PM_DEBUG=y
CONFIG_PM_TRACE_RTC=y
CONFIG_ACPI_DOCK=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI=y
CONFIG_PCCARD=y
CONFIG_YENTA=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_XFRM_USER=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_DIAG is not set
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
# CONFIG_TCP_CONG_WESTWOOD is not set
# CONFIG_TCP_CONG_HTCP is not set
CONFIG_TCP_MD5SIG=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_NETLABEL=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set
CONFIG_NF_CONNTRACK=y
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CT_NETLINK=y
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_NF_CONNTRACK_IPV4=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_MANGLE=y
CONFIG_NF_CONNTRACK_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_NET_SCHED=y
CONFIG_NET_EMATCH=y
CONFIG_NET_CLS_ACT=y
CONFIG_HAMRADIO=y
CONFIG_CFG80211=y
CONFIG_MAC80211=y
CONFIG_MAC80211_LEDS=y
CONFIG_RFKILL=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_DEBUG_DEVRES=y
CONFIG_CONNECTOR=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_NVME=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_DC395x=y
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_VIRTIO=y
CONFIG_ATA=y
CONFIG_SATA_AHCI=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_AMD=y
CONFIG_PATA_OLDPIIX=y
CONFIG_PATA_SCH=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
CONFIG_FUSION=y
CONFIG_FUSION_SAS=y
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NETCONSOLE=y
CONFIG_TIGON3=y
CONFIG_NET_TULIP=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_SKY2=y
CONFIG_FORCEDETH=y
CONFIG_8139TOO=y
CONFIG_FDDI=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_INPUT_TABLET=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_NVRAM=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_I2C_I801=y
CONFIG_WATCHDOG=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_I915=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_EFI=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_HIDRAW=y
CONFIG_HID_GYRATION=y
CONFIG_LOGITECH_FF=y
CONFIG_HID_NTRIG=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SONY=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_MON=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_EDAC=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_DMADEVICES=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
CONFIG_EEEPC_LAPTOP=y
CONFIG_AMD_IOMMU=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_EFI_VARS=y
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QFMT_V2=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_HUGETLBFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=y
CONFIG_PRINTK_TIME=y
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_SCHED_DEBUG is not set
CONFIG_SCHEDSTATS=y
CONFIG_TIMER_STATS=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_DEBUG_BOOT_PARAMS=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
