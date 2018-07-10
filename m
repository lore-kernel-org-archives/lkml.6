Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB6C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725B7208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725B7208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbeGJShB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:37:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390062AbeGJShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:37:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 05620DF2;
        Tue, 10 Jul 2018 18:36:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.17 45/56] i2c: core: smbus: fix a potential missing-check bug
Date:   Tue, 10 Jul 2018 20:25:27 +0200
Message-Id: <20180710182505.723396757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
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

From: Wenwen Wang <wang6495@umn.edu>

commit 8e03477cb709b73a2c1e1f4349ee3b7b33c50416 upstream.

In i2c_smbus_xfer_emulated(), the function i2c_transfer() is invoked to
transfer i2c messages. The number of actual transferred messages is
returned and saved to 'status'. If 'status' is negative, that means an
error occurred during the transfer process. In that case, the value of
'status' is an error code to indicate the reason of the transfer failure.
In most cases, i2c_transfer() can transfer 'num' messages with no error.
And so 'status' == 'num'. However, due to unexpected errors, it is probable
that only partial messages are transferred by i2c_transfer(). As a result,
'status' != 'num'. This special case is not checked after the invocation of
i2c_transfer() and can potentially lead to unexpected issues in the
following execution since it is expected that 'status' == 'num'.

This patch checks the return value of i2c_transfer() and returns an error
code -EIO if the number of actual transferred messages 'status' is not
equal to 'num'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-smbus.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -466,6 +466,8 @@ static s32 i2c_smbus_xfer_emulated(struc
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
 		return status;
+	if (status != num)
+		return -EIO;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {


