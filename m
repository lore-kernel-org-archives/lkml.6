Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDEOct (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:32:49 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57922 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDEOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:32:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 8838A332E37
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Apr 2018 16:32:45 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
 <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
 <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
 <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
Message-ID: <dee9721a530576e667881d86bbec351b@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522938765;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=YSNv3m3BwVs8sIFvyfsXZQ0vpW9XpnD5UvRNICEwTSo=;
        b=Nq7LPOVxjAUHS97YSg+kPt3VCzwAu21Fae1xvAF3evyyTrsasHQ2xUnhS4UjhRSn60MQfl
        irreWYGKK3N/Cdlli4uGRhRhMz3Sng5x3vIDBS8uRRtiKoGq5xEOI5P3Z9PrqXpMlszDnI
        dgXY8m/qn5G2aD8mAzP5fVUga5BcM4I=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522938765; a=rsa-sha256;
        cv=none;
        b=wRCDhOhRnHxMVZxE+8SqR87q1INDSEn/uaXaCkXtj4m/OjtlLHCCjJ5svmb5YS2y0Z1Cbn5/qgdl1auqiduyA3Yp0XZX+gfbNZX/XgyAMJ6mldONqp5e0wGQlFWrvODOzNJdUl6JO3f9N6dprxqpntV1IyoDhZOn6wI+JOb5LCI=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

05.04.2018 16:21, Kees Cook wrote:
> I had a VM running over night with:
> 
> [1]   Running                 while :; do
>     smartctl -a /dev/sda > /dev/null;
> done &
> [2]-  Running                 while :; do
>     ls --color=auto -lR / > /dev/null 2> /dev/null;
> done &
> [3]+  Running                 while :; do
>     sleep $(( $RANDOM % 100 )); sync; echo 3 > 
> /proc/sys/vm/drop_caches;
> done &
> 
> and I haven't seen the issue. :(
> 
> FWIW, I'm using the ahci qemu driver:
> 
> -drive file=disk-image.raw,if=none,id=drive0,format=raw \
> -device ahci,id=bus0 \
> -device ide-drive,bus=bus0.0,drive=drive0
> 
> Does this match your qemu instance?

Well, not really. I just pass 2 raw disks as "-hda sda.img -hdb sda.img" 
(it is a playground VM for me with RAID10, LVM and LUKS inside, but I 
hope this doesn't matter). Does passing "-hda" differ from your 
approach?

Regards,
   Oleksandr
