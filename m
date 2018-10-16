Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CC4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DE62083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE62083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeJPNL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:11:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:11:28 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1ACD71456E0B9;
        Mon, 15 Oct 2018 22:22:49 -0700 (PDT)
Date:   Mon, 15 Oct 2018 22:22:48 -0700 (PDT)
Message-Id: <20181015.222248.2263887975438589835.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: use for mcast
 entries only host port
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
References: <20181012160629.7245-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Oct 2018 22:22:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 12 Oct 2018 19:06:29 +0300

> In dual-emac mode the cpsw driver sends directed packets, that means
> that packets go to the directed port, but an ALE lookup is performed
> to determine untagged egress only. It means that on tx side no need
> to add port bit for ALE mcast entry mask, and basically ALE entry
> for port identification is needed only on rx side.
> 
> So, add only host port in dual_emac mode as used directed
> transmission, and no need in one more port. For single port boards
> and switch mode all ports used, as usual, so no changes for them.
> Also it simplifies farther changes.
> 
> In other words, mcast entries for dual-emac should behave exactly
> like unicast. It also can help avoid leaking packets between ports
> with same vlan on h/w level if ports could became members of same vid.
> 
> So now, for instance, if mcast address 33:33:00:00:00:01 is added then
> entries in ALE table:
> 
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
> 
> Instead of:
> vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x3
> vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x5
> 
> With the same considerations, set only host port for unregistered
> mcast for dual-emac mode in case of IFF_ALLMULTI is set, exactly like
> it's done in cpsw_ale_set_allmulti().
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied.
