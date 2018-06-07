Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N4UaD9NWGVtecgAAmS7hNA
	; Thu, 07 Jun 2018 16:01:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 27E0A607E7; Thu,  7 Jun 2018 16:01:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D8039601D2;
	Thu,  7 Jun 2018 16:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8039601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbeFGQAm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39315 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933040AbeFGOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:06 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zs-9G; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002vz-18; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Andi Shyti" <andi@etezian.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.433831665@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 163/410] Input: edt-ft5x06 - fix error handling for
 factory mode on non-M06
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 4b3e910d7f430ab76dd37131bb75129878950163 upstream.

When attempting enter factory mode on firmware that does not support it,
we'd error out, but leave the device with interrupts disabled, and thus
touch not working. Fix it by moving the check before we disable
interrupts/allocate memory for debug buffers.

Fixes: fd335ab04b3f ("Input: edt-ft5x06 - add support for M09 firmware version")
Reviewed-by: Andi Shyti <andi@etezian.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[bwh: Backported to 3.16:
 - s/EDT_M06/M06/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/touchscreen/edt-ft5x06.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -491,6 +491,12 @@ static int edt_ft5x06_factory_mode(struc
 	int ret;
 	int error;
 
+	if (tsdata->version != M06) {
+		dev_err(&client->dev,
+			"No factory mode support for non-M06 devices\n");
+		return -EINVAL;
+	}
+
 	disable_irq(client->irq);
 
 	if (!tsdata->raw_buffer) {
@@ -504,9 +510,6 @@ static int edt_ft5x06_factory_mode(struc
 	}
 
 	/* mode register is 0x3c when in the work mode */
-	if (tsdata->version == M09)
-		goto m09_out;
-
 	error = edt_ft5x06_register_write(tsdata, WORK_REGISTER_OPMODE, 0x03);
 	if (error) {
 		dev_err(&client->dev,
@@ -539,11 +542,6 @@ err_out:
 	enable_irq(client->irq);
 
 	return error;
-
-m09_out:
-	dev_err(&client->dev, "No factory mode support for M09\n");
-	return -EINVAL;
-
 }
 
 static int edt_ft5x06_work_mode(struct edt_ft5x06_ts_data *tsdata)
