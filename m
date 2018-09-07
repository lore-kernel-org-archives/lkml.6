Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78153C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AB920861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W03q+mBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AB920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIGFFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:05:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32920 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIGFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:05:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id b30-v6so3453940pla.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6SCxTufvokbvK4HRMyLG7u/cHaY8PFMhZWc8ZlNH8=;
        b=W03q+mBViHa34wSNBY6rfdzigQUEeUXvz3sQ33XQ5vnZMh6PqbJ7kaZHaAv9R+cZ2b
         5SMKe25gjvTf1m767KS+jQl284Rfl4y2ZASqQugMruQSMyY8LINlEUtF/0l8ASURSeh3
         ZDyyf+U2n0uhSG/teofR0AhuERFkFn1yudcKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6SCxTufvokbvK4HRMyLG7u/cHaY8PFMhZWc8ZlNH8=;
        b=nVpGigX4GB3LCzVK0Nwo65Z5VOwRIZFJmFFEepnDz1yQXFtSVb0y2mdBKr+tuWZDRZ
         HrCii7uZwXfX3nYh++7eqwjL/XTBHGzyzQqyNQJPFSbWpwDnfun98wryo3Z5hQ5f8+NQ
         MbCLnERlX5MhwPL/3dl08P+yTxmdPBnbTEaZYOQSgmZ5OO2npIQxe1GUZknUnOxDqgvD
         xx0wDAxU8Szb7HX8WSz25oaTfF4lvVYMg58hMGtWGTe7oR3K3da57a8DIR9j0bgN39h+
         nxbOvwMEoLxbuRpdL7/0MfeQge8p9a81pmSI4frWqZDxq78JRjQL09v+frbnoIu9D1C6
         dFGw==
X-Gm-Message-State: APzg51DtXcbdchiX4snoeLUDiBNPUEc9teK70vSTSFCXXxAAgEKEmOEO
        str7Uv4U7FkP9mbjYC+vMx54Hw==
X-Google-Smtp-Source: ANB0VdaLK+M27MHdu2zfLYpw0M1HeFtA/ut4DSwoZw+JbIwJ3Rs0FGguakkjLBEfKnH52S/nK8qn9g==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5-v6mr5374116plk.338.1536280068324;
        Thu, 06 Sep 2018 17:27:48 -0700 (PDT)
Received: from firesword.mtv.corp.google.com ([2620:15c:202:1:b82e:17c6:30fd:4233])
        by smtp.gmail.com with ESMTPSA id g184-v6sm9928382pgc.22.2018.09.06.17.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 17:27:47 -0700 (PDT)
From:   Grant Grundler <grundler@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date:   Thu,  6 Sep 2018 17:27:28 -0700
Message-Id: <20180907002728.112770-1-grundler@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca917f9fe1a0fab added use of usleep_range() but not
the corresponding "include <linux/delay.h>". The result is
with Chrome OS won't build because warnings are forced
to be errors:
mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
        usleep_range(10000, 11000);
        ^

Including delay.h "fixes" this.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 92b7125ea169..1f97b2f7c851 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017, Maxim Integrated
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

