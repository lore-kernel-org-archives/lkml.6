Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81344ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEF520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEF520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeGTNu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbeGTNu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB78C8553C;
        Fri, 20 Jul 2018 13:02:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94DD1CBD63;
        Fri, 20 Jul 2018 13:02:47 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 27F4F4BB78;
        Fri, 20 Jul 2018 13:02:47 +0000 (UTC)
Date:   Fri, 20 Jul 2018 09:02:46 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>, kwolf@redhat.com,
        dan j williams <dan.j.williams@intel.com>, jack@suse.cz,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org,
        ross zwisler <ross.zwisler@intel.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        hch@infradead.org, imammedo@redhat.com, mst@redhat.com,
        niteshnarayanlal@hotmail.com, pbonzini@redhat.com, nilal@redhat.com
Message-ID: <1935251498.52851607.1532091766703.JavaMail.zimbra@redhat.com>
In-Reply-To: <b6ef19f3-7f16-5427-bfed-f352a76e48b7@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com> <20180713075232.9575-4-pagupta@redhat.com> <20180718085529.133a0a22@doriath> <367397176.52317488.1531979293251.JavaMail.zimbra@redhat.com> <20180719121635.GA28107@stefanha-x1.localdomain> <b6ef19f3-7f16-5427-bfed-f352a76e48b7@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.193.70, 10.4.195.18]
Thread-Topic: qemu: Add virtio pmem device
Thread-Index: INy5cCwh9vrG+xbS7CL3R7NtkcjtnA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 20 Jul 2018 13:02:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>>  /*
> >>>>   * virtio-balloon-pci: This extends VirtioPCIProxy.
> >>>>   */
> >>>> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> >>>> new file mode 100644
> >>>> index 0000000000..08c96d7e80
> >>>> --- /dev/null
> >>>> +++ b/hw/virtio/virtio-pmem.c
> >>>> @@ -0,0 +1,241 @@
> >>>> +/*
> >>>> + * Virtio pmem device
> >>>> + *
> >>>> + * Copyright (C) 2018 Red Hat, Inc.
> >>>> + * Copyright (C) 2018 Pankaj Gupta <pagupta@redhat.com>
> >>>> + *
> >>>> + * This work is licensed under the terms of the GNU GPL, version 2.
> >>>> + * See the COPYING file in the top-level directory.
> >>>> + *
> >>>> + */
> >>>> +
> >>>> +#include "qemu/osdep.h"
> >>>> +#include "qapi/error.h"
> >>>> +#include "qemu-common.h"
> >>>> +#include "qemu/error-report.h"
> >>>> +#include "hw/virtio/virtio-access.h"
> >>>> +#include "hw/virtio/virtio-pmem.h"
> >>>> +#include "hw/mem/memory-device.h"
> >>>> +#include "block/aio.h"
> >>>> +#include "block/thread-pool.h"
> >>>> +
> >>>> +typedef struct VirtIOPMEMresp {
> >>>> +    int ret;
> >>>> +} VirtIOPMEMResp;
> >>>> +
> >>>> +typedef struct VirtIODeviceRequest {
> >>>> +    VirtQueueElement elem;
> >>>> +    int fd;
> >>>> +    VirtIOPMEM *pmem;
> >>>> +    VirtIOPMEMResp resp;
> >>>> +} VirtIODeviceRequest;
> >>>> +
> >>>> +static int worker_cb(void *opaque)
> >>>> +{
> >>>> +    VirtIODeviceRequest *req = opaque;
> >>>> +    int err = 0;
> >>>> +
> >>>> +    /* flush raw backing image */
> >>>> +    err = fsync(req->fd);
> >>>> +    if (err != 0) {
> >>>> +        err = errno;
> >>>> +    }
> >>>> +    req->resp.ret = err;
> >>>
> >>> Host question: are you returning the guest errno code to the host?
> >>
> >> No. I am returning error code from the host in-case of host fsync
> >> failure, otherwise returning zero.
> > 
> > I think that's what Luiz meant.  errno constants are not portable
> > between operating systems and architectures.  Therefore they cannot be
> > used in external interfaces in software that expects to communicate with
> > other systems.
> > 
> > It will be necessary to define specific constants for virtio-pmem
> > instead of passing errno from the host to guest.
> > 
> 
> In general, I wonder if we should report errors at all or rather *kill*
> the guest. That might sound harsh, but think about the following scenario:
> 
> fsync() fails due to some block that cannot e.g. be written (e.g.
> network connection failed). What happens if our guest tries to
> read/write that mmaped block? (e.g. network connection failed).
> 
> I assume we'll get a signal an get killed? So we are trying to optimize
> one special case (fsync()) although every read/write is prone to kill
> the guest. And as soon as the guest will try to access the block that
> made fsync fail, we will crash the guest either way.
> 
> I assume the main problem is that we are trying to take a file (with all
> the errors that can happen during read/write/fsync) and make it look
> like memory (dax). On ordinary block access, we can forward errors, but
> not if it's memory (maybe using MCE, but it's complicated and
> architecture specific).

There are two points which you highlighted:

1] Memory hardware errors:
These type of errors will be notified by MCA. If mce is non-recoverable, KVM gets 
SIG_BUS when hardware detects such error and injects mce in guest vCPU. If guest 
does not recoverable it can decide to kill the user-space process. 

Default option for mce is '1':
1: panic or SIGBUS on uncorrected errors, log corrected errors

2] read/write/fsync failure because of (network connection failure):
I assume you are talking about something like NFS mount where read/write/fsync
responsibility is taken care by NFS. This scenario can happen for any application
accessing a network filesystem and return appropriate error or wait. Until 'fsync' 
is not performed there is no guarantee ram data is backed. I think its
the responsibility of application to perform fsync after write operation or 
a transaction.
 
> 
> So I wonder if we should rather assume that our backend file is placed
> on some stable storage that cannot easily fail.
> 
> (we might have the same problem with NVDIMM right now, at least the
> memory reading/writing part)

NVDIMM NFIT handles this handler and checks if any SPA falls in the range
of mce:address. It creates a list of bad blocks(corresponding to nd_region) and handle 
in function 'pmem_do_bvec' used by 'pmem_mem_request' & 'pmem_read_write'.

void nfit_mce_register(void)
{
        mce_register_decode_chain(&nfit_mce_dec);
}

In 'fake DAX', we bypass NFIT ACPI and using virtio & nvdimm_bus way of registering
memory region. By default it should kill the userspace process or at worst cause guest reboot.
I am thinking how we can integrate the NFIT bad block handling with mce handler approach
for fake DAX. I think we can do this. But I want inputs from NVDIMM guys?

Thanks,
Pankaj

> 
> It's complicated and I am not a block level expert :)
