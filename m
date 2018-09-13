Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01502C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B966E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B966E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbeIMTDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:03:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeIMTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:03:20 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD11BCE7;
        Thu, 13 Sep 2018 13:53:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 055/197] i2c: core: ACPI: Make acpi_gsb_i2c_read_bytes() check i2c_transfer return value
Date:   Thu, 13 Sep 2018 15:30:04 +0200
Message-Id: <20180913131843.728550783@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0a30446c0dca3483c384b54a431cc951e15f7e79 ]

Currently acpi_gsb_i2c_read_bytes() directly returns i2c_transfer's return
value. i2c_transfer returns a value < 0 on error and 2 (for 2 successfully
executed transfers) on success. But the ACPI code expects 0 on success, so
currently acpi_gsb_i2c_read_bytes()'s caller does:

        if (status > 0)
                status = 0;

This commit makes acpi_gsb_i2c_read_bytes() return a value which can be
directly consumed by the ACPI code, mirroring acpi_gsb_i2c_write_bytes(),
this commit also makes acpi_gsb_i2c_read_bytes() explitcly check that
i2c_transfer returns 2, rather then accepting any value > 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-core-acpi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -453,8 +453,12 @@ static int acpi_gsb_i2c_read_bytes(struc
 		else
 			dev_err(&client->adapter->dev, "i2c read %d bytes from client@%#x starting at reg %#x failed, error: %d\n",
 				data_len, client->addr, cmd, ret);
-	} else {
+	/* 2 transfers must have completed successfully */
+	} else if (ret == 2) {
 		memcpy(data, buffer, data_len);
+		ret = 0;
+	} else {
+		ret = -EIO;
 	}
 
 	kfree(buffer);
@@ -595,8 +599,6 @@ i2c_acpi_space_handler(u32 function, acp
 		if (action == ACPI_READ) {
 			status = acpi_gsb_i2c_read_bytes(client, command,
 					gsb->data, info->access_length);
-			if (status > 0)
-				status = 0;
 		} else {
 			status = acpi_gsb_i2c_write_bytes(client, command,
 					gsb->data, info->access_length);


