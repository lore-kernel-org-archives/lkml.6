Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ACECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B6D21476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKkqBpjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B6D21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeJRBLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:11:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52620 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJRBLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:11:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so2788217wmw.2;
        Wed, 17 Oct 2018 10:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSeFPlVaCUcJGC0rSCPBJJDa1W19XIpsTzNLSCGqJI8=;
        b=eKkqBpjomihhpNJbc0QrXSgfUfGsTHjSMBBr5C+3P58kKConCI2/SZ4HF/Vc7JfHU7
         peYEKJxHy9Xvohw04Tmt7tDZfmH25FfpEztqqKl6H4s87fQDauny2zRS1x6eHoXffFcK
         78mSQXZRY0Uhh6QYKTvxfJUGdRCwt1GpsHdHzjyglptwGXfXSNo4TK6AL5vP95liWdqo
         9uo7fk9KyRscrCiJZ5PSfgJEC7ly6DcryKMK7kbcMmwajj8Pg9QXtJdeYRO9WNcLJO9F
         NDEt+6rJIfu9++ZI4oIkX+J88Fz/OLR6FOUzVGf86PT4OpmFknYYv1j/lNBOixQSi262
         xThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gSeFPlVaCUcJGC0rSCPBJJDa1W19XIpsTzNLSCGqJI8=;
        b=o74+qu9Razty6OKoc0kkodaO15c9S4HPAFmdiR11Q0P0Skf3kYTI/W0WM2grosUDID
         nIbJU/ghu7ec1MKlCIDhVWlBfh4O1dG1Gwi5N/AU+gVTeq/FewHBU5VOEKpR9hFBcXqd
         qtjCl8FXJLuIchl6OGCyNlfbfKATDkym576LdJZPxAxglpnMBG59scm1eM43PygIJALX
         mU4dAt/3GmZahXDKGaISe8GpU7l+G4akZ/t0iDkM3VaxYJVFjvPc141WGRPZb+veFtrA
         EOpYvDjPoTdgnEKCA/WbGlgsRjpYgRLo6Z0lrsPYFTjSV+9E+CTCbCT1LN70ZuRnAnti
         p3uA==
X-Gm-Message-State: ABuFfohD93BR8eBr+oUJGgj4FszfOwcYFhjruQixoBEH6oAPmlqjn9qv
        SC/oY1C+gu+BI7XBB245C9rVzR/A8WlORg==
X-Google-Smtp-Source: ACcGV61qsjh/xk7vhxyJou5tSGFbZlj2KSgiQQ4323f+THEzfi8nWfjJQg1AKaCsjcUtVkBpxHDPCQ==
X-Received: by 2002:a1c:ce47:: with SMTP id e68-v6mr3643693wmg.45.1539796496646;
        Wed, 17 Oct 2018 10:14:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q77-v6sm3983124wmd.33.2018.10.17.10.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 10:14:55 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mfd: twl-core: Fix section annotations on {,un}protect_pm_master
Date:   Wed, 17 Oct 2018 10:13:23 -0700
Message-Id: <20181017171322.13572-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang, the following section mismatch
warning appears:

WARNING: vmlinux.o(.text+0x3d84a3b): Section mismatch in reference from
the function twl_probe() to the function
.init.text:unprotect_pm_master()
The function twl_probe() references
the function __init unprotect_pm_master().
This is often because twl_probe lacks a __init
annotation or the annotation of unprotect_pm_master is wrong.

Remove the __init annotation on the *protect_pm_master functions so
there is no more mismatch.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Alternatively, I suppose that twl_probe could be marked as __init but
I'm not sure if deferral is possible or not (which I believe would cause
issues but not sure). I went with this more conservative approache but
I'm happy to respin if necessary.

Thanks!

 drivers/mfd/twl-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 4be3d239da9e..299016bc46d9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -979,7 +979,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
  * letting it generate the right frequencies for USB, MADC, and
  * other purposes.
  */
-static inline int __init protect_pm_master(void)
+static inline int protect_pm_master(void)
 {
 	int e = 0;
 
@@ -988,7 +988,7 @@ static inline int __init protect_pm_master(void)
 	return e;
 }
 
-static inline int __init unprotect_pm_master(void)
+static inline int unprotect_pm_master(void)
 {
 	int e = 0;
 
-- 
2.19.1

