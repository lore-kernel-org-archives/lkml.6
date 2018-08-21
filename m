Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B3EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD12E217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD12E217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHUWwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:52:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34648 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHUWwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:52:36 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C1E34144D3973;
        Tue, 21 Aug 2018 12:31:08 -0700 (PDT)
Date:   Tue, 21 Aug 2018 12:31:08 -0700 (PDT)
Message-Id: <20180821.123108.89921430801253333.davem@davemloft.net>
To:     hkallweit1@gmail.com
Cc:     helgaas@kernel.org, jian-hong@endlessm.com, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, linux-pci@vger.kernel.org,
        marc.zyngier@arm.com, tglx@linutronix.de, hch@lst.de
Subject: Re: [PATCH] r8169: don't use MSI-X on RTL8106e
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
References: <ac30d4e6-6411-09e6-1205-96e3e8e29f6f@gmail.com>
        <20180820184438.GA154536@bhelgaas-glaptop.roam.corp.google.com>
        <9d7d960a-6c55-dc4b-7969-f5cf46bff0ce@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Aug 2018 12:31:09 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Mon, 20 Aug 2018 22:46:48 +0200

> I'm in contact with Realtek and according to them few chip versions
> seem to clear MSI-X table entries on resume from suspend. Checking
> with them how this could be fixed / worked around.
> Worst case we may have to disable MSI-X in general.

I worry that if the chip does this, and somehow MSI-X is enabled and
an interrupt is generated, the chip will write to the cleared out
MSI-X address.  This will either write garbage into memory or cause
a bus error and require PCI error recovery.

It also looks like your test patch doesn't fix things for people who
have tested it.

Hmmm...
