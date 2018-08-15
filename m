Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709B8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE447208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE447208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeHOUoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:44:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeHOUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:44:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LmuL6-1gM3R948J2-00hA3r; Wed, 15 Aug 2018 19:50:44 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Yue Haibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
Date:   Wed, 15 Aug 2018 19:49:49 +0200
Message-Id: <20180815175040.3736548-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:tSzZemHT10KfpkLtaIhFGirWgJ144J13z1wkDi7DwUo+0qd6qKf
 S2LSF2ZJpXodlqWgviP3tMyVqgBzskQOiGec46SMRK8vgnLYagGhKZUPhhgJQGb8cnocVk0
 45d/XY8e95a4ZGa+qPVpC30fb9Y/nTi9O5ELpXoPnIrYDuEDmqTe4WWopEbyITCw0d9P7I3
 DMGFmKe4ePv1m1VTuzxpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WboZMbevWSc=:orvnJv6E4dbSiPYbWK/D6D
 SiGBr1LRd40rJcD6/ihtFEw8OOKHPMTCfqHTOkJ0C+rg4XZGV5cfpdZSXXXJbXFZ9UIwYuxhy
 CVe60za1RV0Zfuj0xrbv0wsPI8BOjHfyruVzM6JNSWAUd5+wvRDrciC/UeNynYcq6ZbgBd3dU
 ZvIGn244+7hZsYBBLXUU1hHuM0Ac/FoZf1tRSqRPCV3tpf6yCYbkPAbUZIYncl12E+gwBU3uP
 BBEA7fh0L3528i4qeNbBq4FkK/x+9VLP2PNemegPKyW2feKanRsBhB7qdfy9boralEggl7Kpz
 emzOWzEM2vNI7TmHS1oQZn7JSlvriYaanUAc5smo03M+bveNpKbU15DD4BSnLaksWtoHqsN2O
 HChGKdlfoZv75zgd1lJamyKsClziIw0gVCMvcvSlPwdxPQRvK4C9hpYWf7AY+Fx7hciGIb6pP
 AdFu9eQQ953UcLe+dGh3LkYSSanNISriDFwYMHxjvxp3hyxpOyWFVfjpGAiIoDu8rDxs2wTej
 aL4f5bUZfPcPJXJkwb3q4wCqd/wOZUS/L/naSdSDfA+mJ7ROR5bcma85nggFwrRsPgP3WE57P
 LbXNLtnnCtq2rsb73615saKx7spA+7XMdtbMOmiH5ROo1PeQ+VrKpEn+0Gjso5S/ioQZqk8Ny
 U6I1sk7D8ymcbFzrTG9yO0J8dfaYLq6CD1Yf7ot2WzN4hGJ3Sa7I2NJkRKbYGK4KzFAU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timekeeping_clocktai64() has been renamed to ktime_get_clocktai_ts64()
for consistency with the other ktime_get_* access functions.

Rename the new caller that has come up as well.

Question: this is the only ptp driver that sets the hardware time
to the current system time in TAI. Why does it do that?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/microchip/lan743x_ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 029a2af90d5e..0e851fa3e0cc 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -832,8 +832,7 @@ static void lan743x_ptp_sync_to_system_clock(struct lan743x_adapter *adapter)
 {
 	struct timespec64 ts;
 
-	memset(&ts, 0, sizeof(ts));
-	timekeeping_clocktai64(&ts);
+	ktime_get_clocktai_ts64(&ts);
 
 	lan743x_ptp_clock_set(adapter, ts.tv_sec, ts.tv_nsec, 0);
 }
-- 
2.18.0

