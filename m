Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEDAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9249920818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LkT5lEnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9249920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbeKMV67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:58:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36708 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbeKMV67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:58:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so5593375pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GyIfuQ7O8QNBQ656omiyFVK2J89TEtJq5hYrjzMWEg=;
        b=LkT5lEnVHcOFaDAJfglvEfavnnUpmHXHITyiCyhJZMAj4vVDEBz8JLK2YEEo8sLcUt
         bypyWUyCiPmVwvaXKFucehxlDrtfDXEcV+M/8cKMfh+tVYdYgjkYjm5eS/jqJIbSyxn7
         RfCtxAHJxfHSiDl0tvrxZ0//5hIVUfDEZSzv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GyIfuQ7O8QNBQ656omiyFVK2J89TEtJq5hYrjzMWEg=;
        b=GZJWKCFHWH5fyrV+OMaCUtSSz/4ipdpvD3Nh/vV+vyn/ME0jyUnxf1r05+UdAUs902
         oG3/0+lfQJC216PFxh2FqYl6ICQbgeqqkOdKLqdY9zfvykSTNeS9sBDHPvyeoG3PYDBx
         KND2fFO51KpzXBG2SKrVWLpBBzeVbPfanrLqnh7a2C68hq0BuYagmJP6lNBhGIVK5Etk
         uZzmNM2VVkb34jabJqhd4ynxDc71ETX0ecAUrRKAbTmoBsVU8/qzWtSCSGudUrjXk2lw
         LvIqocVXbS9VbR+dut9Vm6tAlOapTHRpGlR7NehIMLsiPIfLMiiM9JOA0ThD/biyoLTl
         eBoA==
X-Gm-Message-State: AGRZ1gKvhnaWcp5EI468KQvZyL/fFFui+z2iIW209/NGqVrfFMxNhIZb
        sSnNtvGip+LI+WBeHd5wR/nrtg==
X-Google-Smtp-Source: AJdET5da4x37mn00WuEQmErD5lV/1rV6L4jeNGC79wSg0EjfeoLGgWoSZ2NiNcLE79xoDVM57KXObQ==
X-Received: by 2002:a63:2946:: with SMTP id p67mr4532163pgp.317.1542110469221;
        Tue, 13 Nov 2018 04:01:09 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 74sm21826267pgh.82.2018.11.13.04.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:01:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] dt-bindings: gpu: mali-utgard: Add compatible for A64 Mali
Date:   Tue, 13 Nov 2018 17:30:53 +0530
Message-Id: <20181113120054.17639-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has Mali-400MP2, so document the relevant compatible
as "allwinner,sun50i-a64-mali"

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- New patch, separated from previous version patch.

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..a0ee62a5b221 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -11,6 +11,7 @@ Required properties:
       + allwinner,sun4i-a10-mali
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
+      + allwinner,sun50i-a64-mali
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
-- 
2.18.0.321.gffc6fa0e3

