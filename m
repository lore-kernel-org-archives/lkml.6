Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6093FECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1133520856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+7JJTu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1133520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbeGUO27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43571 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so9065372pgr.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19/g7fJMwhKFD+tRGYxB57t+9WX7azPDCbZdJLAQrJw=;
        b=G+7JJTu14zj5eyXEaz3LZgG4/WpkqLJt8tQvvW0VOl3hNepmpkbx65P4xCt9yP2deQ
         n21vTRE29KUEhCpzOyr0tW35UcOjylgxDF1xE8kuYbtSHWkp+BbsgtsOghH5k7nFL2AJ
         mnX54IYEmnOSCpB0N1YZk0oIppLIBpyHH/kCwfxGxdiKlFH8eID1EPworgR7FpwxOjm+
         jL5l8Nbip3/exBQyu+hED4L5VdE3WrSaudbeBo/F2A4Obq8NJKhctAcMmo8bFEQmZz9g
         ZicWarNxX9+6eTl6xGfRzb8ACqE6rc2j+fB4blGo+D4BKmJha3/imLycwo+EN6u6G8tb
         tR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19/g7fJMwhKFD+tRGYxB57t+9WX7azPDCbZdJLAQrJw=;
        b=Pb4QKRZSqPR0ZJX6Wnz92xRyVWZ4qJRKRz80NlUI3jJXC/2a0uJEMBD56rtK+6sgcH
         yD71ChxNnWyejj6veSXoPoslqWJh0VzXZnF/R6b2q4neOd6wngn+azcUJf6np44cjG94
         +K97v2nFjuW4K6W9IEi6zj215ApsQ0735jNscvRqiiuRfhknZnKSe4cob8yB7CsK3HEG
         rkYoHESx6+XlERzLkZwt9kRhilxFnkNAd97lZedQ3mw6x4xmncxSi8StXFYgtLaTCcgD
         D+f09/lFuwxP41T53hMZYp2y2TUKWEzdgakEIC770vq+aJwuPH74/M21a3RNwp8bv+t8
         COaA==
X-Gm-Message-State: AOUpUlHyHHOQw6xZ6/omqYlfZyUtZngSVLHrPdTNhE32YXNRavlKak11
        lw2jBE16bedl4B7Tyu1Lq0o=
X-Google-Smtp-Source: AAOMgpcSSrJtdUsuuDUF33A73xdkCuD2PfA1rjvDsroDgXSCl2NKCdg1tVAJ4uE2wNwZk00qt9L6Hw==
X-Received: by 2002:a63:cc04:: with SMTP id x4-v6mr5594215pgf.33.1532180125695;
        Sat, 21 Jul 2018 06:35:25 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:25 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/14] staging: gasket: remove unnecessary NULL checks on calls from VFS
Date:   Sat, 21 Jul 2018 06:34:59 -0700
Message-Id: <20180721133507.95599-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded checks for NULL pointers in struct file pointers passed
from the VFS layer or the private_data that must have been properly set
at file open time.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 11ab049854493..e82f8ce39c9fd 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1587,11 +1587,6 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	int num_map_regions = 0;
 	enum do_map_region_status map_status;
 
-	if (!gasket_dev) {
-		gasket_nodev_error("Unable to retrieve device data");
-		trace_gasket_mmap_exit(-EINVAL);
-		return -EINVAL;
-	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
 	if (vma->vm_start & ~PAGE_MASK) {
@@ -1785,17 +1780,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 	void __user *argp = (void __user *)arg;
 	char path[256];
 
-	if (!filp)
-		return -ENODEV;
-
 	gasket_dev = (struct gasket_dev *)filp->private_data;
-	if (!gasket_dev) {
-		gasket_nodev_error(
-			"Unable to find Gasket structure for file %s",
-			d_path(&filp->f_path, path, 256));
-		return -ENODEV;
-	}
-
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	if (!driver_desc) {
 		gasket_log_error(
-- 
2.18.0.233.g985f88cf7e-goog

