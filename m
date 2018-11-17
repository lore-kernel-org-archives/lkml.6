Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94471C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D3C2089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hCYfz+nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D3C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeKQNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:34:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aTTDnzEKE6nV1laYZS5GhuPFT85qHsIoi1RhDgVk1Zc=; b=hCYfz+ndUPuIoeouTgaBU4G2R
        BA6oCGBIIaSsrs31G4AMr7X0B2xsWyTqhCr56b+uo6fzg6J0sFZY2D4Pg85hbuKsSLo/rXjOZCQA9
        UY9d0tPR0sK5x0rJ4Pr29A3ogAtUcDO43onW9ah3eCoiT/TK6n4JnJ81fNyh1uxjp41fE=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNr91-0008La-8I; Sat, 17 Nov 2018 03:19:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A4AB9440078; Sat, 17 Nov 2018 03:19:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: Fix return value of _set_load() stub
Date:   Fri, 16 Nov 2018 19:19:30 -0800
Message-Id: <20181117031930.24011-1-broonie@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stub implementation of _set_load() returns a mode value which is
within the bounds of valid return codes for success (the documentation
just says that failures are negative error codes) but not sensible or
what the actual implementation does.  Fix it to just return 0.

Reported-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 25602afd4844..f3f76051e8b0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -508,7 +508,7 @@ static inline int regulator_get_error_flags(struct regulator *regulator,
 
 static inline int regulator_set_load(struct regulator *regulator, int load_uA)
 {
-	return REGULATOR_MODE_NORMAL;
+	return 0;
 }
 
 static inline int regulator_allow_bypass(struct regulator *regulator,
-- 
2.19.1

