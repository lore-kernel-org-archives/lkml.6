Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE17C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C65D21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C65D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJSG77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:59:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeJSG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:59:59 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0094B140A9E0D;
        Thu, 18 Oct 2018 15:56:47 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:56:47 -0700 (PDT)
Message-Id: <20181018.155647.1045018243241594303.davem@davemloft.net>
To:     sam@mendozajonas.com
Cc:     netdev@vger.kernel.org, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple
 packages & channels
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181018035917.19413-1-sam@mendozajonas.com>
References: <20181018035917.19413-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Oct 2018 15:56:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Thu, 18 Oct 2018 14:59:11 +1100

> This series extends the NCSI driver to configure multiple packages
> and/or channels simultaneously. Since the RFC series this includes a few
> extra changes to fix areas in the driver that either made this harder or
> were roadblocks due to deviations from the NCSI specification.
> 
> Patches 1 & 2 fix two issues where the driver made assumptions about the
> capabilities of the NCSI topology.
> Patches 3 & 4 change some internal semantics slightly to make multi-mode
> easier.
> Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
> and keeping track of channel states.
> Patch 6 implements the main multi-package/multi-channel configuration,
> configured via the Netlink interface.
> 
> Readers who have an interesting NCSI setup - especially multi-package
> with HWA - please test! I think I've covered all permutations but I
> don't have infinite hardware to test on.

This doesn't apply cleanly to net-next.  Does it depend upon changes
applied elsewhere?  You must always make that explicit.

Also, please explain this locking in ncsi_reset_dev():

+	NCSI_FOR_EACH_PACKAGE(ndp, np) {
+		NCSI_FOR_EACH_CHANNEL(np, nc) {
+			spin_lock_irqsave(&nc->lock, flags);
+			enabled = nc->monitor.enabled;
+			state = nc->state;
+			spin_unlock_irqrestore(&nc->lock, flags);
+
+			if (enabled)
+				ncsi_stop_channel_monitor(nc);
+			if (state == NCSI_CHANNEL_ACTIVE) {
+				active = nc;
+				break;
+			}

Is that really protecting anything?

Right after you drop np->lock those two values can change, the state
of the 'nc' can change such that it isn't NCSI_CHANNEL_ACTIVE anymore
etc.

At best this locking makes sure thatn enabled and state are consistent
with respect to eachother, only.  It doesn't guarantee anything about
the stability of the state of the object at all, and it can change
right from under you.
