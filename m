Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF522C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56221266DA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56221266DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932829AbeFZIaB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:30:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932206AbeFZI36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C731406E81E;
        Tue, 26 Jun 2018 08:29:58 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B49A52026D6A;
        Tue, 26 Jun 2018 08:29:56 +0000 (UTC)
Date:   Tue, 26 Jun 2018 10:29:54 +0200
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
Message-ID: <20180626102954.73965b42.cohuck@redhat.com>
In-Reply-To: <d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
        <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
        <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
        <20180625100548.64222dad.cohuck@redhat.com>
        <d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 08:29:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 08:29:58 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 10:29:46 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 10:05 AM, Cornelia Huck wrote:
> > On Mon, 25 Jun 2018 09:27:59 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> >> Something like this in QEMU 
> >>
> >> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >> index f278036fa7..14153ce880 100644
> >> --- a/hw/s390x/ipl.c
> >> +++ b/hw/s390x/ipl.c
> >> @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >>           */
> >>          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
> >>              ipl->start_addr = KERN_IMAGE_START;
> >> -            /* Overwrite parameters in the kernel image, which are "rom" */
> >> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >>          } else {
> >>              ipl->start_addr = pentry;
> >>          }
> >> +       if (ipl->cmdline) {
> >> +            /* If there is a command line, put it in the right place */
> >> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
> >> +       }  
> > 
> > Check for the magic Linux string (like in the non-elf case) first?  
> 
> Even that does not exists in vmlinux but only in bzImage with the latest patchset
> (in next, but not upstream yet)

Ok.

> >   
> >>  
> >>          if (ipl->initrd) {
> >>              ram_addr_t initrd_offset;
> >>
> >> would put the command line in no matter what the start address is.  
> > 
> > I'm for putting that one in (and backporting it to qemu-stable). It's a
> > bit worrying, though, that our ipl code is so fragile...  
> 
> We actually have to combine this with Thomas fix (to check for rom_ptr returning
> something sane). It seems that ipl->commandline is always there, so we have to
> check for strlen!=0 it seems..
> 
> I mean if somebody ask for "-append something" we can certainly always write something
> if there is rom/ram.

Given that the uncompressed image is not supposed to be bootable
anymore, does it make sense to add this anyway?

I'll go ahead and queue Thomas' fix, though.
