Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E4CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5001521477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="svi8t7nL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5001521477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeJKXIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDADF213A2;
        Thu, 11 Oct 2018 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272431;
        bh=jmNTm2z6s0yI0Q5AICK9Wlsz82EZa1W6yjdcqrEGr4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svi8t7nL+G1I39brxSX9A2Gq933TLHISXs2NXvvVqiCDN+fGCO1ETmCTL8mImJGvC
         O4GgC9puayWqWIcT0Xgoq2tTYg2G0kL7nqTzhmg/3p32ViiYAlTmfN8jzWGQOvHn2U
         x406HHFHyL0zbtCuZ1cI5+yjW7ZJ8oJz1SIviSCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 068/120] hwmon: (adt7475) Make adt7475_read_word() return errors
Date:   Thu, 11 Oct 2018 17:34:09 +0200
Message-Id: <20181011152552.611398771@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f196dec6d50abb2e65fb54a0621b2f1b4d922995 ]

The adt7475_read_word() function was meant to return negative error
codes on failure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/adt7475.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -274,14 +274,18 @@ static inline u16 volt2reg(int channel,
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
 
-static u16 adt7475_read_word(struct i2c_client *client, int reg)
+static int adt7475_read_word(struct i2c_client *client, int reg)
 {
-	u16 val;
+	int val1, val2;
 
-	val = i2c_smbus_read_byte_data(client, reg);
-	val |= (i2c_smbus_read_byte_data(client, reg + 1) << 8);
+	val1 = i2c_smbus_read_byte_data(client, reg);
+	if (val1 < 0)
+		return val1;
+	val2 = i2c_smbus_read_byte_data(client, reg + 1);
+	if (val2 < 0)
+		return val2;
 
-	return val;
+	return val1 | (val2 << 8);
 }
 
 static void adt7475_write_word(struct i2c_client *client, int reg, u16 val)


