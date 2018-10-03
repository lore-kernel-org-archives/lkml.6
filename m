Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E90C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699A206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 00:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJCHVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 03:21:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeJCHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 03:21:30 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E30B8142A355D;
        Tue,  2 Oct 2018 17:35:29 -0700 (PDT)
Date:   Tue, 02 Oct 2018 17:35:26 -0700 (PDT)
Message-Id: <20181002.173526.155463905341442781.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: systemport: Fix wake-up interrupt race during
 resume
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181002235204.26135-1-f.fainelli@gmail.com>
References: <20181002235204.26135-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 17:35:30 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue,  2 Oct 2018 16:52:03 -0700

> The AON_PM_L2 is normally used to trigger and identify the source of a
> wake-up event. Since the RX_SYS clock is no longer turned off, we also
> have an interrupt being sent to the SYSTEMPORT INTRL_2_0 controller, and
> that interrupt remains active up until the magic packet detector is
> disabled which happens much later during the driver resumption.
> 
> The race happens if we have a CPU that is entering the SYSTEMPORT
> INTRL2_0 handler during resume, and another CPU has managed to clear the
> wake-up interrupt during bcm_sysport_resume_from_wol(). In that case, we
> have the first CPU stuck in the interrupt handler with an interrupt
> cause that has been cleared under its feet, and so we keep returning
> IRQ_NONE and we never make any progress.
> 
> This was not a problem before because we would always turn off the
> RX_SYS clock during WoL, so the SYSTEMPORT INTRL2_0 would also be turned
> off as well, thus not latching the interrupt.
> 
> The fix is to make sure we do not enable either the MPD or
> BRCM_TAG_MATCH interrupts since those are redundant with what the
> AON_PM_L2 interrupt controller already processes and they would cause
> such a race to occur.
> 
> Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
> Fixes: 83e82f4c706b ("net: systemport: add Wake-on-LAN support")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks Florian.
