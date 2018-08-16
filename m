Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35972147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLvyJC/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35972147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeHPX3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:29:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41751 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHPX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:29:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id w19-v6so2613301ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjXGYI8zpzBPRQhl8pxxTVLVL1fpzO6NnA9rDuraYAM=;
        b=MLvyJC/DzMCQV6RzSuNeJPwc1BqHy41usVICel65IKTMB3V8IrtjQbCkaHhFD2QLfp
         59So8mFX0xbYNQfTTInN+t3v063pESkY+vgpI93PN8DcYJcp106NkaflzCLPWiH76/ah
         UKR/HizAgdsQmd2NS0eZWsgozCiO4N7FlSX8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjXGYI8zpzBPRQhl8pxxTVLVL1fpzO6NnA9rDuraYAM=;
        b=iZ35LNJZg477OgN6YtplD+njbP/4badQcGOMEwBm5uDsv4LPhDR73E2VZ/og35QnrR
         16+bafrR142mXFDvoocDnEumYeeh1hFuP3HaEEqlbEtKcM2beL0gDxM4mSsz0tTY7/ic
         j2rJsz0EwDlDzCzopJZ6pnbi06WMVX6CulIkaLvbtOeZ7wWRoY6M+gbRzCym6a+XKRFF
         J0mFs/of2Y8JK8K/fLaxyjRKKnFTp3k0oCRzDiGEYkik5YvbdU1b0ZSVTDhVBmO+QtGV
         JuN/sfRKbKEahGFfoSZVJym9BO2hwjZ81F6F9zvtr/bSMuzYRrerOknp3or+9rcwzRW9
         3OZQ==
X-Gm-Message-State: AOUpUlE1RY0pW74osNxN0ykEUMjGvdgVO5IjM9IcFVJVzyqqM9irj1dn
        /tJ08iId5cuCXvk7jPnnIxfINw==
X-Google-Smtp-Source: AA+uWPw7PJS3R8exmIFneilUPpbF1G7AKJ349YBh9KxeSfSJgoV4QBT7yKUJd4cdrCwH/+Tv2e0GCw==
X-Received: by 2002:a17:902:722:: with SMTP id 31-v6mr30761700pli.207.1534451336593;
        Thu, 16 Aug 2018 13:28:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id t76-v6sm209647pfe.109.2018.08.16.13.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:28:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] regulator: core: Add consumer-requested load in regulator_summary
Date:   Thu, 16 Aug 2018 13:28:02 -0700
Message-Id: <20180816202803.250079-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180816202803.250079-1-dianders@chromium.org>
References: <20180816202803.250079-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's handy to see the load requested by a regulator consumer in the
regulator_summary.  Add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- No longer consider consumers that don't call regulator_set_load().

 drivers/regulator/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 00e931da887a..1e2dc8d09075 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4701,7 +4701,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%45dmV %5dmV",
+			seq_printf(s, "%37dmA %5dmV %5dmV",
+				   consumer->uA_load / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
-- 
2.18.0.865.gffc8e1a3cd6-goog

