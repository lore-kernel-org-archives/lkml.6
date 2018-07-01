Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38022C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E780325424
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E780325424
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeGAQqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965954AbeGAQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4F0DEA73;
        Sun,  1 Jul 2018 16:46:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Larin <cerg2010cerg2010@mail.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.17 206/220] Revert "i2c: algo-bit: init the bus to a known state"
Date:   Sun,  1 Jul 2018 18:23:50 +0200
Message-Id: <20180701160916.771492910@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2a2c8ee2d72c4f1ba0f7fbb02dc74f971df0f934 upstream.

This reverts commit 3e5f06bed72fe72166a6778f630241a893f67799. As per
bugzilla #200045, this caused a regression. I don't really see a way to
fix it without having the hardware. So, revert the patch and I will fix
the issue I was seeing originally in the i2c-gpio driver itself. I
couldn't find new users of this algorithm since, so there should be no
one depending on the new behaviour.

Reported-by: Sergey Larin <cerg2010cerg2010@mail.ru>
Fixes: 3e5f06bed72f ("i2c: algo-bit: init the bus to a known state")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Sergey Larin <cerg2010cerg2010@mail.ru>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/algos/i2c-algo-bit.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -649,11 +649,6 @@ static int __i2c_bit_add_bus(struct i2c_
 	if (bit_adap->getscl == NULL)
 		adap->quirks = &i2c_bit_quirk_no_clk_stretch;
 
-	/* Bring bus to a known state. Looks like STOP if bus is not free yet */
-	setscl(bit_adap, 1);
-	udelay(bit_adap->udelay);
-	setsda(bit_adap, 1);
-
 	ret = add_adapter(adap);
 	if (ret < 0)
 		return ret;


