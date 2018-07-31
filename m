Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F4220870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxbst5UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F4220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbeGaVfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:35:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbeGaVd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:33:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so6602227pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OvSvhiWGfKwBGltm/rvyh7qZB9008ij8gz9HAV4Lqk=;
        b=nxbst5UFI6ttwo3y5vEiDrfIHGj15RF08ksX5JVVnJ3mttwmbwFPcsE/dqobTs41Wq
         sg+Su0vlKSeGlE3IwmOTADJVSeNxNlS2hV1Sr08Yf4VrcMLc5PDuB50vCh027Vyg8ORI
         0yt7Mth7nY7TFX0KkXJROC8hXiE4OtCw/v05s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OvSvhiWGfKwBGltm/rvyh7qZB9008ij8gz9HAV4Lqk=;
        b=hEcJIKSDPIhyCGeFxvCPqhyqVLAh6cQjPVJgKAx7N9G7d0LJD2QT7DEPkMqD6xuTC0
         UciYZPdnr62hVq8uKeTHp1ewYo83Ptb79Zqq2nE8oRfOeIacY/QSjJWoG0ZjVy/qAQZZ
         ztZSYufKvqCiisdDFTI3JnFyHft1Ns2FWKJluFw4mkZ001d54l2WilLGOpcrxTlvSs/B
         PpCTWC0ciC3GrIqX6VTyoCrUvxditRJiMAwhqz2o8QviK5j+NFgvFtaAA+JsgjlaV7/C
         hqwR3erHvpca0J1fenCWFqliTzBa+FyytewV7qDMMAnbeaux43+yJax+/zDmI/y77+xo
         D+QA==
X-Gm-Message-State: AOUpUlGAAT1tC5lulp9n5/6aNA4EO0gkx4l4KQ9ilvYcIhylR10hw0kP
        Yjf/ggX6nrv9iD7fBMmyyIehmA==
X-Google-Smtp-Source: AAOMgpfA8TnocLtlFK3lIbE2T0YqEIB06abj6GF5He1qlw2z57cOFNeRcI+TbAtFFn5/LrtDNHAf7Q==
X-Received: by 2002:a63:81c3:: with SMTP id t186-v6mr22027654pgd.413.1533066725831;
        Tue, 31 Jul 2018 12:52:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h130-v6sm31309276pgc.88.2018.07.31.12.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:52:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] target: don't depend on SCSI
Date:   Tue, 31 Jul 2018 12:51:49 -0700
Message-Id: <20180731195155.46664-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180731195155.46664-1-keescook@chromium.org>
References: <20180731195155.46664-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

The core target code only needs code from scsi_common.c, which is now
separately selectable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/target/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
index 4c44d7bed01a..cb6f32ce7de8 100644
--- a/drivers/target/Kconfig
+++ b/drivers/target/Kconfig
@@ -1,10 +1,10 @@
 
 menuconfig TARGET_CORE
 	tristate "Generic Target Core Mod (TCM) and ConfigFS Infrastructure"
-	depends on SCSI && BLOCK
+	depends on BLOCK
 	select CONFIGFS_FS
 	select CRC_T10DIF
-	select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
+	select BLK_SCSI_REQUEST
 	select SGL_ALLOC
 	default n
 	help
@@ -29,6 +29,7 @@ config TCM_FILEIO
 
 config TCM_PSCSI
 	tristate "TCM/pSCSI Subsystem Plugin for Linux/SCSI"
+	depends on SCSI
 	help
 	Say Y here to enable the TCM/pSCSI subsystem plugin for non-buffered
 	passthrough access to Linux/SCSI device
-- 
2.17.1

