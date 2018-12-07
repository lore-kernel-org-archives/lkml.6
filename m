Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3176A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGTF+96d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3176A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLGM7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:59:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34932 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGM7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:59:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so4435695wmh.0;
        Fri, 07 Dec 2018 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VOstuElbSnWjht63gBCu7fmMuTQw3tfTkXOtwgjJuVg=;
        b=sGTF+96d/jZD86sQ4JO4IaLQTe7ZVM9HCf1Ja2R/aZt7QL7mq+K2tvZKKaAuQm68VD
         rutM5UFZ3j6+35poHElyzW3LooK2jHwMw6yRidoivbUaqbKhuX7OP/T8ucqIkArpGOc7
         0EZrjRkq35APWrz9CQHcBZswOZy+rHF7xw8Szg2CSBGMwEqfYzw8sWC/CVntPd44yFdL
         IBUvwVTZU+FpGKadw0KlaGdexiveJxNDvLqanwq58i8e2y1BHX894xAQgy6rzOA1uvzh
         10Wtk/KWQB/Waxjsx3rcH4rxkllyJq+9CxRB6ISbfs7CbvNwAEfO3Tw+OmPTVS4NBlN/
         6BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VOstuElbSnWjht63gBCu7fmMuTQw3tfTkXOtwgjJuVg=;
        b=MQTA0YRNaNmWW0mkvnHoaeVIENTRSBS6K0cvY26KBserFlixpxO9C/pPwcDCYac7Ko
         HO0052beCqyKbY9pz8JAWyQx5dNp0U6NU5QB5Yvh8ZLQRYFMuQcbrQfgrxPgz8maPS7S
         t8fkUcNwe+S5PoQiNK1FDvzgRoblPNALlePXzsOX0Up9TAlG/11BH//vrrgKlG6N6LE5
         QSjColfHhbd6HLsGbqZMX0FzzYfxr9eo61fK8dyWqfQnrMaGqUju0EYiSnx5KL7N2iqR
         lI9NYVhU7PIsh3x5YDiYow+PzWYlKWPOUyd0KIwsRF8PMmDmyhaSpS0Rvh74e/2LToB9
         IM7w==
X-Gm-Message-State: AA+aEWZe4atgGnNF4mKIxv67TcjeqeiB7OwTQm8j1dkOW3aeuPVxNdTY
        MCZ5Rlm76w3Z3mXD83jx1Kc=
X-Google-Smtp-Source: AFSGD/UHwJ4fPpG8rxsMgHX571xxRbnkSIv0McV132Rus05KsvvAi7cQ/8HW3IprUjBoN4jasBRRRg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr2147070wmi.101.1544187545813;
        Fri, 07 Dec 2018 04:59:05 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id r3sm3654635wrs.78.2018.12.07.04.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 04:59:03 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 5C9E61144859; Fri,  7 Dec 2018 13:59:02 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
Date:   Fri,  7 Dec 2018 13:58:42 +0100
Message-Id: <20181207125844.18775-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a partial revert of commit 5c63e407aaab ("fbdev: Convert to
using %pOFn instead of device_node.name"). This is the minimal work to
get a Mac Mini G4 back to a bootable state. The function
offb_init_palette_hacks would need to handle the case where `name` has
been set to NULL.

Cc: Rob Herring <robh@kernel.org>
Fixes: 5c63e407aaab ("fbdev: Convert to using %pOFn instead of device_node.name")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/video/fbdev/offb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 31f769d67195..6e75851f8142 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -648,7 +648,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") == 0)
 			address += 0x1000;
-		offb_init_fb(no_real_node ? "bootx" : NULL,
+		offb_init_fb(no_real_node ? "bootx" : dp->name,
 			     width, height, depth, pitch, address,
 			     foreign_endian, no_real_node ? NULL : dp);
 	}
-- 
2.19.2

