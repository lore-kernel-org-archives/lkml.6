Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC24C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8201A217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="I6JQ/yot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfB0Uww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:52:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36418 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfB0Uwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:52:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id c2so10035769qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Pqif0CrV1iUCG/KA2vWPDRwvp9OJTIFlQ54VsyglFrA=;
        b=I6JQ/yotuISU27iCbP/uRP3BXZAQTkjhUR8mLvqgVXslpFqQXt7qTFRGq59Q4nhyR+
         N4zyfRHkeZxbfUuUCjOCQUrAl+8S3gcZi4SHSM/Vwq242ev6SMYWQooULcmqx4kknsq0
         zzPv1kWgZKXquriQC1JvPAOivaQeiCCR478M+JtAHgWv5zvbRFTNCaCvW8ei4XQBJRzn
         mSaxEThp0/UAwIXc8kiQ5p2ubj9UN6nKb79wUdtsByzN5+bE1lhhdNoVnY2LKRTwB2pe
         ysup6SCRVBW9W/RaToCsKq4EdOUU16VzmsE/lBmU259HjOJKhaBqftWmm/LuYNCoT8KG
         9DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pqif0CrV1iUCG/KA2vWPDRwvp9OJTIFlQ54VsyglFrA=;
        b=HrMGR/6lgdOfND2I7+TKa8Y0w0bSUx00yC/4eVFHPAofls+NoRUXn3WLZLXuGtD5oZ
         8sCRmhkPXMCbVNswuwovZxWNcgZx9vo/CwyfCxaf95M5p1kzkQRROlovWmiIT7dZ2Pel
         vlfxmh5fry0EEkKCQy1znt0+Zj9FX7c35w4eYFJDvyGPsUhn+o6hR9oRbnK6W45QAznb
         QU8gY8pYqGZq3rwpDsNOrPf0UFyQwVfs2SPPsZSEtv0ky4pgjaM2EN/pIhRhiedMzs7R
         5lDCcWH87vSjaD+LnmmXI8NiNH/KdlXvk7xB9pjTdigyAfrAMEBkr14N6lnWu28w2z9c
         tO0Q==
X-Gm-Message-State: AHQUAuYdTMCEGOLFnWWb+r35b6nIVmW3o7Jfj9kCE/VozLn9YHmUIqH5
        7+LhS4td2Asj/9jEQNeJsINQTA==
X-Google-Smtp-Source: APXvYqzYA320jkBa30rVZ8/Hy5ED0MteiZaFxbekgU5Qe61z837GoDl3ta9VgsPAWBqNcKkBww7QDg==
X-Received: by 2002:a37:491:: with SMTP id 139mr3775133qke.345.1551300770136;
        Wed, 27 Feb 2019 12:52:50 -0800 (PST)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z190sm9073932qkb.9.2019.02.27.12.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:52:49 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] memcg: fix a bad line
Date:   Wed, 27 Feb 2019 15:52:42 -0500
Message-Id: <20190227205242.77355-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miss a star.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b32389..d4b96dc4bd8a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5747,7 +5747,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  *
  *             | memory.current, if memory.current < memory.low
  * low_usage = |
-	       | 0, otherwise.
+ *	       | 0, otherwise.
  *
  *
  * Such definition of the effective memory.low provides the expected
-- 
2.17.2 (Apple Git-113)

