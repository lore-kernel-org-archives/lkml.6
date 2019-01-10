Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55DCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE76214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547112989;
	bh=01spvSlU07szUhaDyec5+i50Dcv5nddP5btseXbXl+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SKJm9NrNlS2jIGD6vQzo5B1i0USW4Sk2CYpeWch3G6AQGeu1z8SjvAt4pU0SeDt8m
	 CZxIzpXzTiEu6Ll3ElWLIbWoYBSx1+Ud1UwZ+ZSK7V6jVoZCF92uINC+cX5YiWjaJ1
	 TKX6tJDfARSzeRJKnjVNfhmEE9RT6wv+ANBeC560=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAJJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfAJJg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7805214DA;
        Thu, 10 Jan 2019 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547112987;
        bh=01spvSlU07szUhaDyec5+i50Dcv5nddP5btseXbXl+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VjkoFUlCnWSPMQc1YYhCyMqs7zCCno12lctE6jp9VM1dBnegMtU3X4+aYRY/e1dWz
         eSX9I9v/2uNsoeH6d9fqCaO5bpK7vdrPMI/YFc5N+C6XqCe6y58xthDdaan+bGkVNP
         6KR6J4Mk5IhlSb+ii7IF/Itf7RA9LbgIjYrHkdVQ=
Date:   Thu, 10 Jan 2019 10:36:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250_pci.c: Only check for communication class in
 serial_pci_guess_board
Message-ID: <20190110093624.GA11265@kroah.com>
References: <1547107932-3714-1-git-send-email-guan.yung.tseng@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547107932-3714-1-git-send-email-guan.yung.tseng@ni.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:12:12PM +0800, Guan Yung Tseng wrote:
> Some multiport serial cards, such as the NI PXI-8430/2, NI PXI-8430/8,
> and NI PXI-8432/4 use PCI_CLASS_COMMUNICATION_OTHER and this fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").
> 
> Since these devices are correctly listed in serial_pci_tbl, we
> shouldn't need to check the PCI class IDs. This change relocates the
> class checking solely into "serial_pci_guess_board" where it had been
> before so that the class-check doesn't hinder initialization.
> 
> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4986b4a..e33a869 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3382,21 +3382,6 @@ static const struct pci_device_id blacklist[] = {
>  	{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), },
>  };
>  
> -static int serial_pci_is_class_communication(struct pci_dev *dev)
> -{
> -	/*
> -	 * If it is not a communications device or the programming
> -	 * interface is greater than 6, give up.
> -	 */
> -	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
> -	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MULTISERIAL) &&
> -	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
> -	    (dev->class & 0xff) > 6)
> -		return -ENODEV;
> -
> -	return 0;
> -}

Please leave this as a function, no need to move it inside another
function at this point in time.

>  static int serial_pci_is_blacklisted(struct pci_dev *dev)
>  {
>  	const struct pci_device_id *bldev;
> @@ -3427,6 +3412,15 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
>  	int num_iomem, num_port, first_port = -1, i;
>  
>  	/*
> +	 * If it is not a communications device or the programming
> +	 * interface is greater than 6, give up.
> +	 *
> +	 */
> +	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
> +	     ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
> +	    (dev->class & 0xff) > 6)
> +		return -ENODEV;
> +	/*

what happened to the multiserial check?

You should just call the function here.

thanks,

greg k-h
