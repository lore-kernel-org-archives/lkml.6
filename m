Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12949C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0320848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Gh27Ouot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA0320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbeJZBaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:30:17 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34226 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZBaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a1L00elH3jQOsSMXuayy74ySl+XGKsx3PZfLVcIhs2s=; b=Gh27Ouot/IVBEjJ4GLFgJYvPN
        encHhoFmiywYaegHBp4ALkz/3jXqA2Olq7NGEcU8VsauLfIWlwQkdTRjLfdTRFeWmDsvR7RAkSSz5
        XXylFMxzyWy/8Mxex+YN3uHFMskHsmxZDw3YTnfNbSAYW7f7kH3POQozsXiUjcRx+lBMI=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:38898)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFivv-0000EI-Cj; Thu, 25 Oct 2018 17:56:31 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFivs-0000hp-Ci; Thu, 25 Oct 2018 17:56:28 +0100
Date:   Thu, 25 Oct 2018 17:56:27 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, p.zabel@pengutronix.de, denis@eukrea.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC v1 1/1] imx-drm: match ipu_di_signal_cfg's clk_pol with its
 observed behaviour.
Message-ID: <20181025165626.GB30658@n2100.armlinux.org.uk>
References: <20181025161711.13727-1-TheSven73@googlemail.com>
 <20181025161711.13727-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025161711.13727-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:17:11PM -0400, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>
> 
> We used an oscilloscope to observe the actual polarity of the
> DI's pixel clock, and saw the following:
> 
> DI_GENERAL bit 17 is SET:
> 	pixel data is stable on the pixel clock's FALLING edge
> DI_GENERAL bit 17 is CLEAR:
> 	pixel data is stable on the pixel clock's RISING  edge
> 
> However, the current driver configures the exact opposite of the
> behaviour documented in video/imx-ipu-v3.h:
>   unsigned clk_pol:1;     /* true = rising edge */

The definition in the manual is:

       17           DI0 Output Clock's polarity
  di0_polarity_     This bits define the polarity of the DI0's clock.
    disp_clk        1    The output clock is active high
                    0    The output clock is active low

but what does that mean...

There's the hint in IMX6SDLCEC that when the clock is active high,
it's expected that the panel will latch data on the _falling_ edge:

  IPP_DISP_CLK latches data into the panel on its negative edge (when
  positive polarity is selected). In active mode, IPP_DISP_CLK runs
  continuously.

That seems to imply that when DI_GEN_POLARITY_DISP_CLK is set, it is
expected that the panel latches data on the _falling_ edge, not on
the positive edge.

What this actually means as far as the output signal is not defined
very well beyond what I've quoted above in any of the IMX6 manuals
that I've checked so far.

Now, the interpretation of the comment "/* true = rising edge */"
is ambiguous, because it doesn't state what "rising edge" refers to -
is that referring to the edge that the data changes, or the edge that
the panel is supposed to latch the data.

Given what's in the documentation, I'd opt for it describing the
edge that the output data changes, not the latch edge.  With that
interpretation, the existing code is correct.

In any case, I suspect if we were to change this as per your patch,
we'd end up breaking stuff that works today, thereby causing
regressions.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
