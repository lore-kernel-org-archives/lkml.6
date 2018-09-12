Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DEC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF20020833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF20020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeILFgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:36:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:48493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbeILFgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:36:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 17:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="87955942"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2018 17:34:28 -0700
Subject: Re: [LKP] [vfs] fd0002870b: BUG:KASAN:null-ptr-deref_in_n
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20180911004752.GG1110@shao2-debian>
 <10338.1536697773@warthog.procyon.org.uk>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <0bac086d-13a5-7275-fd08-7e9bfc58f562@intel.com>
Date:   Wed, 12 Sep 2018 08:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <10338.1536697773@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2018 04:29 AM, David Howells wrote:
> kernel test robot <rong.a.chen@intel.com> wrote:
>
>> [   18.568403]  nfs_fs_mount+0x901/0x1220
> I don't suppose you can tell me what file and line number this corresponds to?
$ faddr2line vmlinux nfs_fs_mount+0x901
nfs_fs_mount+0x901/0x1218:
nfs_parse_devname at fs/nfs/super.c:1911
  (inlined by) nfs_validate_text_mount_data at fs/nfs/super.c:2187
  (inlined by) nfs_fs_mount at fs/nfs/super.c:2684

>
> Also, can you tell me what the mount parameters were?  I'm not sure how to
> extract them from the information provided.
qemu command (you could get from 'bin/lkp qemu -k <bzImage> job-script'):

qemu-system-x86_64 -enable-kvm -fsdev 
local,id=test_dev,path=/home/nfs/.lkp//result/boot/1/vm-kbuild-1G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-r0-09070102/gcc-6/fd0002870b453c58d0d8c195954f5049bc6675fb/0,security_model=none 
-device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel 
vmlinuz-4.19.0-rc1-00104-gfd00028 -append root=/dev/ram0 user=lkp 
job=/lkp/jobs/scheduled/vm-kbuild-1G-11/boot-1-debian-x86_64-2018-04-03.cgz-fd0002870b453c58d0d8c195954f5049bc6675fb-20180910-6016-1hqt4et-1.yaml 
ARCH=x86_64 kconfig=x86_64-randconfig-r0-09070102 
branch=linux-devel/devel-hourly-2018090623 
commit=fd0002870b453c58d0d8c195954f5049bc6675fb 
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r0-09070102/gcc-6/fd0002870b453c58d0d8c195954f5049bc6675fb/vmlinuz-4.19.0-rc1-00104-gfd00028 
max_uptime=600 
RESULT_ROOT=/result/boot/1/vm-kbuild-1G/debian-x86_64-2018-04-03.cgz/x86_64-randconfig-r0-09070102/gcc-6/fd0002870b453c58d0d8c195954f5049bc6675fb/3 
LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled 
rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on 
panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 
prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err 
ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 
console=ttyS0,115200 vga=normal rw  ip=dhcp 
result_service=9p/virtfs_mount -initrd /home/nfs/.lkp/cache/final_initrd 
-smp 2 -m 1024M -no-reboot -watchdog i6300esb -rtc base=localtime 
-device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor 
null -serial stdio -device virtio-scsi-pci,id=scsi0 -drive 
file=/tmp/vdisk-nfs/disk-vm-kbuild-1G-11-0,if=none,id=hd0,media=disk,aio=native,cache=none 
-device scsi-hd,bus=scsi0.0,drive=hd0,scsi-id=1,lun=0 -drive 
file=/tmp/vdisk-nfs/disk-vm-kbuild-1G-11-1,if=none,id=hd1,media=disk,aio=native,cache=none 
-device scsi-hd,bus=scsi0.0,drive=hd1,scsi-id=1,lun=1 -drive 
file=/tmp/vdisk-nfs/disk-vm-kbuild-1G-11-2,if=none,id=hd2,media=disk,aio=native,cache=none 
-device scsi-hd,bus=scsi0.0,drive=hd2,scsi-id=1,lun=2 -drive 
file=/tmp/vdisk-nfs/disk-vm-kbuild-1G-11-3,if=none,id=hd3,media=disk,aio=native,cache=none 
-device scsi-hd,bus=scsi0.0,drive=hd3,scsi-id=1,lun=3 -drive 
file=/tmp/vdisk-nfs/disk-vm-kbuild-1G-11-4,if=none,id=hd4,media=disk,aio=native,cache=none 
-device scsi-hd,bus=scsi0.0,drive=hd4,scsi-id=1,lun=4

Best Regards,
Rong Chen

>
> Thanks,
> David
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp

