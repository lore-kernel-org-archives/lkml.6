Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF982145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="duPXXMD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF982145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeK3WQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:16:26 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53140 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3WQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xm3GtPoyMLfyE7dcaanJdP5XZ9duT9aSerkVkuOSze0=; b=duPXXMD2w7C5f4wHR2EDHDqYF
        7svGwFb2Qju+jY0E6YhmK0J12Zlr2gMtToJbKXjGfBrnpgh5RAg8v75ghNlHxz+bOocbS0c7t9Xdw
        8IuaU6xLrtoHlpXhK1xcDRceWrT4XgV5AQkSDbkmFPYMxJfmsB+MhEsqRS2mU7q7xF8po=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:41136)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSgdQ-0007yq-FX; Fri, 30 Nov 2018 11:07:00 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSgdM-0005Rj-7C; Fri, 30 Nov 2018 11:06:56 +0000
Date:   Fri, 30 Nov 2018 11:06:53 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, mazziesaccount@gmail.com,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <20181130110653.GF30658@n2100.armlinux.org.uk>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
 <154356805035.88331.16867826308376667832@swboyd.mtv.corp.google.com>
 <20181130105022.GA15388@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130105022.GA15388@localhost.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:50:22PM +0200, Matti Vaittinen wrote:
> Hello Stephen,
> 
> Thanks a bunch for taking the time and reviewing this!
> 
> On Fri, Nov 30, 2018 at 12:54:10AM -0800, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-11-13 03:55:58)
> > > With MFD devices the clk properties may be contained in MFD (parent) DT
> > > node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
> > > subdevice not to MFD device (parent). Add
> > > devm_of_clk_add_hw_provider_parent to tackle this issue.
> > > 
> > > Also clkdev registration lacks of managed registration functions and it
> > > seems few drivers do not drop clkdev lookups at exit. Add
> > > devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
> > > releasing at exit.
> > 
> > Please split this into clkdev and non-clkdev devm functionality.
> Allright. I'll split this to two patches.

Definitely, please note that clkdev is separate from the common
clk stuff, and is actually maintained by a different person (me)
although I currently defer much of the review to the common clk
guys.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
