Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1EDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E107F208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E107F208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbeHWMjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:39:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeHWMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:39:17 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B478B93C;
        Thu, 23 Aug 2018 09:10:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.17 322/324] i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes
Date:   Thu, 23 Aug 2018 09:56:28 +0200
Message-Id: <20180823075012.219795887@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit c463a158cb6c5d9a85b7d894cd4f8116e8bd6be0 upstream.

acpi_gsb_i2c_write_bytes() returns i2c_transfer()'s return value, which
is the number of transfers executed on success, so 1.

The ACPI code expects us to store 0 in gsb->status for success, not 1.

Specifically this breaks the following code in the Thinkpad 8 DSDT:

            ECWR = I2CW = ECWR /* \_SB_.I2C1.BAT0.ECWR */
            If ((ECST == Zero))
            {
                ECRD = I2CR /* \_SB_.I2C1.I2CR */
            }

Before this commit we set ECST to 1, causing the read to never happen
breaking battery monitoring on the Thinkpad 8.

This commit makes acpi_gsb_i2c_write_bytes() return 0 when i2c_transfer()
returns 1, so the single write transfer completed successfully, and
makes it return -EIO on for other (unexpected) return values >= 0.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-acpi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -482,11 +482,16 @@ static int acpi_gsb_i2c_write_bytes(stru
 	msgs[0].buf = buffer;
 
 	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
-	if (ret < 0)
-		dev_err(&client->adapter->dev, "i2c write failed\n");
 
 	kfree(buffer);
-	return ret;
+
+	if (ret < 0) {
+		dev_err(&client->adapter->dev, "i2c write failed: %d\n", ret);
+		return ret;
+	}
+
+	/* 1 transfer must have completed successfully */
+	return (ret == 1) ? 0 : -EIO;
 }
 
 static acpi_status


