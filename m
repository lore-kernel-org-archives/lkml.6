Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ED4C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCE219F2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="MIMQKdpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCE219F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHKMV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:21:29 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:41790 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:21:28 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 5D64A3CD269;
        Sat, 11 Aug 2018 11:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1533980866;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PbBOsAmLwProIR8RJalAxpf8t9AihL7cZSW/Y0BzVEg=;
        b=MIMQKdpmERGzQeQCva8BUvpxsCVw4WBHRRj5aDVmYihGJUz6pD469QQ5R1BZ6+fpSvuPqD
        d4x+/6iucqxopPg+XVDN7dsyJ/Tv52YaMqoWE2VPyagDljQi/IvYdixPdhEV4pAzU9ynUq
        5T9lEUcSceB5UFIRSAI3ekAFukuug3E=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 5D64A3CD269
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 11 Aug 2018 11:47:46 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Subject: Slow boot in QEMU with virtio-scsi disks
Message-ID: <f40092b20856d07bd7f870abf5ea939e@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1533980866;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PbBOsAmLwProIR8RJalAxpf8t9AihL7cZSW/Y0BzVEg=;
        b=c0JFOMM+jg7frYMOvWgh4T3jdQh5u1zp7nFFKyBFl9qzMmw/7Ke0U6aHGFY31eEDBWmQiG
        s7j2iCMTPaQr6NhgiLACJdBHih9ZcoL120TmYYuvtr42CFnq9TRCBTPhtpj2TThNOUdyvo
        Qlcelepvf11pV9enFpmjMQMfJS9fkp8=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1533980866; a=rsa-sha256;
        cv=none;
        b=zuPNUJ32Xuj0H2pE9f9Q4vdV/p7uuT0Qticbs/x9ODpDajDDBlebds4jXbaThrgwpSwGN8YE5Qboa5kM+JDiAd4pFKfIYhiiD0iVU6yTNjCgWwxfSydc1aXIDvPo9/evx+6kzVvMHRN0leKWYZV9MckAy7NMvTvXaAo/RAV8XzU=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'd like to resurrect previous discussion [1] regarding slow kernel boot 
inside QEMU with virtio-scsi disks attached and blk_mq enabled.

Symptom:

[    2.830857] ata1: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002100 irq 36
[    2.834559] ata2: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002180 irq 36
[    2.837746] ata3: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002200 irq 36
[    2.841861] ata4: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002280 irq 36
[    2.847899] ata5: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002300 irq 36
[    2.853229] ata6: SATA max UDMA/133 abar m4096@0x98002000 port 
0x98002380 irq 36
[    3.172159] ata1: SATA link down (SStatus 0 SControl 300)
[    3.183552] ata5: SATA link down (SStatus 0 SControl 300)
[    3.189925] ata3: SATA link down (SStatus 0 SControl 300)
[    3.196156] ata6: SATA link down (SStatus 0 SControl 300)
[    3.201136] ata2: SATA link down (SStatus 0 SControl 300)
[    3.208559] ata4: SATA link down (SStatus 0 SControl 300)
[   16.480972] sd 0:0:1:0: Power-on or device reset occurred
[   16.481591] sd 0:0:0:0: [sda] 16777216 512-byte logical blocks: (8.59 
GB/8.00 GiB)
[   16.481671] sd 0:0:0:0: [sda] Write Protect is off
[   16.481815] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[   16.491325]  sda: sda1 sda2
[   16.517532] sd 0:0:1:0: [sdb] 16777216 512-byte logical blocks: (8.59 
GB/8.00 GiB)
[   16.525131] sr 0:0:2:0: Power-on or device reset occurred
[   16.525974] sd 0:0:1:0: [sdb] Write Protect is off
[   16.530946] sr 0:0:2:0: [sr0] scsi3-mmc drive: 16x/50x cd/rw xa/form2 
cdda tray
[   16.543592] cdrom: Uniform CD-ROM driver Revision: 3.20
[   16.549815] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[   16.549833] sd 0:0:0:0: [sda] Attached SCSI disk
[   16.572055]  sdb: sdb1 sdb2
[   16.580463] sd 0:0:1:0: [sdb] Attached SCSI disk

(note the hang that lasts for 13 seconds)

The disks are attached to the VM in the following manner:

-device virtio-scsi,id=scsi -device scsi-hd,drive=hd1 -drive 
if=none,media=disk,id=hd1,file=sda.img,format=raw

What I've tested so far:

* 4.14.62  + virtio-scsi +    blk_mq == slow boot
* 4.14.62  + virtio-scsi + no blk_mq == fast boot
* 4.17.13  + virtio-scsi +    blk_mq == slow boot
* 4.18-rc8 + virtio-scsi +    blk_mq == slow boot

QEMU is of v2.12.1, runs with "-machine q35,accel=kvm -cpu host". Also, 
if virtio-scsi disks are replaced with SATA disks, the hang does not 
occur (although, QEMU has other issues with SATA, but that's another 
story [3]).

Apparently, the commit that was mentioned in [2], 
b5b6e8c8d3b4cbeb447a0f10c7d5de3caa573299, forces blk_mq for virtio_scsi, 
so it cannot be disabled for new kernels.

Any hint on how to avoid this hang while still having virtio-scsi disks 
and blk_mq enabled please?

Thanks.

-- 
   Oleksandr Natalenko (post-factum)

[1] 
https://lists.gnu.org/archive/html/qemu-discuss/2018-07/msg00022.html
[2] 
https://lists.gnu.org/archive/html/qemu-discuss/2018-07/msg00037.html
[3] 
https://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06942.html
