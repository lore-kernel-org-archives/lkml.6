Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9991FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E121871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546678825;
	bh=7Vw1Dpl/s2e2TFSQ38mOHUKz/LJHMz5gJ6lOp6i+lhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cOX+IWlQHEHiCBhIuIijYd1zzIKGCfOqftNN3Tra+PGbkCCjqw4NRLcVl+yss2hZe
	 BcPoO27Q7M3o+t7nKodHZvMrSw1FNQkY1RJralqM0mZGHsn3aBv1vfscdKvF9WWB6j
	 iVpWr5892BBVqx+ilrv0vPHLS5YjLoJ/e2b7R4nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAEJAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 04:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfAEJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 04:00:24 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4890208E3;
        Sat,  5 Jan 2019 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546678823;
        bh=7Vw1Dpl/s2e2TFSQ38mOHUKz/LJHMz5gJ6lOp6i+lhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiJlk6l5Tg9F4EsIoic7OTq/c13NrOkOvwuaxKq6fTdlFHEbF1TBTZtSqWP8u4SAx
         tzblgTX6ZH44kxFXEKL+pj+DhLN9IGstMct2CW3XqWJf0EpNAdoxHUmGH6Yt0evQ49
         y1/ygGBL7S2LAmm3QAhsq/IHjrgxtUUlV9cPI7JE=
Date:   Sat, 5 Jan 2019 10:00:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: misc: goldfish_address_space: add a driver
Message-ID: <20190105090019.GC13941@kroah.com>
References: <20190104021311.38194-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104021311.38194-1-rkir@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:13:11PM -0800, rkir@google.com wrote:
> +static int as_release(struct inode *inode, struct file *filp)
> +{
> +	struct as_allocated_blocks *allocated_blocks = filp->private_data;
> +	struct as_device_state *state;
> +	int blocks_size;
> +	int i;
> +
> +	WARN_ON(!allocated_blocks);
> +	WARN_ON(!allocated_blocks->state);
> +	WARN_ON(!allocated_blocks->blocks);
> +	WARN_ON(allocated_blocks->blocks_size < 0);
> +
> +	state = allocated_blocks->state;
> +	blocks_size = allocated_blocks->blocks_size;
> +
> +	if (mutex_lock_interruptible(&state->registers_lock))

I just took this chunk of code as an example of what you do all over
this file.  Please do not use WARN_ON() as a lazy way of saying "I have
no idea how to handle this random error that might happen, so I'm going
to punt to the user and crash the machine."

If these things really can happen, then properly check for them and
handle the error correctly.  If they can not, then just remove the
WARN_ON check as it is not needed at all.

As it is, this code is obviously broken because if
allocated_blocks->state is NULL, you just crashed on the line after the
check.  So even if you did somehow want to "warn" for something like
this happening, you did not handle it and killed the machine.

All of the WARN_ON can be removed here as I bet you are testing for
things that can never happen.  And if it could happen, then properyl
test for it.

as-is, this code is not ok at all.

Also, along these lines, who else is reviewing this code before you send
it out?  Surely you are not reyling on just me to do that, you are
taking advantage of the huge numbers of reviewers inside your company
that could have told you this before posting it, right?

Please do so.

greg k-h
