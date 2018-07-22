Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B929C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4659920671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4659920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeGVSYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:24:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57170 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbeGVSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:24:49 -0400
Received: from localhost (unknown [172.58.43.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DEB112DE6609;
        Sun, 22 Jul 2018 10:27:25 -0700 (PDT)
Date:   Sun, 22 Jul 2018 10:27:24 -0700 (PDT)
Message-Id: <20180722.102724.533759585465302686.davem@davemloft.net>
To:     vkuznets@redhat.com
Cc:     netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, ross.lagerwall@citrix.com
Subject: Re: [PATCH net-next] xen-netfront: fix queue name setting
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180720163359.28187-1-vkuznets@redhat.com>
References: <20180720163359.28187-1-vkuznets@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 22 Jul 2018 10:27:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Fri, 20 Jul 2018 18:33:59 +0200

> Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
> open") changed the initialization order: xennet_create_queues() now
> happens before we do register_netdev() so using netdev->name in
> xennet_init_queue() is incorrect, we end up with the following in
> /proc/interrupts:
> 
>  60:        139          0   xen-dyn    -event     eth%d-q0-tx
>  61:        265          0   xen-dyn    -event     eth%d-q0-rx
>  62:        234          0   xen-dyn    -event     eth%d-q1-tx
>  63:          1          0   xen-dyn    -event     eth%d-q1-rx
> 
> and this looks ugly. Actually, using early netdev name (even when it's
> already set) is also not ideal: nowadays we tend to rename eth devices
> and queue name may end up not corresponding to the netdev name.
> 
> Use nodename from xenbus device for queue naming: this can't change in VM's
> lifetime. Now /proc/interrupts looks like
> 
>  62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
>  63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
>  64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
>  65:         17          0   xen-dyn    -event     device/vif/0-q1-rx
> 
> Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Patch applied, thank you.
