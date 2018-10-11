Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D354CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A1E20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="conurzDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A1E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJKLvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:51:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46782 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJKLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:51:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so3703293pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eo0/lgHe1smMQVcU6LL1rMDXfSWQZhHYdLIxRFbBwkU=;
        b=conurzDcr3BQR4CNtTQpoMxcd7CWsweu5heZx6fp5CNU7U5m0oEgEwEY4efUjTODPU
         44tli1YAN036yVoTrTJ/XYdH4Oux5qVds7oqkmMHmzv+jLcJsGurAQ1ZBtsWhQ9NVrBf
         vGqTj8+kV/02IeIQSrbOodjPkGRnHz3AdmTnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eo0/lgHe1smMQVcU6LL1rMDXfSWQZhHYdLIxRFbBwkU=;
        b=VHNitDFhIBGUsJEqYF7T3d1cjFSsvbG/FVcrUKDb/2XVQp6eXdTIkgBqw/ADePZLnP
         HBhwoMcfffPwLadhp70mviKJkUM+dpeZwWmu3jXss3b6hr834wNmWKNh+jywOftWwezJ
         TBpMCSofmH7gNpwj5iPb3MlHkP9EU8U4GvWD+MQkv5cDST7qP10hFj72ZSXSM7qb/Eer
         y5uWZwd7JH2YZrDzbcM3zf59hV39W2gOYyrH21/mUNfU+8u0/sqKDMxrCGwo5Qwn9v4O
         4zm6WIC6D4ip216fsq+7IlNRz4baeP3xRydfIDMR7xSPBxG6EEKTqtUXBxetcw+sCO7j
         JD/g==
X-Gm-Message-State: ABuFfoj58WkpQFCMoioCBiQQcqGXO95bdEhryfj62LnvHKNviGhyu+Ip
        D57HAfP4Wixr0ugy214IAPZNtg==
X-Google-Smtp-Source: ACcGV626lYORsw2UuDUALgDqGjkUNVRKnXq/8M7DZgrpSfP2jryhdJFen6im46BvV93rLEtiOoiteQ==
X-Received: by 2002:a62:2741:: with SMTP id n62-v6mr30510328pfn.138.1539231958752;
        Wed, 10 Oct 2018 21:25:58 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n63-v6sm26113748pfn.9.2018.10.10.21.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 21:25:58 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 7/7] ia64: wire up system calls
Date:   Thu, 11 Oct 2018 09:54:55 +0530
Message-Id: <1539231895-4118-8-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wire up perf_event_open, seccomp, pkey_mprotect, pkey_alloc,
pkey_free, statx, io_pgetevents and rseq system calls

This require an architecture specific implementation as it not
present now.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6b64f60..1f42b60 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -335,3 +335,19 @@
 323     common  copy_file_range                 sys_copy_file_range
 324     common  preadv2                         sys_preadv2
 325     common  pwritev2                        sys_pwritev2
+# perf_event_open requires an architecture specific implementation
+326	common	perf_event_open			sys_perf_event_open
+# seccomp requires an architecture specific implementation
+327	common	seccomp				sys_seccomp
+# pkey_mprotect requires an architecture specific implementation
+328	common	pkey_mprotect			sys_pkey_mprotect
+# pkey_alloc requires an architecture specific implementation
+329	common	pkey_alloc			sys_pkey_alloc
+# pkey_free requires an architecture specific implementation
+330	common	pkey_free			sys_pkey_free
+# statx requires an architecture specific implementation
+331	common	statx				sys_statx
+# io_pgetevents requires an architecture specific implementation
+332	common	io_pgetevents			sys_io_pgetevents
+# rseq requires an architecture specific implementation
+333	common	rseq				sys_rseq
-- 
1.9.1

