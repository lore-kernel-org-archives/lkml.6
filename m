Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB83C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4100A2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4100A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeGLPPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:15:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbeGLPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:15:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A19ECC9F;
        Thu, 12 Jul 2018 15:05:37 +0000 (UTC)
Date:   Thu, 12 Jul 2018 17:05:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180712150535.GG22502@kroah.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180711194908.GA27217@mail.hallyn.com>
 <20180711200056.GA13192@cisco.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711200056.GA13192@cisco.cisco.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:00:56PM -0600, Tycho Andersen wrote:
> On Wed, Jul 11, 2018 at 02:49:08PM -0500, Serge E. Hallyn wrote:
> > Quoting Tycho Andersen (tycho@tycho.ws):
> > > We have reports of the following crash:
> > > 
> > >     PID: 7 TASK: ffff88085c6d61c0 CPU: 1 COMMAND: "kworker/u25:0"
> > >     #0 [ffff88085c6db710] machine_kexec at ffffffff81046239
> > >     #1 [ffff88085c6db760] crash_kexec at ffffffff810fc248
> > >     #2 [ffff88085c6db830] oops_end at ffffffff81008ae7
> > >     #3 [ffff88085c6db860] no_context at ffffffff81050b8f
> > >     #4 [ffff88085c6db8b0] __bad_area_nosemaphore at ffffffff81050d75
> > >     #5 [ffff88085c6db900] bad_area_nosemaphore at ffffffff81050e83
> > >     #6 [ffff88085c6db910] __do_page_fault at ffffffff8105132e
> > >     #7 [ffff88085c6db9b0] do_page_fault at ffffffff8105152c
> > >     #8 [ffff88085c6db9c0] page_fault at ffffffff81a3f122
> > >     [exception RIP: uart_put_char+149]
> > >     RIP: ffffffff814b67b5 RSP: ffff88085c6dba78 RFLAGS: 00010006
> > >     RAX: 0000000000000292 RBX: ffffffff827c5120 RCX: 0000000000000081
> > >     RDX: 0000000000000000 RSI: 000000000000005f RDI: ffffffff827c5120
> > >     RBP: ffff88085c6dba98 R8: 000000000000012c R9: ffffffff822ea320
> > >     R10: ffff88085fe4db04 R11: 0000000000000001 R12: ffff881059f9c000
> > >     R13: 0000000000000001 R14: 000000000000005f R15: 0000000000000fba
> > >     ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
> > >     #9 [ffff88085c6dbaa0] tty_put_char at ffffffff81497544
> > >     #10 [ffff88085c6dbac0] do_output_char at ffffffff8149c91c
> > >     #11 [ffff88085c6dbae0] __process_echoes at ffffffff8149cb8b
> > >     #12 [ffff88085c6dbb30] commit_echoes at ffffffff8149cdc2
> > >     #13 [ffff88085c6dbb60] n_tty_receive_buf_fast at ffffffff8149e49b
> > >     #14 [ffff88085c6dbbc0] __receive_buf at ffffffff8149ef5a
> > >     #15 [ffff88085c6dbc20] n_tty_receive_buf_common at ffffffff8149f016
> > >     #16 [ffff88085c6dbca0] n_tty_receive_buf2 at ffffffff8149f194
> > >     #17 [ffff88085c6dbcb0] flush_to_ldisc at ffffffff814a238a
> > >     #18 [ffff88085c6dbd50] process_one_work at ffffffff81090be2
> > >     #19 [ffff88085c6dbe20] worker_thread at ffffffff81091b4d
> > >     #20 [ffff88085c6dbeb0] kthread at ffffffff81096384
> > >     #21 [ffff88085c6dbf50] ret_from_fork at ffffffff81a3d69f​
> > > 
> > > after slogging through some dissasembly:
> > > 
> > > ffffffff814b6720 <uart_put_char>:
> > > ffffffff814b6720:	55                   	push   %rbp
> > > ffffffff814b6721:	48 89 e5             	mov    %rsp,%rbp
> > > ffffffff814b6724:	48 83 ec 20          	sub    $0x20,%rsp
> > > ffffffff814b6728:	48 89 1c 24          	mov    %rbx,(%rsp)
> > > ffffffff814b672c:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
> > > ffffffff814b6731:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
> > > ffffffff814b6736:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
> > > ffffffff814b673b:	e8 b0 8e 58 00       	callq  ffffffff81a3f5f0 <mcount>
> > > ffffffff814b6740:	4c 8b a7 88 02 00 00 	mov    0x288(%rdi),%r12
> > > ffffffff814b6747:	45 31 ed             	xor    %r13d,%r13d
> > > ffffffff814b674a:	41 89 f6             	mov    %esi,%r14d
> > > ffffffff814b674d:	49 83 bc 24 70 01 00 	cmpq   $0x0,0x170(%r12)
> > > ffffffff814b6754:	00 00
> > > ffffffff814b6756:	49 8b 9c 24 80 01 00 	mov    0x180(%r12),%rbx
> > > ffffffff814b675d:	00
> > > ffffffff814b675e:	74 2f                	je     ffffffff814b678f <uart_put_char+0x6f>
> > > ffffffff814b6760:	48 89 df             	mov    %rbx,%rdi
> > > ffffffff814b6763:	e8 a8 67 58 00       	callq  ffffffff81a3cf10 <_raw_spin_lock_irqsave>
> > > ffffffff814b6768:	41 8b 8c 24 78 01 00 	mov    0x178(%r12),%ecx
> > > ffffffff814b676f:	00
> > > ffffffff814b6770:	89 ca                	mov    %ecx,%edx
> > > ffffffff814b6772:	f7 d2                	not    %edx
> > > ffffffff814b6774:	41 03 94 24 7c 01 00 	add    0x17c(%r12),%edx
> > > ffffffff814b677b:	00
> > > ffffffff814b677c:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
> > > ffffffff814b6782:	75 23                	jne    ffffffff814b67a7 <uart_put_char+0x87>
> > > ffffffff814b6784:	48 89 c6             	mov    %rax,%rsi
> > > ffffffff814b6787:	48 89 df             	mov    %rbx,%rdi
> > > ffffffff814b678a:	e8 e1 64 58 00       	callq  ffffffff81a3cc70 <_raw_spin_unlock_irqrestore>
> > > ffffffff814b678f:	44 89 e8             	mov    %r13d,%eax
> > > ffffffff814b6792:	48 8b 1c 24          	mov    (%rsp),%rbx
> > > ffffffff814b6796:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
> > > ffffffff814b679b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
> > > ffffffff814b67a0:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
> > > ffffffff814b67a5:	c9                   	leaveq
> > > ffffffff814b67a6:	c3                   	retq
> > > ffffffff814b67a7:	49 8b 94 24 70 01 00 	mov    0x170(%r12),%rdx
> > > ffffffff814b67ae:	00
> > > ffffffff814b67af:	48 63 c9             	movslq %ecx,%rcx
> > > ffffffff814b67b2:	41 b5 01             	mov    $0x1,%r13b
> > > ffffffff814b67b5:	44 88 34 0a          	mov    %r14b,(%rdx,%rcx,1)
> > > ffffffff814b67b9:	41 8b 94 24 78 01 00 	mov    0x178(%r12),%edx
> > > ffffffff814b67c0:	00
> > > ffffffff814b67c1:	83 c2 01             	add    $0x1,%edx
> > > ffffffff814b67c4:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
> > > ffffffff814b67ca:	41 89 94 24 78 01 00 	mov    %edx,0x178(%r12)
> > > ffffffff814b67d1:	00
> > > ffffffff814b67d2:	eb b0                	jmp    ffffffff814b6784 <uart_put_char+0x64>
> > > ffffffff814b67d4:	66 66 66 2e 0f 1f 84 	data32 data32 nopw %cs:0x0(%rax,%rax,1)
> > > ffffffff814b67db:	00 00 00 00 00
> > > 
> > > for our build, this is crashing at:
> > > 
> > >     circ->buf[circ->head] = c;
> > > 
> > > Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
> > > protected by the "per-port mutex", which based on uart_port_check() is
> > > state->port.mutex. Indeed, the lock acquired in uart_put_char() is
> > > uport->lock, i.e. not the same lock.
> > > 
> > > Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> > > last chunk of that function may release state->xmit.buf before its assigned
> > > to null, and cause the race above.
> > > 
> > > To fix it, let's lock uport->lock when allocating/deallocating
> > > state->xmit.buf in addition to the per-port mutex.
> > > 
> > > v2: switch to locking uport->lock on allocation/deallocation instead of
> > >     locking the per-port mutex in uart_put_char. Note that since
> > >     uport->lock is a spin lock, we have to switch the allocation to
> > >     GFP_ATOMIC.
> > > v3: move the allocation outside the lock, so we can switch back to
> > >     GFP_KERNEL
> > > v4: * switch to positive condition of state->xmit.buf in
> > >       uart_port_startup()
> > >     * declare `flags` on its own line
> > >     * use the result of uart_port_lock() in uart_shutdown() to avoid
> > >       uninitialized warning
> > >     * don't use the uart_port_lock/unlock macros in uart_port_startup,
> > >       instead test against uport directly; the compiler can't seem to "see"
> > >       through the macros/ref/unref calls to not warn about uninitialized
> > >       flags. We don't need to do a ref here since we hold the per-port
> > >       mutex anyway.
> > > 
> > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > 
> > One question: would it be worth doing:
> > 
> > > ---
> > >  drivers/tty/serial/serial_core.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > index 9c14a453f73c..406e8382d3de 100644
> > > --- a/drivers/tty/serial/serial_core.c
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -182,6 +182,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> > >  {
> > >  	struct uart_port *uport = uart_port_check(state);
> > >  	unsigned long page;
> > > +	unsigned long flags;
> > >  	int retval = 0;
> > >  
> > >  	if (uport->type == PORT_UNKNOWN)
> > > @@ -196,15 +197,20 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
> > >  	 * Initialise and allocate the transmit and temporary
> > >  	 * buffer.
> > >  	 */
> > > -	if (!state->xmit.buf) {
> > > -		/* This is protected by the per port mutex */
> > > -		page = get_zeroed_page(GFP_KERNEL);
> > > -		if (!page)
> > > -			return -ENOMEM;
> > > +	page = get_zeroed_page(GFP_KERNEL);
> > 
> > ignoring the alloc failure here.  (leave a comment for worried
> > future reviewers)  Then,
> > 
> > > +	if (!page)
> > > +		return -ENOMEM;
> > >  
> > > +	if (uport)
> > > +		spin_lock_irqsave(&uport->lock, flags);
> > > +	if (state->xmit.buf) {
> > > +		free_page(page);
> > > +	} else {
> > 
> > here if page is NULL (unlock and) return ENOMEM.
> > 
> > Since it looks like this fn is called on every device open, that
> > would seem to minimize getting lots of needless ENOMEMs.
> > 
> > Another alternative is to just wait to do the alloc until we
> > get here, and drop the spinlock here if we need to alloc.  Then
> > retake the lock, re-check state->xmit.buf;  If that is now not
> > null then free_page(page), or if it is still NULL and page alloc
> > failed, then return ENOEMEM). That is uglier code, but is
> > probably the best behavior.
> > 
> > Still the original patch fixes the real bug so I'm fine with it
> > as well.
> 
> Sure, I'm happy to implement whichever of these we think is best.
> Greg?

Let's fix this issue first please, then I'll be glad to review other
changes based on micro optimizations :)

thanks,

greg k-h
