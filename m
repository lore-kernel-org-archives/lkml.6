Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98690C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE7206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeLPWaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:30:06 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:53046 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730758AbeLPWaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:30:05 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 67216180A8125;
        Sun, 16 Dec 2018 22:30:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg39_3aa6ca8da283b
X-Filterd-Recvd-Size: 2592
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Dec 2018 22:30:02 +0000 (UTC)
Message-ID: <325ac79885892082f4a5b9fe294178d59c2ced68.camel@perches.com>
Subject: Re: [PATCH] Staging: nvec: nvec: fixed check style issues
From:   Joe Perches <joe@perches.com>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>, marvin24@gmx.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
Date:   Sun, 16 Dec 2018 14:30:01 -0800
In-Reply-To: <1544996634-10427-1-git-send-email-indigoomega021@gmail.com>
References: <1544996634-10427-1-git-send-email-indigoomega021@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-16 at 13:43 -0800, Amir Mahdi Ghorbanian wrote:
> Replaced udelay() by the preferred usleep_range() function.
[]
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
[]
> @@ -626,7 +626,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  		break;
>  	case 2:		/* first byte after command */
>  		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -			udelay(33);
> +			usleep_range(0, 33);

Umm, this is not the same outcome.

udelay delays a minimum of 33 usecs.
usleep_range delays from min to max usecs.


kernel/time/timer.c: * usleep_range - Sleep for an approximate time
kernel/time/timer.c- * @min: Minimum time in usecs to sleep
kernel/time/timer.c- * @max: Maximum time in usecs to sleep
kernel/time/timer.c- *
kernel/time/timer.c- * In non-atomic context where the exact wakeup time is flexible, use
kernel/time/timer.c: * usleep_range() instead of udelay().  The sleep improves responsiveness
kernel/time/timer.c- * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
kernel/time/timer.c- * power usage by allowing hrtimers to take advantage of an already-
kernel/time/timer.c- * scheduled interrupt instead of scheduling a new one just for this sleep.
kernel/time/timer.c- */

>  			if (nvec->rx->data[0] != 0x01) {
>  				dev_err(nvec->dev,
>  					"Read without prior read command\n");
> @@ -713,7 +713,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>  	 * We experience less incomplete messages with this delay than without
>  	 * it, but we don't know why. Help is appreciated.
>  	 */
> -	udelay(100);
> +	usleep_range(0, 100);

here too.


