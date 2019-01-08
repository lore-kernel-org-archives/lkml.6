Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC02C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3648B218AF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="FNBeOhbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAHKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:32:05 -0500
Received: from onstation.org ([52.200.56.107]:54838 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfAHKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:32:05 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id EE9E91AE;
        Tue,  8 Jan 2019 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546943524;
        bh=iZYd0kD9Huk1bJPdESmFcNk0PKSwm6QLymJACS2aw2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNBeOhbii9PIpojWD5tLaU0iEK1bdllmT8pSFMWWnQR0EkYRZdkBjJaq+Exa8sv7R
         pECpt1W7ixEXsjOfyBq0ZlvQjQqiMo4qJ7V9G6238tFSHY5X7JYmr5t854Ji1pDioW
         t6jehv/6rCWDXV8souDE6p5m0BiCDKbPNSqQ5lIs=
Date:   Tue, 8 Jan 2019 05:32:03 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mfd: qcom-spmi-pmic: use devm_mfd_add_devices
 instead of devm_of_platform_populate
Message-ID: <20190108103203.GA3643@basecamp>
References: <20190107021145.6370-1-masneyb@onstation.org>
 <20190107021145.6370-3-masneyb@onstation.org>
 <154689729020.15366.16314952173889307636@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154689729020.15366.16314952173889307636@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:41:30PM -0800, Stephen Boyd wrote:
> Now this seems worse. We have gotten by without having to explicitly
> list all the devices that are inside the PMIC as mfd cells. But now, to
> avoid creating the irqs before the hierarchy is installed, we have to
> undo all of that and rely on the difference in behavior of
> of_platform_populate() and mfd_add_devices(). That's pretty obscure to
> figure out.
> 
> I'd prefer we drop this patch and keep disassociating virqs and
> reassociating them in the gpio driver. Then we can remove the interrupts
> properties in all the DTS files and finally remove the disassociate and
> reassociating code in the gpio driver when all the DT files are cleaned
> up. It makes things less confusing that way and doesn't require updates
> to this driver.

You are right that we can get this working without this patch. The issue
that I experienced was caused by the interrupts property on the
spmi-gpio node. I thought that I tested this with that configuration but
I obviously didn't.

qcom-pm8941.dtsi and qcom-pma8084.dtsi are the only two in-tree users of
spmi-gpio. I'll include the fix for qcom-pma8084.dtsi as well.

Brian
