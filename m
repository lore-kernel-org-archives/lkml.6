Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1532D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyyjizdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfBZOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:15:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44508 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBZOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:15:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so6296308pff.11;
        Tue, 26 Feb 2019 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2dcBGpeDu9VrQUmcncUC/FVHM7sjCr4G6vnYs4OA2ak=;
        b=nyyjizdxr4k7JY26Xe+opo//E25NWJ2KMcR9Ztyy880dYKfgPYW+bDSBP3XzdU58vQ
         WAv5B/gvMDRjK/8IMHMDbxF8tkrhMtHvXa3jgnutKm4N5BMSBcblDQ39O7f68yfI6+G8
         UeTjRpDbd/Bt2umDPhgJ2H29dMyUVgSzdMs+X7ZUSxSjGhxQhDjZfXDUSQpbe2LHqFfD
         1WoFIZHjKypX/A70hbg2OZB8ZDegqJr9AO9X9SdEV8FSgcw4bNpQkHiIhWDwvMX33H+R
         II5HkflfK7EpgpbhdgbMJss64Whq2CJen5Hc4QuN5IhoISFSih3l2Hf9lGSYh/Uee8p2
         Oo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2dcBGpeDu9VrQUmcncUC/FVHM7sjCr4G6vnYs4OA2ak=;
        b=XBnZcOvabIErHaE7qGz+lEi/OMuxOYif/To4UXraDbj+Tgd2SWgqgR1Z5cyD/h2cDE
         leOkSUhytDHv7NYGjgn98/EdUHn8VabBp+6G/caP4d13P8oL9rYnfb236Fv4ixQH7GQ+
         kF+rXfC7VXoS16sQCJHkfa2EA1MOnX/uWpnyghVfEMb49ksq/RsDma/VE1h9IYJVhOD1
         r98g9h3IhpDbK6O7DxhgU2SCb3dAlUCzylNxLk85UYsiNDXilBRJELr9r9+ywrAu52UQ
         hoKo5DW8W22vs8nPXlvBKZe5z6rzEcTk966WCSMc+grUIroXSP3uCV8p+fZjS07wZfLk
         0ANQ==
X-Gm-Message-State: AHQUAuZV6GZDfo4BQr+k3xkR0+3vhY5gC5HbzW+eJRS5kEi5uEKa3iuD
        ckSWMJIf6U6kbOHFSwyma1Y=
X-Google-Smtp-Source: AHgI3IaQBGSjcavQROfVxkqOSQ3JLAxHZVQVgtfiInr33VMt4z7e67uRqAgSi2JjoRuHPlHMY25CtQ==
X-Received: by 2002:a62:64d1:: with SMTP id y200mr24653502pfb.161.1551190546431;
        Tue, 26 Feb 2019 06:15:46 -0800 (PST)
Received: from localhost.localdomain ([171.221.1.102])
        by smtp.googlemail.com with ESMTPSA id b138sm22609137pfb.48.2019.02.26.06.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 06:15:45 -0800 (PST)
From:   zerons <sironhide0null@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in bpf_map_get_fd_by_id()
Date:   Tue, 26 Feb 2019 22:15:37 +0800
Message-Id: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]

In bpf/syscall.c, bpf_map_get_fd_by_id() use bpf_map_inc_not_zero() to increase
the refcount, both map->refcnt and map->usercnt. Then, if bpf_map_new_fd() fails,
should handle map->usercnt too.

Signed-off-by: zerons <sironhide0null@gmail.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf5040f..db1ed12 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1966,7 +1966,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)

 	fd = bpf_map_new_fd(map, f_flags);
 	if (fd < 0)
-		bpf_map_put(map);
+		bpf_map_put_with_uref(map);

 	return fd;
 }
--
2.7.4

