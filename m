Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E981C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451632070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfAIHYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:24:17 -0500
Received: from shell.v3.sk ([90.176.6.54]:52169 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfAIHYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:24:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D49B21000F2;
        Wed,  9 Jan 2019 08:24:11 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UNI4V9w367RP; Wed,  9 Jan 2019 08:24:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6C5001000F3;
        Wed,  9 Jan 2019 08:24:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t4h50ervkpdZ; Wed,  9 Jan 2019 08:24:07 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6E43D1000F2;
        Wed,  9 Jan 2019 08:24:06 +0100 (CET)
Message-ID: <916efaa742e0b621f02b385f0ac6f186b960c028.camel@v3.sk>
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 08:24:04 +0100
In-Reply-To: <20190108233137.GW11171@n2100.armlinux.org.uk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
         <20190108175818.705110-2-lkundrak@v3.sk>
         <20190108233137.GW11171@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 23:31 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> > The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> > Controller. The EC driver should be a module, since most people don't need
> > it to be compiled in.
> 
> Why do you need this - is there a reason why you can't hook onto the
> restart_handler_list using register_restart_handler()?  The registered
> handlers are passed the command.

Actually, yes. The restart handlers are invoked in atomic context, but
the EC communication needs to block. (The 1.75 EC is actually a SPI
master: a command it initiated by poking a GPIO and waiting until EC
tells us it's ready to read a command.)

Sorry for not mentioning that earlier, I forgot that it is the case.

> I would rather this is not exported to modules, it is generally unsafe
> to hook stuff by directly poking function pointers from module code.

Lubo

