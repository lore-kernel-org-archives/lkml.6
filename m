Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeFAIAB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750981AbeFAH7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:59:55 -0400
Date: Fri, 1 Jun 2018 09:59:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>, Gil Kupfer <gilkup@gmail.com>,
        Oleksandr Natalenko <onatalen@redhat.com>,
        "ldu@redhat.com" <ldu@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] vmw_balloon: fixing double free when batching mode is
 off
Message-ID: <20180601075931.GB12809@kroah.com>
References: <20180419063856.GA7643@kroah.com>
 <20180419181722.12273-1-namit@vmware.com>
 <162DEB66-373B-4E01-8D64-3CE7BEF47920@vmware.com>
 <7B3793E8-8DD9-4566-9CCB-6D1B0C364754@vmware.com>
 <4D5BA2F0-377D-4959-9786-95E195EE2D22@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D5BA2F0-377D-4959-9786-95E195EE2D22@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:56:52PM +0000, Nadav Amit wrote:
> Nadav Amit <namit@vmware.com> wrote:
> 
> > Nadav Amit <namit@vmware.com> wrote:
> > 
> >> Ping. Please consider it for inclusion for rc4.
> >> 
> >> Nadav Amit <namit@vmware.com> wrote:
> >> 
> >>> From: Gil Kupfer <gilkup@gmail.com>
> >>> 
> >>> The balloon.page field is used for two different purposes if batching is
> >>> on or off. If batching is on, the field point to the page which is used
> >>> to communicate with with the hypervisor. If it is off, balloon.page
> >>> points to the page that is about to be (un)locked.
> >>> 
> >>> Unfortunately, this dual-purpose of the field introduced a bug: when the
> >>> balloon is popped (e.g., when the machine is reset or the balloon driver
> >>> is explicitly removed), the balloon driver frees, unconditionally, the
> >>> page that is held in balloon.page.  As a result, if batching is
> >>> disabled, this leads to double freeing the last page that is sent to the
> >>> hypervisor.
> >>> 
> >>> The following error occurs during rmmod when kernel checkers are on, and
> >>> the balloon is not empty:
> >>> 
> >>> [   42.307653] ------------[ cut here ]------------
> >>> [   42.307657] Kernel BUG at ffffffffba1e4b28 [verbose debug info unavailable]
> >>> [   42.307720] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
> >>> [   42.312512] Modules linked in: vmw_vsock_vmci_transport vsock ppdev joydev vmw_balloon(-) input_leds serio_raw vmw_vmci parport_pc shpchp parport i2c_piix4 nfit mac_hid autofs4 vmwgfx drm_kms_helper hid_generic syscopyarea sysfillrect usbhid sysimgblt fb_sys_fops hid ttm mptspi scsi_transport_spi ahci mptscsih drm psmouse vmxnet3 libahci mptbase pata_acpi
> >>> [   42.312766] CPU: 10 PID: 1527 Comm: rmmod Not tainted 4.12.0+ #5
> >>> [   42.312803] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 09/30/2016
> >>> [   42.313042] task: ffff9bf9680f8000 task.stack: ffffbfefc1638000
> >>> [   42.313290] RIP: 0010:__free_pages+0x38/0x40
> >>> [   42.313510] RSP: 0018:ffffbfefc163be98 EFLAGS: 00010246
> >>> [   42.313731] RAX: 000000000000003e RBX: ffffffffc02b9720 RCX: 0000000000000006
> >>> [   42.313972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9bf97e08e0a0
> >>> [   42.314201] RBP: ffffbfefc163be98 R08: 0000000000000000 R09: 0000000000000000
> >>> [   42.314435] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc02b97e4
> >>> [   42.314505] R13: ffffffffc02b9748 R14: ffffffffc02b9728 R15: 0000000000000200
> >>> [   42.314550] FS:  00007f3af5fec700(0000) GS:ffff9bf97e080000(0000) knlGS:0000000000000000
> >>> [   42.314599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [   42.314635] CR2: 00007f44f6f4ab24 CR3: 00000003a7d12000 CR4: 00000000000006e0
> >>> [   42.314864] Call Trace:
> >>> [   42.315774]  vmballoon_pop+0x102/0x130 [vmw_balloon]
> >>> [   42.315816]  vmballoon_exit+0x42/0xd64 [vmw_balloon]
> >>> [   42.315853]  SyS_delete_module+0x1e2/0x250
> >>> [   42.315891]  entry_SYSCALL_64_fastpath+0x23/0xc2
> >>> [   42.315924] RIP: 0033:0x7f3af5b0e8e7
> >>> [   42.315949] RSP: 002b:00007fffe6ce0148 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> >>> [   42.315996] RAX: ffffffffffffffda RBX: 000055be676401e0 RCX: 00007f3af5b0e8e7
> >>> [   42.316951] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055be67640248
> >>> [   42.317887] RBP: 0000000000000003 R08: 0000000000000000 R09: 1999999999999999
> >>> [   42.318845] R10: 0000000000000883 R11: 0000000000000206 R12: 00007fffe6cdf130
> >>> [   42.319755] R13: 0000000000000000 R14: 0000000000000000 R15: 000055be676401e0
> >>> [   42.320606] Code: c0 74 1c f0 ff 4f 1c 74 02 5d c3 85 f6 74 07 e8 0f d8 ff ff 5d c3 31 f6 e8 c6 fb ff ff 5d c3 48 c7 c6 c8 0f c5 ba e8 58 be 02 00 <0f> 0b 66 0f 1f 44 00 00 66 66 66 66 90 48 85 ff 75 01 c3 55 48
> >>> [   42.323462] RIP: __free_pages+0x38/0x40 RSP: ffffbfefc163be98
> >>> [   42.325735] ---[ end trace 872e008e33f81508 ]---
> >>> 
> >>> To solve the bug, we eliminate the dual purpose of balloon.page.
> >>> 
> >>> Fixes: f220a80f0c2e ("VMware balloon: add batching to the vmw_balloon.")
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Oleksandr Natalenko <onatalen@redhat.com>
> >>> Signed-off-by: Gil Kupfer <gilkup@gmail.com>
> >>> Signed-off-by: Nadav Amit <namit@vmware.com>
> >>> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
> >>> ---
> >>> drivers/misc/vmw_balloon.c | 23 +++++++----------------
> >>> 1 file changed, 7 insertions(+), 16 deletions(-)
> >>> 
> >>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> >>> index 9047c0a529b2..efd733472a35 100644
> >>> --- a/drivers/misc/vmw_balloon.c
> >>> +++ b/drivers/misc/vmw_balloon.c
> >>> @@ -576,15 +576,9 @@ static void vmballoon_pop(struct vmballoon *b)
> >>> 		}
> >>> 	}
> >>> 
> >>> -	if (b->batch_page) {
> >>> -		vunmap(b->batch_page);
> >>> -		b->batch_page = NULL;
> >>> -	}
> >>> -
> >>> -	if (b->page) {
> >>> -		__free_page(b->page);
> >>> -		b->page = NULL;
> >>> -	}
> >>> +	/* Clearing the batch_page unconditionally has no adverse effect */
> >>> +	free_page((unsigned long)b->batch_page);
> >>> +	b->batch_page = NULL;
> >>> }
> >>> 
> >>> /*
> >>> @@ -991,16 +985,13 @@ static const struct vmballoon_ops vmballoon_batched_ops = {
> >>> 
> >>> static bool vmballoon_init_batching(struct vmballoon *b)
> >>> {
> >>> -	b->page = alloc_page(VMW_PAGE_ALLOC_NOSLEEP);
> >>> -	if (!b->page)
> >>> -		return false;
> >>> +	struct page *page;
> >>> 
> >>> -	b->batch_page = vmap(&b->page, 1, VM_MAP, PAGE_KERNEL);
> >>> -	if (!b->batch_page) {
> >>> -		__free_page(b->page);
> >>> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> >>> +	if (!page)
> >>> 		return false;
> >>> -	}
> >>> 
> >>> +	b->batch_page = page_address(page);
> >>> 	return true;
> >>> }
> >>> 
> >>> -- 
> >>> 2.14.1
> > 
> > Greg, can you please include this patch?? 4.17 is almost out of the door,
> > and the last version was sent a month ago.
> > 
> > If you have any reservations, please let me know immediately.
> 
> Arnd,
> 
> Perhaps you can - the very least - respond (or just include the patch)?
> 
> The last version of this patch was sent over a month ago.

It's too late for 4.17 now, and as this touches core code, I'll wait for
the next merge window cycle.  It's also not even in my patch review
queue anymore, I guess the long "does this solve the problem" delays
that this went through pushed it out.

So I would need it resent no matter what.

thanks,

greg k-h
