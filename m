Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61394C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1959A224EC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1959A224EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965274AbeFZCii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:38:38 -0400
Received: from sauhun.de ([88.99.104.3]:48912 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933574AbeFZCih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:38:37 -0400
Received: from localhost (unknown [91.73.131.157])
        by pokefinder.org (Postfix) with ESMTPSA id 6644256A489;
        Tue, 26 Jun 2018 04:38:35 +0200 (CEST)
Date:   Tue, 26 Jun 2018 11:38:33 +0900
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        benh@kernel.crashing.org, joel@jms.id.au, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        andy.shevchenko@gmail.com, peda@axentia.se
Subject: Re: [PATCH v10 7/7] i2c: fsi: Add bus recovery
Message-ID: <20180626023833.iwjz7pqnhf4jd3w5@ninjato>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528918579-27602-8-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:36:19PM -0500, Eddie James wrote:
> Bus recovery should reset the engine and force clock the bus 9 times
> to recover most situations.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index d6cab4b..940b198 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -611,6 +611,24 @@ static u32 fsi_i2c_functionality(struct i2c_adapter *adap)
>  		I2C_FUNC_SMBUS_BLOCK_DATA;
>  }
>  
> +static int fsi_i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	int rc;
> +	struct fsi_i2c_port *port = adap->algo_data;
> +	struct fsi_i2c_master *master = port->master;
> +
> +	mutex_lock(&master->lock);
> +
> +	rc = fsi_i2c_reset(master, port->port);
> +
> +	mutex_unlock(&master->lock);
> +	return rc;
> +}
> +
> +static struct i2c_bus_recovery_info fsi_i2c_bus_recovery_info = {
> +	.recover_bus = fsi_i2c_recover_bus,
> +};
> +

This all won't have any effect since you never call i2c_recover_bus
which calls back into i2c_bus_recovery_info callbacks.

