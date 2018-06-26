Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281BDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F6F2642E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F6F2642E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935294AbeFZCi3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:38:29 -0400
Received: from sauhun.de ([88.99.104.3]:48896 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933574AbeFZCi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:38:27 -0400
Received: from localhost (unknown [91.73.131.157])
        by pokefinder.org (Postfix) with ESMTPSA id AC72A56A487;
        Tue, 26 Jun 2018 04:38:25 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:38:24 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 5/7] i2c: fsi: Add transfer implementation
Message-ID: <20180626023823.i3fmdegn2sric5kx@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528918579-27602-6-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:17PM -0500, Eddie James wrote:
> Execute I2C transfers from the FSI-attached I2C master. Use polling
> instead of interrupts as we have no hardware IRQ over FSI.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 195 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 193 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index 4611a0b..8c0a6cb 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -155,6 +155,7 @@ struct fsi_i2c_port {
>  	struct i2c_adapter	adapter;
>  	struct fsi_i2c_master	*master;
>  	u16			port;
> +	u16			xfrd;
>  };
>  
>  static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
> @@ -230,6 +231,99 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
>  	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
>  }
>  
> +static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
> +			 bool stop)
> +{
> +	struct fsi_i2c_master *i2c = port->master;
> +	u32 cmd = I2C_CMD_WITH_START | I2C_CMD_WITH_ADDR;
> +
> +	port->xfrd = 0;
> +
> +	if (msg->flags & I2C_M_RD)
> +		cmd |= I2C_CMD_READ;

Since you support MANGLING, I'd think you can easily support
I2C_M_REV_DIR_ADDR here, too?

