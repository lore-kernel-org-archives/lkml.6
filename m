Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3DAC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C0620867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkac+1ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C0620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeLAK7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:59:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36914 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLAK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:59:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so3551086pfb.4;
        Fri, 30 Nov 2018 15:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=bkac+1geXCQMO7SBGOHvZYHy+O1blewP8Fl9p5hxw+eIZxmX5Dmdkxefu53YmAODGv
         ArCDssqsorbtsVVUA7FVvlNYYZ987LCMhIpv0DqUB/jzpfDXtJDghqSa/KXydxtN06dS
         opbTdxUVgO9nQXx5Eng4S0A6atZmaSPJzIxoMEpOujx8zDxDVVJmYlKu1Itc24gGv4Ed
         EMVieW+0ME1m1gy2ynCnWl2o6WwMQK7BxuLPw4HDH1uBgR55ENZ3sGQXGuP3kJDi+Qg8
         Oj1Ojjz+VqF+3ROVtu2Eom7E07dmDW2ql1xzzx3iOsjpem0B+TwK2CzlqqeYzttebd2a
         MbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oiVWgL/WHUTd0gentorRc6DDTrlDET1vasHz44Fkvas=;
        b=TAzLCHBiplIiPTrszMvrT/Z3RJmqESgDUt6S7cA0uXYwvYEOOI29FHC+MuTZ9E0YqG
         Sx27zf55AhWSy88VFEBVCnIYWo+OQYPtxi/ow6KPlB+Uvz09EBVHolN0XfsWroEMtWJa
         ZU83LVFqghI+ZvonSzYk35KdsMmO3oWOoMBQd37IdBGy19Rqslf9YTPVcaR2AJ04rnR8
         X1sGTg2tGp3W1jNwt//WAxQhPCuBYyymBW9RZaN965RZnBEx3i+yzda7rbuQPDVlciro
         hqAT0HWSRQu6WpbRlgzaGYG2/7oJTWew3QBPKmfDlYF5A1roOjX7Calk3OLbSR0GO4BG
         ISdQ==
X-Gm-Message-State: AA+aEWYshvS9oVJKHspYGVJQX3P/honBFDK+YdF0+F7lzqEixF6P4Mvr
        fEeeFSduuxkvBtKhP94y6uo=
X-Google-Smtp-Source: AFSGD/UbRthTaL8THl8tytsA2WmEUjJz6Bavp9M4d8IHdPL2bXQ9TV+XZ1EQ2bWPe0SlyjDI7B8zIg==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr6376660pgx.10.1543621679441;
        Fri, 30 Nov 2018 15:47:59 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:47:58 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Fri, 30 Nov 2018 15:47:43 -0800
Message-Id: <20181130234745.6756-6-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130234745.6756-1-guro@fb.com>
References: <20181130234745.6756-1-guro@fb.com>
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
Cc: linux-kselftest@vger.kernel.org
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

