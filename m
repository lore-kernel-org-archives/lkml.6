Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CFDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C822A21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C822A21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeIYUWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:22:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38608 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729313AbeIYUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:22:15 -0400
Received: (qmail 2203 invoked by uid 2102); 25 Sep 2018 10:14:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2018 10:14:31 -0400
Date:   Tue, 25 Sep 2018 10:14:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Vladis Dronov <vdronov@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <syzkaller@googlegroups.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: usbfs: fix crash in check_ctrlrecip()->usb_find_alt_setting()
In-Reply-To: <20180925122242.10950-1-vdronov@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1809251012040.1517-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018, Vladis Dronov wrote:

> ps->dev->actconfig can be NULL and cause NULL-deref in usb_find_alt_setting()
> before c9a4cb204e9e. fix this anyway by checking that ps->dev->actconfig is not
> NULL, so usb_find_alt_setting() is not called with a known-bad argument.

What reason is there for having two different fixes for the same bug?  
This one isn't going to get into any mainline trees that don't already 
have c9a4cb204e9e.

Alan Stern

> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> Reported-by: syzbot+19c3aaef85a89d451eac@syzkaller.appspotmail.com
> ---
>  drivers/usb/core/devio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index 6ce77b33da61..26047620b003 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -824,7 +824,7 @@ static int check_ctrlrecip(struct usb_dev_state *ps, unsigned int requesttype,
>  	 * class specification, which we always want to allow as it is used
>  	 * to query things like ink level, etc.
>  	 */
> -	if (requesttype == 0xa1 && request == 0) {
> +	if (requesttype == 0xa1 && request == 0 && ps->dev->actconfig) {
>  		alt_setting = usb_find_alt_setting(ps->dev->actconfig,
>  						   index >> 8, index & 0xff);
>  		if (alt_setting

