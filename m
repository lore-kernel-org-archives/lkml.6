Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33151C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D587120652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qm15cJVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeICTKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45469 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeICTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180903144949euoutp02b2b360a68b0a026b4d6162e0862ff231~Q600yoHB90409804098euoutp02b;
        Mon,  3 Sep 2018 14:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180903144949euoutp02b2b360a68b0a026b4d6162e0862ff231~Q600yoHB90409804098euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535986189;
        bh=BUUIxh6GLuxhAm9EJQctazbXmvE15UgCdUY+B/18qnM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=qm15cJVdh0bsaYDzBRbEOfN5YSDTy1+XO+bs0JHTi4baIm+s21cJVwOYPflEOu/pY
         1doB5fiE4iKu1pfuzKAcsGOa/rCQWj1Qi7qucGxkgaIUyhUjaftfrliQERTd2k/mp7
         A4DSGLc71KO0fSYmrgtoMiWbaALjmReohvX4PeH8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180903144949eucas1p229f119d3452b081709f5cceedcadc158~Q600JeoGb3206732067eucas1p28;
        Mon,  3 Sep 2018 14:49:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.63.04441.C0A4D8B5; Mon,  3
        Sep 2018 15:49:48 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180903144948eucas1p2232126205868c2ccf5d40b7b0b70ff64~Q60zX3bb03206732067eucas1p25;
        Mon,  3 Sep 2018 14:49:48 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-c2-5b8d4a0c6cef
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.B9.04284.C0A4D8B5; Mon,  3
        Sep 2018 15:49:48 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEH00LLMIIVL500@eusync4.samsung.com>;
        Mon, 03 Sep 2018 15:49:48 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] regulator: Fix 'do-nothing' value for regulators
 without suspend state
Date:   Mon, 03 Sep 2018 16:49:37 +0200
Message-id: <20180903144937.16507-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20180903144937.16507-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7djPc7o8Xr3RBmenaVlsnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBZrj9xlt5i86CCrA7vHzll32T02repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGV861jMVPBDpOLRq7fMDYxPBLsYOTkkBEwk5s3oZu9i5OIQEljB
        KHFo6XlWCOczo8SC763sMFW/zvRCJZYxSsxZ+p4Jwmlgkvi27x4bSBWbgKFE19suMFtEIFfi
        /ZVfbCBFzAIbGSWmPHoPNkpYIFbiTdsCFhCbRUBV4uWzhUwgNq+ArcSExo1sEOvkJVZvOMAM
        YnMK2Em8/7+XEWSQhEAHm0TDsxdMEEUuElO3/2CBsIUlXh3fAnWrjERnx0EmiIZmRon2GbPY
        IZweRomtc3ZArbCWOHz8IiuIzSzAJzFp23SgdRxAcV6JjjYhiBIPiZ4fC5kh/pwIDJojW5km
        MEouYGRYxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJERiHp/8d/7SD8eulpEOMAhyMSjy8
        AQa90UKsiWXFlbmHGCU4mJVEeBvdgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+bTSooUE0hNL
        UrNTUwtSi2CyTBycUg2MqxM2/79Wls2WVShzN/e4nqLv1OYoRh69G8G7d4jv3zpb6Z79u/WK
        DerWjC55KyvU2m+nm2abeMa/WXT0oXXZW1POuzx77+V9nqESL7zivK391MAKp02Lhb9tqP4V
        eb6E+1+I95mF9858NeP8Jv+3i9+s3LXdaJd8yf1Dc1RO3FmXuNyuXsRRiaU4I9FQi7moOBEA
        9IBytL8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgluLIzCtJLcpLzFFi42I5/e/4NV0er95og5aT3BYbZ6xntZj68Amb
        xbcrHUwWl3fNYbOYcX4fk8XaI3fZLSYvOsjqwO6xc9Zddo9NqzrZPO5c28Pm0bdlFaPH501y
        AaxRXDYpqTmZZalF+nYJXBnfOhYzFfwQqXj06i1zA+MTwS5GTg4JAROJX2d6WbsYuTiEBJYw
        Spw/1gDlNDFJbL6xhgWkik3AUKLrbRcbiC0ikCux/1onE0gRs8BmRon/uw8wgiSEBWIlpu2e
        wg5iswioSrx8tpAJxOYVsJWY0LiRDWKdvMTqDQeYQWxOATuJ9//3gvUKAdVcvreKdQIjzwJG
        hlWMIqmlxbnpucWGesWJucWleel6yfm5mxiB4bPt2M/NOxgvbQw+xCjAwajEwxtg0BstxJpY
        VlyZe4hRgoNZSYS30R0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPe8QWWUkEB6YklqdmpqQWoR
        TJaJg1OqgTG57c+29cr3n9jf3ppb6PFl+bwz3u3clVueN09MZdpklXlD+9zKf/KH2UPMcncW
        SL21OXi31U2jgcHy289vh+NmZXB6bA298bXm6qU56uaCPl1zX+t9OZ9bFX1K8cUHu0wXLeYt
        a74tEpeNP6S4j7l7R2+xeXyd8+8mriPRMafu3nH9EVqo56PEUpyRaKjFXFScCAAFJXYvGwIA
        AA==
