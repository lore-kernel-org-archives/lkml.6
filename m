Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C14CC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E3620652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tb9Ky6JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E3620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeIHQ7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:59:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55125 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbeIHQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:59:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so17082409wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D2eLoesu0VK8dxVlq2VwMc8ftCc1a8pSYQGBZr8c33E=;
        b=tb9Ky6JP4jtb6MFQO3buwscM15cPcdyb0/aToJPuICxSQR9JI5xDoAwIFrt3UoRu9Y
         MO6sn3llwQO0FlVmSzyMgUdDX1Hi29wrQqFLsQrsNy1mfT8fi5cu9KVXuITiQ78vUgMV
         tCljD1oi2q5zwHNyuMhixQt8VwW1LG2ywdpaAxwXacr+Q64ZxPpWi0v4B99HX165WyMM
         7/skuxCP7modN3amlgHQUM22vRxmCYiaUjGQieZDsWgihlcO0LkVzMMe4plgaRprfCg/
         nebBLF5NsEUnbQJO1OxuSKZimgmY6PjCCS09m06yvjslSgeV1JXNsV9sGRFe7YOhsapD
         q1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D2eLoesu0VK8dxVlq2VwMc8ftCc1a8pSYQGBZr8c33E=;
        b=OVMAu9HYfK7psHaOw88CGyNHNLOzGsq/8q+so/wltV+ZejevqslaLs76ZGuwsG6nCP
         kp5POuZzIIa1ppn3QK7InX+jNv0nkv6YDm0w4UYb268LQj5fR7ljhugS9TnFrYb4+XuZ
         5o6zHr6XTLX+Gg/vX6gUkTFn6XfP48NCvyr/uy0KxAfBHiO5PWs71iW4+lzzdhNRMKjA
         T0bhQrURNCy0PZYFyNCRHx8YGKO8VCYXJTyotkUgR+T/5jQTcjVVg2Fc0+pVDSJiAdnT
         shj2WlPBRnXBm5ciH6wjU+DlmH9nJG689Se/IoLnrqGzpvMroMnKTdI9ss674R4FXy1j
         hIog==
X-Gm-Message-State: APzg51C7AhPSkyYoNwDBNZmU3S+SP8oUQRjUucsksfO/9dkBpOcrGzAx
        O0wcd2iCxq9nQjVHkKqjHi1TZePF
X-Google-Smtp-Source: ANB0Vdb99PSbMVk+CpG+xiQ4T4qbczUDjgMG56V7stOSssrZ5lWxjlq5Uf2AXjQwpTxLS3/m5pDOlg==
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr7111154wme.122.1536408844330;
        Sat, 08 Sep 2018 05:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id z4-v6sm9096458wrt.89.2018.09.08.05.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 05:14:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8188eu: refactor SwLedControlMode1()
Date:   Sat,  8 Sep 2018 14:13:51 +0200
Message-Id: <20180908121353.16137-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor switch cases in SwLedControlMode1() to reduce
indentation level. Also clears line over 80 characters
checkpatch warnings.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_led.c | 223 ++++++++++++-----------
 1 file changed, 113 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_led.c b/drivers/staging/rtl8188eu/core/rtw_led.c
