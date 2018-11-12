Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190AC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63432245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQbfUsto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63432245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbeKMI7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:59:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbeKMI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:59:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1753735pfd.12;
        Mon, 12 Nov 2018 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DzcE5bixymM64ursY5BeupFFYZWpXSHlxEvgaLA1wns=;
        b=TQbfUstoE9l37hyzHmN9qEUsPBITbxGKzsyNTkbv/1Wr/Yk9R3vRC7gcz4A6Iy1cPt
         SAHYtJ2D7QJOz7obNNnltT6BOC1FUBkbHupPCsoZOKeN3P+8MJdw21I5leaDpOjXf1dy
         mS3j8tDy2IzD7U8btOEGyjb7rkgPkR/NQtSO0hCcKb1EGAQPaGy+Vhnes7hVT/CNwToG
         qHa0YcQ5FeTc1xtdOIY/qJ/thA9oSVS/vy9VFYOr0lMvPd8dTaaqQ/K12g6ocwFfjheb
         A6+4+oLqQHsdnapMF03hGjCcvvIC/x3uEgg015EHw6jWRgzQzyyIz09q4OjpRcON6DC3
         +C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DzcE5bixymM64ursY5BeupFFYZWpXSHlxEvgaLA1wns=;
        b=W/aK1YdCYrEnrZIdU849kptNRiid+3IiGZZQgyZYCThqd8yx2+Lu9PMOqooAhhFSmz
         rsoMBixboQX/S2yHQHN0N+ayDoY9uaPjgBbSWAjFmVGRzvpzmMb7tkN0vzvXc6jltwjV
         UlQCi3axtm8rjufDkNM9PymKlYHteYpNbS0JxlQX+gSCSN6iPHpXOW0CG7YyL7OJ0TS5
         D2Vg8utDsqM3AgnckaJetDkFCqdEGqNE8a3ODW3CmaWD8lBkyYd2q1ZGbcuid+I264xG
         0gI8E0izhi/6B0L1smLxpgZ/kGZ9cNTASOxS1ccFd9nn60nC2G8uxeGZ8bQvi1Kn0TyE
         4cRQ==
X-Gm-Message-State: AGRZ1gL2HhpgBJkz9QmNRVbHmQ7TH1bZcs9ZJCLe3tTUUdUWu4p37mSZ
        mihT79gxTJYuOevvy26dCVQ=
X-Google-Smtp-Source: AJdET5fxWLQV9OjbklNiG2YYKhlu2QUDZ+PFxTt2uMQk0k9b8R7kskQp99FC6RpTzn2+KNhibVEFXg==
X-Received: by 2002:a63:413:: with SMTP id 19mr2481678pge.7.1542063870051;
        Mon, 12 Nov 2018 15:04:30 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:c2f7])
        by smtp.gmail.com with ESMTPSA id f64sm7192327pfh.0.2018.11.12.15.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 15:04:29 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 4/6] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Mon, 12 Nov 2018 15:04:20 -0800
Message-Id: <20181112230422.5911-6-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181112230422.5911-1-guro@fb.com>
References: <20181112230422.5911-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cgroup destruction races with an exit() of a belonging
process(es), cg_kill_all() may fail. It's not a good reason to make
cg_destroy() fail and leave the cgroup in place, potentially causing
next test runs to fail.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 14c9fe284806..eba06f94433b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -227,9 +227,7 @@ int cg_destroy(const char *cgroup)
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
-		ret = cg_killall(cgroup);
-		if (ret)
-			return ret;
+		cg_killall(cgroup);
 		usleep(100);
 		goto retry;
 	}
-- 
2.17.2

