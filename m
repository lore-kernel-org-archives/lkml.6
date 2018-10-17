Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4E4ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F36821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4zQPzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F36821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJQTob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeJQToa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:44:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BC92098A;
        Wed, 17 Oct 2018 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539776949;
        bh=LFzkml6stIefEjZMuWrkiYvJoeSOY3JSdRj37HdcbLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vB4zQPzb59RP6wlFIWTgnJExPyfuCopHIi0SrE8c0cPNuF79rUY/qMYZDiQdz9McK
         bx5kjjO/aw6usPOsmRcE1d8qB2fI06t97E5gwy+0e+AP03HFYASRMVsraIpyve75xg
         lTr4AHEfE3niKPiBp1GtLKo8FOcSuUq2an3eEyYY=
Date:   Wed, 17 Oct 2018 13:49:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] driver core: add probe_err log helper
Message-ID: <20181017114906.GA32302@kroah.com>
References: <CAHp75VecquoNrzOuRvWcZ-Qa1b-5P0V0MWq=sNj-SnVcd2EhRw@mail.gmail.com>
 <CGME20181017085832eucas1p23dbb86230149a13634b8a091c3b1301f@eucas1p2.samsung.com>
 <20181017085824.30806-1-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017085824.30806-1-a.hajda@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:58:24AM +0200, Andrzej Hajda wrote:
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
> 	if (err != -EPROBE_DEFER)
> 		dev_err(dev, ...);
> 	return err;
> becomes:
> 	return probe_err(dev, err, ...);
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> v2:
>   - added error value to log message,
>   - fixed code style,
>   - added EXPORT_SYMBOL_GPL,
>   - Added R-B by Javier (I hope the changes did not invalidate it).
> ---
>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..aa6f3229d066 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>  
>  #endif
>  
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string, not ended with newline
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + * 	if (err != -EPROBE_DEFER)
> + * 		dev_err(dev, ...);
> + * 	return err;
> + * with
> + * 	return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	if (err == -EPROBE_DEFER)
> +		return err;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	dev_err(dev, "%pV, %d\n", &vaf, err);
> +	va_end(args);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>  	return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 90224e75ade4..06c2c797d132 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1577,6 +1577,8 @@ do {									\
>  	WARN_ONCE(condition, "%s %s: " format, \
>  			dev_driver_string(dev), dev_name(dev), ## arg)
>  
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);

__printf(3, 4) ?

