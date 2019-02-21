Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A7C10F07
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BB72089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0PAxE2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBUBWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:22:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBUBWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V2ydE4AEk0FEWXbith5g30WIPW7ega244MSb+lvhbl0=; b=m0PAxE2cEmdtItBRRv9THfaqQ
        Pa9s5dlhB4yh74r6eIPMBZ5lW2Wg9czjRRsX+xUcoUH1W0WWG4HfbwMgFuotHxoWP9Ww3DSMtH8VD
        SpSzlIdObjBZmsNV5evPX5UBzuRF+1KiLxGVbJoGpXcF1D0eW4UIsJwNxc1o64hGbcFDq9ot1ZBfK
        lB15VExNKDj+0706fY4Wlt2ZsHV9rlcW+Fp/MOybVbw3ft2nTHI9IJ/Sz97cyiYQCjEiF392RsJBa
        EQg1ho/pF0G/JkIfmRD8fsirutZgfE/7nh4zsnoCI1uOQCUI3RIvXEn2/vUulgHS+SkaL+tBDEilO
        6SJsU5EWg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwd4L-0000bm-6A; Thu, 21 Feb 2019 01:22:33 +0000
Date:   Wed, 20 Feb 2019 17:22:31 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/10] Platform: OLPC: Add XO-1.75 EC driver
Message-ID: <20190221012231.GC5838@wrath>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110175845.1203986-7-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:58:41PM +0100, Lubomir Rintel wrote:
> It's based off the driver from the OLPC kernel sources. Somewhat
> modernized and cleaned up, for better or worse.
> 
> Modified to plug into the olpc-ec driver infrastructure (so that battery
> interface and debugfs could be reused) and the SPI slave framework.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v4:
> - Chop off the reboot handler. Will be added back once it's clear how.
> 
> Changes since v3:
> - Introduce CONFIG_OLPC_EC symbol to enable parts common to this driver
>   and the X86 OLPC EC machinery.
> 
> Changes since v1:
> - Cosmetic style changes; whitespace, ordering of declarations and
>   #includes, remoted extra comas from sentinels
> - Count the terminating NUL in LOG_BUF_SIZE
> - Make olpc_xo175_ec_is_valid_cmd() return -EINVAL instead of -1
>   on error
> - Spell keyboard/touchpad in full for CHAN_KEYBOARD/TOUCHPAD messages
> - Use a #define for PM wakeup processing time
> - Log a message on unknown event
> - Escape logging payload with %*pE
> - Replace an open-coded min()
> - Correct an error code on short read
> - replaced PM callback #ifdefs with __maybe_unusedm SET_RUNTIME_PM_OPS
>   and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> - dev_get_drvdata() instead of a round-trip through platform device
> - s/unsigned char x/u8 x/ in olpc_xo175_ec_resume()
> - Use GENMASK() instead of 0xffff for the event mask
> - Replace cmd tx/resp rx buffers with structures
> - Turned suspend hint arguments into a struct, and tidied up the comment
> 
> Basically all of the above is based on the review by Andy Shevchenko.

Andy, I am happy to merge this series - but this patch includes a lot of changes
driven by your feedback. Are you satisfied with the changes, would you like to
add your Reviewed-by?

-- 
Darren Hart
VMware Open Source Technology Center
