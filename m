Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A4E20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A4E20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeKEVOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:14:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeKEVOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:14:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A9A7308212A;
        Mon,  5 Nov 2018 11:55:30 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BAF8672C2;
        Mon,  5 Nov 2018 11:55:26 +0000 (UTC)
Message-ID: <71ed924dfecf358f6e13a0d1897f94e148058b4a.camel@redhat.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 05 Nov 2018 13:55:24 +0200
In-Reply-To: <CAGF4SLhxvC5WN8W_ApoqMTe1i1r8FwX92Bb9UewpNwkKCZepnQ@mail.gmail.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
         <bf92bdb6dcb0e94014b3e1ffc8acce260a3df61e.camel@redhat.com>
         <CAGF4SLhxvC5WN8W_ApoqMTe1i1r8FwX92Bb9UewpNwkKCZepnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 05 Nov 2018 11:55:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 11:40 -0500, Vitaly Mayatskih wrote:
> On Sun, Nov 4, 2018 at 6:57 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> 
> > Hi!
> > I am also working in this area, and so I am very intersted in this driver.
> > 
> > > 1  171k  151k  148k 151k 195k  187k  175k
> > 
> > If I understand correctly this is fio --numjobs=1?
> > It looks like you are getting better that native performance over bare metal
> > in
> > E,F,G (vhost-blk cases in fact). Is this correct?
> 
> Yes. At such speeds it is a matter of how the workers are scheduled,
> i.e. how good is batching. There are other factors why vhost-blk is on
> par or slightly higher than fio running in userspace on bare metal,
> but from my observation the right batching all through the stack is
> more important.

I completely agree with you on that.
I currently learning profiling/tracing to understand the batching (or lack of)
in the tests I run

My focus currently is mostly on spdk + native nvme
While for multiple threads, the performance is very close to bare metal, on
single thread I see significant overhead which probably relate to batching as
well.

> 
> > Could you share the full fio command line you have used?
> 
> sysctl -w vm.nr_hugepages=8300; numactl -p 1 -N 1 ./qemu-system-x86_64
> -enable-kvm -cpu host -smp 16 -mem-prealloc -mem-path
> /dev/hugepages/foo -m 8G -nographic -drive
> if=none,id=drive0,format=raw,file=/dev/mapper/mirror-hello,cache=none
> -device virtio-blk-pci,id=blk0,drive=drive0,num-queues=16 -drive
> if=none,id=drive1,format=raw,file=/dev/mapper/mirror-volume,cache=none
> -device vhost-blk-pci,id=blk1,drive=drive1,num-queues=16
Thanks!

> 
> for i in `seq 1 16`; do echo -n "$i "; ./fio --direct=1 --rw=randread
> --ioengine=libaio --bs=4k --iodepth=128 --numjobs=$i --name=foo
> --time_based --runtime=15 --group_reporting --filename=/dev/vda
> --size=10g | grep -Po 'IOPS=[0-9\.]*k'; done
> 
> > Which IO device did you use for the test? NVME?
> 
> That was LVM mirror over 2 network disks. On the target side it was
> LVM stripe over few NVMe's.
Have you tried to test this over directly connected NVME device to?
The networking might naturally improve batching I think.

> 
> > Which system (cpu model/number of cores/etc) did you test on?
> 
> Dual socket: "model name    : Intel(R) Xeon(R) Gold 6142 CPU @
> 2.60GHz" with HT enabled, so 64 logical cores in total. The network
> was something from Intel with 53 Gbps PHY and served by fm10k driver.


All right, thanks!
I'll test your driver on my system where I tested most of the current solutions.

Best regards,
	Maxim Levitsky



