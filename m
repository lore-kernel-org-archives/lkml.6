Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDCEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020AE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020AE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeJPWnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:43:32 -0400
Received: from webbox1416.server-home.net ([77.236.96.61]:33143 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbeJPWnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:43:32 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id B3E2427A45D;
        Tue, 16 Oct 2018 16:52:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by imapserver.systec-electronic.com (Postfix) with ESMTP id 37F2B1A1B58;
        Tue, 16 Oct 2018 16:52:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at imapserver.systec-electronic.com
Received: from imapserver.systec-electronic.com ([127.0.0.1])
        by localhost (imapserver.systec-electronic.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UI6YKVfpJWY1; Tue, 16 Oct 2018 16:52:40 +0200 (CEST)
Received: from ws-140106.localnet (ws-140106.systec.local [192.168.10.85])
        by imapserver.systec-electronic.com (Postfix) with ESMTPA id 77B1A1A1B57;
        Tue, 16 Oct 2018 16:52:40 +0200 (CEST)
From:   Alexander Stein <alexander.stein@systec-electronic.com>
To:     Claudiu.Beznea@microchip.com
Cc:     jonas@orbital-systems.com, linux-kernel@vger.kernel.org,
        sre@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] power: reset: at91-reset: enable I-cache for at91sam9260_reset
Date:   Tue, 16 Oct 2018 16:52:40 +0200
Message-ID: <2351196.3BzoFE0xYq@ws-140106>
In-Reply-To: <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
References: <20181007125815.8392-1-jonas@threetimestwo.org> <80993f04-c8ce-5a71-4f04-7edab5e1857b@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 16, 2018, 3:30:24 PM CEST Claudiu.Beznea@microchip.com wrote:
> Hi Jonas,
> 
> On 07.10.2018 15:57, Jonas Danielsson wrote:
> > From: Jonas Danielsson <jonas@orbital-systems.com>
> > 
> > This fixes a bug where our embedded system (AT91SAM9260 based) would
> > hang at reboot. At the most we managed 16 boot loops without a hang.
> > 
> > With this patch applied the problem has not been observed and the board
> > has managed above 250 boot loops.
> > 
> > The AT91SAM9260 datasheet tells us that with the instruction cache
> > disabled all instructions are fetched from SDRAM. And we have an errata
> > telling us we must power down the SDRAM before issuing cpu reset.
> > 
> > This means we need the instruction cache enabled in at91sam9260_reset()
> > At the moment it is being disabled in cpu_proc_fin() which is called from
> > arch/arm/kernel/reboot.c.
> 
> Are you using kexec reboot or implemented hibernate mode on this machine?
> I'm seeing cpu_proc_fin() is called only in case of kexec reboot or
> switching to hibernate mode.
> 
> In case of normal reboot (e.g. reboot command) machine_restart() from
> arch/arm/kernel/reboot.c is called. Please correct me if I'm wrong.

Another location is cpu_reset() aka cpu_arm926_reset() in proc-arm926.S
which also disables I-cache. But I can't track down a callstack
ending there.

Best regards,
Alexander



