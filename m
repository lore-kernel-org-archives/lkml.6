Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D245C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3E921902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfBTJW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:22:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTJW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:22:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B2CAC3A6D;
        Wed, 20 Feb 2019 09:22:56 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E33F5D6B6;
        Wed, 20 Feb 2019 09:22:54 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:22:52 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/setup: fix early warning messages
Message-ID: <20190220102252.43dd10a4.cohuck@redhat.com>
In-Reply-To: <eca82ff3-bc07-ee2f-b67a-91425fe1ace0@roeck-us.net>
References: <20190218154640.GA27699@roeck-us.net>
        <20190218180146.79930fe6@mschwideX1>
        <20190218182106.61b10ee4@mschwideX1>
        <20190218191655.103c81ca.cohuck@redhat.com>
        <05e78442-07e1-9783-965f-b3d64a2c5e99@roeck-us.net>
        <20190218233021.368bb475.cohuck@redhat.com>
        <eca82ff3-bc07-ee2f-b67a-91425fe1ace0@roeck-us.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 20 Feb 2019 09:22:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 10:47:38 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Cornelia,
> 
> On 2/18/19 2:30 PM, Cornelia Huck wrote:
> 
> >> What is your qemu command line ?  
> > 
> > Ignoring any additional devices:
> > 
> > s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu max  -m 1024 -nographic -device virtio-scsi-ccw,id=scsi0,devno=fe.0.0001 -drive file=/home/cohuck/vm-images/vm1.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1 -sandbox on -kernel ~/git/linux/arch/s390/boot/bzImage -append "root=/dev/sda3"
> >   
> 
> Is "accel=tcg" and "-cpu max" expected to make any difference ? CPU consumption
> on my system seems to be identical to the default (no -M or -cpu on command line).
> This is with qemu 3.1.

If you're not running on a s390x, QEMU will pick tcg even if not
specified (as it needs to emulate anyway), so that should not make any
difference. The 'max' cpu model was is not yet available with 3.1
(merged in the current development cycle); it will not make much
difference in practice (a few more cpu features are currently provided
with it over the default 'qemu' cpu model).

As I'm testing various combinations (tcg vs. kvm on an s390x host,
different cpu models) when I'm queuing patches, my command line is not
necessarily exactly the same every time (this was just the one I
happened to be testing the kernel patch with). If you simply want to be
able to boot a test kernel on a non-s390x host, relying on the default
accelerator (tcg) and the default cpu model (qemu) being picked should
be completely fine.
