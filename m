Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeE2L7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:59:08 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37662 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933438AbeE2L7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:59:02 -0400
Date: Tue, 29 May 2018 21:59:05 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@lst.de>
cc: Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, Joshua Thompson <funaho@jurai.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
In-Reply-To: <20180529071119.GB32615@lst.de>
Message-ID: <alpine.LNX.2.21.1805292140160.16@nippy.intranet>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net> <alpine.LNX.2.21.1805271212480.9@nippy.intranet> <55c1c33b-4a34-bd72-57de-577ce8d95e0b@gmail.com> <alpine.LNX.2.21.1805271547090.9@nippy.intranet> <2ffd0de6-e8d6-6449-7c05-cbbfd8a99a97@gmail.com>
 <alpine.LNX.2.21.1805281521420.10@nippy.intranet> <CAMuHMdWXnP96p9swox6FXg2-2doeNGK+G9eQyZ-td+xWGSKKoQ@mail.gmail.com> <alpine.LNX.2.21.1805291047230.13@nippy.intranet> <b4f0d2d7-fcd5-b68f-0bc6-cd41c353aba7@gmail.com> <alpine.LNX.2.21.1805291524080.16@nippy.intranet>
 <20180529071119.GB32615@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018, Christoph Hellwig wrote:

> Btw, can I get a review and testing for the above? They aren't really 
> experimental any more, and I'd like to move architectures over as soon 
> as possible.

When I boot the generic-dma-noncoherent.2 branch (5f4613b2dcd4) in qemu 
and run "ifconfig eth0 up" I get an oops (see below).

The crash goes away when I add a patch to initialize the macsonic device 
dma masks, but it appears the new code is not as robust as the old code.

Unable to handle kernel NULL pointer dereference at virtual address   (null)
Oops: 00000000
Modules linked in:
PC: [<003352e6>] dma_direct_map_page+0xc0/0xf8
SR: 2004  SP: f93954f5  a2: 1e988f30
d0: 1e9c7950    d1: 1e9c7000    d2: fff0b1c8    d3: f4e569c7
d4: 000005f0    d5: 00000002    a0: 1e85a20a    a1: 00000000
Process ifconfig (pid: 46, task=87dc4b31)
Frame format=7 eff addr=00000000 ssw=0505 faddr=00000000
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 00000000 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 1e9b9c74:
        00000000 00000000 000005f0 00000002 0001e9c7 0000003d 1e85a20a 00951ffc
        1e9c7950 1e9b9cd8 00335636 1e85a20a 00951ffc 00000950 000005f0 00000002
        00000000 00000000 00000017 003d38e0 0027b11e 0001e9c7 1e9783e0 1e9784d0
        00381f10 1e9b9d2c 0025c11a 1e85a20a 00951ffc 00000950 000005f0 00000002
        00000000 00001043 00001002 00000041 8000b543 00000000 1e95f00c 1e978000
        0037c3a0 1e97802f 00000950 1e85a20a 0007a71c 1e9b9d44 1e9b9d44 0028d4b0
Call Trace: [<0001e9c7>] resource_list_create_entry+0x11/0x46
 [<00335636>] dma_noncoherent_map_page+0x32/0xfc
 [<0027b11e>] skb_put+0x0/0x6a
 [<0001e9c7>] resource_list_create_entry+0x11/0x46
 [<0025c11a>] macsonic_open+0x124/0x360
 [<00001043>] kernel_pg_dir+0x43/0x1000
 [<00001002>] kernel_pg_dir+0x2/0x1000
 [<0007a71c>] wb_update_bandwidth+0x40/0x4c
 [<0028d4b0>] __dev_open+0x8e/0x108
 [<0028d026>] dev_set_rx_mode+0x0/0x3e
 [<0028d676>] __dev_change_flags+0x14c/0x19e
 [<00001002>] kernel_pg_dir+0x2/0x1000
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00021378>] ns_capable_common+0x30/0x96
 [<0028d6e8>] dev_change_flags+0x20/0x56
 [<00001043>] kernel_pg_dir+0x43/0x1000
 [<00001043>] kernel_pg_dir+0x43/0x1000
 [<002fad14>] devinet_ioctl+0x610/0x754
 [<00001043>] kernel_pg_dir+0x43/0x1000
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<002fc3c6>] inet_ioctl+0x1a2/0x250
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00291c50>] dev_get_by_name_rcu+0x68/0xa0
 [<00291c50>] dev_get_by_name_rcu+0x68/0xa0
 [<00008913>] via_nubus_irq+0x9d/0xd0
 [<002b17ce>] dev_ioctl+0x334/0x4ba
 [<002b1826>] dev_ioctl+0x38c/0x4ba
 [<00273b44>] sock_ioctl+0x132/0x3f4
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00001002>] kernel_pg_dir+0x2/0x1000
 [<00028000>] getrusage+0x25a/0x3ee
 [<000c1594>] vfs_ioctl+0x20/0x36
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<000c197e>] do_vfs_ioctl+0x70/0x6ae
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<000bf7e0>] user_path_at_empty+0x2c/0x34
 [<0003471e>] __put_cred+0x2a/0x78
 [<00034b2a>] put_cred_rcu+0x0/0x92
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<000c1fec>] ksys_ioctl+0x30/0x6c
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<000c203e>] sys_ioctl+0x16/0x1a
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<00002b7c>] syscall+0x8/0xc
 [<00008914>] via_nubus_irq+0x9e/0xd0
 [<0000c00f>] cu_norm+0x9/0x28
Code: 9781 6514 4280 4cee 18fc ffdc 4e5e 4e75 <2211> 2429 0004 60e2 2f02 2f01 2f2e 0014 486e fffc 4879 0038 1efc 4879 003e a45d
Disabling lock debugging due to kernel taint

-- 
