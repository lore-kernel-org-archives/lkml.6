Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA6CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E362082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYARkkVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E362082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeLESAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:00:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLESAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:00:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so9343373pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKgzt9jM2iynx5qWwfVAz9jDsDSALJ/HvNJnuoHSRwM=;
        b=dYARkkVOVOwA/n0mNacNjsv+3Z8Iz3cG3a4CIGxWBur1GzLk2shhYV1aUN+YFxa/eO
         u8tIaWujNSqaS8wSAW3YZbzUuTtBgFCs1149sACCKG7OufZCtGyEVTOpShA6Ce4xa1PA
         XXZ1+afRVPWX+2dJBKA6QCxPKZSZkbts5NKSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKgzt9jM2iynx5qWwfVAz9jDsDSALJ/HvNJnuoHSRwM=;
        b=WZ9can4rFdZZer7EXsNMlsg/27MDGwsoDD8jZ1wc6H8LOJL1yrNOud6kUGfVYMsn4t
         cDzbPrLFbgCmmu6Ha31YzNY6rcef1z66NXMh7sO/O0n6BXd3pjn68LIKFm2cpAbS4TPl
         0m3sqyL44YMTaSJsVbNAENZ9+utJgJv8r2IKtFEKSjhZTUVBmCWKS0yVG9Ks9AGs3Qa4
         X5BpD31KVm+Wvx4CJcktcoCTZXPq3xNJSBhVR8Ad8FqSyzUE7QwnSR2mrCV0Br82u6M1
         YnpqIu9iiYlxXMXgYruU84ifiLDJ8fz2AslZyTTWxdThLqqnbh0n6X7LQBbMCPea01FD
         w0dw==
X-Gm-Message-State: AA+aEWb8Qq5QoyUXAhqEFQU4/rRGGBfitKus0ANuY03gqDD8NlmzYP7A
        Ey2sofqILEh+6G5XZm0XEY8Llw==
X-Google-Smtp-Source: AFSGD/WEOYZ84gpscSD2jL++UKPtsWroJTiYRpRHL7v+NzIxZQxei65EcouT35NhBfyPHPXOdZN0Tg==
X-Received: by 2002:a63:235f:: with SMTP id u31mr21122158pgm.122.1544032852341;
        Wed, 05 Dec 2018 10:00:52 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id y71sm35751942pfi.123.2018.12.05.10.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 10:00:50 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:00:47 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Allow driver to be shutdown on reboot/kexec
Message-ID: <20181205180046.GA57043@google.com>
References: <20180805124807.18169-1-marc.zyngier@arm.com>
 <20181205030127.GA200921@google.com>
 <1693737.bVF0dcvACY@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693737.bVF0dcvACY@diego>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:11:03PM +0100, Heiko Stuebner wrote:
> Can you maybe give "drm/rockchip: shutdown drm subsystem on shutdown" [2]
> a try? When the underlying issue of rebooting surfaced we had 2 competing 
> solutions, so we at least don't reopen the issue, that people have problems
> rebooting?
> 
> drm-drivers seem to be short on shutdown handlers to peek at but this
> second variant mimics what tinydrm does in its shutdown
> (calling drm_atomic_helper_shutdown), so at least shouldn't be completely
> wrong.
> 
> 
> [2] https://patchwork.kernel.org/patch/10556151/

I tried the linked patch on Kevin and Scarlet with 4.20-rc5-ish, with
$subject reverted; I saw no warnings/complaints, and things worked OK.
Same with Kevin on 4.19.6.

I can't test on 4.4.y, since drm_atomic_helper_shutdown() doesn't exist
there.

I can provide a Tested-by to the original patch if you'd like. (I won't
provide it here, lest patchwork apply it to the $subject patch.)

Brian
