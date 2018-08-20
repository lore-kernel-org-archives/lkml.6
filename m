Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F55C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C57D206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C57D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeHTQPL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:15:11 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:38598 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbeHTQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:15:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-63-psq3Hum6Nf-CiGHl1SCeGw-1; Mon, 20 Aug 2018 13:59:34 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 20 Aug 2018 14:01:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Aug 2018 14:01:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chuanhua Han' <chuanhua.han@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jiafei.pan@nxp.com" <jiafei.pan@nxp.com>,
        "zhiqiang.hou@nxp.com" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Thread-Topic: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Thread-Index: AQHUOIO1v0mwy7J+K0+V94NCbAoDI6TImGqw
Date:   Mon, 20 Aug 2018 13:01:13 +0000
Message-ID: <109aeb2622924f20b29743746bb77ce2@AcuMS.aculab.com>
References: <1534769013-43449-1-git-send-email-chuanhua.han@nxp.com>
In-Reply-To: <1534769013-43449-1-git-send-email-chuanhua.han@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: psq3Hum6Nf-CiGHl1SCeGw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhua Han
> Sent: 20 August 2018 13:44
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v3:
>     Rename variable name "val" to "opcode_addr_dummy_sum".
>     Place the legitimacy of the transfer size(i.e., "pi_max_message_size(mem->spi)" and
> "opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
> structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum".
>     Adjust the formatting alignment of your code.
>     "(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)".
> 
> Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
> ---
>  drivers/spi/spi-mem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 990770d..5ec2bc9 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -328,10 +328,24 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>  {
>  	struct spi_controller *ctlr = mem->spi->controller;
> +	unsigned long opcode_addr_dummy_sum = sizeof(op->cmd.opcode) +
> +					      op->addr.nbytes +
> +					      op->dummy.nbytes;

I'd split that (and shorten the variable name) to avoid line wrap. Maybe:

	unsigned long len;

	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
> 
>  	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
>  		return ctlr->mem_ops->adjust_op_size(mem, op);
> 
> +	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
> +		if (spi_max_message_size(mem->spi) < opcode_addr_dummy_sum ||
> +		    spi_max_transfer_size(mem->spi) < opcode_addr_dummy_sum)
> +			return -EINVAL;

Those comparisons are lexically backwards, you want 'value op constant'.
So:
		if (len > spi_max_message_size(mem->spi) ||
		    len > spi_max_transfer_size(mem->spi))
			return -EINVAL.
Although I'm surprised you need to do both comparisons.

> +
> +		op->data.nbytes = min3((unsigned long)(op->data.nbytes),
> +				       spi_max_transfer_size(mem->spi),
> +				       spi_max_message_size(mem->spi) -
> +				       opcode_addr_dummy_sum);

That looks like a strange limit...

> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
> --
> 2.7.4

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

