Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF07ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712EB20850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712EB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeGQPGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:06:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:48989 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbeGQPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:06:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 07:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="57175488"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2018 07:33:38 -0700
Message-ID: <1cdb4985f9d5fbd461bacf0e04eb7c10bfb7f6f9.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] i2c: designware: allow IP specific sda_hold_time
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 17 Jul 2018 17:33:37 +0300
In-Reply-To: <20180717114837.21839-3-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-3-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> Because some old designware IPs were not supporting setting an SDA
> hold
> time, vendors developed their own solution. Add a way for the final
> driver
> to provide its own SDA hold time handling.
> 

Thanks for information you provided. See my comment below.
After addressing it, 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-designware-common.c | 6 ++++++
>  drivers/i2c/busses/i2c-designware-core.h   | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c
> b/drivers/i2c/busses/i2c-designware-common.c
> index 9afc3e075b33..545b69d6be3c 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -297,6 +297,12 @@ void i2c_dw_set_sda_hold_time(struct dw_i2c_dev
> *dev)
>  {
>  	u32 reg;
> 

>  
> +	if (dev->set_sda_hold_time) {
> +		dev->set_sda_hold_time(dev);
> +
> +		return;
> +	}

I would rather inject this, for now (*), into if-else-if ladder, i.e.

if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
 ...
} else if (dev->set_sda_hold_time) { // <<<
 ...
} else if (dev->sda_hold_time) {
 ...

(*) Since your IP is of v1.10a I don't believe any new version of IP
would shadow existing DW IP registers, thus version check is okay to
have first in my opinion.

> +
>  	/* Configure SDA Hold Time if required. */
>  	reg = dw_readl(dev, DW_IC_COMP_VERSION);
>  	if (reg >= DW_IC_SDA_HOLD_MIN_VERS) {
> diff --git a/drivers/i2c/busses/i2c-designware-core.h
> b/drivers/i2c/busses/i2c-designware-core.h
> index bc43fb9ac1cf..b2778b6d8aca 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -283,6 +283,7 @@ struct dw_i2c_dev {
>  	void			(*disable)(struct dw_i2c_dev
> *dev);
>  	void			(*disable_int)(struct dw_i2c_dev
> *dev);
>  	int			(*init)(struct dw_i2c_dev *dev);
> +	int			(*set_sda_hold_time)(struct
> dw_i2c_dev *dev);
>  	int			mode;
>  	struct i2c_bus_recovery_info rinfo;
>  };

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
