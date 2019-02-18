Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE8C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfBRWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:30:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfBRWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:30:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30D9DC0467FA;
        Mon, 18 Feb 2019 22:30:26 +0000 (UTC)
Received: from gondolin (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2F7600C8;
        Mon, 18 Feb 2019 22:30:24 +0000 (UTC)
Date:   Mon, 18 Feb 2019 23:30:21 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/setup: fix early warning messages
Message-ID: <20190218233021.368bb475.cohuck@redhat.com>
In-Reply-To: <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
        <20190218180146.79930fe6@mschwideX1>
        <20190218182106.61b10ee4@mschwideX1>
        <20190218191655.103c81ca.cohuck@redhat.com>
        <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 18 Feb 2019 22:30:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 11:22:40 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Cornelia,
> 
> On 2/18/19 10:16 AM, Cornelia Huck wrote:
> > On Mon, 18 Feb 2019 18:21:06 +0100
> > Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >   
> >> On Mon, 18 Feb 2019 18:01:46 +0100
> >> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >>  
> >>> On Mon, 18 Feb 2019 07:46:40 -0800
> >>> Guenter Roeck <linux@roeck-us.net> wrote:
> >>>      
> >>>> Hi,
> >>>>
> >>>> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:  
> >>>>> The setup_lowcore() function creates a new prefix page for the boot CPU.
> >>>>> The PSW mask for the system_call, external interrupt, i/o interrupt and
> >>>>> the program check handler have the DAT bit set in this new prefix page.
> >>>>>
> >>>>> At the time setup_lowcore is called the system still runs without virtual
> >>>>> address translation, the paging_init() function creates the kernel page
> >>>>> table and loads the CR13 with the kernel ASCE.
> >>>>>
> >>>>> Any code between setup_lowcore() and the end of paging_init() that has
> >>>>> a BUG or WARN statement will create a program check that can not be
> >>>>> handled correctly as there is no kernel page table yet.
> >>>>>
> >>>>> To allow early WARN statements initially setup the lowcore with DAT off
> >>>>> and set the DAT bit only after paging_init() has completed.
> >>>>>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>  
> >>>>
> >>>> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
> >>>> Reverting the patch fixes the problem. Crash log and bisect results below.  
> >>>
> >>> Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> >>> with 4K mapping where the prefix page is mapped to absolute zero.
> >>>
> >>> Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> >>> because low-address protection is already active. I'll think of something.
> >>>
> >>> Thanks for bug report!  
> >>   
> >> This patch should fix the problem:
> >> --
> >>  From d4393e82c3ec9b2fe5dba4b0d1b6eef29f8d15c8 Mon Sep 17 00:00:00 2001
> >> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >> Date: Mon, 18 Feb 2019 18:10:08 +0100
> >> Subject: [PATCH] s390/setup: fix boot crash for machine without EDAT-1
> >>
> >> The fix to make WARN work in the early boot code created a problem
> >> on older machines without EDAT-1. The setup_lowcore_dat_on function
> >> uses the pointer from lowcore_ptr[0] to set the DAT bit in the new
> >> PSWs. That does not work if the kernel page table is set up with
> >> 4K pages as the prefix address maps to absolute zero.
> >>
> >> To make this work the PSWs need to be changed with via address 0 in
> >> form of the S390_lowcore definition.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 94f85ed3e2 ("s390/setup: fix early warning messages")
> >> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >> ---
> >>   arch/s390/kernel/setup.c | 13 ++++++-------
> >>   1 file changed, 6 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> >> index 65b22ef5141a..12934e8fbb91 100644
> >> --- a/arch/s390/kernel/setup.c
> >> +++ b/arch/s390/kernel/setup.c
> >> @@ -451,13 +451,12 @@ static void __init setup_lowcore_dat_off(void)
> >>   
> >>   static void __init setup_lowcore_dat_on(void)
> >>   {
> >> -	struct lowcore *lc;
> >> -
> >> -	lc = lowcore_ptr[0];
> >> -	lc->external_new_psw.mask |= PSW_MASK_DAT;
> >> -	lc->svc_new_psw.mask |= PSW_MASK_DAT;
> >> -	lc->program_new_psw.mask |= PSW_MASK_DAT;
> >> -	lc->io_new_psw.mask |= PSW_MASK_DAT;
> >> +	__ctl_clear_bit(0, 28);
> >> +	S390_lowcore.external_new_psw.mask |= PSW_MASK_DAT;
> >> +	S390_lowcore.svc_new_psw.mask |= PSW_MASK_DAT;
> >> +	S390_lowcore.program_new_psw.mask |= PSW_MASK_DAT;
> >> +	S390_lowcore.io_new_psw.mask |= PSW_MASK_DAT;
> >> +	__ctl_set_bit(0, 28);
> >>   }
> >>   
> >>   static struct resource code_resource = {  
> > 
> > I could reproduce the crash under qemu/tcg and with this patch on top
> > it is gone.
> >   
> 
> What is your qemu command line ?

Ignoring any additional devices:

s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu max  -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001 -drive file=/home/cohuck/vm-images/vm1.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 -sandbox on -kernel ~/git/linux/arch/s390/boot/bzImage -append "root=/dev/sda3"

Code level is https://github.com/cohuck/qemu s390-next (as of today)

> 
> Thanks,
> Guenter