index cbef871a7679..217a1aaab8a1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_led.c
+++ b/drivers/staging/rtl8188eu/core/rtw_led.c
@@ -245,131 +245,134 @@ static void SwLedControlMode1(struct adapter *padapter, enum LED_CTL_MODE LedAct
 	case LED_CTL_POWER_ON:
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
-		if (!pLed->bLedNoLinkBlinkInProgress) {
-			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedBlinkInProgress = false;
-			}
-
-			pLed->bLedNoLinkBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_SLOWLY;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		if (pLed->bLedNoLinkBlinkInProgress)
+			break;
+		if (pLed->CurrLedState == LED_BLINK_SCAN ||
+		    IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedBlinkInProgress = false;
 		}
+		pLed->bLedNoLinkBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_SLOWLY;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_LINK:
-		if (!pLed->bLedLinkBlinkInProgress) {
-			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedBlinkInProgress = false;
-			}
-			pLed->bLedLinkBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_NORMAL;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+		if (pLed->bLedLinkBlinkInProgress)
+			break;
+		if (pLed->CurrLedState == LED_BLINK_SCAN ||
+		    IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedNoLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedBlinkInProgress = false;
 		}
+		pLed->bLedLinkBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_NORMAL;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_SITE_SURVEY:
-		if ((pmlmepriv->LinkDetectInfo.bBusyTraffic) && (check_fwstate(pmlmepriv, _FW_LINKED))) {
-			;
-		} else if (!pLed->bLedScanBlinkInProgress) {
-			if (IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedBlinkInProgress = false;
-			}
-			pLed->bLedScanBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_SCAN;
-			pLed->BlinkTimes = 24;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		if (pmlmepriv->LinkDetectInfo.bBusyTraffic &&
+		    check_fwstate(pmlmepriv, _FW_LINKED))
+			break;
+		if (pLed->bLedScanBlinkInProgress)
+			break;
+		if (IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedNoLinkBlinkInProgress = false;
 		}
+		if (pLed->bLedLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedBlinkInProgress = false;
+		}
+		pLed->bLedScanBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_SCAN;
+		pLed->BlinkTimes = 24;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_TX:
 	case LED_CTL_RX:
-		if (!pLed->bLedBlinkInProgress) {
-			if (pLed->CurrLedState == LED_BLINK_SCAN || IS_LED_WPS_BLINKING(pLed))
-				return;
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedLinkBlinkInProgress = false;
-			}
-			pLed->bLedBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_TXRX;
-			pLed->BlinkTimes = 2;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+		if (pLed->bLedBlinkInProgress)
+			break;
+		if (pLed->CurrLedState == LED_BLINK_SCAN ||
+		    IS_LED_WPS_BLINKING(pLed))
+			return;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedNoLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedLinkBlinkInProgress = false;
 		}
+		pLed->bLedBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_TXRX;
+		pLed->BlinkTimes = 2;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
-		if (!pLed->bLedWPSBlinkInProgress) {
-			if (pLed->bLedNoLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedNoLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedLinkBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				 pLed->bLedLinkBlinkInProgress = false;
-			}
-			if (pLed->bLedBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedBlinkInProgress = false;
-			}
-			if (pLed->bLedScanBlinkInProgress) {
-				del_timer_sync(&pLed->BlinkTimer);
-				pLed->bLedScanBlinkInProgress = false;
-			}
-			pLed->bLedWPSBlinkInProgress = true;
-			pLed->CurrLedState = LED_BLINK_WPS;
-			if (pLed->bLedOn)
-				pLed->BlinkingLedState = RTW_LED_OFF;
-			else
-				pLed->BlinkingLedState = RTW_LED_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		if (pLed->bLedWPSBlinkInProgress)
+			break;
+		if (pLed->bLedNoLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedNoLinkBlinkInProgress = false;
 		}
+		if (pLed->bLedLinkBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			 pLed->bLedLinkBlinkInProgress = false;
+		}
+		if (pLed->bLedBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedBlinkInProgress = false;
+		}
+		if (pLed->bLedScanBlinkInProgress) {
+			del_timer_sync(&pLed->BlinkTimer);
+			pLed->bLedScanBlinkInProgress = false;
+		}
+		pLed->bLedWPSBlinkInProgress = true;
+		pLed->CurrLedState = LED_BLINK_WPS;
+		if (pLed->bLedOn)
+			pLed->BlinkingLedState = RTW_LED_OFF;
+		else
+			pLed->BlinkingLedState = RTW_LED_ON;
+		mod_timer(&pLed->BlinkTimer, jiffies +
+			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedNoLinkBlinkInProgress) {
-- 
2.18.0

