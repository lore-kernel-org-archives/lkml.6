Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8E5208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8E5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeJPCui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:50:38 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41910 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbeJPCui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:50:38 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 921473A2903;
        Mon, 15 Oct 2018 20:51:18 +0200 (CEST)
X-Originating-IP: 212.92.120.238
Received: from localhost (unknown [212.92.120.238])
        (Authenticated sender: amit@amitshah.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E5E59FF802;
        Mon, 15 Oct 2018 18:51:15 +0000 (UTC)
Date:   Mon, 15 Oct 2018 20:51:15 +0200
From:   Amit Shah <amit@kernel.org>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     dgilbert@redhat.com, amit@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk
 performance
Message-ID: <20181015185115.GA3247@grmbl.mre>
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
 <20181001114146.GA2508@work-vm>
 <CAEK8JBBDPxTe0k8Nf=7PQ6gjYv4xyqQu=bef5VXmgaLVGw3JUg@mail.gmail.com>
 <CAEK8JBC-HKGb43UynWx69Lj-y48Em038eNMpOb7G72XfLF_mDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEK8JBC-HKGb43UynWx69Lj-y48Em038eNMpOb7G72XfLF_mDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (Thu) 11 Oct 2018 [18:15:41], Feng Li wrote:
> Add Amit Shah.
> 
> After some tests, we found:
> - the virtio serial port number is inversely proportional to the iSCSI
> virtio-blk-pci performance.
> If we set the virio-serial ports to 2("<controller
> type='virtio-serial' index='0' ports='2'/>), the performance downgrade
> is minimal.

If you use multiple virtio-net (or blk) devices -- just register, not
necessarily use -- does that also bring the performance down?  I
suspect it's the number of interrupts that get allocated for the
ports.  Also, could you check if MSI is enabled?  Can you try with and
without?  Can you also reproduce if you have multiple virtio-serial
controllers with 2 ports each (totalling up to whatever number that
reproduces the issue).

		Amit

> 
> - use local disk/ram disk as virtio-blk-pci disk, the performance
> downgrade is still obvious.
> 
> 
> Could anyone give some help about this issue?
> 
> Feng Li <lifeng1519@gmail.com> 于2018年10月1日周一 下午10:58写道：
> >
> > Hi Dave,
> > My comments are in-line.
> >
> > Dr. David Alan Gilbert <dgilbert@redhat.com> 于2018年10月1日周一 下午7:41写道：
> > >
> > > * Feng Li (lifeng1519@gmail.com) wrote:
> > > > Hi,
> > > > I found an obvious performance downgrade when virtio-console combined
> > > > with virtio-pci-blk.
> > > >
> > > > This phenomenon exists in nearly all Qemu versions and all Linux
> > > > (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> > > >
> > > > This is a disk cmd:
> > > > -drive file=iscsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-iscsi/1,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native
> > > > -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on
> > > >
> > > > If I add "-device
> > > > virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x5  ", the virtio
> > > > disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.
> > > >
> > > > In VM, if I rmmod virtio-console, the performance will back to normal.
> > > >
> > > > Any idea about this issue?
> > > >
> > > > I don't know this is a qemu issue or kernel issue.
> > >
> > > It sounds odd;  can you provide more details on:
> > >   a) The benchmark you're using.
> > I'm using fio, the config is:
> > [global]
> > ioengine=libaio
> > iodepth=128
> > runtime=120
> > time_based
> > direct=1
> >
> > [randread]
> > stonewall
> > bs=4k
> > filename=/dev/vdb
> > rw=randread
> >
> > >   b) the host and the guest config (number of cpus etc)
> > The qemu cmd is : /usr/libexec/qemu-kvm --device virtio-balloon -m 16G
> > --enable-kvm -cpu host -smp 8
> > or qemu-system-x86_64 --device virtio-balloon -m 16G --enable-kvm -cpu
> > host -smp 8
> >
> > The result is the same.
> >
> > >   c) Why are you running it with iscsi back to the same host - why not
> > >      just simplify the test back to a simple file?
> > >
> >
> > Because my ISCSI target could supply a high IOPS performance.
> > If using a slow disk, the performance downgrade would be not so obvious.
> > It's easy to be seen, you could try it.
> >
> >
> > > Dave
> > >
> > > >
> > > > Thanks in advance.
> > > > --
> > > > Thanks and Best Regards,
> > > > Alex
> > > >
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> >
> >
> > --
> > Thanks and Best Regards,
> > Feng Li(Alex)
> 
> 
> 
> --
> Thanks and Best Regards,
> Feng Li(Alex)

		Amit
-- 
http://amitshah.net/
