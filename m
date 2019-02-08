Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44D7218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549627604;
	bh=ztBbklp1wuQs2eH66xGa2j8+14ZxllYXrmU+YHHE0Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y3G5mi6/5dQidbM0Fo9+6VAhroQE3/fDPzuDJ35Rtt4j6CDLhVjHHNcF1E7laGXL1
	 9EzqvPcMDcMh96PvCd5X3Dg1/5pg/RzkdDazMJQzajFW+I5SaBr1rE5zwcqK8ZBbbF
	 E2B+XdYPcC0T8bIcm/gTzgP02YW1bs/qU6vN2kwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfBHMGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:06:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F9D2177B;
        Fri,  8 Feb 2019 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549627601;
        bh=ztBbklp1wuQs2eH66xGa2j8+14ZxllYXrmU+YHHE0Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cE8Zsoc+C8iX+xmLh83q4nz9n03pFja7SXgmH6LTCFyvcJq70lzOSR3InqsS+xhHe
         4GlgkZVYwe4lBX/1qvnuu8Ls/b7QVNfRyI13dYYv1VSxvm/Ezdf8gtHh+z4rGABk13
         uo2/0ow3nwTC7YRu8KsIyE7watLoi9QQ/47AgStc=
Date:   Fri, 8 Feb 2019 13:06:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, rppt@linux.ibm.com,
        ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v3 05/15] habanalabs: add command buffer module
Message-ID: <20190208120639.GA23483@kroah.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
 <20190204203254.4026-6-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204203254.4026-6-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:32:44PM +0200, Oded Gabbay wrote:
> +int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
> +{
> +	union hl_cb_args *args = data;
> +	struct hl_device *hdev = hpriv->hdev;
> +	u64 handle;
> +	int rc;
> +
> +	switch (args->in.op) {
> +	case HL_CB_OP_CREATE:
> +		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
> +					&handle, hpriv->ctx->asid);

so cb_size comes from userspace, ok, you check for the value to be too
small, but not too big.  That means someone can try to allocate too much
memory, possibly crashing things, not good :(


> +		memset(args, 0, sizeof(*args));
> +		args->out.cb_handle = handle;
> +		break;
> +	case HL_CB_OP_DESTROY:
> +		rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
> +					args->in.cb_handle);
> +		memset(args, 0, sizeof(*args));

Why zero this if it's not copied back to userspace?



> +		break;
> +	default:
> +		rc = -EINVAL;

-ENOTTY is normally the "invalid ioctl value", right?

> +		break;
> +	}
> +
> +	return rc;
> +}

thanks,

greg k-h
