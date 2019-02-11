Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14340C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B02070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfBKLqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:46:46 -0500
Received: from shell.v3.sk ([90.176.6.54]:45194 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfBKLqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:46:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0FA55CE8F5;
        Mon, 11 Feb 2019 12:46:42 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2oTyeK1wVX70; Mon, 11 Feb 2019 12:46:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D9371CE8F6;
        Mon, 11 Feb 2019 12:46:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jtaDc44OURAU; Mon, 11 Feb 2019 12:46:37 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D137BCE8F5;
        Mon, 11 Feb 2019 12:46:36 +0100 (CET)
Message-ID: <16ce7d18e3b9a2232bd30c7d7741873d0d2d855a.camel@v3.sk>
Subject: Re: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 11 Feb 2019 12:46:35 +0100
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 18:58 +0100, Lubomir Rintel wrote:
> Hello!
> 
> This is a fifth spin of the patch set that adds support for the Embedded
> Controller on an OLPC XO 1.75 machine.
> 
> It notably removes the patches that adjust the battery driver -- those were
> submitted to linux-pm separately [1].
> 
> [1] https://lore.kernel.org/lkml/20190110174005.1202564-1-lkundrak@v3.sk/T/#m9da9aee9e6482ee680a103280ebb769ebcbb32ef
> 
> This DT bindings doc is pretty much independent of the above:
> 
> [01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC
> 
> The OLPC EC changes follow. Cleanups first, then functionality:
> 
> [02/10] Platform: OLPC: Remove an unused include
> [03/10] Platform: OLPC: Move EC-specific functionality out from
> [04/10] Platform: OLPC: Avoid a warning if the EC didn't
> [05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
> [06/10] Platform: OLPC: Add XO-1.75 EC driver
> [07/10] Platform: OLPC: Add a regulator for the DCON
> 
> The patch 08/10 only makes sense once both the above and the XO 1.75
> battery support is merged, otherwise enabling CONFIG_BATTERY_OLPC on
> ARM would break build.
> 
> [08/10] power: supply: olpc_battery: Allow building the driver
> 
> The restart support has been split off, because there's a possibility it
> needs to be reworked: the arm_pm_restart export patch was objected to:
> 
> [09/10] ARM: export arm_pm_restart
> [10/10] Platform: OLPC: Add restart support to XO-1.75 EC
> 
> Tested to work on an OLPC XO 1.75 and also tested not to break x86
> support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
> unlikely this breaks it when XO 1 works.

Hello Andy & Darren,

I'm wondering if there's anything more I need to do in order for the
patches 01-07 to be queued for 5.1? I believe I addressed the issues
that were pointed out and I believe the patch set is already in a good
shape.

Thanks,
Lubo

