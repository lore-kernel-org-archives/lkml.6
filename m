Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DBC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F920C0A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 18:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811F920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeHSV4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 17:56:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53608 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeHSV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 17:56:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so12071864wmh.3;
        Sun, 19 Aug 2018 11:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5HSCeG6RHhc12Km6JxE4vh6x909S3tvluAUWwtEVQVs=;
        b=Tp/bRmPQTVRZNuD3yYROfc5y1jjm5q1mnartBLZcVBm0g83qwSyl0X8HL+5nWsB+VI
         taEgewLQqQhCoc+MZoOlH89e3Ja/KxQk1W/Cb77aZmEpiyS1LK8uV8wi82KvRrddOoo0
         HQzEz0hY7gsiF28JMgMUaZTIKbcKm7+yRzpz/SXgtaAWgmKKnLhU+t1FhtxWcHra0nOR
         +gtZsizM8VOPraKvcM6nRBi0DWN8gYYw/6VTMQahqKPc369O7H0ULpwl2F6ounf1/3e8
         XxzUs02VdsowMEG0njLnM3rE8pnU/WSQpzK8V4c+sYP4ZiphsUDv2oQnS4cstctWXASI
         KHig==
X-Gm-Message-State: AOUpUlGbc2yz/B3ycGLMrqlOpDHi/8mHL21a2VmWHaIDOGP1HTnVUI39
        9yFHp5ywigO9uLfRZhQJGJT//X4hfX0=
X-Google-Smtp-Source: AA+uWPypiKIZUBmbfMWbM+Os6+/EZHrTHEN5BJQSSxHzdjMfpdlMmwtx1ow9hAzdGkOhZqud01KAVw==
X-Received: by 2002:a1c:9a42:: with SMTP id c63-v6mr24153550wme.5.1534704261541;
        Sun, 19 Aug 2018 11:44:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:39c5:71d4:851c:7d15])
        by smtp.gmail.com with ESMTPSA id r6-v6sm1162093wrt.92.2018.08.19.11.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 11:44:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     serge@hallyn.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH] security/capabilities: remove check for -EINVAL
Date:   Sun, 19 Aug 2018 20:44:03 +0200
Message-Id: <20180819184403.5343-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bprm_caps_from_vfs_caps() does not return -EINVAL anymore so remove the rc
== -EINVAL check.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 security/commoncap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f4c33abd9959..6012f0cd8157 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -684,9 +684,6 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
 	}
 
 	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
-	if (rc == -EINVAL)
-		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
-		       __func__, rc, bprm->filename);
 
 out:
 	if (rc)
-- 
2.17.1

