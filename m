Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CE620854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="wcPE+zpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CE620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeGTVJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:09:55 -0400
Received: from vern.gendns.com ([206.190.152.46]:50539 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbeGTVJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/SJUeqk1cauFQTqTcQ5loAdeLKEq3VeHzQMjaU2pDoY=; b=wcPE+zpMHL0o/+vGNFOJosMOQ
        SlxgvZGZGC7SnIPbZdFGC/CG2HyblWUsy4T6C2muMcZN23WeNkYqKjtSTK4l18RzrrlP5yunWcgID
        ON8lJr7rTCLk55WTT+NhsWyZzrC3evQ+rMe4vmxqwHykELaifU+fiMLydVEZf6gTedh4pGxsAg3UZ
        zqjaqBYxyRLtudWbDxiKGPDKrEjmZuqFfiGWCP5KK/S2CzUIFm8iNSBmJ/rozA9wmEYmkRGQPO8B7
        6FDL0v7J7WBdTh5FBYBKVb9oR/Mm1FubMuTPeLhA+KmGRdiUihPP7fhi1oot/tXRjCEToSa+rGa8k
        Mo0dbT5Eg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41598 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fgbsf-006e0i-0z; Fri, 20 Jul 2018 16:20:01 -0400
From:   David Lechner <david@lechnology.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: lego_ev3_battery: fix Vce offset
Date:   Fri, 20 Jul 2018 15:19:44 -0500
Message-Id: <20180720201944.20503-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720201944.20503-1-david@lechnology.com>
References: <20180720201944.20503-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the value that accounts for the Vce of a transistor in the
LEGO MINDSTORMS EV3 power supply driver. The old value (200mV) was the
max value from the data sheet. After testing, the actual value has been
found to be 50mV. By using 50mV we get a more accurate voltage
indication.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/lego_ev3_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 6e3b3e384172..1ae3710909b7 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -52,7 +52,7 @@ static int lego_ev3_battery_get_property(struct power_supply *psy,
 			return ret;
 
 		val->intval *= 2000;
-		val->intval += 200000;
+		val->intval += 50000;
 
 		/* plus adjust for shunt resistor drop */
 		ret = iio_read_channel_processed(batt->iio_i, &val2);
-- 
2.17.1

