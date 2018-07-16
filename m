Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39365ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C1F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C1F20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeGPIEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeGPIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D3D3C03;
        Mon, 16 Jul 2018 07:38:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.17 47/67] i2c: recovery: if possible send STOP with recovery pulses
Date:   Mon, 16 Jul 2018 09:35:16 +0200
Message-Id: <20180716073450.669892751@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
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

commit abe41184abac487264a4904bfcff2d5500dccce6 upstream.

I2C clients may misunderstand recovery pulses if they can't read SDA to
bail out early. In the worst case, as a write operation. To avoid that
and if we can write SDA, try to send STOP to avoid the
misinterpretation.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-base.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -198,7 +198,16 @@ int i2c_generic_scl_recovery(struct i2c_
 
 		val = !val;
 		bri->set_scl(adap, val);
-		ndelay(RECOVERY_NDELAY);
+
+		/*
+		 * If we can set SDA, we will always create STOP here to ensure
+		 * the additional pulses will do no harm. This is achieved by
+		 * letting SDA follow SCL half a cycle later.
+		 */
+		ndelay(RECOVERY_NDELAY / 2);
+		if (bri->set_sda)
+			bri->set_sda(adap, val);
+		ndelay(RECOVERY_NDELAY / 2);
 	}
 
 	/* check if recovery actually succeeded */


