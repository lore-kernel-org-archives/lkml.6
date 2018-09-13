Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A582C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E018320882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIMRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:05:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeIMRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:05:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8388AC49;
        Thu, 13 Sep 2018 11:56:19 +0000 (UTC)
Date:   Thu, 13 Sep 2018 12:33:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/50] amiserial: switch to ->[sg]et_serial()
Message-ID: <20180913103331.GA1460@kroah.com>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:08AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/tty/amiserial.c | 83 ++++++++++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 34dead614149..17fc8bb6c6b8 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -996,63 +996,60 @@ static void rs_unthrottle(struct tty_struct * tty)
>   * ------------------------------------------------------------
>   */
>  
> -static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
> -			   struct serial_struct __user * retinfo)
> +static int get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>  {
> -	struct serial_struct tmp;
> -   
> -	memset(&tmp, 0, sizeof(tmp));
> +	struct serial_state *state = tty->driver_data;
> +
> +	if (serial_paranoia_check(state, tty->name, "rs_ioctl"))
> +		return -ENODEV;

These crazy paranoia check functions just need to be deleted, no need to
add new ones here.  Or we can just delete them later on...

thanks,

greg k-h
