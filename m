Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1544C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DE021A8D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE021A8D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbeGGLz1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:55:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbeGGLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:55:25 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 589E912107593;
        Sat,  7 Jul 2018 04:55:23 -0700 (PDT)
Date:   Sat, 07 Jul 2018 20:55:21 +0900 (KST)
Message-Id: <20180707.205521.189537026947491605.davem@davemloft.net>
To:     harini.katakam@xilinx.com
Cc:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, harinikatakamlinux@gmail.com
Subject: Re: [PATCH v2 2/2] net: macb: Allocate valid memory for TX and RX
 BD prefetch
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1530859738-11802-2-git-send-email-harini.katakam@xilinx.com>
References: <1530859738-11802-1-git-send-email-harini.katakam@xilinx.com>
        <1530859738-11802-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 07 Jul 2018 04:55:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>
Date: Fri, 6 Jul 2018 12:18:58 +0530

> GEM version in ZynqMP and most versions greater than r1p07 supports
> TX and RX BD prefetch. The number of BDs that can be prefetched is a
> HW configurable parameter. For ZynqMP, this parameter is 4.
> 
> When GEM DMA is accessing the last BD in the ring, even before the
> BD is processed and the WRAP bit is noticed, it will have prefetched
> BDs outside the BD ring. These will not be processed but it is
> necessary to have accessible memory after the last BD. Especially
> in cases where SMMU is used, memory locations immediately after the
> last BD may not have translation tables triggering HRESP errors. Hence
> always allocate extra BDs to accommodate for prefetch.
> The value of tx/rx bd prefetch for any given SoC version is:
> 2 ^ (corresponding field in design config 10 register).
> (value of this field >= 1)
> 
> Added a capability flag so that older IP versions that do not have
> DCFG10 or this prefetch capability are not affected.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied.
