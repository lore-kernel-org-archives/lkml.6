Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85417C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4295820673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYnalcB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4295820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeLBC4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:56:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40661 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLBC4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:56:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3804119pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3MBKnEdc2vCt+hp1v45FpAxJ6rOrkFnLUOM7Xtr3Bas=;
        b=JYnalcB6IgOtSpExFlupPIVU9BwW3skkDr6wr0EtEnzj8v+Guqn+LxifFu6u2o/HUF
         Slci6EweGjftreiY4AfllvfhDz1SGkxT7z5YCdB7S0Y6yr3enZ8i+U8oPQSqyOJYrmIO
         yJwDEn6HE9pjes26KxSqTB/gdsDPditr8GMVAPov+xelVR5DYdFPFHPJW+a3qZa7r9Pe
         eJJ9K0vlYqdwDxRCsvOpo+69vhwceUhpXS69JxT1X6ALXUbQ1dp2/GdfrNdanyIQC4EV
         gTWWoJpaFd7dJShgjx9X3F1YcygqBDNuuK4dPstf0HjWzUXz61PskxBcvArXJdMoRP7S
         nHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3MBKnEdc2vCt+hp1v45FpAxJ6rOrkFnLUOM7Xtr3Bas=;
        b=fOIDU5l7iNRXzMt5F0zUj/T63h3MUlUI3YdideKTRQqCPwCo8fwmARA5voYQ1oonSR
         FHQVNn0waQRgu4w9xjxR9fRhm3REw+pum9wSHXrQvH3u9F/rrTdO9f6sApNlHnhDbvlZ
         eHFVx7nbS6hvCepelO0Zodz8Q8Lq7xOLbVHwCw7P/sh1FEtAZsxgjLC6skVaBLvXtm9N
         ZM1yNJZy7LF0y3O4XHswGlSpUdvP8LZWDbIM4U03Es3hTbQmDdsHhrpfwcnf98gzcotN
         nZUIbFYjGUUCv1P1C7gTK/EnAEJQRxINEOtOx5up79vqSbf1TGcCoIubwRSFTOYrENpX
         drMQ==
X-Gm-Message-State: AA+aEWYoclC8/yA7exHatAXHVu5/aX4t7t+X0uFLFVAH9IszWPu7Nc7n
        1RsPX8WXTz20J4M0/kscVaw=
X-Google-Smtp-Source: AFSGD/XInaSl/OQ/3V5jGYfmxWK1tUiz7jztFUXgG8/kIFm6iUMSSjQNO9t6VzXE7baqDl74kQHWJw==
X-Received: by 2002:a62:644:: with SMTP id 65mr9695588pfg.161.1543679035086;
        Sat, 01 Dec 2018 07:43:55 -0800 (PST)
Received: from localhost.localdomain ([115.143.98.81])
        by smtp.gmail.com with ESMTPSA id i72sm16283573pfe.181.2018.12.01.07.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 07:43:54 -0800 (PST)
From:   Sihyeon Jang <uneedsihyeon@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kenel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>
Subject: [PATCH] perf util config : Modify size factor of snprintf
Date:   Sun,  2 Dec 2018 00:43:11 +0900
Message-Id: <20181201154311.9990-1-uneedsihyeon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to definition of snprintf, it gets size factor including null('\0') byte.
So '-1' is not neccessary. Also it will be helpful unfied style with other cases. (eg. builtin-script.c)

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
---
 tools/perf/util/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 5ac157056cdf..bce980fa9f41 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -811,14 +811,14 @@ int config_error_nonbool(const char *var)
 void set_buildid_dir(const char *dir)
 {
 	if (dir)
-		scnprintf(buildid_dir, MAXPATHLEN-1, "%s", dir);
+		scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
 
 	/* default to $HOME/.debug */
 	if (buildid_dir[0] == '\0') {
 		char *home = getenv("HOME");
 
 		if (home) {
-			snprintf(buildid_dir, MAXPATHLEN-1, "%s/%s",
+			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
 				 home, DEBUG_CACHE_DIR);
 		} else {
 			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);
-- 
2.17.1

