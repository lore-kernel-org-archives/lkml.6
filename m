Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5E1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1564D222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549998745;
	bh=ApG+XFbVUeB9kRK7kR/51mjNC0Eay2PRw/AGiZJw+w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iRPxAH7rs8qUAt0Xkh6Cs/v0rfS6XdL2/T9wX1v5jp4KvHbqjvsfO7YgiiAlP7WGz
	 5BjAJgEc/sGNw6vIoLsPtyBw0TP/oF6p0scYcnhv3L5PH6hu2voef+6m+azmYoGYOw
	 b7/T88Y5KS6OhAswuD5FOds5cuTBBcLo8YxA0tlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfBLTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfBLTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:12:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DAB21905;
        Tue, 12 Feb 2019 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549998742;
        bh=ApG+XFbVUeB9kRK7kR/51mjNC0Eay2PRw/AGiZJw+w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srcDGxNS31/YWGMYqK8nr7pN8mrTEZaPHSGedyaCLAydD/IkJuGIZx3jaekE8c9IR
         T6+5iNcPQtCjFxyfr5gnGQmYqnV5FRMdAUJl0koWvF/tc7UHtEzCXxIQNBJPe0Ko/e
         opjNTIjUVn+p1kIABAXp23G2Npxen9V39/ql49yQ=
Date:   Tue, 12 Feb 2019 20:12:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [v2] lib/string: add memrchr function
Message-ID: <20190212191219.GB22246@kroah.com>
References: <1549994809-27479-1-git-send-email-xiaoxiang@xiaomi.com>
 <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549997683-27986-1-git-send-email-xiaoxiang@xiaomi.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:54:43AM +0800, Xiang Xiao wrote:
> Here is the detailed description for memrchr:
> 
> void *memrchr(const void *s, int c, size_t n);
> 
> The memrchr() function is like the memchr() function, except
> that it searches backward from the end of the n bytes pointed
> to by s instead of forward from the beginning.
> 
> The memrchr() functions return a pointer to the matching byte
> or NULL if the character does not occur in the given memory
> area.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b87..f380f4b 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>  	memcpy(dst, src, cnt);
>  }
>  #endif
> +void *memrchr(const void *s, int c, size_t n);
>  void *memchr_inv(const void *s, int c, size_t n);
>  char *strreplace(char *s, char old, char new);

Also, if you really need this, why not also provide the arch-specific
versions as well?

thanks,

greg k-h
