Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA77208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA77208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755249AbeFRPRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:17:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbeFRPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:17:45 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MZhco-1fn0Dv1GbW-00LTsy; Mon, 18 Jun 2018 17:17:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Intiyaz Basha <intiyaz.basha@cavium.com>,
        Rick Farrington <ricardo.farrington@cavium.com>,
        Veerasenareddy Burru <veerasenareddy.burru@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Weilin Chang <weilin.chang@cavium.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] liquidio: use ktime_get_real_ts64() instead of getnstimeofday64()
Date:   Mon, 18 Jun 2018 17:17:13 +0200
Message-Id: <20180618151724.1406034-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:60jBWTqQzoxAdMwvIGDNit/rqcH7vdAaWkJWWHHY2ih0sTAiTgU
 N8M/IegXuedOyiUpRl7cNT/XxD9nQsuZPOdeO+zktlTiKwpI0yfC9zkR7hIKJ37HqW/9xsr
 D0ARMtoffG0cRMi8e4jEAQMq4b3jsBvd4dq++LTNvLXi8D73JFA7DXfmkY17y3dEfnFHe3E
 9H/YOAL04Si5LMtmW+W/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zEeuOR1Jq9Q=:Oh8AHbyyLV7DjfsgWy1dJA
 hgvIM+LXkge++zVulYrUFlAMy+0nsPt6WHbBOSaVSDKwU8gtClvANbH9DI9D7yEDsnTuWzMHX
 HAPfoxE3Lu5B+DkaW68iEE+zJPSuCqGaM06pr3v0KUWqT+rQoJEzoVyYNXM11TRiTS++rUU1G
 6BfyP5PoLNyb01s6hMQ1IlM+wb5vmc+GgCst6D73aaZgWGDUjTZuH00I0QdHiJT1/W9I6qFiO
 D59iqXTQkdiCGKPCLUpZAeH904MZ6GCYeUxKfsKWDcioz/Blc/J00lj7lMaZ/K8XQsOcjV8C2
 INWcnQJkElbeKAAEZqYFePd5nxjmYWpzLaFtQJ9rnkodJyjK+jxHoYF3fvbiZZpK0+DIu0du8
 TsSu1rprGi1wHSFwHptZ2F//84FZq2jYkVN5ND8bw0qlAX2/vQYRwMxNCtyJ0QWU1D8bH5du8
 kfdJlehPimncFlkMmfNg9J7tgqZoEMY0hg81bs8nzyrfDINxGHnT7q0IO0JfLhc4iHHWEw2t7
 1nSVlXhj7B0vXTzDZQro/XvqS9Da97IjHpXu7/ZiQhZQz17O5cB1X1p3Vh8OIbQHt6WQiOJKy
 KP5zPplPYk+ROE8lSPOeky6cR64j/3l04dGLRBsz6jiJwpAc87wr1CMdcZCAZ9x89HXN8b53c
 /YMvoDOmR3yH9SZJ1JjgfxXOE5w2RoUg9pkIwsEw/hYDfUqcaBaCPvAbbBaPLF6FfVJs=
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
index 8a815bb57177..17a64044ac95 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -684,7 +684,7 @@ static void lio_sync_octeon_time(struct work_struct *work)
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

