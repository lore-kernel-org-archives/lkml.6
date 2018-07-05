Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252462411D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252462411D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGEFuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:50:51 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33152 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbeGEFur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:50:47 -0400
Received: by mail-ua0-f196.google.com with SMTP id g18-v6so4684476uak.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OQjnbjFmZZcKhgXkfV76VOAmh8XLseq039oUmNpmQlw=;
        b=MJmSu44AFbfLpAS/htKdLhiMlwsR15vi4D6Ad0k8Q+YDmnFZoRiNCM9lYF/QaIsXlR
         ORweMNI8nYn3/hj4J83IO2XUUSR0dXHLALQyU1AIYKw47tGttdIYncMkMBF0HVlFXelM
         gysOndnV1UfABv1Ws3+ofQnzLE1Sg+08IiBSyJ50uNItWRjU0BxTFeMHpd7BDb750Duc
         lbrj4PwuL6q2EhKxC17lifSs0k7cKKYC5LMvT+cciDQQrnXQmoLz6DtVoyr4orQP1yH7
         Kl5ieTpkDwrskr12a0YhOemZLFBcsADfKMFAJWPdbAl9XrohdZQ5m6ntO39uEi/IFXZN
         OOAA==
X-Gm-Message-State: APt69E23R2H3ThcCSpxibqa8WjBRfbyPTz6BPNYTpUwT8gWAoQrxrxz5
        LWBQsmJvuGkQL76yk2pD4lGR9CJYg81ue/+ZkWKBz6r1Y2g=
X-Google-Smtp-Source: AAOMgpeip1mkgnkYtrM5x080+iQHMIwmNjDV9Za/LjQq8fd7mATvogNlA5mdGEN60oh4TDkDR5FvOWrAWnIGMQjyXvk=
X-Received: by 2002:a9f:3b89:: with SMTP id r9-v6mr2772144uah.160.1530769846002;
 Wed, 04 Jul 2018 22:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:260d:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 22:50:45 -0700 (PDT)
In-Reply-To: <CAEemH2egA1hoECjTSaao8n_YBZ3ypycMSUwZh+Ece28phL4F2Q@mail.gmail.com>
References: <CAEemH2egA1hoECjTSaao8n_YBZ3ypycMSUwZh+Ece28phL4F2Q@mail.gmail.com>
From:   Li Wang <liwang@redhat.com>
Date:   Thu, 5 Jul 2018 13:50:45 +0800
Message-ID: <CAEemH2fFJrToG1=SFwMFeyThSgPmTy9xzTnLVHO3c1GdpF_EGQ@mail.gmail.com>
Subject: Re: ltp/read_all_sys (read_all -d /sys -q -r 10) cause system panic
 with kernel-4.18.0-rc1
To:     linux-kernel <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Cc:     Himanshu Madhani <hmadhani@redhat.com>, oberman@redhat.com,
        William.Kuzeja@stratus.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Tran, Quinn" <quinn.tran@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

The problem is still in kernel-v4.18-rc3.

Panic was caused by command:
  # ./read_all  -d /sys -q -r 10


Or, you can try the full steps to reproduce:

# git clone https://github.com/linux-test-project/ltp/
# cd ltp
# ./build.sh
# cd ../ltp-install
# ./runltp -s read_all_sys


dmesg log:
-----------------------
# dmesg |grep qla2
[    4.764969] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA
Driver: 10.00.00.07-k.
[    4.775414] qla2xxx [0000:04:00.0]-001a: : MSI-X vector count: 32.
[    4.783705] qla2xxx [0000:04:00.0]-001d: : Found an ISP2532 irq 27
iobase 0x(____ptrval____).
[    4.793972] qla2xxx [0000:04:00.0]-00c6:4: MSI-X: Failed to enable
support with 32 vectors, using 10 vectors.
[    5.214159] scsi host4: qla2xxx
[    5.214514] qla2xxx [0000:04:00.0]-00fb:4: QLogic QLE2562 -
PCI-Express Dual Channel 8Gb Fibre Channel HBA.
[    5.214520] qla2xxx [0000:04:00.0]-00fc:4: ISP2532: PCIe (5.0GT/s
x8) @ 0000:04:00.0 hdma+ host#=4 fw=8.07.00 (90d5).
[    5.214622] qla2xxx [0000:04:00.1]-001a: : MSI-X vector count: 32.
[    5.214624] qla2xxx [0000:04:00.1]-001d: : Found an ISP2532 irq 57
iobase 0x(____ptrval____).
[    5.215149] qla2xxx [0000:04:00.1]-00c6:5: MSI-X: Failed to enable
support with 32 vectors, using 10 vectors.
[    5.631289] scsi host5: qla2xxx
[    5.635270] qla2xxx [0000:04:00.1]-00fb:5: QLogic QLE2562 -
PCI-Express Dual Channel 8Gb Fibre Channel HBA.
[    5.646156] qla2xxx [0000:04:00.1]-00fc:5: ISP2532: PCIe (5.0GT/s
x8) @ 0000:04:00.1 hdma+ host#=5 fw=8.07.00 (90d5).
[   26.393233] qla2xxx [0000:04:00.0]-8038:4: Cable is unplugged...
[   26.841214] qla2xxx [0000:04:00.1]-8038:5: Cable is unplugged...


