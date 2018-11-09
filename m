Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF4EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0203F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0203F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeKIN0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:26:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeKIN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:26:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1B4BD14B3D58F;
        Thu,  8 Nov 2018 19:47:56 -0800 (PST)
Date:   Thu, 08 Nov 2018 19:47:55 -0800 (PST)
Message-Id: <20181108.194755.2227584522482516860.davem@davemloft.net>
To:     thor.thayer@linux.intel.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] net: stmmac: Fix RX packet size > 8191
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541698935-9752-1-git-send-email-thor.thayer@linux.intel.com>
References: <1541698935-9752-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Nov 2018 19:47:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: thor.thayer@linux.intel.com
Date: Thu,  8 Nov 2018 11:42:14 -0600

> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Ping problems with packets > 8191 as shown:
> 
> PING 192.168.1.99 (192.168.1.99) 8150(8178) bytes of data.
> 8158 bytes from 192.168.1.99: icmp_seq=1 ttl=64 time=0.669 ms
> wrong data byte 8144 should be 0xd0 but was 0x0
> 16    10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
>       20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
> %< ---------------snip--------------------------------------
> 8112  b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 ba bb bc bd be bf
>       c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 ca cb cc cd ce cf
> 8144  0 0 0 0 d0 d1
>       ^^^^^^^
> Notice the 4 bytes of 0 before the expected byte of d0.
> 
> Databook notes that the RX buffer must be a multiple of 4/8/16
> bytes [1].
> 
> Update the DMA Buffer size define to 8188 instead of 8192. Remove
> the -1 from the RX buffer size allocations and use the new
> DMA Buffer size directly.
> 
> [1] Synopsys DesignWare Cores Ethernet MAC Universal v3.70a
>     [section 8.4.2 - Table 8-24]
> 
> Tested on SoCFPGA Stratix10 with ping sweep from 100 to 8300 byte packets.
> 
> Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
> Suggested-by: Jose Abreu <jose.abreu@synopsys.com>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied.
