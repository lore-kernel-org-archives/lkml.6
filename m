Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23B6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8357C2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YSCC/Iuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfAHXbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:31:47 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43648 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbfAHXbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZDpqMIOfSr80qqy4WqGmoqDm1tA8iRjzyqUWs77v9hw=; b=YSCC/Iuu4hcibcnt+3fd/pdu4
        VI6WQA0g6fGBNHBuaPXlISIs3/naf9d0hwkDuj9jYXCNGwGR1oCV7+zP+JbKCbnaRG7NhiDwiQaON
        FYQ5RVYeo7wVcxELm7psFb/PrELdekvRzbEbZ0k1x56ujZtBRn7fAtpeLacAhvyXENQrU=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38817)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gh0qT-0004wk-Dp; Tue, 08 Jan 2019 23:31:41 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gh0qQ-0007a6-QT; Tue, 08 Jan 2019 23:31:39 +0000
Date:   Tue, 8 Jan 2019 23:31:37 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/15] ARM: export arm_pm_restart()
Message-ID: <20190108233137.GW11171@n2100.armlinux.org.uk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
 <20190108175818.705110-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108175818.705110-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:58:04PM +0100, Lubomir Rintel wrote:
> The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
> Controller. The EC driver should be a module, since most people don't need
> it to be compiled in.

Why do you need this - is there a reason why you can't hook onto the
restart_handler_list using register_restart_handler()?  The registered
handlers are passed the command.

I would rather this is not exported to modules, it is generally unsafe
to hook stuff by directly poking function pointers from module code.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
