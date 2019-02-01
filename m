Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAB3C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D98A218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfBAKA7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:00:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56325 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfBAKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:00:59 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0E710CEEB0;
        Fri,  1 Feb 2019 11:08:46 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] tty: Fix WARNING in tty_set_termios()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190131232359.27948-1-shuah@kernel.org>
Date:   Fri, 1 Feb 2019 11:00:56 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2EA87A3C-BC0D-4CDA-998D-BA7A6D829356@holtmann.org>
References: <20190131232359.27948-1-shuah@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

> tty_set_termios() has the following WARN_ON which can be triggered with a
> syscall to invoke TIOCSETD __NR_ioctl.
> 
> WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
>                tty->driver->subtype == PTY_TYPE_MASTER);
> Reference: https://syzkaller.appspot.com/bug?id=2410d22f1d8e5984217329dd0884b01d99e3e48d
> 
> The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty.
> 
> Fix the problem by preventing setting the HCI line discipline for PTYs
> from hci_uart_setup() and hci_uart_set_flow_control().
> 
> The reproducer is used to reproduce the problem and verify the fix.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
> drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..ce84ca91ca70 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> 		return;
> 	}
> 
> +	/* don't set HCI line discipline on PTYs */
> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +	    tty->driver->subtype == PTY_TYPE_MASTER)
> +		return;
> +

just do it once in hci_uart_tty_open. Actually we already check for ops->write and so lets just ensure all ops we ever call are present. If they are not, then bail out. I wouldn’t even bother with the TTY type. Wouldn’t that be a lot simpler?

Regards

Marcel

