Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E63C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E64217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfBCRbl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:31:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59688 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfBCRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:31:41 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6D16ECF167;
        Sun,  3 Feb 2019 18:39:28 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] bluetooth: Fix WARNING in tty_set_termios()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190203164825.9621-1-shuah@kernel.org>
Date:   Sun, 3 Feb 2019 18:31:38 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, johan@kernel.org,
        viro@zeniv.linux.org.uk, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0CC28468-8E2F-4DEE-8307-DA0CEA59A8D0@holtmann.org>
References: <20190203164825.9621-1-shuah@kernel.org>
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
> Johan Hovold said: "The problemm started with
> commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty."
> 
> Fix it by by preventing setting the HCI line discipline for PTYs in
> hci_uart_tty_open(). Looked into keying off of tty and ldisc ops, and
> couldn't find any that would be conclusive. Checking tty as such clearly
> tags the reason for rejecting the request to set ldisc.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
> drivers/bluetooth/hci_ldisc.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..a3d313fcc0f2 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -480,6 +480,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
> 	if (tty->ops->write == NULL)
> 		return -EOPNOTSUPP;
> 
> +	/* don't set HCI line discipline on PTYs */
> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +	    tty->driver->subtype == PTY_TYPE_MASTER)
> +		return -EINVAL;
> +

this is turning in circles. What is wrong with checking !tty->ops->set_termios here?

Regards

Marcel

