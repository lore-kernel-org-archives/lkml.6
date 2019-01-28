Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F152C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F84621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA1MQp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:16:45 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57437 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA1MQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:16:44 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id EB9C2CF2B6;
        Mon, 28 Jan 2019 13:24:30 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: Add NULL check for tiocmget() and tiocmset()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190128065910.GA14959@myunghoj-Precision-5530>
Date:   Mon, 28 Jan 2019 13:16:42 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0D7C928B-8E3E-4986-A6D2-AFCFF4F0E274@holtmann.org>
References: <20190128065910.GA14959@myunghoj-Precision-5530>
To:     Myungho Jung <mhjungk@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myungho,

> tiocmget() and tiocmset() operations are optional and some tty drivers
> like pty miss the operations. We need NULL check before referencing
> them.
> 
> Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
> drivers/bluetooth/hci_ath.c   | 13 ++++++++-----
> drivers/bluetooth/hci_ldisc.c |  5 +++++
> 2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index d568fbd94d6c..076700a1e9a8 100644
> --- a/drivers/bluetooth/hci_ath.c
> +++ b/drivers/bluetooth/hci_ath.c
> @@ -94,11 +94,14 @@ static void ath_hci_uart_work(struct work_struct *work)
> 	hu = ath->hu;
> 	tty = hu->tty;
> 
> -	/* verify and wake up controller */
> -	if (ath->cur_sleep) {
> -		status = ath_wakeup_ar3k(tty);
> -		if (!(status & TIOCM_CTS))
> -			return;
> +	/* tiocmget() and tiocmset() operations are optional */
> +	if (tty->driver->ops->tiocmget && tty->driver->ops->tiocmset) {
> +		/* verify and wake up controller */
> +		if (ath->cur_sleep) {
> +			status = ath_wakeup_ar3k(tty);
> +			if (!(status & TIOCM_CTS))
> +				return;
> +		}
> 	}

actually in case of hci_ath.c I would prefer that the setup actually fails. There is no point in continuing here. These are vendor specific hardware routines and you will not run them over TTYs that don’t support it. So instead of ignoring the operating, fail hard and cleanly during setup.

> 	/* Ready to send Data */
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index fbf7b4df23ab..9f88a8563cf6 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -314,6 +314,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> 		return;
> 	}
> 
> +	/* tiocmget() and tiocmset() operations are optional */
> +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset) {
> +		return;
> +	}
> +

No { } here please.

> 	if (enable) {
> 		/* Disable hardware flow control */
> 		ktermios = tty->termios;

Regards

Marcel

