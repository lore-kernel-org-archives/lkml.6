Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D55C217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544986519;
	bh=vGQECqz+y7APmcjDOQArWa9o48cUPml+P6H5vTT38gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lTsofLh1HLkifAuL4rfP/2gb96l6gIi7JGeU6W0o+4lzd8yBNvSF3FETVy9NnPvIQ
	 Hyg7uqtfPflRL8V719foatOI9WOceWbmy93xP+YBdL9FaEUK8yMqgHLRWSmmVDzpJy
	 QtYJ74rz4wmdORpwb3pybiC3kx0HOAVzajFcYzvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbeLPSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 13:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbeLPSzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 13:55:17 -0500
Received: from sol.localdomain (c-24-23-142-8.hsd1.ca.comcast.net [24.23.142.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E772086C;
        Sun, 16 Dec 2018 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544986516;
        bh=vGQECqz+y7APmcjDOQArWa9o48cUPml+P6H5vTT38gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ip9EJ2xVPxsTjpnn8O9YOnG2axRoDFcY4eURFOjOQ4XM6XWKXlYYhY0NYJnv85EzK
         RD563pJTCTlTYqqm0WIQHf6b6v/m7VxIAqB+A7rwWvLorgQdWuTW6mEjN1dGW0HTYD
         NVkAGESHUPf4zrWXiD+Ag9prIOTO23yp1SgFdQT4=
Date:   Sun, 16 Dec 2018 10:55:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peng Hao <peng.hao2@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in kvm_put_kvm (caused by: "kvm/x86:
 add coalesced pio support")
Message-ID: <20181216185513.GA691@sol.localdomain>
References: <000000000000bc23740578abe82c@google.com>
 <3ad5acd8-5c73-1d82-aea5-426e598b15ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ad5acd8-5c73-1d82-aea5-426e598b15ed@redhat.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng and Paolo,

On Sun, Oct 21, 2018 at 12:01:55PM +0200, Paolo Bonzini wrote:
> On 20/10/2018 18:57, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    8c60c36d0b8c Add linux-next specific files for 20181019
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12d808b5400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8b6d7c4c81535e89
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=f87f60bb6f13f39b54e3
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cf2f5e400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1036dcce400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com
> 
> Tentative (untested) patch:
> 
> diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
> index 3710342cf6ad..dc76cc8d24fd 100644
> --- a/virt/kvm/coalesced_mmio.c
> +++ b/virt/kvm/coalesced_mmio.c
> @@ -90,6 +90,7 @@ static int coalesced_mmio_write(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
> 
> +/* called with kvm->slots_lock held */
>  static void coalesced_mmio_destructor(struct kvm_io_device *this)
>  {
>  	struct kvm_coalesced_mmio_dev *dev = to_mmio(this);
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index b20b751286fc..001e1ef18c8c 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -741,8 +741,8 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct
> kvm_io_device *this, gpa_t addr,
>  }
> 
>  /*
> - * This function is called as KVM is completely shutting down.  We do not
> - * need to worry about locking just nuke anything we have as quickly as
> possible
> + * This function is called as KVM is completely shutting down, so there
> + * are no RCU readers anymore. Called with kvm->slots_lock held.
>   */
>  static void
>  ioeventfd_destructor(struct kvm_io_device *this)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index aff1242b7af7..e6f2ae6fedcd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -783,6 +783,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  	list_del(&kvm->vm_list);
>  	spin_unlock(&kvm_lock);
>  	kvm_free_irq_routing(kvm);
> +	mutex_lock(&kvm->slots_lock);
>  	for (i = 0; i < KVM_NR_BUSES; i++) {
>  		struct kvm_io_bus *bus = kvm_get_bus(kvm, i);
> 
> @@ -790,6 +791,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  			kvm_io_bus_destroy(bus);
>  		kvm->buses[i] = NULL;
>  	}
> +	mutex_unlock(&kvm->slots_lock);
>  	kvm_coalesced_mmio_free(kvm);
>  #ifdef KVM_DIRTY_LOG_PAGE_OFFSET
>  	if (kvm->dirty_ring_size)
> 

This is still happening.  Paolo, I don't see how your patch matches this bug, as
it has a single threaded reproducer.  I simplified it to:

	#include <fcntl.h>
	#include <linux/kvm.h>
	#include <sys/ioctl.h>

	int main(void)
	{
		int kvm, vm;
		struct kvm_coalesced_mmio_zone zone = { 0 };

		kvm = open("/dev/kvm", O_RDWR);

		vm = ioctl(kvm, KVM_CREATE_VM, 0);

		ioctl(vm, KVM_REGISTER_COALESCED_MMIO, &zone);

		zone.pio = 1;
		ioctl(vm, KVM_UNREGISTER_COALESCED_MMIO, &zone);
	}

The bug is in this commit:

	commit 0804c849f1df0992d39a37c4fc259f7f8b16f385
	Author: Peng Hao <peng.hao2@zte.com.cn>
	Date:   Sun Oct 14 07:09:55 2018 +0800

	    kvm/x86 : add coalesced pio support

The problem is that if you register a kvm_coalesced_mmio_zone with '.pio = 0'
but then unregister it with '.pio = 1', KVM_UNREGISTER_COALESCED_MMIO will try
to unregister it from KVM_PIO_BUS rather than KVM_MMIO_BUS, which is a no-op,
but then it frees the kvm_coalesced_mmio_dev anyway.

Here's one possible fix but I don't know what was intended here.  Are you
supposed to pass in the same value of '.pio' when unregistering or is it
supposed to use the existing value?  Can one of you please point me to the
documentation for these ioctls?

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 3710342cf6ad0..6855cce3e5287 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -175,10 +175,14 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 {
 	struct kvm_coalesced_mmio_dev *dev, *tmp;
 
+	if (zone->pio != 1 && zone->pio != 0)
+		return -EINVAL;
+
 	mutex_lock(&kvm->slots_lock);
 
 	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
-		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
+		if (zone->pio == dev->zone.pio &&
+		    coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
 			kvm_io_bus_unregister_dev(kvm,
 				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, &dev->dev);
 			kvm_iodevice_destructor(&dev->dev);
