Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1B62559A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1B62559A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeFYIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:05:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752589AbeFYIFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:05:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B3548315E;
        Mon, 25 Jun 2018 08:05:53 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7790411166E2;
        Mon, 25 Jun 2018 08:05:51 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:05:48 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: s390 qemu boot failure in -next
Message-ID: <20180625100548.64222dad.cohuck@redhat.com>
In-Reply-To: <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
        <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
        <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 08:05:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 08:05:53 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 09:27:59 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Also adding QEMU.
> 
> On 06/25/2018 09:10 AM, Christian Borntraeger wrote:
> > 
> > 
> > On 06/22/2018 09:47 PM, Guenter Roeck wrote:  
> >> Hi,
> >>
> >> starting with commit 's390/boot: make head.S and als.c be part of the
> >> decompressor only' in -next, s390 immages no longer boot in qemu.
> >> As far as I can see, the reason is that the command line is no longer
> >> passed from qemu to the kernel, which results in a panic because the
> >> root file system can not be mounted.
> >>
> >> Was this change made on purpose ? If so, is there a way to get qemu
> >> back to working ?  
> > 
> > Certainly not on purpose.
> > 
> > Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
> > 
> > e.g.
> > 
> > qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
> > 
> > The compressed image (bzImage) seems to work fine though.
> > 
> > This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
> > address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
> > the load address is 0x100000 as there is no unpacker.

Do we consider these locations to be an exported interface, or is it
just QEMU guessing?

> > 
> > Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?  
> 
> Something like this in QEMU 
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index f278036fa7..14153ce880 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>           */
>          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
>              ipl->start_addr = KERN_IMAGE_START;
> -            /* Overwrite parameters in the kernel image, which are "rom" */
> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>          } else {
>              ipl->start_addr = pentry;
>          }
> +       if (ipl->cmdline) {
> +            /* If there is a command line, put it in the right place */
> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> +       }

Check for the magic Linux string (like in the non-elf case) first?

>  
>          if (ipl->initrd) {
>              ram_addr_t initrd_offset;
> 
> would put the command line in no matter what the start address is.

I'm for putting that one in (and backporting it to qemu-stable). It's a
bit worrying, though, that our ipl code is so fragile...
