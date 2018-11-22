Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBDCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8F220831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8F220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbeKVLe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:34:56 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbeKVLe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:34:56 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D628613E5BD94;
        Wed, 21 Nov 2018 16:58:04 -0800 (PST)
Date:   Wed, 21 Nov 2018 16:58:04 -0800 (PST)
Message-Id: <20181121.165804.509539437154732563.davem@davemloft.net>
To:     vincentc@andestech.com
Cc:     gregkh@linuxfoundation.org, rdunlap@infradead.org,
        yuehaibing@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: faraday: ftmac100: remove
 netif_running(netdev) check before disabling interrupts
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1542764291-11208-1-git-send-email-vincentc@andestech.com>
References: <1542764291-11208-1-git-send-email-vincentc@andestech.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 21 Nov 2018 16:58:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincentc@andestech.com>
Date: Wed, 21 Nov 2018 09:38:11 +0800

> In the original ftmac100_interrupt(), the interrupts are only disabled when
> the condition "netif_running(netdev)" is true. However, this condition
> causes kerenl hang in the following case. When the user requests to
> disable the network device, kernel will clear the bit __LINK_STATE_START
> from the dev->state and then call the driver's ndo_stop function. Network
> device interrupts are not blocked during this process. If an interrupt
> occurs between clearing __LINK_STATE_START and stopping network device,
> kernel cannot disable the interrupts due to the condition
> "netif_running(netdev)" in the ISR. Hence, kernel will hang due to the
> continuous interruption of the network device.
> 
> In order to solve the above problem, the interrupts of the network device
> should always be disabled in the ISR without being restricted by the
> condition "netif_running(netdev)".
> 
> [V2]
> Remove unnecessary curly braces.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>

Applied.
