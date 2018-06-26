Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E62EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046642667F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046642667F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeFZILJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:11:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:3420 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeFZILH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:11:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 01:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="67321726"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2018 01:11:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 26 Jun 2018 11:11:01 +0300
Date:   Tue, 26 Jun 2018 11:11:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tps6598x: Remove VLA usage
Message-ID: <20180626081101.GE16601@kuha.fi.intel.com>
References: <20180625222316.GA5773@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625222316.GA5773@beast>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:23:16PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the maximum buffer size and adds a sanity check. While 25 bytes
> is the size of the largest current things coming through, Heikki
> Krogerus pointed out that the actual max in 64 bytes, as per ch 1.3.2
> http://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2: use 64 bytes (Heikki)
> ---
>  drivers/usb/typec/tps6598x.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 4b4c8d271b27..c84c8c189e90 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -81,12 +81,21 @@ struct tps6598x {
>  	struct typec_capability typec_cap;
>  };
>  
> +/*
> + * Max data bytes for Data1, Data2, and other registers. See ch 1.3.2:
> + * http://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf
> + */
> +#define TPS_MAX_LEN	64
> +
>  static int
>  tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>  {
> -	u8 data[len + 1];
> +	u8 data[TPS_MAX_LEN + 1];
>  	int ret;
>  
> +	if (WARN_ON(len + 1 > sizeof(data)))
> +		return -EINVAL;
> +
>  	if (!tps->i2c_protocol)
>  		return regmap_raw_read(tps->regmap, reg, val, len);

Thanks,

-- 
heikki
