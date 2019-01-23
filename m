Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B89D2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAWQJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:09:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:49126 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726009AbfAWQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:09:31 -0500
Received: (qmail 2495 invoked by uid 2102); 23 Jan 2019 11:09:30 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2019 11:09:30 -0500
Date:   Wed, 23 Jan 2019 11:09:30 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     YueHaibing <yuehaibing@huawei.com>
cc:     geoff@infradead.org, <gregkh@linuxfoundation.org>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH -next] usb: host: drop pointless static qualifier
In-Reply-To: <20190123083758.8412-1-yuehaibing@huawei.com>
Message-ID: <Pine.LNX.4.44L0.1901231107030.1564-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019, YueHaibing wrote:

> There is no need to have the 'dummy_mask' variable static since new
> value always be assigned before use it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/usb/host/ehci-ps3.c | 2 +-
>  drivers/usb/host/ohci-ps3.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-ps3.c b/drivers/usb/host/ehci-ps3.c
> index 454d8c6..91cee02 100644
> --- a/drivers/usb/host/ehci-ps3.c
> +++ b/drivers/usb/host/ehci-ps3.c
> @@ -86,7 +86,7 @@ static int ps3_ehci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask;
> +	u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;
> diff --git a/drivers/usb/host/ohci-ps3.c b/drivers/usb/host/ohci-ps3.c
> index 395f9d3..a1c1bdf 100644
> --- a/drivers/usb/host/ohci-ps3.c
> +++ b/drivers/usb/host/ohci-ps3.c
> @@ -69,7 +69,7 @@ static int ps3_ohci_probe(struct ps3_system_bus_device *dev)
>  	int result;
>  	struct usb_hcd *hcd;
>  	unsigned int virq;
> -	static u64 dummy_mask;
> +	u64 dummy_mask;
>  
>  	if (usb_disabled()) {
>  		result = -ENODEV;

No.  You need to read the code and understand how a variable is used
before you decide to modify it.

In this case, a suitable approach would be to change the declaration 
so that it says:

	status u64 dummy_mask = DMA_BIT_MASK(32);

and remove the line that does the assignment dynamically.

Alan Stern

