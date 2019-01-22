Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5665B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149231;
	bh=hfRqU4/K9KCSWf14377C4GuFc6+wCeSaQXFVgxydbjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gvbN4C3C+BRbDMLwwAh+agPxVTRPZ7bAu0mvnx0BvhnUuxnKwICaNmhWWPttrXEel
	 W6vgW8wctXIDq/iaITmOmbC83gQWQDgJslAEJauT9/vQkd1cE5ZJ1r3MzU9HhFIqec
	 UncMy41QGHnnO2Kt2zBYsgqIE3hqoateECJ+u4c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfAVJ1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfAVJ1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:27:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5162218D9;
        Tue, 22 Jan 2019 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149228;
        bh=hfRqU4/K9KCSWf14377C4GuFc6+wCeSaQXFVgxydbjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zybm35QZiEKzGkb63XvO2ZegwaM13atjvWJtABqwWMzc7QsU/6glVzIAigb/2AHgT
         w4Q1qWN2sHwdDp6fDEYOG6VlS+D8QiFRqb2Pz5G7IcKqBdiurPonP7FUeQC8gyEIQX
         JzJekGj0CrzH465mTqu2k785zbOGH9TeOFSkj+Fw=
Date:   Tue, 22 Jan 2019 10:27:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: (memconsole) do not count numbers if read fails
Message-ID: <20190122092706.GA6133@kroah.com>
References: <20181226052913.74614-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226052913.74614-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 11:29:11PM -0600, Kangjie Lu wrote:
> When memory_read_from_buffer() fails, the return value is a negative
> error code, thus we shouldn't count it as the number of read bytes.
> 
> The fix checks the return value of memory_read_from_buffer, and count
> the number only when it succeeds.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/firmware/google/memconsole-coreboot.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
> index b29e10757bfb..4e8a0ad110c1 100644
> --- a/drivers/firmware/google/memconsole-coreboot.c
> +++ b/drivers/firmware/google/memconsole-coreboot.c
> @@ -55,6 +55,7 @@ static ssize_t memconsole_coreboot_read(char *buf, loff_t pos, size_t count)
>  	} seg[2] = { {0}, {0} };
>  	size_t done = 0;
>  	int i;
> +	int ret;
>  
>  	if (flags & OVERFLOW) {
>  		if (cursor > size)	/* Shouldn't really happen, but... */
> @@ -66,8 +67,10 @@ static ssize_t memconsole_coreboot_read(char *buf, loff_t pos, size_t count)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(seg) && count > done; i++) {
> -		done += memory_read_from_buffer(buf + done, count - done, &pos,
> +		ret = memory_read_from_buffer(buf + done, count - done, &pos,
>  			cbmem_console->body + seg[i].phys, seg[i].len);
> +		if (ret >= 0)
> +			done += ret;

But if ret < 0, then it's an error, and something should happen, right?

And really, the only way this can fail is if pos is less than 0, which.
And if that happens, you just now stuck us in an endless loop, which is
worse than just ignoring the error value returned :(

thanks,

greg k-h
