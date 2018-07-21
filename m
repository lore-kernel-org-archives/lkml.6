Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7628EECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8BD20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8BD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeGUSTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:19:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeGUSTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:19:43 -0400
Received: from localhost (unknown [172.58.43.143])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DA462122FED9D;
        Sat, 21 Jul 2018 10:26:16 -0700 (PDT)
Date:   Sat, 21 Jul 2018 10:26:15 -0700 (PDT)
Message-Id: <20180721.102615.85495078941250538.davem@davemloft.net>
To:     jarod@redhat.com
Cc:     linux-kernel@vger.kernel.org, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, maheshb@google.com,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] bonding: set default miimon value for non-arp
 modes if not set
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180718184936.16037-1-jarod@redhat.com>
References: <20180718184936.16037-1-jarod@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 10:26:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>
Date: Wed, 18 Jul 2018 14:49:36 -0400

> For some time now, if you load the bonding driver and configure bond
> parameters via sysfs using minimal config options, such as specifying
> nothing but the mode, relying on defaults for everything else, modes
> that cannot use arp monitoring (802.3ad, balance-tlb, balance-alb) all
> wind up with both arp_interval=0 (as it should be) and miimon=0, which
> means the miimon monitor thread never actually runs. This is particularly
> problematic for 802.3ad.
 ...
> I believe this became a major issue as of commit 4d2c0cda0744, which for
> 802.3ad bonds, sets slave->link = BOND_LINK_DOWN, with a comment about
> relying on link monitoring via miimon to set it correctly, but since the
> miimon work queue never runs, the link just stays marked down.
> 
> If we simply tweak bond_option_mode_set() slightly, we can check for the
> non-arp modes having no miimon value set, and insert BOND_DEFAULT_MIIMON,
> which gets things back in full working order. This problem exists as far
> back as 4.14, and might be worth fixing in all stable trees since, though
> the work-around is to simply specify an miimon value yourself.
> 
> Reported-by: Bob Ball <ball@umich.edu>
 ...
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Applied and queued up for -stable, thank you.
