Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B668EC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745D0219A2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745D0219A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeHEXmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:42:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:54599 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbeHEXmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:42:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w75LUs6K031030;
        Sun, 5 Aug 2018 16:30:56 -0500
Message-ID: <00113a1e9ec3e111ee4e12d682168142dcbbcf61.camel@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Date:   Mon, 06 Aug 2018 07:30:54 +1000
In-Reply-To: <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
References: <20180802200646-mutt-send-email-mst@kernel.org>
         <e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
         <20180802225738-mutt-send-email-mst@kernel.org>
         <de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
         <20180803070507.GA1344@infradead.org>
         <eb1750e90e4bd45da297fa6f78f8ef93671b7c2f.camel@kernel.crashing.org>
         <20180803160246.GA13794@infradead.org>
         <22310f58605169fe9de83abf78b59f593ff7fbb7.camel@kernel.crashing.org>
         <20180804082120.GB4421@infradead.org>
         <a3ec0a454928e880dabc3782ea906e318634abf9.camel@kernel.crashing.org>
         <20180805072930.GB23288@infradead.org>
         <b7e8294e3e70d24072883a7e8e5375719d5af870.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 07:16 +1000, Benjamin Herrenschmidt wrote:
> I'm trying to understand because the limitation is not a device side
> limitation, it's not a qemu limitation, it's actually more of a VM
> limitation. It has most of its memory pages made inaccessible for
> security reasons. The platform from a qemu/KVM perspective is almost
> entirely normal.

In fact this is probably the best image of what's going on:

It's a normal VM from a KVM/qemu perspective (and thus virtio). It
boots normally, can run firmware, linux, etc... normally, it's not
created with any different XML or qemu command line definition etc...

It just that once it reaches the kernel with the secure stuff enabled
(could be via kexec from a normal kernel), that kernel will "stash
away" most of the VM's memory into some secure space that nothing else
(not even the hypervisor) can access.

It can keep around a pool or two of normal memory for bounce buferring
IOs but that's about it.

I think that's the clearest way I could find to explain what's going
on, and why I'm so resistant on adding things on qemu side.

That said, we *can* (and will) notify KVM and qemu of the transition,
and we can/will do so after virtio has been instanciated and used by
the bootloader, but before it will be used (or even probed) by the
secure VM itself, so there's an opportunity to poke at things, either
from the VM itself (a quirk poking at virtio config space for example)
or from qemu (though I find the idea of iterating all virtio devices
from qemu to change a setting rather gross).

Cheers,
Ben.


