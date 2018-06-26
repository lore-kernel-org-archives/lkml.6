Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA28C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3B426752
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3B426752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeFZJCM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:02:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59038 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbeFZJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:02:10 -0400
Received: from localhost (unknown [221.164.75.83])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E86F12573ED4;
        Tue, 26 Jun 2018 02:02:09 -0700 (PDT)
Date:   Tue, 26 Jun 2018 18:01:34 +0900 (KST)
Message-Id: <20180626.180134.216760218494444800.davem@davemloft.net>
To:     jslaby@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] r8152: napi hangup fix after disconnect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180625072627.9109-1-jslaby@suse.cz>
References: <20180625072627.9109-1-jslaby@suse.cz>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Jun 2018 02:02:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 25 Jun 2018 09:26:27 +0200

> When unplugging an r8152 adapter while the interface is UP, the NIC
> becomes unusable.  usb->disconnect (aka rtl8152_disconnect) deletes
> napi. Then, rtl8152_disconnect calls unregister_netdev and that invokes
> netdev->ndo_stop (aka rtl8152_close). rtl8152_close tries to
> napi_disable, but the napi is already deleted by disconnect above. So
> the first while loop in napi_disable never finishes. This results in
> complete deadlock of the network layer as there is rtnl_mutex held by
> unregister_netdev.
> 
> So avoid the call to napi_disable in rtl8152_close when the device is
> already gone.
> 
> The other calls to usb_kill_urb, cancel_delayed_work_sync,
> netif_stop_queue etc. seem to be fine. The urb and netdev is not
> destroyed yet.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied, thank you.
