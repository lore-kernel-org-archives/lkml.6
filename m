Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B305C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05E3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05E3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeJRMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:47:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54426 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbeJRMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:47:22 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D979913AE1397;
        Wed, 17 Oct 2018 21:48:17 -0700 (PDT)
Date:   Wed, 17 Oct 2018 21:48:17 -0700 (PDT)
Message-Id: <20181017.214817.899061946206965862.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     netanel@amazon.com, saeedb@amazon.com, zorik@amazon.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ena: fix unintended sign extension
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181012194948.GA24925@embeddedor.com>
References: <20181012194948.GA24925@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 21:48:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 12 Oct 2018 21:49:48 +0200

> In the following expression:
> 
> 372                size = io_sq->bounce_buf_ctrl.buffer_size *
> 373                         io_sq->bounce_buf_ctrl.buffers_num;
> 
> both buffer_size and buffers_num are of type u16 (16 bits, unsigned),
> so they are promoted to type int (32 bits, signed) and then
> sign-extended to type size_t.
> 
> Fix this by casting io_sq->bounce_buf_ctrl.buffer_size to size_t in
> order to avoid the sign extension and unintended results.
> 
> Addresses-Coverity-ID: 1474187 ("Unintended sign extension")
> Addresses-Coverity-ID: 1474189 ("Unintended sign extension")
> Fixes: 689b2bdaaa14 ("net: ena: add functions for handling Low Latency Queues in ena_com")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

I don't understand how this can possibly be a real problem, and it looks
therefore like we are just papering over a coverity warning.

I'm not applying this without more information and justification.
