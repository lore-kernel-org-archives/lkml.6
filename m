Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD752148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yp8Z64j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD752148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJTDYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:41 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13E2921486;
        Fri, 19 Oct 2018 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539976637;
        bh=OgoS4cBDhr4ZI97D2KDvxSx5LOfrBwgbfEwDOihaHpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yp8Z64j5CJSJyrATcuo/zZrT549PvboqyVZUHIdtzhtGDm8iktjm/zvjg3zSIzc2m
         br3n3jp3al+YhiMv7L52aq9WfZPVNUpbPVLBqr6kDCezac0DbziVeN4tWMD6waTA3Z
         IgzO5oQgFB23kic8px29is8UwJ9jU4eAbP5nH1AM=
Date:   Fri, 19 Oct 2018 21:17:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: gasket: page_table: add mapping flags
Message-ID: <20181019191705.GA399@kroah.com>
References: <20181016120309.9082-1-toddpoynor@gmail.com>
 <20181016120309.9082-4-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016120309.9082-4-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:03:09AM -0700, Todd Poynor wrote:
> From: Nick Ewalt <nicholasewalt@google.com>
> 
> This allows for more precise dma_direction in the dma_map_page requests.
> Also leaves room for adding more flags later.

Why are you adding new features to this code?  It needs to have stuff
cleaned up and removed before you can add new stuff to it.

And why is this new ioctl even needed?

Some patch review comments below:

> +/*
> + * Structure for ioctl mapping buffers with flags when using the Gasket
> + * page_table module.
> + */
> +struct gasket_page_table_ioctl_flags {
> +	struct gasket_page_table_ioctl base;
> +	/*
> +	 * Flags indicating status and attribute requests from the host.
> +	 * NOTE: STATUS bit does not need to be set in this request.
> +	 *       Set RESERVED bits to 0 to ensure backwards compatibility.
> +	 *
> +	 * Bitfields:
> +	 *   [0]     - STATUS: indicates if this entry/slot is free
> +	 *                0 = PTE_FREE
> +	 *                1 = PTE_INUSE
> +	 *   [2:1]   - DMA_DIRECTION: dma_data_direction requested by host
> +	 *               00 = DMA_BIDIRECTIONAL
> +	 *               01 = DMA_TO_DEVICE
> +	 *               10 = DMA_FROM_DEVICE
> +	 *               11 = DMA_NONE
> +	 *   [31:3]  - RESERVED

What endian are these bitfields in?

> +	 */
> +	u32 flags;

"u32" is not a valid variable type for something that goes across the
user/kernel boundry.  It should be __u32.  You all know this stuff...

> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> index b7d460cf15fbc..06e188f5b905c 100644
> --- a/drivers/staging/gasket/gasket_page_table.c
> +++ b/drivers/staging/gasket/gasket_page_table.c
> @@ -87,6 +87,19 @@
>   */
>  #define GASKET_EXTENDED_LVL1_SHIFT 12
>  
> +/*
> + * Utilities for accessing flags bitfields.
> + */
> +#define MASK(field)            (((1u << field##_WIDTH) - 1) << field##_SHIFT)
> +#define GET(field, flags)      (((flags) & MASK(field)) >> field##_SHIFT)
> +#define SET(field, flags, val) (((flags) & ~MASK(field)) | ((val) << field##_SHIFT))

Ick, why invent stuff the kernel already has?  Please never do that, use
the functions/macros we already have for this very thing please.

That way I don't have to audit it that you all got it correct, and
neither do you have to guess that you got it correct :)


thanks,

greg k-h
