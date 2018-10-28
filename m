Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15FECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97DA20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2tjJEb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97DA20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJ1PXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 11:23:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35047 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1PXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 11:23:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id n4-v6so1746197plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 23:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0YuOJIcBRXQNlro26KjI0BDU5QceW/0+0TNtCTTzRBg=;
        b=h2tjJEb2RWhnyogE+fdeQV9RoXBj3b528GsmugR27Vg19R43GdJm0TW6qGtuxCitmO
         tstw8rOmnMpvCpS4N7xOTahE7qSk3yl8F7chPWz5Vd8U8hyfxZQq/VePPM65aVcRIHqB
         y+mc22nch+32MbxHMFsVI1oWQL0obInbkEOXXHBzIR3IyNFvGOEYGHSgnOOVr8wAGKuo
         jrCPgemaAXjKM/5PgZWdg7Y6nIHoE8UMHa3lxNLwxQ1q/Fmbkhdx5D44clbIhuG9m8e8
         rCzPOr7rhV9xACUYnhDhA9sVGfRuAoe9vt1khHROQ/ScvZVTJLaJa0AoSIst2lzYod4/
         0r/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YuOJIcBRXQNlro26KjI0BDU5QceW/0+0TNtCTTzRBg=;
        b=Ap7Zgw5FdSt0sXT9mAO7QksCMqb8t2XrvuwZExeWeJGX6CjKwMxB7loiCVFjJDBXHU
         KdO6bwLFGBKN0bDAlLcbpVvbqihXeCsv7SZyWpZATXXZ5wByf55WrWzi/aC8NRUctShh
         72dm3OQAyfYpgwgrNuWEI5QfvM+5NJ8BEy5Qx+0/1o6+CesWkiSP2l1JeKA9mmohbtTC
         T6ZOfCjDlc7hKsMvweWN7+SFNg3FJEyiVloS+zlpuVyekgSs5AbpMIMwgoLJvKh4L5Fo
         smoL2pxyjVecUAADFE0pvUVRAa7ga8lb74cmMSboZ/JtN2LFqInRIp9Jeb1FVaL46tg4
         ueow==
X-Gm-Message-State: AGRZ1gLD1Ic+UyyCwoGYA8QtsnHDg6K4/bVlKNHBaRtRc0UOtQS8SqEy
        saJeVo03iUXappQ4f7knKbv5pXDv17A=
X-Google-Smtp-Source: AJdET5e8OVsRAGmnKzSjS/9ujtN6NRSWUt7e1n3CiswUNFIgU67oBJXP5mOESKWXsOnstVoYRFZ+eQ==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr9720599plb.76.1540708768474;
        Sat, 27 Oct 2018 23:39:28 -0700 (PDT)
Received: from localhost.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id a4-v6sm21020657pga.2.2018.10.27.23.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:39:27 -0700 (PDT)
From:   Muchun Song <smuchun@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Replace simple_strtol by kstrtoint
Date:   Sun, 28 Oct 2018 14:39:11 +0800
Message-Id: <20181028063911.51586-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtol() function is deprecated, use kstrtoint() instead.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 drivers/base/dd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 169412ee4ae8..940abad069c0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -223,7 +223,10 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 static int deferred_probe_timeout = -1;
 static int __init deferred_probe_timeout_setup(char *str)
 {
-	deferred_probe_timeout = simple_strtol(str, NULL, 10);
+	int timeout;
+
+	if (!kstrtoint(str, 10, &timeout))
+		deferred_probe_timeout = timeout;
 	return 1;
 }
 __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
-- 
2.17.1

