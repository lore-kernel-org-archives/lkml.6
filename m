Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF3AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE8821EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nRWgMUpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE8821EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeHIU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:29:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40187 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeHIU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:29:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so2864208plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7TgL/KAG1qFE9MX3gZuvrj66i0U0xsP6r6rx2+8gwM=;
        b=nRWgMUpENGyJVIFbYxTR3wQ8/jyfuN905ZFIMNn7UA7jNOQgJ7Tihzcvrmkbnh9Xiw
         FHOnvPc0vystnYQJHKXM0losPvCRIDtsKSsOvcfku+FtZVylvQDWJ9wqTuoeR4xP2AsW
         qZocNM8YT7OxYkG7C/4yzYvcwmaES9eZAB6/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7TgL/KAG1qFE9MX3gZuvrj66i0U0xsP6r6rx2+8gwM=;
        b=KGnYeT/3NKAz0DBF6vJr54W99PB2Wjn+UFlUf/5wq1wkfhymyqJ8tV5fc8C96l5jDW
         1a/cBlNvM77iN03PXa2tqvO90/JLic1XBy3mRDvJoh5eyMYBO9WkkoYnqALTUKBffIm5
         TJUrsogY2DQZUYgfONpNTcBUFQxVAhMVXPDcZICo+g3inDB/2I8Kdhgkfq4NcwzXoKoU
         VLUOQqLssis4ePn1eIWWJW5f0lk1xgvcDSmrntPi5r2wxd6b8em8q7ANmjn3JpSWj6A1
         dwXuaNh3c6bbGsBgzOXdqgbnZJXWMjCBUVxwhozIbjoJoUHc1wbPXOM4l3CL8HRVPFXP
         OjIQ==
X-Gm-Message-State: AOUpUlFExRnD8tj6oooCe2xDgG+8Oorg+kh/0I+N7xISIGcr3nVnaZno
        lROoERyZOv68frtloL9uppWFmQ==
X-Google-Smtp-Source: AA+uWPyFPwudKaSYAFFAUHG7C2NEGYeB6pKy4S4FnTCNy/tdJLMPdW7XiFhR9zBslPm/DNuIlu11ow==
X-Received: by 2002:a17:902:4d45:: with SMTP id o5-v6mr2941822plh.78.1533837801870;
        Thu, 09 Aug 2018 11:03:21 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id h29-v6sm19526349pgh.37.2018.08.09.11.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 11:03:20 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:03:18 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/7] firmware: coreboot: Fix probe and simplify code
Message-ID: <20180809180316.GD129285@ban.mtv.corp.google.com>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stepehen,

On Thu, Aug 09, 2018 at 10:17:15AM -0700, Stephen Boyd wrote:
> This series reworks the coreboot firmware driver a bit to fix some bugs
> and then simplify the code by changing the design to get rid of the
> different platform drivers, remap memory with memremap(), and use devm
> to simplify error paths. There's some risk in changing to memremap() but
> I think that should work out alright. It will either return memory
> directly, or fallback to ioremap_cache() as has been done before.
> 
> Changes from v2:
>  * A bunch more patches
>  * Fix iounmap missing on error path
>  * Fix bus getting unregistered on driver unbind and never registered
>    again
>  * Request exclusive access to table region
>  * Pull out table signature check to driver probe
> 
> Changes from v1:
>  * Split out fixlet for DT based driver from platform driver change
> 
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Samuel Holland <samuel@sholland.org>
> 
> Stephen Boyd (7):
>   firmware: coreboot: Let OF core populate platform device
>   firmware: coreboot: Unmap ioregion on failure
>   firmware: coreboot: Make bus registration symmetric
>   firmware: coreboot: Collapse platform drivers into bus core
>   firmware: coreboot: Remap RAM with memremap() instead of ioremap()
>   firmware: coreboot: Only populate devices in coreboot_table_init()
>   firmware: coreboot: Request table region for exclusive access

I gave patches 1 and 2 closer review (and individual replies); the
remaining patches look good to me too, so for the whole series:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  drivers/firmware/google/Kconfig               |  26 ++--
>  drivers/firmware/google/Makefile              |   2 -
>  drivers/firmware/google/coreboot_table-acpi.c |  88 ------------
>  drivers/firmware/google/coreboot_table-of.c   |  82 -----------
>  drivers/firmware/google/coreboot_table.c      | 135 +++++++++++++-----
>  drivers/firmware/google/coreboot_table.h      |   6 -
>  6 files changed, 107 insertions(+), 232 deletions(-)
>  delete mode 100644 drivers/firmware/google/coreboot_table-acpi.c
>  delete mode 100644 drivers/firmware/google/coreboot_table-of.c
> 
> -- 
> Sent by a computer through tubes
> 
