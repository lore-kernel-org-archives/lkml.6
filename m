Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeDFGVj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:21:39 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:42734 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeDFGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:21:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name A16CE332FE4
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Apr 2018 08:21:35 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
 <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
 <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
 <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
 <dee9721a530576e667881d86bbec351b@natalenko.name>
 <08e06234c81fac30ccff5a2695d02f2a@natalenko.name>
 <CAGXu5jL8oLV2xvjBVYv_SNXr74LdgpXEmU7K+cLYpD7jh2chgw@mail.gmail.com>
 <CAGXu5j+mVc6O_=GOF3YQmS4QZxeFgVPQtMxNH8sjBAhpJLjm9w@mail.gmail.com>
Message-ID: <1e9fb351f60a9bfe36d2f0974e5237eb@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522995695;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=DQQDEPRUEbGIfgNlX7dHoMtjf2+BuLSwLUD7JDZfapg=;
        b=0SIpNg7K1HSNCV9CR36aclHlNAyO3SqxyedRENHsT2WMPJzmr8f+/hUyuvrFqRFsJN0aI6
        z+YM7unegt75evFuovXvehkDS8OZi33V4IyFrvKCaMgEex36cgrh05xv4GJXQ0IzmzNSCz
        6J1zfCb5JXW4CjyNzvVGyXcbf+5q6hM=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522995695; a=rsa-sha256;
        cv=none;
        b=ICTNeROY1QFkKZhP1G/bFOnLD3V2IbHmpE/4uG0+6i4Fx3Gb/SGR14kyk+mKgU0V3NdhCpCH9zypeLi0S3XAcrdjvbT0TJ3WfraFta2x6iBaEl5uwfmmnEt8l6NXOVJ5IB6HVZJAfgUz+IDLfD9w5zPfeGBt3PSycxWPR/7usbU=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

05.04.2018 20:52, Kees Cook wrote:
> Okay. My qemu gets mad about that and wants the format=raw argument,
> so I'm using:
> 
> -drive file=sda.img,format=raw \
> -drive file=sdb.img,format=raw \
> 
> How are you running your smartctl? I'm doing this now:
> 
> [1]   Running                 while :; do
>     ( smartctl -a /dev/sda; smartctl -a /dev/sdb ) > /dev/null;
> done &

Yes, so do I.

> I assume I'm missing something from your .config, but since I don't
> boot with an initramfs, I had to tweak it a bit. I'll try again...

Let me, maybe, describe, what both the VM and the server have in common:

1. have 4 CPUs
2. are EFI-based
3. use blk-mq with BFQ scheduler (it is set up via udev rule during 
boot)
4. have zswap enabled
5. have 2 SATA disks with RAID10 on top of it (layout f2)
6. have LUKS on top of the RAID, and LVM on top of the LUKS

VM has machine type "q35", BTW.

Do you think something of what's mentioned above is relevant for the 
code path in question?

Thanks.

Regards,
   Oleksandr
