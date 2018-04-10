Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeDJRQ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:16:56 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:14868 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeDJRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:16:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 12DAB336533
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Apr 2018 19:16:49 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5j+9BJcR63bsqQpqaKrvcgOpWyDzgpD-zRrf1qq7v=Z2CA@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
 <2679696.GDoj5zcZOu@natalenko.name>
 <CAGXu5jLG9ia+zBNcPt+q+BpJayoUuYwXitOgeHmh=7sPp-s87A@mail.gmail.com>
 <51a7e805058ef7f35b226cbbf0ccc4ff@natalenko.name>
 <CAGXu5jKRrdYjuyLSvc4k4mqttkM7zw-96poQ1GYqRRgPqZFOYQ@mail.gmail.com>
 <3d7b5a707e216e19eb3defe0586bfbc8@natalenko.name>
 <CAGXu5j+9BJcR63bsqQpqaKrvcgOpWyDzgpD-zRrf1qq7v=Z2CA@mail.gmail.com>
Message-ID: <d53af006c314eb9d326bfb19b08e189b@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1523380610;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=tGkC1r+TZEazHk91syu7LV0Rok2tVEsKVmkFtWVNI5o=;
        b=vWXeyBG4VR8M+DOQqC7xqIiupVK/FUktMbTYmXa65sFm110+ELfeq777T5VHe6JGOnNmZK
        OForm0+D+sCWhCsn2jvvrrOxYyaCDYO9SnfnNlddlbTDwdsDDUoQf49iE0ajtsHVqPRMNE
        5E3PntLGAO26/i08kaykioxe8FeEg0g=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1523380610; a=rsa-sha256;
        cv=none;
        b=tOL5Ckw/L3IPhg8DVOMGtHVZJoZV8cjpXgBbmEzMRJa1scBHocbhV+RLCF7W+LqyjWJYwNFhickb1yGhiccXyIDNcyeiSEUGN+k+76vCMAt8GCYhW3Qxx+pFDgGqcFR2O79Sdw+D1Xsa3tueQN6EJH0xeqDYC7+KZtyBz12KPDo=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kees, Paolo et al.

10.04.2018 08:53, Kees Cook wrote:
> Unfortunately I only had a single hang with no dumps. I haven't been
> able to reproduce it since. :(

For your convenience I've prepared a VM that contains a reproducer.

It consists of 3 disk images (sda.img is for the system, it is 
Arch-based, sdb/sdc.img are for RAID). They are available (in a 
compressed form) to download here [1].

RAID is built as RAID10 with far2 layout, on top of it there is a LUKS 
container (can be opened either with keyfile under the /root or using 
"qwerty" password). There's one LVM PV, one VG and one volume on top of 
LUKS containing XFS. RAID is automatically assembled during the boot, so 
you don't have to worry about it.

I run the VM like this:

$ qemu-system-x86_64 -display gtk,gl=on -machine q35,accel=kvm -cpu 
host,+vmx -enable-kvm -netdev user,id=user.0 -device 
virtio-net,netdev=user.0 -usb -device nec-usb-xhci,id=xhci -device 
usb-tablet,bus=xhci.0 -serial stdio -smp 4 -m 512 -hda sda.img -hdb 
sdb.img -hdc sdc.img

The system is accessible via both VGA and serial console. The user is 
"root", the password is "qwerty".

Under the /root folder there is a reproducer script (reproducer.sh). It 
does trivial things like enabling sysrq, opening LUKS device, mounting a 
volume, running a background I/O (this is an important part, actually, 
since I wasn't able to trigger the issue without the background I/O) 
and, finally, running the smartctl in a loop. If you are lucky, within a 
minute or two you'll get the first warning followed shortly by 
subsequent bugs and I/O stall (htop is pre-installed for your 
convenience too).

Notable changes in this VM comparing to generic defaults:

1) blk-mq is enabled via kernel cmdline (scsi_mod.use_blk_mq=1 is in 
/etc/default/grub)
2) BFQ is set via udev (check /etc/udev/rules.d/10-io-scheduler.rules 
file)

Again, I wasn't able to reproduce the usercopy warning/bug and I/O hang 
without all these components being involved.

Hope you enjoy it.

P.S. I haven't tested Linus' master branch yet. For now, this VM runs 
v4.16 kernel.

Regards,
   Oleksandr

[1] https://natalenko.name/myfiles/usercopy_bfq_woe/
