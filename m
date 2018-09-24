Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D69ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5DE208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5DE208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeIXSRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:17:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbeIXSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:17:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12B9810A7;
        Mon, 24 Sep 2018 12:15:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 068/173] i2c: aspeed: Fix initial values of master and slave state
Date:   Mon, 24 Sep 2018 13:51:42 +0200
Message-Id: <20180924113121.043570764@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 517fde0eb5a8f46c54ba6e2c36e32563b23cb14f ]

This patch changes the order of enum aspeed_i2c_master_state and
enum aspeed_i2c_slave_state defines to make their initial value to
ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
In case of multi-master use, if a slave data comes ahead of the
first master xfer, master_state starts from an invalid state so
this change fixes the issue.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-aspeed.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -110,22 +110,22 @@
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
 
 enum aspeed_i2c_master_state {
+	ASPEED_I2C_MASTER_INACTIVE,
 	ASPEED_I2C_MASTER_START,
 	ASPEED_I2C_MASTER_TX_FIRST,
 	ASPEED_I2C_MASTER_TX,
 	ASPEED_I2C_MASTER_RX_FIRST,
 	ASPEED_I2C_MASTER_RX,
 	ASPEED_I2C_MASTER_STOP,
-	ASPEED_I2C_MASTER_INACTIVE,
 };
 
 enum aspeed_i2c_slave_state {
+	ASPEED_I2C_SLAVE_STOP,
 	ASPEED_I2C_SLAVE_START,
 	ASPEED_I2C_SLAVE_READ_REQUESTED,
 	ASPEED_I2C_SLAVE_READ_PROCESSED,
 	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
 	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
-	ASPEED_I2C_SLAVE_STOP,
 };
 
 struct aspeed_i2c_bus {


