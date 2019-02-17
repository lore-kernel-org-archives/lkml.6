Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66C3218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsyEzi9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfBQTWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:22:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43403 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBQTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:22:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id z20so11453629ljj.10;
        Sun, 17 Feb 2019 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qljl+laKgAawohlKJZtgdt0AW8/6HgeMue2UYobsbiQ=;
        b=QsyEzi9J4pN7o9qjZrtuwE3EF8SfpytoCP52XlHFeD5R/ZzIVdqwuWUsepC92n5/HE
         SooYapW3U1vJU0WULTGsNIwNwmm2ZptdnNl3t0i73K4XO18NXdVHjtCJBSsJjwJVIKa3
         UayIvzyZeF2hgCReXkHLY7pdgPLaISKW7E1YGz8fYsZhWrcEqu8J+TuCoOHMJLUuy/1D
         kMCve+WPAgndCFNhpZM7LcFFCboY0K+gKusAye9vG9hEUXYV2xb9z/foYDF0VTvi9L3d
         v+f3GEmiCT1V77lAPz4LjsxFbdoLOygZnVb+1pHjhEAVF0NFZHQAQaGZV5f/aRaLyUfu
         0nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qljl+laKgAawohlKJZtgdt0AW8/6HgeMue2UYobsbiQ=;
        b=YG9iO0lIVd7JIvphp8n0cqRwByB2SnCNndgAVykJjUkLdWZbp1LzeYPLxgVTChDHn7
         vbVmZO4Az2mP9defKuO6V91VJ4W9lP4hKh+HtnRSjwTf7YHzlu1IKqHosItEO/B7d6gb
         JsqiH3MURzFxrirAeVPck06w3dYoisD7ZVfdV8awnsfbyEhkUL109UINBTQfkJ3lAvic
         h76YSzni0MyIGt7v3xs13Mpws2CpL747fjW1zbwxxpSsHZhr212T9Sp1dXzFO4VirUpE
         aSCnzFsFzrDzfoYDar9P6bNkqZOrZPzcREbQ0YKpWQI7o/DBVSh494Hj207JBdWajsTo
         xsBw==
X-Gm-Message-State: AHQUAuZWwgK8EZA/UgIsYZMdq3UkHwxCycMwU259vXk77URKPz5Gd+9o
        3Lwi9/RNhdr2IDsfq6ztwljT87b6
X-Google-Smtp-Source: AHgI3IbJwrAYvtfGULQ/pmbAhH3T2CzhOHmf2uND8lxbvqdqbC2gCOg3ey1DNxNw6W61s5tQ2tfHSg==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr7423822lji.170.1550431361436;
        Sun, 17 Feb 2019 11:22:41 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id j14sm2916766lji.32.2019.02.17.11.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 11:22:40 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 1/2] iio: chemical: pms7003: extend supported sensors list
Date:   Sun, 17 Feb 2019 20:22:12 +0100
Message-Id: <20190217192213.15803-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190217192213.15803-1-tduszyns@gmail.com>
References: <20190217192213.15803-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add other sensors to the compatible list.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/pms7003.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index db8e7b2327b3..23c9ab252470 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -321,7 +321,12 @@ static int pms7003_probe(struct serdev_device *serdev)
 }
 
 static const struct of_device_id pms7003_of_match[] = {
+	{ .compatible = "plantower,pms1003" },
+	{ .compatible = "plantower,pms3003" },
+	{ .compatible = "plantower,pms5003" },
+	{ .compatible = "plantower,pms6003" },
 	{ .compatible = "plantower,pms7003" },
+	{ .compatible = "plantower,pmsa003" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pms7003_of_match);
-- 
2.20.1