X-CMS-MailID: 20180903144948eucas1p2232126205868c2ccf5d40b7b0b70ff64
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903144948eucas1p2232126205868c2ccf5d40b7b0b70ff64
References: <20180903144937.16507-1-m.szyprowski@samsung.com>
        <CGME20180903144948eucas1p2232126205868c2ccf5d40b7b0b70ff64@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators don't have all states defined and in such cases regulator
core should not assume anything. However in current implementation
of of_get_regulation_constraints() DO_NOTHING_IN_SUSPEND enable value was
set only for regulators which had suspend node defined, otherwise the
default 0 value was used, what means DISABLE_IN_SUSPEND. This lead to
broken system suspend/resume on boards, which had simple regulator
constraints definition (without suspend state nodes).

To avoid further mismatches between the default and uninitialized values
of the suspend enabled/disabled states, change the values of the them,
so default '0' means DO_NOTHING_IN_SUSPEND.

Fixes: 72069f9957a1: regulator: leave one item to record whether regulator is enabled
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c          | 2 +-
 drivers/regulator/of_regulator.c  | 2 --
 include/linux/regulator/machine.h | 6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 71ba040c7c5b..d1485ed98509 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3161,7 +3161,7 @@ static inline int regulator_suspend_toggle(struct regulator_dev *rdev,
 	if (!rstate->changeable)
 		return -EPERM;
 
-	rstate->enabled = en;
+	rstate->enabled = (en) ? ENABLE_IN_SUSPEND : DISABLE_IN_SUSPEND;
 
 	return 0;
 }
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 638f17d4c848..210fc20f7de7 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -213,8 +213,6 @@ static void of_get_regulation_constraints(struct device_node *np,
 		else if (of_property_read_bool(suspend_np,
 					"regulator-off-in-suspend"))
 			suspend_state->enabled = DISABLE_IN_SUSPEND;
-		else
-			suspend_state->enabled = DO_NOTHING_IN_SUSPEND;
 
 		if (!of_property_read_u32(np, "regulator-suspend-min-microvolt",
 					  &pval))
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 3468703d663a..a459a5e973a7 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -48,9 +48,9 @@ struct regulator;
  * DISABLE_IN_SUSPEND	- turn off regulator in suspend states
  * ENABLE_IN_SUSPEND	- keep regulator on in suspend states
  */
-#define DO_NOTHING_IN_SUSPEND	(-1)
-#define DISABLE_IN_SUSPEND	0
-#define ENABLE_IN_SUSPEND	1
+#define DO_NOTHING_IN_SUSPEND	0
+#define DISABLE_IN_SUSPEND	1
+#define ENABLE_IN_SUSPEND	2
 
 /* Regulator active discharge flags */
 enum regulator_active_discharge {
-- 
2.17.1

