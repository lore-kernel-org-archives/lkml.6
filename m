Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB51C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035B62086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547812643;
	bh=Am9493e7UKN8/ZKv76n+e42nzKaMKjniujCPg8hozPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iUc94cby0bdAqXIsFXYbvLiuXmTA7/JNOSlXD3WUS0sTpRob2VcdqB6tFnxOv4UZW
	 WKXdEVyfWP3J/Ca3O+162klLYmxprjbp0tkKNIwZ+oWmAWZTaI1hpFzBIIEP1XELks
	 nfzNjLCV2yqGY78QTyDVxEn5BunXAw3/SMwsyMw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfARL5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:57:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfARL5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:57:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6352086D;
        Fri, 18 Jan 2019 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547812640;
        bh=Am9493e7UKN8/ZKv76n+e42nzKaMKjniujCPg8hozPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViDM0PKC4rUlzbR6nzpZD2h2PURy55DLutz4p7IG4MeQCJLMKhHDjoK7ViYW075SC
         LLUoNVYyw5+VIvrYe+2MjrFllDEOdPVQqZ7mN7vlYA+r/UZn8UnuDbFM70LwvqAIzg
         qgHY/OgVZkBFfeAhSQucsVHzdc5+RWKZA8ryjKag=
Date:   Fri, 18 Jan 2019 12:57:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Message-ID: <20190118115718.GA16370@kroah.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
> Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> The reason of doing this is because all NI multi port serial cards
> use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> serial_pci_is_class_communication test added in the commit 7d8905d06405
> ("serial: 8250_pci: Enable device after we check black list").
> 
> Signed-off-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 4986b4a..0949db1 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -663,6 +663,13 @@ static int pci_xircom_init(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static int pci_ni_probe(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
> +			(dev->class & 0xff);

As Christoph said, this looks really odd.  This field comes from the
PCI structure on the device, it should not be modified by the kernel.

Unless the device is broken and needs to be fixed up in the kernel?

Also, you have sent 2 different patches here for this type of issue, are
both needed?  If so, please resend both of them as a patch series, with
more explainations in this one as to why you are modifying this field.

I've dropped all pending patches from you from my queue now.

thanks,

greg k-h
