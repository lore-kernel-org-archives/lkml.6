Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F78C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D552154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oACscB5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D552154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeHBWps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbeHBWps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:45:48 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20E52154D;
        Thu,  2 Aug 2018 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533243178;
        bh=hR/DSVcPp5Aigb1d835aeK4rfBJV3yNG0NVnXPNIrgw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=oACscB5GdBPWEYNjdrCnXl8DHtfhfzja5iXLDkC1nNU3B6JwSy50ZIAEPmgZEIpeu
         amKstCdK5mAqoeHhetdyPrf7cv5bo+asYA2V3qWNdM4QhB4u3fbvbd5LIAk45JAFC2
         153xvOSZwFDdW29OTwtD9WUUUw9uoHRYaNsvQSbk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Steve Longerbeam <slongerbeam@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9b8f68f6-dd88-cc1a-6f13-b4d2fedadead@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>
References: <1527818357-8154-1-git-send-email-steve_longerbeam@mentor.com>
 <153090140728.143105.7720351459587498082@swboyd.mtv.corp.google.com>
 <9b8f68f6-dd88-cc1a-6f13-b4d2fedadead@gmail.com>
Message-ID: <153324317799.10763.16530922080427544645@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: vc5: Avoid divide by zero when rounding or setting rates
Date:   Thu, 02 Aug 2018 13:52:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steve Longerbeam (2018-07-18 10:56:51)
> =

> =

> On 07/06/2018 11:23 AM, Stephen Boyd wrote:
> > Quoting Steve Longerbeam (2018-05-31 18:59:17)
> >> Add checks in the .round_rate and .set_rate ops for zero requested
> >> rate or zero parent rate. If either are zero in .round_rate, just
> >> return zero. If either are zero in .set_rate, return -EINVAL.
> > Are you seeing problems when the clk is unparented and we're trying to
> > recalculate the rate or change rates, and thus the parent frequency
> > looks like 0?
> =

> The problem appeared when suspending the rcar-du driver.
> The kernel tested is a Renesas BSP release (3.6.2), and in the
> version of the rcar-du driver from that release, the driver calls
> clk_set_rate() with a rate of zero in its suspend PM op. This is
> fixed in mainline kernel. So the divide-by-zero in vc5 clock driver
> probably will not show up in mainline.

Ok so then this patch shouldn't be applied on mainline?

> =

> >   Should this get a Fixes: tag so that it goes back to
> > stable kernels?
> >
> =

> Zero rates are not checked beginning with the initial commit
> 3e1aec4e2c ("clk: vc5: Add support for IDT VersaClock 5P49V5923 and =

> 5P49V5933").
> so that would have to be the Fixes: tag.

Thanks!

