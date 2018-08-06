Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CFFC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9EA21A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JDN+2oKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9EA21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbeHFTsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:48:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33236 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeHFTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:48:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id b90-v6so5159463plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G3LcWer/CStsmymSMqHvLf4QhJ56b4XAq/qc3kkl9wA=;
        b=JDN+2oKPar5Wb9n3/5YlVi+VV7KjzBihp+5c1GCLmBHDH5OlVRmgMWaCNg3qcwt6Oh
         9gb8J9HQ98i5nnC/AcZopbMh3cFG5dOmwvL92x5C4LIAeCHyCB4GR+P9IVzLZm8B7kiB
         E5TNBRq3V2xUZlZT7NvBpDXQsIHhWY2VClFWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G3LcWer/CStsmymSMqHvLf4QhJ56b4XAq/qc3kkl9wA=;
        b=WgNRJkHfG9ZMPk0vsW3LNS9uYFNwCndw4PQaJryiMHMq3RuZ2jVmGruGB5Cqk0FP8m
         FujDDov6IjyCfi3K9atQloRfbV6BkdIwCwJf6myfS498PKQtfUv2GUG+RcG0aN6XVFuz
         kiUvH0YZ+trJ7yZ6xLPdizwUGbjQDsQArvZfQesiU6De2OkawKLD3viW0eT8J701rUJG
         hXBvzpjW5u9r3O6UL9+i5rx8BK/4G0gf7XJtrpzqMyUf4MOY4iN7w1/MTFN+7X+iZEcw
         2Q0PBYNZ9R0fahbXmBd8vZ+RdYyBfi7N978nMUPudSoL1r/7oDnucg3zb9AiLn/iUqT2
         RvCw==
X-Gm-Message-State: AOUpUlEid4E+hKMwXXw4wnOFT5ypP+lJmkjgrGnQ7S28uwf+24wADmp+
        YTBQynUJKsrr2pyvrj26Wx2vHQ==
X-Google-Smtp-Source: AAOMgpcymVVptPN8aLjJDRSEtRJ8vQca9v8ceJCo0+Z2eYAfLxs/WCg3DzikOQYfV3Nz7R19H9d7ig==
X-Received: by 2002:a17:902:6501:: with SMTP id b1-v6mr14801876plk.31.1533577091672;
        Mon, 06 Aug 2018 10:38:11 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id f11-v6sm13134723pfa.131.2018.08.06.10.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 10:38:10 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:38:08 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH] firmware: coreboot: Let OF core populate platform device
Message-ID: <20180806173806.GA26374@ban.mtv.corp.google.com>
References: <20180806171047.227835-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806171047.227835-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:10:47AM -0700, Stephen Boyd wrote:
> Now that the /firmware/coreboot node in DT is populated by the core DT
> platform code with commit 3aa0582fdb82 ("of: platform: populate
> /firmware/ node from of_platform_default_populate_init()") we should and

Does this deserve a 'Fixes' tag?

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")

The coreboot-of driver was in 4.12, and it seems to have broken in 4.16,
along with the above patch.

> can remove the platform device creation here. Otherwise, the
> of_platform_device_create() call will fail, the coreboot of driver won't
> be registered, and this driver will never bind. At the same time, we can
> move this driver to use platform device APIs instead of DT specific ones
> and drop the of_node handling that was presumably placed there to hold a
> reference to the DT node created during module init.
> 
> Cc: Wei-Ning Huang <wnhuang@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>

> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/firmware/google/coreboot_table-of.c | 39 +++++----------------
>  1 file changed, 9 insertions(+), 30 deletions(-)
