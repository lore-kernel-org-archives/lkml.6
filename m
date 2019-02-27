Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F47213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KESMNHVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfB0Og4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:36:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42730 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfB0Ogz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:36:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id v11so2691815plg.9;
        Wed, 27 Feb 2019 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hMM+U5uQzrfAfl+apatZhOIfSoVUQBO+zTVJBKz6bjU=;
        b=KESMNHVWlT0P2OSrupXu0sOBSnEmX/Qpb3NTYI7yol1pVUVy24XJXeuswmxdrqHnvj
         7P2TmGnAMEjLErkNyD+faGRw8rkg6d62NKDeR3cEpr9TnSCh+AM4Bd5TnNZkuLYERYBV
         JLDwbliBffcW2J1v1eE0ix9OTNWlo961cMJknTKft43TWG1mWe2wlbmtO3fZ0WLXkvTn
         xoBHSb0zFk0QnJZZ+OT/QqLYshrmi2iCuZFIttnNaUzJX5ILvimT6HxEFsVMGDBUzAdC
         MNUOUBnh1IMdKJa31DfbV4bvj31eae9wxr+k4RB9k2CBEB5o32bX8TrP6itsrsfqz4ID
         IYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hMM+U5uQzrfAfl+apatZhOIfSoVUQBO+zTVJBKz6bjU=;
        b=cJJJNgJXHDEdfm0cTD72yBCn5M8nh7yrQ6AXLr7OSb/zT5ORyRirrWEmo/rzKdp4/K
         O4UZTpTwuiKNel7k3MpT2baI9XhNxeK7rGdF53xan08hsm2celnOkvGbbvRVLAxwHqQI
         R7eI6HbZkqO4Vs5YBr0wyJj/ikmXKuashgEB/ttjY3WnrNnxIAYO4H7FgqpxIpxakAQZ
         WOyybYV77E58BSTyDJHuaiwokwvC2gsTU4DCKn//laSASMJpFCEwsop2pqVbxZPmMvkj
         5e7rcPIW2qVJ5vihnnwMSO461IksTJQVEoYrRmseKX1+3TIfOgpXHsRi4Lq0o3qxp6Yk
         JVLg==
X-Gm-Message-State: AHQUAuYPLZEfX+2rfxZTysuqbB6ND+ci4LcB/lilRotONIphYTLwu4Js
        1p7ytrrn7H9cxa9nrQTZkDo=
X-Google-Smtp-Source: AHgI3IZvxYCJKiPDVemn97o5vdUSqWPuNVG/QQBC9mfaG5Ft52ZNOZdoqcALQ68wHPYngaIPLbAILA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr2436336plb.120.1551278214963;
        Wed, 27 Feb 2019 06:36:54 -0800 (PST)
Received: from localhost.localdomain ([171.221.1.102])
        by smtp.googlemail.com with ESMTPSA id 33sm39097313pgs.81.2019.02.27.06.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 06:36:54 -0800 (PST)
From:   zerons <sironhide0null@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Sun <sironhide0null@gmail.com>
Subject: [PATCH] bpf: drop refcount if bpf_map_new_fd() fails in map_create()
Date:   Wed, 27 Feb 2019 22:36:25 +0800
Message-Id: <1551278185-5219-1-git-send-email-sironhide0null@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bpf/syscall.c, map_create() first set map->usercnt to 1, a file descriptor is
supposed to return to userspace. When bpf_map_new_fd() fails, drop the refcount.

Signed-off-by: Peng Sun <sironhide0null@gmail.com>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cf5040f..1c4f1c4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -558,12 +558,12 @@ static int map_create(union bpf_attr *attr)
 	err = bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
 		/* failed to allocate fd.
-		 * bpf_map_put() is needed because the above
+		 * bpf_map_put_with_uref() is needed because the above
 		 * bpf_map_alloc_id() has published the map
 		 * to the userspace and the userspace may
 		 * have refcnt-ed it through BPF_MAP_GET_FD_BY_ID.
 		 */
-		bpf_map_put(map);
+		bpf_map_put_with_uref(map);
 		return err;
 	}

--
2.7.4

