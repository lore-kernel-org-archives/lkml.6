Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB306C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1EE208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1EE208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeFYIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:09:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752616AbeFYII7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A918E401EF22;
        Mon, 25 Jun 2018 08:08:52 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4F2111AF12;
        Mon, 25 Jun 2018 08:08:51 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:08:49 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>,
        qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [qemu-s390x] s390 qemu boot failure in -next
Message-ID: <20180625100849.42ebfe78.cohuck@redhat.com>
In-Reply-To: <947bbba3-dcd0-7f5b-1d92-b41be764c2f5@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
        <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
        <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
        <947bbba3-dcd0-7f5b-1d92-b41be764c2f5@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 08:08:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 08:08:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 10:02:28 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 09:27 AM, Christian Borntraeger wrote:
> > Also adding QEMU.
> > 
> > On 06/25/2018 09:10 AM, Christian Borntraeger wrote:  
> >>
> >>
> >> On 06/22/2018 09:47 PM, Guenter Roeck wrote:  
> >>> Hi,
> >>>
> >>> starting with commit 's390/boot: make head.S and als.c be part of the
> >>> decompressor only' in -next, s390 immages no longer boot in qemu.
> >>> As far as I can see, the reason is that the command line is no longer
> >>> passed from qemu to the kernel, which results in a panic because the
> >>> root file system can not be mounted.
> >>>
> >>> Was this change made on purpose ? If so, is there a way to get qemu
> >>> back to working ?  
> >>
> >> Certainly not on purpose.
> >>
> >> Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
> >>
> >> e.g.
> >>
> >> qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
> >>
> >> The compressed image (bzImage) seems to work fine though.
> >>
> >> This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
> >> address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
> >> the load address is 0x100000 as there is no unpacker.
> >>
> >> Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?  
> > 
> > Something like this in QEMU 
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index f278036fa7..14153ce880 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >           */
> >          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> >              ipl->start_addr = KERN_IMAGE_START;
> > -            /* Overwrite parameters in the kernel image, which are "rom" */
> > -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >          } else {
> >              ipl->start_addr = pentry;
> >          }
> > +       if (ipl->cmdline) {
> > +            /* If there is a command line, put it in the right place */
> > +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> > +       }
> >  
> >          if (ipl->initrd) {
> >              ram_addr_t initrd_offset;
> > 
> > would put the command line in no matter what the start address is.  
> 
> Ideally we would do 2 changes:
> - change QEMU to add a commandline to 10480 if specified
> - have a way to fix the kernel elf file to still boot with older QEMUs 
> 

Agreed on both. Even if we change QEMU now (+ stable), there are many
versions out there that will now fail.
