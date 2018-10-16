Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FCA21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrRWkqem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FCA21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeJQBGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E512089E;
        Tue, 16 Oct 2018 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710080;
        bh=3kBSpaQEuQOjB/QOOoZayXvPe6DGuUjwbPkRVKkF5hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrRWkqem4iYTv952Lr8+ASw0U28wQHWw+f2Z3fnTPh8xUdossFsYKOb/WQMrdOTOp
         fjCmFrV1C3p2pN8iqMthc+poah1zdGe3oW8vVS+YoGWRibnUgqBQHL2UZ2XoWJ/8VC
         fgbUaBnViXFsuC/MLx1OUDYRr+mc3eCa1XOV4Z4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Kern <ulteq@web.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 096/135] hwmon: (nct6775) Use different register to get fan RPM for fan7
Date:   Tue, 16 Oct 2018 19:05:26 +0200
Message-Id: <20181016170521.971892527@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 55066354285b36ee09dc50e2527f43a97c567177 ]

The documented register to retrieve the fan RPM for fan7 is found
to be unreliable at least with NCT6796D revision 3. Let's use
register 0x4ce instead. This is undocumented for NCT6796D, but
documented for NCT6797D and NCT6798D and known to be working.

Reported-by: Robert Kern <ulteq@web.de>
Cc: Robert Kern <ulteq@web.de>
Fixes: 81820059a428 ("hwmon: (nct6775) Add support for NCT6796D")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct6775.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -502,7 +502,7 @@ static const s8 NCT6779_BEEP_BITS[] = {
 	30, 31 };			/* intrusion0, intrusion1 */
 
 static const u16 NCT6779_REG_FAN[] = {
-	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x660 };
+	0x4c0, 0x4c2, 0x4c4, 0x4c6, 0x4c8, 0x4ca, 0x4ce };
 static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] = {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
 
@@ -1293,7 +1293,7 @@ static bool is_word_sized(struct nct6775
 		  reg == 0x402 ||
 		  reg == 0x63a || reg == 0x63c || reg == 0x63e ||
 		  reg == 0x640 || reg == 0x642 || reg == 0x64a ||
-		  reg == 0x64c || reg == 0x660 ||
+		  reg == 0x64c ||
 		  reg == 0x73 || reg == 0x75 || reg == 0x77 || reg == 0x79 ||
 		  reg == 0x7b || reg == 0x7d;
 	}


