Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2090C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747CE2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747CE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeLIWEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36738 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbeLIWD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:03:59 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73R-0002im-7k; Sun, 09 Dec 2018 21:56:01 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Z-0003F4-9n; Sun, 09 Dec 2018 21:55:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tycho Andersen" <tycho@tycho.ws>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.133294230@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 037/328] uart: fix race between uart_put_char() and
 uart_shutdown()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tycho Andersen <tycho@tycho.ws>

commit a5ba1d95e46ecaea638ddd7cd144107c783acb5d upstream.

We have reports of the following crash:

    PID: 7 TASK: ffff88085c6d61c0 CPU: 1 COMMAND: "kworker/u25:0"
    #0 [ffff88085c6db710] machine_kexec at ffffffff81046239
    #1 [ffff88085c6db760] crash_kexec at ffffffff810fc248
    #2 [ffff88085c6db830] oops_end at ffffffff81008ae7
    #3 [ffff88085c6db860] no_context at ffffffff81050b8f
    #4 [ffff88085c6db8b0] __bad_area_nosemaphore at ffffffff81050d75
    #5 [ffff88085c6db900] bad_area_nosemaphore at ffffffff81050e83
    #6 [ffff88085c6db910] __do_page_fault at ffffffff8105132e
    #7 [ffff88085c6db9b0] do_page_fault at ffffffff8105152c
    #8 [ffff88085c6db9c0] page_fault at ffffffff81a3f122
    [exception RIP: uart_put_char+149]
    RIP: ffffffff814b67b5 RSP: ffff88085c6dba78 RFLAGS: 00010006
    RAX: 0000000000000292 RBX: ffffffff827c5120 RCX: 0000000000000081
    RDX: 0000000000000000 RSI: 000000000000005f RDI: ffffffff827c5120
    RBP: ffff88085c6dba98 R8: 000000000000012c R9: ffffffff822ea320
    R10: ffff88085fe4db04 R11: 0000000000000001 R12: ffff881059f9c000
    R13: 0000000000000001 R14: 000000000000005f R15: 0000000000000fba
    ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
    #9 [ffff88085c6dbaa0] tty_put_char at ffffffff81497544
    #10 [ffff88085c6dbac0] do_output_char at ffffffff8149c91c
    #11 [ffff88085c6dbae0] __process_echoes at ffffffff8149cb8b
    #12 [ffff88085c6dbb30] commit_echoes at ffffffff8149cdc2
    #13 [ffff88085c6dbb60] n_tty_receive_buf_fast at ffffffff8149e49b
    #14 [ffff88085c6dbbc0] __receive_buf at ffffffff8149ef5a
    #15 [ffff88085c6dbc20] n_tty_receive_buf_common at ffffffff8149f016
    #16 [ffff88085c6dbca0] n_tty_receive_buf2 at ffffffff8149f194
    #17 [ffff88085c6dbcb0] flush_to_ldisc at ffffffff814a238a
    #18 [ffff88085c6dbd50] process_one_work at ffffffff81090be2
    #19 [ffff88085c6dbe20] worker_thread at ffffffff81091b4d
    #20 [ffff88085c6dbeb0] kthread at ffffffff81096384
    #21 [ffff88085c6dbf50] ret_from_fork at ffffffff81a3d69f​

after slogging through some dissasembly:

