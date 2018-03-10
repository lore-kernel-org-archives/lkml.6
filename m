Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeCJVdr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 16:33:47 -0500
Received: from mout.web.de ([212.227.15.14]:42983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbeCJVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 16:33:45 -0500
Subject: [PATCH 3/3] wlcore: Use common error handling code in
 wl1271_acx_sta_rate_policies()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Message-ID: <7d5cc7b4-f0ce-192a-3e5e-c2944c1e3e3d@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5db0825-394a-1d6d-351a-43be14e4c6b4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qPmk5sZgIjrjUmBIWaiTaTC4wi5HoHHUC9Jc8IEcfu8yFwsbyTf
 D98BL/kUIMYp/C57BhR8dQyGwTOdPGl8waP/WHht+fosP6bj3GFtRyWCHWmPZTIE/tZ2OMv
 xuetODZKxh8/lfk8HSGPJiAdoPrhGHEdU15TVMhZqbmLmIqxEaAFcFqf+JGqwTNII7dBV5+
 W+sLaXIfqofS/zgzxksxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pB7D1iG8nyM=:qSpID9McHeZSN0UIwyNPDl
 Ksc4uljcW6E8wSagVPaHonBisErOS++s+fzX+bSFDFbtsrb+R/F4ePrXZl6LTJUI58hpDm2u8
 MFGRLa/5S/YaMJDJlQVJTobSDyUedObsoxLYPIH2YrckA7z+E7FrwmnUsi21JdRP2ZVPqDAmi
 xe3t5NuhdZVrlBvmAgQukltaeAvppL8p9C6NFxT+JZ97DS9hxO/TClzKiHsVMeViomiAUm2ep
 hU4XC2U5PdLMUrpGs8Mx1gyP/KUM5lugBP7ozjxGFOtgF6/3qZbxR+9HIIErXfOvs7bcXPOZr
 L6A2kcuGEg46GdHEIqa1GZ8P2nK2kK0eGoA6qoui87p990LhpsrIDQHqZERBJnp45yXItY/xq
 NgfQPwaeXcstYgPkC8pEg4jkZkWEEnhaHV3VbAkkhJ0FiQh1JAZSgBq04kQc+8m3N2hMhvVhZ
 Ajd/k3cveB1ASGzEyYhREA23npNKjE1OSYwCrmeIeqb9/DY6mGWQc19mqvY4jQ8vx5hRxJHwy
 kvmR6Z/txF16cFLKD+n4aVDu80DRY0KsULMAoKzPxHJyDGMlwPyg2mOPGxyl+5da4qWJpa4uN
 wBKNLRhP7WMCVJu81df3SnS34G0b2QTeFsxNxF2xOfNniDFtIhnnPk8iWaBCU7UuPyZ8BmQWO
 RkC5dZ7E4TIEhw41ngbl67IXtwtp4j13Ugycn9Av8DvvsxTm1LoxR1ZIjSzoDI9HmB3PZVy6Z
 iSAVBHcEKqy+ZR3tesX8gdDXj9eVroWWLsAUZdJr0yakalDGKgc6jYVZm0/86TJvMvTofld21
 I5RhVmP6JqZHpWU8h3vs5n+E865sVIv1FQ9+QMWvls5MXgNR8A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 22:18:45 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/wireless/ti/wlcore/acx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/acx.c b/drivers/net/wireless/ti/wlcore/acx.c
index 1cc5bba670e1..7d37a417c756 100644
--- a/drivers/net/wireless/ti/wlcore/acx.c
+++ b/drivers/net/wireless/ti/wlcore/acx.c
@@ -757,10 +757,8 @@ int wl1271_acx_sta_rate_policies(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	acx->rate_policy.aflags = c->aflags;
 
 	ret = wl1271_cmd_configure(wl, ACX_RATE_POLICY, acx, sizeof(*acx));
-	if (ret < 0) {
-		wl1271_warning("Setting of rate policies failed: %d", ret);
-		goto out;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	/* configure one AP supported rate class */
 	acx->rate_policy_idx = cpu_to_le32(wlvif->sta.ap_rate_idx);
@@ -773,10 +771,8 @@ int wl1271_acx_sta_rate_policies(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	acx->rate_policy.aflags = c->aflags;
 
 	ret = wl1271_cmd_configure(wl, ACX_RATE_POLICY, acx, sizeof(*acx));
-	if (ret < 0) {
-		wl1271_warning("Setting of rate policies failed: %d", ret);
-		goto out;
-	}
+	if (ret < 0)
+		goto report_failure;
 
 	/*
 	 * configure one rate class for basic p2p operations.
@@ -791,14 +787,16 @@ int wl1271_acx_sta_rate_policies(struct wl1271 *wl, struct wl12xx_vif *wlvif)
 	acx->rate_policy.aflags = c->aflags;
 
 	ret = wl1271_cmd_configure(wl, ACX_RATE_POLICY, acx, sizeof(*acx));
-	if (ret < 0) {
-		wl1271_warning("Setting of rate policies failed: %d", ret);
-		goto out;
-	}
+	if (ret < 0)
+		goto report_failure;
 
-out:
+free_acx:
 	kfree(acx);
 	return ret;
+
+report_failure:
+	wl1271_warning("Setting of rate policies failed: %d", ret);
+	goto free_acx;
 }
 
 int wl1271_acx_ap_rate_policy(struct wl1271 *wl, struct conf_tx_rate_class *c,
-- 
2.16.2
