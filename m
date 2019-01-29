Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAFEC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA6E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763094;
	bh=ovPXgvZKWIjo4QxWF6oYi12OHNjpG6+uIJWf8MXUiS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wVwy3eOk80/HFytykvMuw0mRGqnD9Ara8mvnsjxo52L9GCySl023Hrq+H8Lu23aQ9
	 S0tqNxJZ88FhfaFiVspj7WoAzz2S5ym/5dnw23EwlTYQKZTKrTgfnlMokZ46JmRPUo
	 hcKrjKnlkj56zEnB+IIv/LWUbA8wH00dEVHPJi3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfA2Ls2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbfA2LsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:48:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECDA21852;
        Tue, 29 Jan 2019 11:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762500;
        bh=ovPXgvZKWIjo4QxWF6oYi12OHNjpG6+uIJWf8MXUiS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyZjLIlTidHcjFTOCRGI2RzS8C30VVbbfjOlQvC4QwdV7vjWofNLrCUAfH9rWhGF9
         UjokI34vAnEHaFIv/KCshEJpJUyWeyTf/t7aD8sEfwW1aLzqHccNHAZzsS++UwPiby
         9ldHXnpu0lIiNWjIA4eT/6+b3znn5jKfI/wjGwEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samir Virmani <samir@embedur.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 4.14 26/68] uart: Fix crash in uart_write and uart_put_char
Date:   Tue, 29 Jan 2019 12:35:48 +0100
Message-Id: <20190129113133.819071469@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samir Virmani <samir@embedur.com>

commit aff9cf5955185d1f183227e46c5f8673fa483813 upstream.

We were experiencing a crash similar to the one reported as part of
commit:a5ba1d95e46e ("uart: fix race between uart_put_char() and
uart_shutdown()") in our testbed as well. We continue to observe the same
crash after integrating the commit a5ba1d95e46e ("uart: fix race between
uart_put_char() and uart_shutdown()")

On reviewing the change, the port lock should be taken prior to checking for
if (!circ->buf) in fn. __uart_put_char and other fns. that update the buffer
uart_state->xmit.

Traceback:

[11/27/2018 06:24:32.4870] Unable to handle kernel NULL pointer dereference
                           at virtual address 0000003b

[11/27/2018 06:24:32.4950] PC is at memcpy+0x48/0x180
[11/27/2018 06:24:32.4950] LR is at uart_write+0x74/0x120
[11/27/2018 06:24:32.4950] pc : [<ffffffc0002e6808>]
                           lr : [<ffffffc0003747cc>] pstate: 000001c5
[11/27/2018 06:24:32.4950] sp : ffffffc076433d30
[11/27/2018 06:24:32.4950] x29: ffffffc076433d30 x28: 0000000000000140
[11/27/2018 06:24:32.4950] x27: ffffffc0009b9d5e x26: ffffffc07ce36580
[11/27/2018 06:24:32.4950] x25: 0000000000000000 x24: 0000000000000140
[11/27/2018 06:24:32.4950] x23: ffffffc000891200 x22: ffffffc01fc34000
[11/27/2018 06:24:32.4950] x21: 0000000000000fff x20: 0000000000000076
[11/27/2018 06:24:32.4950] x19: 0000000000000076 x18: 0000000000000000
[11/27/2018 06:24:32.4950] x17: 000000000047cf08 x16: ffffffc000099e68
[11/27/2018 06:24:32.4950] x15: 0000000000000018 x14: 776d726966205948
[11/27/2018 06:24:32.4950] x13: 50203a6c6974755f x12: 74647075205d3333
[11/27/2018 06:24:32.4950] x11: 3a35323a36203831 x10: 30322f37322f3131
[11/27/2018 06:24:32.4950] x9 : 5b205d303638342e x8 : 746164206f742070
[11/27/2018 06:24:32.4950] x7 : 7520736920657261 x6 : 000000000000003b
[11/27/2018 06:24:32.4950] x5 : 000000000000817a x4 : 0000000000000008
[11/27/2018 06:24:32.4950] x3 : 2f37322f31312a5b x2 : 000000000000006e
[11/27/2018 06:24:32.4950] x1 : ffffffc0009b9cf0 x0 : 000000000000003b

[11/27/2018 06:24:32.4950] CPU2: stopping
[11/27/2018 06:24:32.4950] CPU: 2 PID: 0 Comm: swapper/2 Tainted: P      D    O    4.1.51 #3
[11/27/2018 06:24:32.4950] Hardware name: Broadcom-v8A (DT)
[11/27/2018 06:24:32.4950] Call trace:
[11/27/2018 06:24:32.4950] [<ffffffc0000883b8>] dump_backtrace+0x0/0x150
[11/27/2018 06:24:32.4950] [<ffffffc00008851c>] show_stack+0x14/0x20
[11/27/2018 06:24:32.4950] [<ffffffc0005ee810>] dump_stack+0x90/0xb0
[11/27/2018 06:24:32.4950] [<ffffffc00008e844>] handle_IPI+0x18c/0x1a0
[11/27/2018 06:24:32.4950] [<ffffffc000080c68>] gic_handle_irq+0x88/0x90

Fixes: a5ba1d95e46e ("uart: fix race between uart_put_char() and uart_shutdown()")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Samir Virmani <samir@embedur.com>
Acked-by: Tycho Andersen <tycho@tycho.ws>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -563,10 +563,12 @@ static int uart_put_char(struct tty_stru
 	int ret = 0;
 
 	circ = &state->xmit;
-	if (!circ->buf)
+	port = uart_port_lock(state, flags);
+	if (!circ->buf) {
+		uart_port_unlock(port, flags);
 		return 0;
+	}
 
-	port = uart_port_lock(state, flags);
 	if (port && uart_circ_chars_free(circ) != 0) {
 		circ->buf[circ->head] = c;
 		circ->head = (circ->head + 1) & (UART_XMIT_SIZE - 1);
@@ -599,11 +601,13 @@ static int uart_write(struct tty_struct
 		return -EL3HLT;
 	}
 
+	port = uart_port_lock(state, flags);
 	circ = &state->xmit;
-	if (!circ->buf)
+	if (!circ->buf) {
+		uart_port_unlock(port, flags);
 		return 0;
+	}
 
-	port = uart_port_lock(state, flags);
 	while (port) {
 		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
 		if (count < c)


