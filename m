Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dBFRLwxZGVuABgAAmS7hNA
	; Thu, 07 Jun 2018 16:15:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 70682608B8; Thu,  7 Jun 2018 16:15:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DFAA160115;
	Thu,  7 Jun 2018 16:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFAA160115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936139AbeFGQPm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:15:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39097 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932879AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zq-7s; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gf-7W; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Andrey Konovalov" <andreyknvl@google.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Malcolm Priestley" <tvboxspy@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.844335152@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 008/410] media: dvb-usb-v2: lmedm04: move ts2020
 attach to  dm04_lme2510_tuner
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

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 7bf7a7116ed313c601307f7e585419369926ab05 upstream.

When the tuner was split from m88rs2000 the attach function is in wrong
place.

Move to dm04_lme2510_tuner to trap errors on failure and removing
a call to lme_coldreset.

Prevents driver starting up without any tuner connected.

Fixes to trap for ts2020 fail.
LME2510(C): FE Found M88RS2000
ts2020: probe of 0-0060 failed with error -11
...
LME2510(C): TUN Found RS2000 tuner
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb-v2/lmedm04.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -1115,8 +1115,6 @@ static int dm04_lme2510_frontend_attach(
 
 		if (adap->fe[0]) {
 			info("FE Found M88RS2000");
-			dvb_attach(ts2020_attach, adap->fe[0], &ts2020_config,
-					&d->i2c_adap);
 			st->i2c_tuner_gate_w = 5;
 			st->i2c_tuner_gate_r = 5;
 			st->i2c_tuner_addr = 0x60;
@@ -1179,17 +1177,18 @@ static int dm04_lme2510_tuner(struct dvb
 			ret = st->tuner_config;
 		break;
 	case TUNER_RS2000:
-		ret = st->tuner_config;
+		if (dvb_attach(ts2020_attach, adap->fe[0],
+			       &ts2020_config, &d->i2c_adap))
+			ret = st->tuner_config;
 		break;
 	default:
 		break;
 	}
 
-	if (ret)
+	if (ret) {
 		info("TUN Found %s tuner", tun_msg[ret]);
-	else {
-		info("TUN No tuner found --- resetting device");
-		lme_coldreset(d);
+	} else {
+		info("TUN No tuner found");
 		return -ENODEV;
 	}
 
