Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50430C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F9F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="njHRf7oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F9F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeK3XLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:11:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55026 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeK3XLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:11:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181130120231euoutp02b74ca89398e5882a80533eeaae6a34de~r5T37yX7w1090810908euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:02:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181130120231euoutp02b74ca89398e5882a80533eeaae6a34de~r5T37yX7w1090810908euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543579351;
        bh=Z4CGJ14WtfybGXs/Qu45gREy3sZEYMWP3/MaWou4ruw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njHRf7oRpMJtz4/IqFqrjN+HAug4s/OP92SJxJ98G6tDzBZmMlX2UKJI3wq3lVkXR
         KK58vWdmL/jb0K7BGQ3KGuNuAFc5GzrD3yhrs+w41kohoUoeQ9YQk+XIE6ykVXC2NR
         Gfv9SXIe7yU5xlbaYarQfl4XqVtouEc2O5d9Uxfc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181130120230eucas1p198fed9cacd4f72890d4fe39361f6f68a~r5T3KXC-g1333813338eucas1p1F;
        Fri, 30 Nov 2018 12:02:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D6.BE.04806.6D6210C5; Fri, 30
        Nov 2018 12:02:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181130120230eucas1p28cfa1960874470828230d288830f6974~r5T2Xa7Y10360203602eucas1p21;
        Fri, 30 Nov 2018 12:02:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181130120229eusmtrp2cc865aa031bc4cb1543e1956f68fe051~r5T2Hqwkq2249222492eusmtrp2n;
        Fri, 30 Nov 2018 12:02:29 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-d5-5c0126d66611
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.A1.04128.5D6210C5; Fri, 30
        Nov 2018 12:02:29 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181130120229eusmtip2d4668d4dd19400f0fc6a5e3ddac67421~r5T1f5TEP0089000890eusmtip2z;
        Fri, 30 Nov 2018 12:02:29 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] drm/exynos: mixer: Use colorimetry helper function
Date:   Fri, 30 Nov 2018 13:02:12 +0100
Message-Id: <1543579332-16609-3-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87rX1BhjDKa8UrHoPXeSyeL47qWM
        Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
        8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
        yypGj8+b5AI4o7hsUlJzMstSi/TtErgyXs45ylzwjb3iQttt5gbGh2xdjJwcEgImEu9nf2Hu
        YuTiEBJYwSix4/5dNgjnC6PEzpd3WCGcz4wSZ1sfsMK0vPmzHaplOaPE95NH2eFabt1cwQxS
        xSZgKnH77iewJSICyhJ/J65iBCliFljDItF4exvYKGEBd4mrV1aBNbAIqEp8n98PFOfg4BXw
        kOg8ag+xTU7i5rlOsBJOAU+JS9vfgG2WEDjGLvH26W6oL1wkpt68xQhhC0u8Or6FHcKWkfi/
        cz4TREMz0HVfrrFCOBMYJQ6u7mKBqLKW2HTjFRPIZmYBTYn1u/Qhwo4SnTtfsoOEJQT4JG68
        FQQJMwOZk7ZNZ4YI80p0tAlBVKtJvN6yhQ1m7YvPX6HO8ZD4ce0wNEznMEpc63vKPoFRfhbC
        sgWMjKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU9Ppf8e/7mDc9yfpEKMAB6MSD6/D
        r//RQqyJZcWVuYcYJTiYlUR4z7UxxAjxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5Y
        kpqdmlqQWgSTZeLglGpglFFaVXrik0qLb3mWUMcHp8MM13Y3rz61nGvSzZeWm450TDWYrSGa
        XbzX7JKNnlwH2yGRiSFyEpse/Z2g/5Sp5clVj/iaNUHNH561GEUI/fuz99TDfa8cffc7vp1o
        e6M2xvu9GusloU4d9sWt/97OWx++7h3v/7WuGdNypNwOvN7eE3rrz/zWZ0osxRmJhlrMRcWJ
        AOF3F5ZJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t/xe7pX1RhjDK5t07boPXeSyeL47qWM
        Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
        8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
        yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
        i/TtEvQyXs45ylzwjb3iQttt5gbGh2xdjJwcEgImEm/+bGfuYuTiEBJYyijx6cNbZoiEjMS8
        s31QRcISf651sUEUfWKUeHL9KBNIgk3AVOL23U9gRSICyhJ/J65iBCliFtjBIvHt8x4WkISw
        gLvE1SurwKayCKhKfJ/fz9rFyMHBK+Ah0XnUHmKBnMTNc51gJZwCnhKXtr8Bs4WASo4eXcEy
        gZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMA42Xbs55YdjF3vgg8xCnAwKvHwOvz6
        Hy3EmlhWXJl7iFGCg1lJhPdcG0OMEG9KYmVValF+fFFpTmrxIUZToJsmMkuJJucDYzivJN7Q
        1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAOjzsX5sZKdkklmd5MOP9Q3
        nMkyXyY7/OHES+yWD/cFmxrtePdrSszfaB7Zld7zTupXnNa5x7LlzLNin4rLlTe3O25ifbMn
        b02B7w/+30sMjrY+s7mnJ33WNObX68iLAXGan3Omv9Vz4Lqi9qNJ+8XRe1uiiwL3fPvXtN5Z
        fRPvPomS9soL+mUrlViKMxINtZiLihMB0fFxq6kCAAA=
X-CMS-MailID: 20181130120230eucas1p28cfa1960874470828230d288830f6974
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181130120230eucas1p28cfa1960874470828230d288830f6974
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130120230eucas1p28cfa1960874470828230d288830f6974
References: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
        <CGME20181130120230eucas1p28cfa1960874470828230d288830f6974@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_default_colorimetry helper function to determine the default
colorspace type (ITU-R BT.601 or ITU-R BT.709).

Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 2a25822bd6a1..895c6268025d 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -384,9 +384,10 @@ static void mixer_cfg_scan(struct mixer_context *ctx, int width, int height)
 static void mixer_cfg_rgb_fmt(struct mixer_context *ctx, struct drm_display_mode *mode)
 {
 	enum hdmi_quantization_range range = drm_default_rgb_quant_range(mode);
+	enum hdmi_colorimetry format = drm_default_colorimetry(mode);
 	u32 val;
 
-	if (mode->vdisplay < 720) {
+	if (format == HDMI_COLORIMETRY_ITU_601) {
 		val = MXR_CFG_RGB601;
 	} else {
 		val = MXR_CFG_RGB709;
-- 
2.7.4

