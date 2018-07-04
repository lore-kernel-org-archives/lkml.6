Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C865240FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OEszfJgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C865240FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeGDR05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:26:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37199 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeGDR04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:26:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id h20-v6so3150744pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=prShxXBRpnQtQLlF1thVa5pZBCWyVavixXvhELVVq7M=;
        b=OEszfJgsF3aIksAE/HxPzMc9SR135pNRg6UaPlnWLvmtOZ0tnACuUTWDmd8wmKsL7+
         V8PWe+o7ts2L+GaKCEIcw14ZJ+emI1fRJvZ8biT/aeLwGPK3W7J9LgUOYQTYN89IzFbN
         Q5Pbm9rJzp+OoKRA2XkMBDJ4awZW0VWEnQgr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=prShxXBRpnQtQLlF1thVa5pZBCWyVavixXvhELVVq7M=;
        b=bB6sHVwIkuXGbVjl6vaz0BtkWAncrUqn1hW0hH4s6OvlcZNZ5OM5LH1qtD4mDUXFDN
         5T5EnofTrqGM3KFQ4PPsnLk1wJCOuEQh2eKpZelGICDUpxR33vlslnzMll6hDFeZe/PB
         N5lfjMqoTmelRFXtAeyo0Sfv2Y1u8WPx3zsVQ+/E6TULxmEdvh6gHXt58uYvWfGOGH60
         h0zs2A0hCDGotOdFTUiCkBIFaDBSG91e1PEKrgZMON5pIVs7kZPQKZeVrgDHnKWvEetn
         kMw3fpVYS1dzXzbQbRa96FAx04PEpinYLdG0f5wWs7uOHj+zNzuU0KJxmArqigTYGnz0
         l6og==
X-Gm-Message-State: APt69E25mi8kjt6FXngAl87xsrPEj9o1Aa5EtCMP3Spujg89HDzCrgrk
        iWtHQCvRusBZAw3/DHDUAs/lDqOgKHc=
X-Google-Smtp-Source: AAOMgpev+xYun/GFpB0G4sDpYK664N3XPQ9oGbSY0PNHaHMiwmKfwTPDtSWJxQC0Y1XJA6LGfnaavQ==
X-Received: by 2002:a62:98d6:: with SMTP id d83-v6mr3104808pfk.186.1530725215992;
        Wed, 04 Jul 2018 10:26:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a20-v6sm7111008pfi.124.2018.07.04.10.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:26:54 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:26:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: Use 2-factor allocator calls
Message-ID: <20180704172653.GA33528@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done treewide already, switch from open-coded multiplication to the
2-factor allocation helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/bus/ti-sysc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 1cc29629d238..80d60f43db56 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -169,9 +169,9 @@ static int sysc_get_clocks(struct sysc *ddata)
 	const char *name;
 	int nr_fck = 0, nr_ick = 0, i, error = 0;
 
-	ddata->clock_roles = devm_kzalloc(ddata->dev,
-					  sizeof(*ddata->clock_roles) *
+	ddata->clock_roles = devm_kcalloc(ddata->dev,
 					  SYSC_MAX_CLOCKS,
+					  sizeof(*ddata->clock_roles),
 					  GFP_KERNEL);
 	if (!ddata->clock_roles)
 		return -ENOMEM;
@@ -200,8 +200,8 @@ static int sysc_get_clocks(struct sysc *ddata)
 		return -EINVAL;
 	}
 
-	ddata->clocks = devm_kzalloc(ddata->dev,
-				     sizeof(*ddata->clocks) * ddata->nr_clocks,
+	ddata->clocks = devm_kcalloc(ddata->dev,
+				     ddata->nr_clocks, sizeof(*ddata->clocks),
 				     GFP_KERNEL);
 	if (!ddata->clocks)
 		return -ENOMEM;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
