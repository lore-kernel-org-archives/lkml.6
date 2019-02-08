Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A8CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958B420869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549634120;
	bh=S6hBq56c8rs3xRiwo7j1PP04a3Ddud8lTbCUT4FD1RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SV1khK+i4qjiWPEfXTnjScbvXUNg80usnoQMsiCKxQ7K//te1q/5FgNdWcMw4m09t
	 vp5d37BElRl83JOYIOEkqBH1cBxHVEszf4oKkw4J7i2rF+dG5ph4Ki127IRA/Hjmss
	 tkaWAx31/Zr3jb0Z9y5P0/yfo1cBpRRGFk3At/fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfBHNzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:55:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbfBHNzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:55:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D54C20869;
        Fri,  8 Feb 2019 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549634117;
        bh=S6hBq56c8rs3xRiwo7j1PP04a3Ddud8lTbCUT4FD1RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c87PGjZnyXvYoqJPj9MVo/3xgdpK/3QVXn0dyfZ2+hP8ph6ovEajFDjIQJCKBBrCC
         ivmoxLCENrIXoDmhI1EkXQuDS2JbYc5uOAdUGVFJuT1Pc1kxhKXUaq4ilnXlKlIel/
         TMZKyGyDMbosCjn4yWsh5+TGdgIItwTm5a0Cj6uM=
Date:   Fri, 8 Feb 2019 14:55:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH v6 3/5] misc: fastrpc: Add support for context Invoke
 method
Message-ID: <20190208135514.GA23406@kroah.com>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
 <20190208132306.12571-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208132306.12571-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:23:04PM +0000, Srinivas Kandagatla wrote:
> +static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
> +{
> +	struct fastrpc_invoke_args *args = NULL;
> +	struct fastrpc_invoke inv;
> +	u32 nscalars;
> +	int err;
> +
> +	if (copy_from_user(&inv, argp, sizeof(inv)))
> +		return -EFAULT;
> +
> +	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
> +
> +	if (nscalars > MAX_REMOTE_SCALARS)
> +		return -EINVAL;
> +
> +	if (nscalars) {
> +		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
> +		if (!args)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(args, (void __user *)(uintptr_t)inv.args,
> +				   nscalars * sizeof(*args))) {
> +			kfree(args);
> +			return -EFAULT;
> +		}
> +
> +		/* Make sure reserved field is set to 0 */
> +		if (args->reserved) {
> +			kfree(args);
> +			return -EINVAL;

Am I wrong in that you are only checking the first reserved field in
this array of args?  Don't you have a whole bunch of them here (nscalars
of them)?  Don't you need to check them all and not just the first one?

thanks,

greg k-h
