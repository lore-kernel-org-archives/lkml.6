Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9458BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EC22089B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EC22089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeGKMt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:49:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51846 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:49:28 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MTL2h-1fTVRV3hSB-00SOYN; Wed, 11 Jul 2018 14:44:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] firewire: use 64-bit time_t based interfaces
Date:   Wed, 11 Jul 2018 14:44:42 +0200
Message-Id: <20180711124456.1023039-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:o1AIODU37O5wgCLgawhC4au4MwpuxaHxlYWMv+7fowyQSv+Zy+N
 P6syUZKnuyFr9Ztd9xIarQUrnxq0xw8AbWJgioq9wouylwDkOq5voPoojpb7GyDw+ZNeGBp
 iJipePfBeyEsUshZuLMuXD19NoBr305IQG0Jf/UsyhEwsjsnzCiLFq2y8wl20B/zjn81EFq
 jnqkBMJcR4df+SCPqbR2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LdpBKiM93TU=:TW+kLa40CsW0xYjfqzDgls
 bq7f2neiZqWD0OlRsmP+MKYYHcaVvlqnggRw++cXM2jlm8VBLI6BabiMuKQThC9gLCNIpOvXq
 Gsq/tHYu4K/Z6SMyttuo7WnHQxtHFxK5XeRu+7diVQT2uE2MGe92KIMK1TIUohm9FG+9uFmx1
 Oq7sCfWwLEMAclvtfNcruQRlZ3fE5/tI/DjLQnPAKgkdl4cQBBujXwyJEVCzDqquf8tWyibaC
 u7eSKrSCK9OW+0rBancdgpJpWiLIT02ysMbAy1l6d9gQswU8kySqQDm6m4EMprD42GlfI8Ydv
 xaJV7YNjy41pS395BCJbcgk0Ame3rrKVti0KLYvOXl0vD0vUm3ihnk4uSdTeJWvUdO7Mx1KNe
 IN28OeeIWN53gDDeD6a1xuJZmvaYYviXilS/6FbOjjns8mOBtWzjYPQi01q3aPsCC7wtNsDMm
 /9S7Jkv5Vcg+YyuRhoTRxTAoCpMj4BFCI+q7Z5hhFnckZCugdHajGxNXihvZkp0udrStlkz+s
 CAU9iqRVv5h8vXtupmvHI9Jh4uoPGbmdrdEGVGwKqDimukbGc9nQJPv2bdYaehICTRKdZzvX3
 R0Df4vuoKBFQLVUMPCD3xsK0yNmX9OedWhHruFH0opvB0k2EPzinF8GL+PZFbJZ/MAxryo6TX
 5vdKhhOusb57KSob3s92QIHIz5Z41RksYUuf1x+KlwDo80oEp0FF50MBmDQRjfO5zO7s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit CLOCK_REALTIME timestamps overflow in year 2038, so all such interfaces
are deprecated now. For the FW_CDEV_IOC_GET_CYCLE_TIMER2 ioctl, we already
support 64-bit timestamps, but the implementation still uses timespec.

This changes the code to use timespec64 instead with the appropriate
accessor functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sent originally on Jun 18, but got not reply.

I notice that Stefan Richter has not been active on the mailing lists
since February 2018.

Andrew, could you pick it up in the meantime?
---
 drivers/firewire/core-cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index f0587273940e..d8e185582642 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1205,7 +1205,7 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 {
 	struct fw_cdev_get_cycle_timer2 *a = &arg->get_cycle_timer2;
 	struct fw_card *card = client->device->card;
-	struct timespec ts = {0, 0};
+	struct timespec64 ts = {0, 0};
 	u32 cycle_time;
 	int ret = 0;
 
@@ -1214,9 +1214,9 @@ static int ioctl_get_cycle_timer2(struct client *client, union ioctl_arg *arg)
 	cycle_time = card->driver->read_csr(card, CSR_CYCLE_TIME);
 
 	switch (a->clk_id) {
-	case CLOCK_REALTIME:      getnstimeofday(&ts);	break;
-	case CLOCK_MONOTONIC:     ktime_get_ts(&ts);	break;
-	case CLOCK_MONOTONIC_RAW: getrawmonotonic(&ts);	break;
+	case CLOCK_REALTIME:      ktime_get_real_ts64(&ts);	break;
+	case CLOCK_MONOTONIC:     ktime_get_ts64(&ts);		break;
+	case CLOCK_MONOTONIC_RAW: ktime_get_raw_ts64(&ts);	break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.9.0

