Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF110C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82570218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548936123;
	bh=v5FmM8JMbGh8lLfo05d49HXT0Cuq7wm2UMkiebkM2nY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nn+kSM0bVDLxpPDpqbE4sFgAmB5CGtNThyDo9RD5zvSMLuQHMVW3Bwqh0BfbavDa3
	 JfaGs8siEPWU7mEB2xnoz2DLNt/+p7wiULhA4Rkr8z8ctvjQRyxBWQhYFxuTeJD0A0
	 MU9xDHWuQJ9ISmt4IGL+46fHZrqJy+pMacgweBzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfAaMCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfAaMCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:02:01 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201E5218D3;
        Thu, 31 Jan 2019 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548936120;
        bh=v5FmM8JMbGh8lLfo05d49HXT0Cuq7wm2UMkiebkM2nY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FOsADNr6TrMlOSRO3YV0Heb0SOnP/CszRRKPRbnhhiVRUWq5kJIku8UMIW+cxbW1D
         VlNh2HWmTpyuNLAnFZAcfXdIRxavzOmIbRyGTxmn8cEL8cpG5Zc6TKHhKBnVVxIQo8
         9au9Q6uYnHrmAxG0uKtHhhYdCAgqUMMXlxQ3jkGM=
Date:   Thu, 31 Jan 2019 13:01:50 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190131130137.52b592f8@bbrezillon>
In-Reply-To: <20190130150818.24902-10-tudor.ambarus@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-10-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 15:08:47 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +/*
> + * atmel_qspi_set_address_mode() - set address mode.
> + * @cfg:	contains register values
> + * @op:		describes a SPI memory operation
> + *
> + * The controller allows 24 and 32-bit addressing while NAND-flash requires
> + * 16-bit long. Handling 8-bit long addresses is done using the option field.
> + * For the 16-bit addresses, the workaround depends of the number of requested
> + * dummy bits. If there are 8 or more dummy cycles, the address is shifted and
> + * sent with the first dummy byte. Otherwise opcode is disabled and the first
> + * byte of the address contains the command opcode (works only if the opcode and
> + * address use the same buswidth). The limitation is when the 16-bit address is
> + * used without enough dummy cycles and the opcode is using a different buswidth
> + * than the address.

Too bad they didn't patch the IP to support 1 to 4 address bytes
instead of only 3 or 4 :-(.