ffffffff814b6720 <uart_put_char>:
ffffffff814b6720:	55                   	push   %rbp
ffffffff814b6721:	48 89 e5             	mov    %rsp,%rbp
ffffffff814b6724:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff814b6728:	48 89 1c 24          	mov    %rbx,(%rsp)
ffffffff814b672c:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
ffffffff814b6731:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
ffffffff814b6736:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
ffffffff814b673b:	e8 b0 8e 58 00       	callq  ffffffff81a3f5f0 <mcount>
ffffffff814b6740:	4c 8b a7 88 02 00 00 	mov    0x288(%rdi),%r12
ffffffff814b6747:	45 31 ed             	xor    %r13d,%r13d
ffffffff814b674a:	41 89 f6             	mov    %esi,%r14d
ffffffff814b674d:	49 83 bc 24 70 01 00 	cmpq   $0x0,0x170(%r12)
ffffffff814b6754:	00 00
ffffffff814b6756:	49 8b 9c 24 80 01 00 	mov    0x180(%r12),%rbx
ffffffff814b675d:	00
ffffffff814b675e:	74 2f                	je     ffffffff814b678f <uart_put_char+0x6f>
ffffffff814b6760:	48 89 df             	mov    %rbx,%rdi
ffffffff814b6763:	e8 a8 67 58 00       	callq  ffffffff81a3cf10 <_raw_spin_lock_irqsave>
ffffffff814b6768:	41 8b 8c 24 78 01 00 	mov    0x178(%r12),%ecx
ffffffff814b676f:	00
ffffffff814b6770:	89 ca                	mov    %ecx,%edx
ffffffff814b6772:	f7 d2                	not    %edx
ffffffff814b6774:	41 03 94 24 7c 01 00 	add    0x17c(%r12),%edx
ffffffff814b677b:	00
ffffffff814b677c:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
ffffffff814b6782:	75 23                	jne    ffffffff814b67a7 <uart_put_char+0x87>
ffffffff814b6784:	48 89 c6             	mov    %rax,%rsi
ffffffff814b6787:	48 89 df             	mov    %rbx,%rdi
ffffffff814b678a:	e8 e1 64 58 00       	callq  ffffffff81a3cc70 <_raw_spin_unlock_irqrestore>
ffffffff814b678f:	44 89 e8             	mov    %r13d,%eax
ffffffff814b6792:	48 8b 1c 24          	mov    (%rsp),%rbx
ffffffff814b6796:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
ffffffff814b679b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
ffffffff814b67a0:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
ffffffff814b67a5:	c9                   	leaveq
ffffffff814b67a6:	c3                   	retq
ffffffff814b67a7:	49 8b 94 24 70 01 00 	mov    0x170(%r12),%rdx
ffffffff814b67ae:	00
ffffffff814b67af:	48 63 c9             	movslq %ecx,%rcx
ffffffff814b67b2:	41 b5 01             	mov    $0x1,%r13b
ffffffff814b67b5:	44 88 34 0a          	mov    %r14b,(%rdx,%rcx,1)
ffffffff814b67b9:	41 8b 94 24 78 01 00 	mov    0x178(%r12),%edx
ffffffff814b67c0:	00
ffffffff814b67c1:	83 c2 01             	add    $0x1,%edx
ffffffff814b67c4:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
ffffffff814b67ca:	41 89 94 24 78 01 00 	mov    %edx,0x178(%r12)
ffffffff814b67d1:	00
ffffffff814b67d2:	eb b0                	jmp    ffffffff814b6784 <uart_put_char+0x64>
ffffffff814b67d4:	66 66 66 2e 0f 1f 84 	data32 data32 nopw %cs:0x0(%rax,%rax,1)
ffffffff814b67db:	00 00 00 00 00

for our build, this is crashing at:

    circ->buf[circ->head] = c;

Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
protected by the "per-port mutex", which based on uart_port_check() is
state->port.mutex. Indeed, the lock acquired in uart_put_char() is
uport->lock, i.e. not the same lock.

Anyway, since the lock is not acquired, if uart_shutdown() is called, the
last chunk of that function may release state->xmit.buf before its assigned
to null, and cause the race above.

To fix it, let's lock uport->lock when allocating/deallocating
state->xmit.buf in addition to the per-port mutex.

v2: switch to locking uport->lock on allocation/deallocation instead of
    locking the per-port mutex in uart_put_char. Note that since
    uport->lock is a spin lock, we have to switch the allocation to
    GFP_ATOMIC.
v3: move the allocation outside the lock, so we can switch back to
    GFP_KERNEL

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: Use uport->lock directly rather than through
 uart_port_{,un}lock()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/serial_core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -131,6 +131,7 @@ static int uart_port_startup(struct tty_
 	struct uart_port *uport = state->uart_port;
 	struct tty_port *port = &state->port;
 	unsigned long page;
+	unsigned long flags = 0;
 	int retval = 0;
 
 	if (uport->type == PORT_UNKNOWN)
@@ -145,15 +146,18 @@ static int uart_port_startup(struct tty_
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	if (!state->xmit.buf) {
-		/* This is protected by the per port mutex */
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page)
-			return -ENOMEM;
+	page = get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
+	spin_lock_irqsave(&uport->lock, flags);
+	if (!state->xmit.buf) {
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
+	} else {
+		free_page(page);
 	}
+	spin_unlock_irqrestore(&uport->lock, flags);
 
 	retval = uport->ops->startup(uport);
 	if (retval == 0) {
@@ -232,6 +236,7 @@ static void uart_shutdown(struct tty_str
 {
 	struct uart_port *uport = state->uart_port;
 	struct tty_port *port = &state->port;
+	unsigned long flags = 0;
 
 	/*
 	 * Set the TTY IO error marker
@@ -262,10 +267,12 @@ static void uart_shutdown(struct tty_str
 	/*
 	 * Free the transmit buffer page.
 	 */
+	spin_lock_irqsave(&uport->lock, flags);
 	if (state->xmit.buf) {
 		free_page((unsigned long)state->xmit.buf);
 		state->xmit.buf = NULL;
 	}
+	spin_unlock_irqrestore(&uport->lock, flags);
 }
 
 /**

