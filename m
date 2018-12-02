Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E7C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2100620851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U32Qj4dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLBXNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 18:13:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 18:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=468YkyHmHjR8WB7h95DaFqwpn95HUihY+kX1qINkW4w=; b=U32Qj4ddjxP6zeVxMXnkZWsmj
        MErZQMTDjKPcO/r1Ym9+hxyRhSJAY4mnREWoh634gdPq2wJBlmpzFCsc01HYY5T0dw/lE49MRe3/M
        cgFHhH6tYQEw4SpSQTuMCsSxMHd4QZqWdbQm+AavGD3eDQVrZIW/5Jxwo5acEjJ0yNCKURkF/hP8K
        DYJI29etr7M3jzIrmsbntkADkVmge3sSI3+3ANGcQQseZjgsjAJ2VI/pmwo42fAAaKKfCIOzfBwbv
        gHmyea+5W+P/o1couyFrEubX9S77vG/BilklWIlZmUEihTlXZv2P+9jZVHj8JRUJwp7r+sw4LZLTq
        0T/czN0TQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTavZ-0005hw-6v; Sun, 02 Dec 2018 23:13:29 +0000
Date:   Sun, 2 Dec 2018 15:13:28 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 06/17] Platform: OLPC: Add XO-1.75 EC driver
Message-ID: <20181202231328.GB23087@wrath>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-7-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-7-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:23:52PM +0100, Lubomir Rintel wrote:
> It's based off the driver from the OLPC kernel sources. Somewhat
> modernized and cleaned up, for better or worse.
> 
> Modified to plug into the olpc-ec driver infrastructure (so that battery
> interface and debugfs could be reused) and the SPI slave framework.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 

Hi Lubomir,

You asked for some tips on how to incorporate the changes in a patch
series like this.

Keep in mind that each patch should create an independent small
functional change. This makes it easier to review the patch and verify
that what you said you were going to do matches what the patch does. For
example, if you separate out the style, whitespace, ordering of
declarations into an initial first patch, then all that noise is removed
when the reviewer goes to check to implementation of one of the features
below.

This is a large patch, and should most certainly be broken up into
several smaller patches. Do cleanups first, followed by functional
changes. This ordering ensure that when a "git blame" is used in the
future to understand why a given line is what it is, the first hit will
be a functional change, and not a cleanup.

> ---
> Changes since v1:
> - Cosmetic style changes; whitespace, ordering of declarations and
>   #includes, remoted extra comas from sentinels

Please make this a separate change, possibly more than one, depending on
how many of these there are. This will reduce the size of the subsequent
patches, making them easier to review.

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

Just from these comments, each of these could be a separate patch. You
can group related things together, or those that change the same line or
function for example. Order them with cleanups / non-functional-changes
first, followed by functional changes.

> 
> Basically all of the above is based on the review by Andy Shevchenko.

Andy, what was your intent for Lubomir here? From the above, this looks
like it should be several patches to me.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
