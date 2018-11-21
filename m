Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81831C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347F3214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ9lC7ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347F3214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeKUXjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:39:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33724 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeKUXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:39:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so5494603plo.0;
        Wed, 21 Nov 2018 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XpADW7oy/CtsN60pSotwU7P9NnmgHpwGnq+aATSuM2k=;
        b=DQ9lC7exOmLcrAAlRa5xNuMTb0TpnSyL3ygTB5TKlVtqXrboFn+HZzfUz6fndRiIUp
         Fy/JB/2/6RNusM2ZIp0q9l6QzLjD91cdUnJkQ8B1alkkypnlZUhtUTg4QZf/BO4LgTu0
         8ta5BrPY/gvl+vvcpXllxynLQvgbe0WwL/SsxSr+9EYmMLyZ0EzyJqfueajGRANB2Kvo
         5DZicNqYSENPkV/EhIdMM15IfL4rH3TQSyvMy+H40LwJ6zqAvxJXi8dRfQcFIgOReK4g
         uMQpqfz35nBT5IJXjFDGSsBAID6zJovd5ylTzJ5Zqw/EC+MqwpUFBx53gB8qSwY9snSt
         iE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XpADW7oy/CtsN60pSotwU7P9NnmgHpwGnq+aATSuM2k=;
        b=a3BPssOe8mHc931gcI55upRusjqIFxvzXELkgN/wz3iWy9+D5vcj6FZMe3MeBfaDC3
         qwsQJyWkY3wPonmUgUlKv93YpOZQ9qqdR5ozo2fYW8DUHIw/ttE4RUrzKKW0hoUk1Y+5
         qcsAVu9NJ/SbHJqnvuH25VgLnNEanxNom0CpljvSdQ/Tk5yq3nPwazNZ976N1pM1Zq1s
         8pj017dWNdsVLgsLa9CjMeY9HPZDzA8esMoivQd4SKVeYnqFg5nAMC6OkjABy80I17hB
         FzUXatvff6ou5TIQ3+mhcAyL5MEh1t79Sm+QrfNp0IAgxxpSozUr8sg9iTotU1/WpNZt
         LJqQ==
X-Gm-Message-State: AA+aEWaCgW8+H4l5crfKCGOvIzzNIyH8fYOhwB4rK6jyHDuikOh4vXju
        lhSm7+m5awMitU4DMDZ/70/H9gP+JC8=
X-Google-Smtp-Source: AFSGD/UvM49PK3D1hcml4O6KI5DS6LAxCVvrKeHMPwYyv6pbMn2RVlVnELGMhSdfe2izXQ+V94NDrg==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2mr6787812plt.339.1542805483610;
        Wed, 21 Nov 2018 05:04:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h8sm22857863pfo.162.2018.11.21.05.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:04:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     b.zolnierkie@samsung.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ata: pata_macio: add of_node_put()
Date:   Wed, 21 Nov 2018 08:04:39 -0500
Message-Id: <20181121130439.22255-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/ata/pata_macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9588e685d994..8cc9c429ad95 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
 		struct device_node *root = of_find_node_by_path("/");
 		const char *model = of_get_property(root, "model", NULL);
 
+		of_node_put(root);
+
 		if (cable && !strncmp(cable, "80-", 3)) {
 			/* Some drives fail to detect 80c cable in PowerBook
 			 * These machine use proprietary short IDE cable
-- 
2.17.0

