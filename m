Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C5FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C95221E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oa2yj/fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C95221E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbeHIUPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:15:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35735 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbeHIUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:15:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so3201432pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huIdhvc31zB8/Q083cdPlHCFVCmDNsdTuSlR1lc3GSU=;
        b=Oa2yj/fkQIyGPN4upHFmFAl/lI3qBYvExBHsJHoSTxeD3bI/PoAtGncdL8kAwUxY7c
         kZ8FnH166BjuXwgmZfglFbUhpfqR7UGT3Gg5CybUzymeLxdKC0kgBwOiNqrRTRcxZt2s
         P6/xxAbLxzSYPAFHKfytWjs9N8XRXpqepNiEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huIdhvc31zB8/Q083cdPlHCFVCmDNsdTuSlR1lc3GSU=;
        b=P+xI35DYqdmr4EEHHVbP8dbuhJRLqWsR10q8/v7kNgfcyjsfzjyfVUdnFplFgzhepI
         SKMl9t2udhRKm3zvB0a9QUGWSOskM/F9HLiL54muzlfuB5NT6rUwivZcQePqMREdk58l
         OnbaskYSbdEFQ3tMS0mSNUhVgd2H85JNBS4x7DqER7TWYOt3PV4nrxaJ4KzfGy9DSB0/
         JM9mt7so127J603ZXqbCL/j6sBuXhe5goQ41slkchr48TXedMUYrNcHOzgLS4UM3n6l0
         VvAYwU/YQ75s8i59Q9DNHxSDyKDVNZiILmiAeGEm8Egj8TWTLVLW22LF0aTkSLNloklN
         XG9w==
X-Gm-Message-State: AOUpUlGuLZWx8Y9yAYNjH0c8YYAungZAel9pWKSJoAoVPysfi4Hsr0Fn
        S2lLwlOt+ICdlmuFeCl7m0/13A==
X-Google-Smtp-Source: AA+uWPxh9GdhQO9TPWvLsa1yiqUDQ6DoNmnuaXg0l+X7pdluUCYIbWq9PrJXjOaMg9m2FJdANSEIRg==
X-Received: by 2002:a63:3d41:: with SMTP id k62-v6mr3096258pga.254.1533836981776;
        Thu, 09 Aug 2018 10:49:41 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id u11-v6sm13755492pfd.117.2018.08.09.10.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 10:49:40 -0700 (PDT)
Date:   Thu, 9 Aug 2018 10:49:38 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 2/7] firmware: coreboot: Unmap ioregion on failure
Message-ID: <20180809174936.GC129285@ban.mtv.corp.google.com>
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809171722.144325-3-swboyd@chromium.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:17:17AM -0700, Stephen Boyd wrote:
> Both callers of coreboot_table_init() ioremap the pointer that comes in
> but they don't unmap the memory on failure. Both of them also fail probe
> immediately with the return value of coreboot_table_init(), leaking a
> mapping when it fails. Plug the leak so the mapping isn't left unused.
> 
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")

I suppose this is fair, since that commit introduced error paths and
didn't clean them up. But one warning below:

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index 19db5709ae28..0d3e140444ae 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -138,6 +138,9 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
>  		ptr_entry += entry.size;
>  	}
>  
> +	if (ret)
> +		iounmap(ptr);

This works because no sub-driver is using this mapping any more (i.e.,
because we killed coreboot_table_find()). Otherwise, we'd need to
explicitly kill all the sub-devices first. IOW, if this gets backported
to older kernels, it would need to go along with this and its other
dependencies:

b616cf53aa7a firmware: coreboot: Remove unused coreboot_table_find

But I guess that's a question for -stable. Or, we remove the 'Fixes'
tag? Or add another tag, to list other dependencies? Or just ignore it.

But for this change as applied to mainline:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(coreboot_table_init);
> -- 
> Sent by a computer through tubes
> 
