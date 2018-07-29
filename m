Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3EC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AC320873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeG2RBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 13:01:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40734 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeG2RBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 13:01:33 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3625913CEE04F;
        Sun, 29 Jul 2018 08:30:44 -0700 (PDT)
Date:   Sun, 29 Jul 2018 08:30:40 -0700 (PDT)
Message-Id: <20180729.083040.53901922165497594.davem@davemloft.net>
To:     xiliang@redhat.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen-netfront: wait xenbus state change when load
 module manually
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180727095608.25210-1-xiliang@redhat.com>
References: <20180727095608.25210-1-xiliang@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 08:30:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiao Liang <xiliang@redhat.com>
Date: Fri, 27 Jul 2018 17:56:08 +0800

> @@ -1330,6 +1331,11 @@ static struct net_device *xennet_create_dev(struct xenbus_device *dev)
>  	netif_carrier_off(netdev);
>  
>  	xenbus_switch_state(dev, XenbusStateInitialising);
> +	wait_event(module_load_q,
> +			   xenbus_read_driver_state(dev->otherend) !=
> +			   XenbusStateClosed &&
> +			   xenbus_read_driver_state(dev->otherend) !=
> +			   XenbusStateUnknown);
>  	return netdev;
>  
>   exit:

What performs the wakeups that will trigger for this sleep site?

Thank you.
