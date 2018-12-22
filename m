Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF5EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2BE2192D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4KeCjZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404686AbeLVADt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:03:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36439 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404200AbeLVADQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:03:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so3175354pgm.3;
        Fri, 21 Dec 2018 16:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CNs81y4CnakkHOiMBhU/ECBjLx8oP0VFMrPLGDOhpII=;
        b=G4KeCjZIzCd4AUKqQLHckdHP0rluxIgkGmhJzHAib9IerLRdW7nakvDpl6t4atSH+i
         hRJ3vjTEwz6X/+plbmMNNlMsep8u73x36C+g2rdBZ8ms1ekG/vTtNcggsKpdU0CrkAwK
         B/BtXIXWNIu9r899zYEu/Wo2cSYXCkJK0VvNzJTABHMYci6v6RyCsh8yIWC0YcaXsOnJ
         VCyagZVsYL2odkr8Gcw8nXxM5YwDTOXJxMk8PPuYkJG5mqHqfMFO+XeHNX1MXHy5DETQ
         LQ/O1HEHAsKFgMJ47mSQhW3NCM+nE7zEAcvUIfdnoZDR68P7OwWr7ErQk40ogzDjtkTF
         OWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNs81y4CnakkHOiMBhU/ECBjLx8oP0VFMrPLGDOhpII=;
        b=dQs+eImOJs+N1ETnF9wX/iaMqQHpkh9Sq2vDIXgRwKIJVOx0exE0F1ZQvM4+qlXw5r
         TPkIqnTdCAKtcuE3cnhhDmSGzvCBLiGjIUnhT8D99LVQaToOVCvW9ZkpcbzUll1ylWpP
         nyUWZ2yGSKs0dpUDuk1dPE3X1i97V6ChHJjPFxicQ8IqGDcB34W96e29YemG+QXGf19W
         VH34WbpZ1A+6gn4ISJN0mgA9Sst1u+8FF8S6LR+WRMU7IOJZHXuixtHTLknCNwTKiXW1
         OplZAnBJCk8d6g/PrDNmRdQCDZlfgYNoidDJ/XwK2jQwqUSFr02zoE/dzMss4BSh3ATB
         vgVQ==
X-Gm-Message-State: AA+aEWYR/UPn35s4HdnpQYZbbaF+H1r8vQ1aUXClOZPMCx7luoLV+Mb0
        pF7kSjmQ/ygL9nzidUPb7bU=
X-Google-Smtp-Source: ALg8bN6Wvg99lBqJTIbKE3itiDzOsXh6XxJwZFVPAgCMYBJVFXPkPkSeiLyvAG7ruDZS3HrQJSswpg==
X-Received: by 2002:a62:1c0a:: with SMTP id c10mr4516508pfc.213.1545436995738;
        Fri, 21 Dec 2018 16:03:15 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:608f])
        by smtp.gmail.com with ESMTPSA id 83sm36659266pgf.57.2018.12.21.16.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 16:03:15 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v6 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Fri, 21 Dec 2018 16:03:05 -0800
Message-Id: <20181222000307.28231-6-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181222000307.28231-1-guro@fb.com>
References: <20181222000307.28231-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.2