---------------------
[ 8162.297286] BUG: unable to handle kernel NULL pointer dereference
at 00000000000000b8
[ 8162.306027] PGD 800000042a986067 P4D 800000042a986067 PUD 42a990067 PMD 0
[ 8162.313695] Oops: 0000 [#1] SMP PTI
[ 8162.317588] CPU: 7 PID: 1677 Comm: read_all Tainted: G          I
    4.18.0-rc3+ #1
[ 8162.326422] Hardware name: FUJITSU
PRIMERGY RX200 S6             /D3031, BIOS 6.00 Rev. 1.10.3031
     01/20/2012
[ 8162.341096] RIP: 0010:qla_dfs_tgt_counters_show+0x92/0x2a0 [qla2xxx]
[ 8162.348176] Code: b6 86 22 01 00 00 66 85 c0 74 63 83 e8 01 4c 8b
9e b8 00 00 00 31 f6 0f b7 c0 48 8d 3c c5 08 00 00 00 49 8b 04 33 48
83 c6 08 <48> 03 90 b8 00 00 00 48 03 88 c0 00 00 00 4c 03 80 c8 00 00
00 4c
[ 8162.369260] RSP: 0018:ffffadee829d7d60 EFLAGS: 00010202
[ 8162.375088] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[ 8162.383049] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000040
[ 8162.391010] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 8162.398973] R10: ffff893be3dce798 R11: ffff893be3a004c0 R12: 0000000000000000
[ 8162.406935] R13: 0000000000000000 R14: ffff893be5006f00 R15: 0000000000000000
[ 8162.414898] FS:  00007f7611b68740(0000) GS:ffff893bffdc0000(0000)
knlGS:0000000000000000
[ 8162.423926] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8162.430337] CR2: 00000000000000b8 CR3: 000000042a98e006 CR4: 00000000000206e0
[ 8162.438298] Call Trace:
[ 8162.441031]  ? _cond_resched+0x15/0x30
[ 8162.445215]  ? __kmalloc_node+0x1cd/0x280
[ 8162.449690]  ? seq_read+0x33e/0x3f0
[ 8162.453581]  seq_read+0x120/0x3f0
[ 8162.457280]  full_proxy_read+0x50/0x70
[ 8162.461462]  __vfs_read+0x36/0x190
[ 8162.465257]  vfs_read+0x87/0x130
[ 8162.468855]  ksys_read+0x52/0xc0
[ 8162.472456]  do_syscall_64+0x5b/0x180
[ 8162.476541]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 8162.482177] RIP: 0033:0x7f76117476d0
[ 8162.486163] Code: 73 01 c3 48 8b 0d d8 88 20 00 f7 d8 64 89 01 48
83 c8 ff c3 66 0f 1f 44 00 00 83 3d 19 cd 20 00 00 75 10 b8 00 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fc ff ff 48 89
04 24
[ 8162.507237] RSP: 002b:00007fff35e015f8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 8162.515685] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f76117476d0
[ 8162.523647] RDX: 00000000000003ff RSI: 00007fff35e01ab0 RDI: 0000000000000003
[ 8162.531607] RBP: 0000000000001c0c R08: 0000000000000000 R09: 00007fff35e01550
[ 8162.539569] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7611b59000
[ 8162.547530] R13: 00007fff35e01ab0 R14: 0000000000000028 R15: 0000000000000030
[ 8162.555493] Modules linked in: sunrpc intel_powerclamp coretemp
kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel ipmi_ssif pcbc aesni_intel crypto_simd cryptd
ipmi_si iTCO_wdt glue_helper iTCO_vendor_support gpio_ich ipmi_devintf
sg pcspkr i2c_i801 ipmi_msghandler acpi_power_meter lpc_ich
i7core_edac acpi_cpufreq ip_tables xfs libcrc32c sd_mod sr_mod cdrom
mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
ttm ata_generic qla2xxx pata_acpi drm igb ata_piix mptsas libata
nvme_fc scsi_transport_sas nvme_fabrics mptscsih nvme_core
crc32c_intel mptbase scsi_transport_fc dca i2c_algo_bit dm_mirror
dm_region_hash dm_log dm_mod
[ 8162.621090] CR2: 00000000000000b8


