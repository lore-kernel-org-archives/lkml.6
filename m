Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF241C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDF8208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDF8208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387393AbeGKMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:34:36 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:46999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbeGKMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:34:36 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MZsqM-1fND0L0E4U-00LXUS; Wed, 11 Jul 2018 14:30:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Intiyaz Basha <intiyaz.basha@cavium.com>,
        Rick Farrington <ricardo.farrington@cavium.com>,
        Veerasenareddy Burru <veerasenareddy.burru@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Weilin Chang <weilin.chang@cavium.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [RESEND] liquidio: use ktime_get_real_ts64() instead of getnstimeofday64()
Date:   Wed, 11 Jul 2018 14:29:52 +0200
Message-Id: <20180711123003.453442-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:f0Gc1creoeJGRDRruAZySEn3SVXoLVoHTVCD04Mh+oydOkGUi64
 yBU+MGkbfQA6TPR02Lfrxhl80TDD+U0uzhzKseDcQalm/sS3TD1FJicDxyxx6e+TDl+NMwY
 2pqdv07W8u1PK2q8BwPCV4i2LAO3bAL3KDJS6owp5WBq/Mnpk5TL0JT0AvBi+Hrhmpe7WEn
 OTPogzWahdrTicgbkXZ6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uP4fpjTe0Kc=:VIjAXcw2DJNanSxM8UK5hW
 vYJLL7mQKjwr9qSCPjIGANvlxp+GGMBQXcG91YDcIO/Hl1K35Ezg5wkLZzWUGQ3/BWyIiRiTd
 4ogR9sv8K0dfWbZwolVGCKgji0iqitc1+lFNk8xlZw2WffjChXBoRxTQrlw2KzA3cEbe6RvjZ
 AAGhPTNmp7ZATgb5mV5WxAenW2JxTHsVubGHgY6+AKHnhSqDdGmwxmeMTIMIGNDag9gDAYwxg
 Z2gvh3vMSAZlgOsczhqQZ3pSoXrPTFPrGnEQ7WtCXjtulrj4LCZamSIZMeCU5NgZI51qHB/1e
 m3+t10s8Xy+AbTviaWpB9Uuc/5cT7+ozWbODFFZFXrjm3LjVMIRLA/Byk6QqsdaaWomtH/JkK
 9OpRGunnC0CEsi8cPNhjKimaif86cKEep2brpNakN9kYq04HJdxd3N5WwpYCUfMt35sPKQIbt
 l/U0L+VeA9lNkvGaNShAr6vhp8dnzfnlMNKd1vDlmYXOcIhPYnEIHjIalv73btLKMM8J1okGz
 NPzRRhABDH2A1vaHJToB/XpSQjuScZEiWnC2wlBfKxvGygOSJQcNCaZXPz8XIedvU/7+FGE3m
 TIyOs3gsTzK05RYoWwWP9aSxlQK2yEcf/iRugDRfY9k8CFAnzFylXF9XvVynlX+DF9Uv0um4f
 Llu0hnyGqO2xHScK51h6Kff6v9ASuylYGYlQ00h0Wz4Q6jjLRcvmiA3qLq7DUNhr8QPg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two do the same thing, but we want to have a consistent
naming in the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c       | 2 +-
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 19d03fc24305..30884ad0a509 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -687,7 +687,7 @@ static void lio_sync_octeon_time(struct work_struct *work)
 	lt = (struct lio_time *)sc->virtdptr;
 
 	/* Get time of the day */
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 	lt->sec = ts.tv_sec;
 	lt->nsec = ts.tv_nsec;
 	octeon_swap_8B_data((u64 *)lt, (sizeof(struct lio_time)) / 8);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 7f97ae48efed..0cc2338d8d2a 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -902,7 +902,7 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 	 *
 	 * Octeon always uses UTC time. so timezone information is not sent.
 	 */
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
 		       " time_sec=%lld time_nsec=%ld",
 		       (s64)ts.tv_sec, ts.tv_nsec);
-- 
2.9.0

