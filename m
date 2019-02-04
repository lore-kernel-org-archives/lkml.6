Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1660C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B79220811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="005/w22S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfBDJzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:55:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfBDJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:55:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so12704522wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkjz/f0QfqEm9NzY0SVdhwC//Bv3LcwK48URNAuYP+A=;
        b=005/w22SjKaKR+OcSUPI0xl637BCseo2Vn7Ri2qV4IF2msRMe2NJBsZ79L8nefX8cn
         Ym7ZT5o74573nDVQRufx8Jy1COyDtO0rVEFqJb+1ukeyEJ2YiQMTWbSzr2bFiouXKv44
         Td4xnY/yo5iCjCCRu8lEPixq/xI0MAwJL8ym/3wnylukSGIQkqforVcJbo4XoHLsMS5+
         Bqbl5dzaib6RDHfnYAuxLMTTJ8Fdjj8fqcuZZEYlUAGv3bA+q7O5jLiAUg3/O4xHKltb
         UkVxNTmaj4Ti3fjpFcB3cOoz5MTuGacokYr73H3eu7D9KfHD+Brx1r5tIxfuj9NBtNa6
         hzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkjz/f0QfqEm9NzY0SVdhwC//Bv3LcwK48URNAuYP+A=;
        b=YK7/MiIK0eapApEurk8tYlwxvuYjkPAQ4LjMHDYuJOfZZT3jMeH1adjGQx9LIGMDaW
         5aVarRYm2JoET/UgDwNyp+G58Dx3JD/TnObnrmt8+fFjyNG0rNEftHNa2vyTHxQidYau
         Ry7baztqb4tDodmUkavXmNkcGmVu51ypStyXVZtXKiN6fGIYm7H29l9CDkFus+PuE4QJ
         wBf9tC4F3Ro4tCSZeeOjqOmTAe4fYsz1lhROqMtYxXdor/Kiu/4S61fNac4aT9JeTdak
         b8rWy+Qp8QNp0zaX8TfJxo11sN00XJzjF/OLlw97scEYhwd5KDFn4yTC3K7C6h47PqMs
         wCNA==
X-Gm-Message-State: AHQUAuYWTeWe4nELQqHyACvnQFtA2/Dr6+BODCW/BDMl7+qllUffpucd
        N2beYWCsy0u5ei48saaOMMtN2Q==
X-Google-Smtp-Source: AHgI3IYQZtyGrCgztWDiCxQW2vcfV7LQU+ZmP5HkQx2m5TyjJ/4sZs9DC4i01BhL+drnz7l8aBEPZA==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr12752545wma.109.1549274135224;
        Mon, 04 Feb 2019 01:55:35 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y14sm12450683wro.92.2019.02.04.01.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 01:55:34 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: handle when meson_canvas_get returns -EPROBE_DEFER
Date:   Mon,  4 Feb 2019 10:55:32 +0100
Message-Id: <20190204095532.27185-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When meson_canvas is not yet probed, meson_canvas_get returns -EPROBE_DEFER.

Handle this case but deferring the probe of the drm driver aswell.

Fixes: 66cae477c380 ("drm/meson: Use optional canvas provider")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index ef4afaadaf8d..17e55d63daff 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -236,6 +236,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 			meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
 			goto free_drm;
 		}
+	} else if (PTR_ERR(priv->canvas) == -EPROBE_DEFER) {
+		ret = PTR_ERR(priv->canvas);
+		goto free_drm;
 	} else {
 		priv->canvas = NULL;
 
-- 
2.20.1

