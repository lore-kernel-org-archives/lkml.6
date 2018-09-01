Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973C8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4373020837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 06:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4373020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIAKTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 06:19:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44030 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeIAKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 06:19:24 -0400
Received: from localhost (unknown [172.58.43.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7103E1433DAA3;
        Fri, 31 Aug 2018 23:08:34 -0700 (PDT)
Date:   Fri, 31 Aug 2018 23:08:33 -0700 (PDT)
Message-Id: <20180831.230833.1182096350264602698.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        netdev@vger.kernel.org, jopoulso@microsoft.com, olaf@aepfle.de,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        marcelo.cerri@canonical.com, apw@canonical.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com
Subject: Re: [PATCH v2] hv_netvsc: Fix a deadlock by getting rtnl lock
 earlier in netvsc_probe()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <PU1P153MB0169F05DF2A05DC39B4BF360BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169F05DF2A05DC39B4BF360BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Aug 2018 23:08:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 30 Aug 2018 05:42:13 +0000

> 
> This patch fixes the race between netvsc_probe() and
> rndis_set_subchannel(), which can cause a deadlock.
> 
> These are the related 3 paths which show the deadlock:
 ...
> Before path #1 finishes, path #2 can start to run, because just before
> the "bus_probe_device(dev);" in device_add() in path #1, there is a line
> "object_uevent(&dev->kobj, KOBJ_ADD);", so systemd-udevd can
> immediately try to load hv_netvsc and hence path #2 can start to run.
> 
> Next, path #2 offloads the subchannal's initialization to a workqueue,
> i.e. path #3, so we can end up in a deadlock situation like this:
> 
> Path #2 gets the device lock, and is trying to get the rtnl lock;
> Path #3 gets the rtnl lock and is waiting for all the subchannel messages
> to be processed;
> Path #1 is trying to get the device lock, but since #2 is not releasing
> the device lock, path #1 has to sleep; since the VMBus messages are
> processed one by one, this means the sub-channel messages can't be
> procedded, so #3 has to sleep with the rtnl lock held, and finally #2
> has to sleep... Now all the 3 paths are sleeping and we hit the deadlock.
> 
> With the patch, we can make sure #2 gets both the device lock and the
> rtnl lock together, gets its job done, and releases the locks, so #1
> and #3 will not be blocked for ever.
> 
> Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied and queued up for -stable.
