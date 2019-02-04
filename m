Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6DAC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12FC2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfBDFjj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:39:39 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56424 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBDFjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:39:39 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id D236BCF16D;
        Mon,  4 Feb 2019 06:47:26 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4] bluetooth: Fix WARNING in tty_set_termios()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190203193848.12959-1-shuah@kernel.org>
Date:   Mon, 4 Feb 2019 06:39:36 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EBD36B7C-0B26-4483-B7C8-736F27B9D267@holtmann.org>
References: <20190203193848.12959-1-shuah@kernel.org>
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
> "The problem started with commit 7721383f4199 ("Bluetooth: hci_uart: Support
> operational speed during setup") which introduced a new way for how
> tty_set_termios() could end up being called for a master pty."
> 
> Fix it by by preventing setting the HCI line discipline for PTYs in
> hci_uart_tty_open().
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
> drivers/bluetooth/hci_ldisc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..c8faa4759cb7 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -475,9 +475,9 @@ static int hci_uart_tty_open(struct tty_struct *tty)
> 	BT_DBG("tty %p", tty);
> 
> 	/* Error if the tty has no write op instead of leaving an exploitable
> -	 * hole
> +	 * hole. In addition check if setting HCI line discipline is allowed.
> 	 */

this comment is wrong. The result of setting the HCI line discipline is a call into hci_uart_tty_open. You have to check ops->write and ops->set_termios since both are required. That is it.

> -	if (tty->ops->write == NULL)
> +	if (tty->ops->write == NULL || tty->ops->set_termios == NULL)
> 		return -EOPNOTSUPP;

And while at it, change this to (!tty->ops->write).

Regards

Marcel

