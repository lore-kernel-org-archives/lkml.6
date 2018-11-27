Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52086C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199612086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199612086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeK1J7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:59:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1J7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:59:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 380F014A6A0BC;
        Tue, 27 Nov 2018 14:59:51 -0800 (PST)
Date:   Tue, 27 Nov 2018 14:59:50 -0800 (PST)
Message-Id: <20181127.145950.2178672310020332163.davem@davemloft.net>
To:     3erndeckstein@gmail.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 3ernd.Eckstein@gmail.com,
        Oliver.Zweigle@faro.com
Subject: Re: [PATCH] usbnet: ipheth: fix potential recvmsg bug and recvmsg
 bug 2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542977486-15363-1-git-send-email-3ernd.Eckstein@gmail.com>
References: <1542977486-15363-1-git-send-email-3ernd.Eckstein@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 27 Nov 2018 14:59:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernd Eckstein <3erndeckstein@gmail.com>
Date: Fri, 23 Nov 2018 13:51:26 +0100

> The bug is not easily reproducable, as it may occur very infrequently
> (we had machines with 20minutes heavy downloading before it occurred)
> However, on a virual machine (VMWare on Windows 10 host) it occurred
> pretty frequently (1-2 seconds after a speedtest was started)
> 
> dev->tx_skb mab be freed via dev_kfree_skb_irq on a callback
> before it is set.
> 
> This causes the following problems:
> - double free of the skb or potential memory leak
> - in dmesg: 'recvmsg bug' and 'recvmsg bug 2' and eventually
>   general protection fault
> 
> Example dmesg output:
 ...
> The proposed patch eliminates a potential racing condition.
> Before, usb_submit_urb was called and _after_ that, the skb was attached
> (dev->tx_skb). So, on a callback it was possible, however unlikely that the
> skb was freed before it was set. That way (because dev->tx_skb was not set
> to NULL after it was freed), it could happen that a skb from a earlier
> transmission was freed a second time (and the skb we should have freed did
> not get freed at all)
> 
> Now we free the skb directly in ipheth_tx(). It is not passed to the
> callback anymore, eliminating the posibility of a double free of the same
> skb. Depending on the retval of usb_submit_urb() we use dev_kfree_skb_any()
> respectively dev_consume_skb_any() to free the skb.
> 
> Signed-off-by: Oliver Zweigle <Oliver.Zweigle@faro.com>
> Signed-off-by: Bernd Eckstein <3ernd.Eckstein@gmail.com>

Applied and queued up for -stable, thanks.
