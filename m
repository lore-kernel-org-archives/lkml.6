Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD85BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9788520867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJT5IKxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIDUzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:55:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46573 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeIDUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:55:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so1905219pga.13;
        Tue, 04 Sep 2018 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dlfSQFDwzKOSjnjxyCTv1Vk+WCVtxFvV9WTaMiQMTaM=;
        b=vJT5IKxkpu0Vl9/rA4AMDexjThqH1PO+nu/hwarcdO/YupzI3wHmzD2LG/TugMqEDr
         kW+1nB/H+dy18M/XwkuH53/b/7EDM1FvDN5ZjMxzOPTmZc4UEAFQQFrJy65TtEb21Ryj
         IE/9NOJevFaKzAZSz4JPlKiZW+019f2X906e0PlBg51RbJtiwo6jP4OW10w2kLC8ERWK
         JB2W90lGauQmlI3bBnM4f+DaNFVr2IN5SrAspocuJH8EIa/jjasI/k/H3D+kBxlz9GhV
         kK2MlzqVv7mUR5zJ9SCPEPV9RmU/EEZYx+FaNruOunfDLP04FEHEAbtVpRXPqThZhN+I
         Lspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dlfSQFDwzKOSjnjxyCTv1Vk+WCVtxFvV9WTaMiQMTaM=;
        b=IGOeQdbmuwZU/qt8518+6vr408ZnRzql1OubAxpnunAtuujt9e8CYokZv+o3TfcRMk
         4KBYL42R+uRHGr1FSrBTc42RfqK7VJYMPReFe2C/sVRdN3rtSee9QjGnlD1Yvq7BguO+
         IGFEQR3VFeA5Qxlrf66TzmF02ypNsuqY9V1NQ13i7gcMd1StHlOrS1fBo8NHypX+3oou
         NfP1qHikQ2mxc+3gQxdF+zTjklTaDtITsd4+mUx1utEngrLAAPqa6RYlSrgJE4rSf8WG
         eP9ORCFrhaLajrmiX3ldIIRSIrS5EMQoYM89NEVxcoMtJ+QQ7VlA479PYRcDZPuOrw2A
         Hs5A==
X-Gm-Message-State: APzg51D3PW+3DxrRJ9ebbLF1Ff8NkkDRyinONUhJKikDOiCnRqXd9KmR
        4UMP5HC2tIEOXbkluiDyJ1cm8mBl
X-Google-Smtp-Source: ANB0VdZLoExv79mzY33vLnoRXDBa8MnCL3TFYjuOzjLK/eOoRlr7aN/skDS5zHyZ7fOnuE/c4+oEyw==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr31993827pgm.105.1536078592839;
        Tue, 04 Sep 2018 09:29:52 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:51 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v3 15/15] MAINTAINERS: Add entry for Marvell OcteonTX2 Admin Function driver
Date:   Tue,  4 Sep 2018 21:58:45 +0530
Message-Id: <1536078525-31534-16-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

Added maintainers entry for Marvell OcteonTX2 SOC's RVU
admin function driver.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e178f2b..38f874c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8748,6 +8748,16 @@ S:	Supported
 F:	drivers/mmc/host/sdhci-xenon*
 F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 
+MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
+M:	Sunil Goutham <sgoutham@marvell.com>
+M:	Linu Cherian <lcherian@marvell.com>
+M:	Geetha sowjanya <gakula@marvell.com>
+M:	Jerin Jacob <jerinj@marvell.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/marvell/octeontx2
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
-- 
2.7.4

