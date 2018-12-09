Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B255C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A0020837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLIV4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:56:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36378 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbeLIVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:41 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002po-28; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003W2-Ls; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.352064289@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 211/328] hwmon: (nct6775) Set weight source to zero
 correctly
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit e3f3d7ab00cd459d0f7a839758a4542f4d4b8ac8 upstream.

This is dead code because j can never be 1 at this point.  We had
intended to just test if the bit was clear.

Fixes: bbd8decd4123 ("hwmon: (nct6775) Add support for weighted fan control")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hwmon/nct6775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1331,7 +1331,7 @@ static void nct6775_update_pwm(struct de
 		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
 		data->pwm_weight_temp_sel[i] = reg & 0x1f;
 		/* If weight is disabled, report weight source as 0 */
-		if (j == 1 && !(reg & 0x80))
+		if (!(reg & 0x80))
 			data->pwm_weight_temp_sel[i] = 0;
 
 		/* Weight temp data */

