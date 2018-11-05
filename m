Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B217C32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775A20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 00:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B775A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeKEKCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:02:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:46640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKEKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:02:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F1C814883D3B;
        Sun,  4 Nov 2018 16:45:58 -0800 (PST)
Date:   Sun, 04 Nov 2018 16:45:57 -0800 (PST)
Message-Id: <20181104.164557.2006286407522148282.davem@davemloft.net>
To:     jarod@redhat.com
Cc:     linux-kernel@vger.kernel.org, maheshb@google.com,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] bonding/802.3ad: fix link_failure_count tracking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181104195946.33861-1-jarod@redhat.com>
References: <20181101212240.26768-1-jarod@redhat.com>
        <20181104195946.33861-1-jarod@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 04 Nov 2018 16:45:58 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarod Wilson <jarod@redhat.com>
Date: Sun,  4 Nov 2018 14:59:46 -0500

> Commit 4d2c0cda07448ea6980f00102dc3964eb25e241c set slave->link to
> BOND_LINK_DOWN for 802.3ad bonds whenever invalid speed/duplex values
> were read, to fix a problem with slaves getting into weird states, but
> in the process, broke tracking of link failures, as going straight to
> BOND_LINK_DOWN when a link is indeed down (cable pulled, switch rebooted)
> means we broke out of bond_miimon_inspect()'s BOND_LINK_DOWN case because
> !link_state was already true, we never incremented commit, and never got
> a chance to call bond_miimon_commit(), where slave->link_failure_count
> would be incremented. I believe the simple fix here is to mark the slave
> as BOND_LINK_FAIL, and let bond_miimon_inspect() transition the link from
> _FAIL to either _UP or _DOWN, and in the latter case, we now get proper
> incrementing of link_failure_count again.
> 
> Fixes: 4d2c0cda0744 ("bonding: speed/duplex update at NETDEV_UP event")
> CC: Mahesh Bandewar <maheshb@google.com>
> CC: David S. Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> CC: stable@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
> v2: fix Fixes line

Applied and queued up for -stable.
