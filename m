Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA9C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8966B20873
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 18:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhreKd3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBJS6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 13:58:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40731 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfBJS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 13:58:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so12747568wmc.5;
        Sun, 10 Feb 2019 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=BhreKd3F9gUJ5+gkrrKL1/9AiFILu6A9XFLWRIx03QE0NZ5RTiGuy6WpcdMXrgABkp
         DkECW7OCX7VCh/7g8Gup/BGdIERbIAoYrfImlfVfgFQVkKzV7r5xc88VV1JCIeDTTWp7
         Fy/zFoQoyjxHZ+B1DK6FqLigyABBrls3ydzRO0RcgPfqdh9XWtsYs1OY36+CVvhx+xj9
         mep56bAr9nQRQkiMXllthdDpfk3LYuGFrugywN0GWUTUWe9yFWkMuZl7HXCcnk3yzref
         QaL3ePLKaYXrKuOwqUw8lePGVPX0rTno9RClqmNODkz3+gsmaBhdoK8KA9zL0/5ho7Dr
         54cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+eMmTfwODzLvEzByWZTx/8AnGc8y+MNL0RRcXP1LEg8=;
        b=csJf/OA8AJhpe/lmxCm/534NWh7Nede/5f6XHz+cIMCgvBTnTUMXXU8UwsR9eOwVyl
         r4hgxB6jzyMzzwnCNFlibmyehkGHlXsMbv+KXI73nYAFKwKS04MuPSoQD1whx4h0meSb
         3FkqibbsRkJdaBaxs1K+MNHN5b281GdIAEqNzwYgxSiCfXUOcysCTNvwAJsttQvy/otS
         F8T5lpvnkxjsbxeTo/SjdDjuiA17YHT02RkLL2ksr6MbLKZ64vdY1dPCVmndDjNe2bGO
         RH6WB+m25N3IFs4OsBtl8REupRozH0EJcx35KaHb86Osm6RqVPzhUWgoywHXOq8Lebos
         p8hA==
X-Gm-Message-State: AHQUAuZOjBpgsBQjfFfJud0y1c5caJ57WWNPGnvd+WqG8Be/a+JTixJq
        DwjWbPHPIRPX5l/ul6hH75E=
X-Google-Smtp-Source: AHgI3IaFC7b/q2r/taD3fo5GZjhHaOskdk0Nk5ZZrt2IrsMdIOLZSph6a96dugK0J8sxz5IIVowlPA==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr7003809wmk.30.1549825083194;
        Sun, 10 Feb 2019 10:58:03 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dee:9f00:2436:5653:8de5:2886])
        by smtp.gmail.com with ESMTPSA id q3sm1251792wmj.40.2019.02.10.10.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 10:58:02 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linuxibm.com>
Cc:     paulmck@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify two issues in KEYS-TRUSTED entry
Date:   Sun, 10 Feb 2019 19:57:55 +0100
Message-Id: <20190210185755.9776-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mimi Zohar used spaces instead of a tab when adding Jarkko Sakkinen as
further maintainer to the KEYS-TRUSTED section entry. Paul McKenney also
introduced a typo in Mimi Zohar's email address in the KEYS-TRUSTED section
entry.

The two issues were detected when writing a script that parses MAINTAINERS.

Fixes: 34bccd61b139 ("MAINTAINERS: add Jarkko as maintainer for trusted keys")
Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mimi, please pick up this patch instead of
  "[PATCH] MAINTAINERS: use tab instead of spaces". Thanks.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf4965d6d5de..b4b62ea78eeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8405,8 +8405,8 @@ F:	security/keys/encrypted-keys/
 
 KEYS-TRUSTED
 M:	James Bottomley <jejb@linux.ibm.com>
-M:      Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
-M:	Mimi Zohar <zohar@linuxibm.com>
+M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
-- 
2.17.1

