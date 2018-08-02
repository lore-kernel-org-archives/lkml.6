Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898C1214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898C1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeHBPxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:53:43 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:47280 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732255AbeHBPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:53:42 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w72E210M021673;
        Thu, 2 Aug 2018 15:02:02 +0100
Date:   Thu, 2 Aug 2018 15:02:01 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] tty: rocket: Fix possible buffer overwrite on
 register_PCI
Message-ID: <20180802150201.316e3361@alans-desktop>
In-Reply-To: <20180727133931.12701-1-vasilyev@ispras.ru>
References: <20180727133931.12701-1-vasilyev@ispras.ru>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 16:39:31 +0300
Anton Vasilyev <vasilyev@ispras.ru> wrote:

> If number of isa and pci boards exceed NUM_BOARDS on the path
> rp_init()->init_PCI()->register_PCI() then buffer overwrite occurs
> in register_PCI() on assign rcktpt_io_addr[i].
> 
> The patch adds check on upper bound for index of registered
> board in register_PCI.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>  drivers/tty/rocket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index bdd17d2aaafd..b121d8f8f3d7 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1881,7 +1881,7 @@ static __init int register_PCI(int i, struct pci_dev *dev)
>  	ByteIO_t UPCIRingInd = 0;
>  
>  	if (!dev || !pci_match_id(rocket_pci_ids, dev) ||
> -	    pci_enable_device(dev))
> +	    pci_enable_device(dev) || i >= NUM_BOARDS)
>  		return 0;
>  
>  	rcktpt_io_addr[i] = pci_resource_start(dev, 0);

This is a real fix but you want to check i >= NUM_BOARDS before you
enable the device

Alan

