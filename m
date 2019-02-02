Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA83C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 12:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FAC2086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 12:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfBBMPT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 07:15:19 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43091 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfBBMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 07:15:19 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id A8327CEF9A;
        Sat,  2 Feb 2019 13:23:06 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] Bluetooth: hci_uart: Switch pty driver to slave side
 in tty_set_termios()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190202072816.GA15630@myunghoj-Precision-5530>
Date:   Sat, 2 Feb 2019 13:15:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3EC8C1C2-27AE-46B7-A345-860A87B94E6B@holtmann.org>
References: <20190202072816.GA15630@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> tty_set_termios() should be called with slave side of pty driver. So, If
> tty driver is pty master, it needs to be switched to ->link.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 27 ++++++++++++++++++++++-----
> 1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..0f6e70ea1dc3 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -299,10 +299,21 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> +/* If pty master, return slave side */
> +static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
> +{
> +	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
> +	    tty->driver->subtype == PTY_TYPE_MASTER)
> +		tty->link;
> +
> +	return tty;
> +}
> +
> /* Flow control or un-flow control the device */
> void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> {
> 	struct tty_struct *tty = hu->tty;
> +	struct tty_struct *real_tty;
> 	struct ktermios ktermios;
> 	int status;
> 	unsigned int set = 0;
> @@ -314,11 +325,14 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> 		return;
> 	}
> 
> +	/* termios should be set from slave side if tty driver is pty */
> +	real_tty = hci_uart_get_real_tty(tty);
> +
> 	if (enable) {
> 		/* Disable hardware flow control */
> -		ktermios = tty->termios;
> +		ktermios = real_tty->termios;
> 		ktermios.c_cflag &= ~CRTSCTS;
> -		status = tty_set_termios(tty, &ktermios);
> +		status = tty_set_termios(real_tty, &ktermios);
> 		BT_DBG("Disabling hardware flow control: %s",
> 		       status ? "failed" : "success");
> 
> @@ -350,9 +364,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
> 
> 		/* Re-enable hardware flow control */
> -		ktermios = tty->termios;
> +		ktermios = real_tty->termios;
> 		ktermios.c_cflag |= CRTSCTS;
> -		status = tty_set_termios(tty, &ktermios);
> +		status = tty_set_termios(real_tty, &ktermios);
> 		BT_DBG("Enabling hardware flow control: %s",
> 		       status ? "failed" : "success");
> 	}
> @@ -367,9 +381,12 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
> 
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> -	struct tty_struct *tty = hu->tty;
> +	struct tty_struct *tty;
> 	struct ktermios ktermios;
> 
> +	/* termios should be set from slave side if tty driver is pty */
> +	tty = hci_uart_get_real_tty(hu->tty);
> +

didn’t we conclude that allowing the HCI line discipline on a PTY master isn't worth the effort? The ptm_unix98_ops doesn’t have the .set_termios and thus, just check that ops->set_termios is present in hci_uart_tty_open and if not fail with EOPNOTSUPP like we do for missing ops->write.

Regards

Marcel

