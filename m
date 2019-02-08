Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0978C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808BB20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549634222;
	bh=9hoa6dXGYbGbZwxqtCYYdW6Mj6HZbgLoUu0t6cG9rLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pIe6VOtoJmSOJbs04NzySJqNbImc007C2ig9Zkx6jwnow77PMKqI2OiHvODi9Xfja
	 ifQeH0GglBUbVZF0BmWdZi0CIASqbeVct6Q/2Y0AVK5zxto/8y36aIFWB2ODDxcYAO
	 ztBq3LYw09UqulwcoKRpRfxSsjybW4fD4KVTUA08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBHN5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfBHN47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:56:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A0220869;
        Fri,  8 Feb 2019 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549634218;
        bh=9hoa6dXGYbGbZwxqtCYYdW6Mj6HZbgLoUu0t6cG9rLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlmzBJWWhYk9zz7/4KReDVZ43gyC4Z1Fj6RsB39uOfZ6YKdgmBpaC8yflV/Jq/2m3
         0H70HNP3tDseerlBsrtYok3+3ldvV6eqOuGa1pbI7hYUzsVtNiTzzIMlBnag4/W/rX
         WjFHbL86QkaR/awPgTNYi97x9GMf8teTJZwiONuI=
Date:   Fri, 8 Feb 2019 14:56:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: Re: [PATCH v6 4/5] misc: fastrpc: Add support for create remote init
 process
Message-ID: <20190208135656.GB23406@kroah.com>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
 <20190208132306.12571-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208132306.12571-5-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:23:05PM +0000, Srinivas Kandagatla wrote:
> +static int fastrpc_init_create_process(struct fastrpc_user *fl,
> +					char __user *argp)
> +{
> +	struct fastrpc_init_create init;
> +	struct fastrpc_invoke_args args[6];

All on the stack?  Ok, but:

> +	struct fastrpc_phy_page pages[1];
> +	struct fastrpc_map *map = NULL;
> +	struct fastrpc_buf *imem = NULL;
> +	int memlen;
> +	int err;
> +	struct {
> +		int pgid;
> +		u32 namelen;
> +		u32 filelen;
> +		u32 pageslen;
> +		u32 attrs;
> +		u32 siglen;
> +	} inbuf;
> +	u32 sc;
> +
> +	if (copy_from_user(&init, argp, sizeof(init)))
> +		return -EFAULT;
> +
> +	if (init.filelen > INIT_FILELEN_MAX)
> +		return -EINVAL;
> +
> +	inbuf.pgid = fl->tgid;
> +	inbuf.namelen = strlen(current->comm) + 1;
> +	inbuf.filelen = init.filelen;
> +	inbuf.pageslen = 1;
> +	inbuf.attrs = init.attrs;
> +	inbuf.siglen = init.siglen;
> +	fl->pd = 1;
> +
> +	if (init.filelen && init.filefd) {
> +		err = fastrpc_map_create(fl, init.filefd, init.filelen, &map);
> +		if (err)
> +			return err;
> +	}
> +
> +	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
> +		       1024 * 1024);
> +	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
> +				&imem);
> +	if (err) {
> +		fastrpc_map_put(map);
> +		return err;
> +	}
> +
> +	fl->init_mem = imem;
> +	args[0].ptr = (u64)(uintptr_t)&inbuf;
> +	args[0].length = sizeof(inbuf);
> +	args[0].fd = -1;

You never clear the reserved field :(

thanks,

greg k-h