On Tue, Jun 19, 2018 at 6:41 PM, Li Wang <liwang@redhat.com> wrote:
> Hi,
>
> I'm hitting this panic when running ltp/read_all_sys on kernel-v4.18-rc1.
>
> Test env:
> FUJITSU PRIMERGY RX200 S6 GS01
> Intel(R) Xeon(R) CPU E5620 @ 2.40GHz
> 16384 MB memory, 598 GB disk space
>
>
> [ 5915.705844] BUG: unable to handle kernel NULL pointer dereference
> at 00000000000000b8
> [ 5915.714587] PGD 800000042bcf7067 P4D 800000042bcf7067 PUD 423f4e067 PMD 0
> [ 5915.722254] Oops: 0000 [#1] SMP PTI
> [ 5915.726147] CPU: 6 PID: 18535 Comm: read_all Tainted: P
> IOE     4.18.0-rc1 #1
> [ 5915.734980] Hardware name: FUJITSU
> PRIMERGY RX200 S6             /D3031, BIOS 6.00 Rev. 1.10.3031
>      01/20/2012
> [ 5915.749654] RIP: 0010:qla_dfs_tgt_counters_show+0x92/0x2a0 [qla2xxx]
> [ 5915.756733] Code: b6 86 22 01 00 00 66 85 c0 74 63 83 e8 01 4c 8b
> 9e b8 00 00 00 31 f6 0f b7 c0 48 8d 3c c5 08 00 00 00 49 8b 04 33 48
> 83 c6 08 <48> 03 90 b8 00 00 00 48 03 88 c0 00 00 00 4c 03 80 c8 00 00
> 00 4c
> [ 5915.777816] RSP: 0018:ffffaf04109e3d60 EFLAGS: 00010202
> [ 5915.783645] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [ 5915.791606] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000040
> [ 5915.799568] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 5915.807529] R10: ffff956823a74798 R11: ffff956824a29000 R12: 0000000000000000
> [ 5915.815489] R13: 0000000000000000 R14: ffff9567badfc280 R15: 0000000000000000
> [ 5915.823451] FS:  00007f27336a1740(0000) GS:ffff95683fd80000(0000)
> knlGS:0000000000000000
> [ 5915.832479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5915.838890] CR2: 00000000000000b8 CR3: 000000042960a003 CR4: 00000000000206e0
> [ 5915.846850] Call Trace:
> [ 5915.849583]  ? __kmalloc_node+0x195/0x280
> [ 5915.854056]  ? seq_read+0x33e/0x3f0
> [ 5915.857946]  seq_read+0x120/0x3f0
> [ 5915.861643]  full_proxy_read+0x50/0x70
> [ 5915.865827]  __vfs_read+0x36/0x190
> [ 5915.869622]  vfs_read+0x87/0x130
> [ 5915.873223]  ksys_read+0x52/0xc0
> [ 5915.876823]  do_syscall_64+0x5b/0x180
> [ 5915.880910]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5915.886547] RIP: 0033:0x7f2733280790
> [ 5915.890532] Code: 73 01 c3 48 8b 0d 18 88 20 00 f7 d8 64 89 01 48
> 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 cc 20 00 00 75 10 b8 00 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e fc ff ff 48 89
> 04 24
> [ 5915.911617] RSP: 002b:00007ffef181c738 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 5915.920064] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f2733280790
> [ 5915.928025] RDX: 00000000000003ff RSI: 00007ffef181cbf0 RDI: 0000000000000006
> [ 5915.935986] RBP: 0000000000000b7b R08: 0000000000000000 R09: 00007ffef181c690
> [ 5915.943949] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2733688000
> [ 5915.951909] R13: 00007ffef181cbf0 R14: 0000000000000028 R15: 0000000000000030
> [ 5915.959871] Modules linked in: dummy veth binfmt_misc sctp overlay
> tun fuse vfat fat btrfs xor zstd_decompress zstd_compress xxhash
> raid6_pq ext4 mbcache jbd2 loop sunrpc intel_powerclamp coretemp
> kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel pcbc ipmi_ssif aesni_intel crypto_simd iTCO_wdt
> ipmi_si cryptd iTCO_vendor_support glue_helper gpio_ich ipmi_devintf
> sg acpi_power_meter ipmi_msghandler i2c_i801 pcspkr lpc_ich
> i7core_edac acpi_cpufreq ip_tables xfs libcrc32c sd_mod sr_mod cdrom
> mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> ttm ata_generic pata_acpi qla2xxx drm igb ata_piix nvme_fc mptsas
> libata nvme_fabrics scsi_transport_sas dca crc32c_intel mptscsih
> i2c_algo_bit nvme_core i2c_core mptbase scsi_transport_fc dm_mirror
> dm_region_hash dm_log
> [ 5916.038566]  dm_mod [last unloaded: ltp_insmod01]
> [ 5916.043814] CR2: 00000000000000b8
> [ 5916.047513] BUG: unable to handle kernel NULL pointer dereference
> at 00000000000000b8
> [ 5916.047537] ---[ end trace 1dddacfb06305174 ]---
>
>
> --
> Regards,
> Li Wang



-- 
Regards,
Li Wang
