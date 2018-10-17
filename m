Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDDFECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA6921528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4vof5xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA6921528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJQXWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:22:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39419 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQXWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:22:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id p1-v6so24742723ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CWDfQHejJxb56YWPrs3uapt60VBxS9nOcz4x9QTcLs=;
        b=j4vof5xviRjUaME4E9EyHZbgWvb0jzZQla7t6wiqOGjBqk4U4Ev3u4JVvkaQAacFME
         mkVtJOr3T1zuTPHQfWkO1YEii6viLPFSQ6n9sUDneaIWzCxImFpXajYgzNLLWxzCwpaX
         ks6I5S3mB2OgBqGBqt7nM0PB+3bYCNYaCNSTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CWDfQHejJxb56YWPrs3uapt60VBxS9nOcz4x9QTcLs=;
        b=NbHoqsUuyFoeS3pF7pdAa1M9VYzZYW7+V29ftBitDubHKdWYfaDJbW5o3mlUKTO7A4
         9lBoRsof6acqHN5jFBmZuDrR2opgOQ3Q4sBfHpEdR5QXbyaFgIS7FU38AK2uf0jUVf85
         6z36A9ZWbT7Z/yPLuSITt9xdrErVe6dNyNda6vAw51jAzd0QSfKdkhDyD98GgzQsolPP
         qhCIqqfgiiZxnglIpnIRq5Ehq5W1kzDMAR/d5MFZkL+w9PVpalKeLrhkWwEwogoh2K16
         5LZBrvO7m/Bv7vaEj4QbdbSghIs5iZ7oxCVQ6bdIVVWKnfMQ0WBnPENcIfKe1UuDH8xQ
         +FRA==
X-Gm-Message-State: ABuFfogSUcXrXy1l5pC6kG53qYCmRNDMeNcJaiRS9CBmWNtiGArYhe7n
        +gZvPuYpChhHwfD5fmFRxwu8Hg==
X-Google-Smtp-Source: ACcGV639rv5jWvaSyS6dJP+hQ9IUkEG3qCkAgfQgsuycTbtqY08WLKoJRo+Ic2Prrll5YSC6roA1hw==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr16762831lje.81.1539789988514;
        Wed, 17 Oct 2018 08:26:28 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id r6-v6sm3861476lff.0.2018.10.17.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 08:26:27 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arm64: perf: set suppress_bind_attrs flag to true
Date:   Wed, 17 Oct 2018 17:26:22 +0200
Message-Id: <20181017152622.15717-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The armv8_pmuv3 driver doesn't have a remove function, and when the test
'CONFIG_DEBUG_TEST_DRIVER_REMOVE=y' is enabled, the following Call trace
can be seen.

[    1.424287] Failed to register pmu: armv8_pmuv3, reason -17
[    1.424870] WARNING: CPU: 0 PID: 1 at ../kernel/events/core.c:11771 perf_event_sysfs_init+0x98/0xdc
[    1.425220] Modules linked in:
[    1.425531] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-rc7-next-20181012-00003-ge7a97b1ad77b-dirty #35
[    1.425951] Hardware name: linux,dummy-virt (DT)
[    1.426212] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.426458] pc : perf_event_sysfs_init+0x98/0xdc
[    1.426720] lr : perf_event_sysfs_init+0x98/0xdc
[    1.426908] sp : ffff00000804bd50
[    1.427077] x29: ffff00000804bd50 x28: ffff00000934e078
[    1.427429] x27: ffff000009546000 x26: 0000000000000007
[    1.427757] x25: ffff000009280710 x24: 00000000ffffffef
[    1.428086] x23: ffff000009408000 x22: 0000000000000000
[    1.428415] x21: ffff000009136008 x20: ffff000009408730
[    1.428744] x19: ffff80007b20b400 x18: 000000000000000a
[    1.429075] x17: 0000000000000000 x16: 0000000000000000
[    1.429418] x15: 0000000000000400 x14: 2e79726f74636572
[    1.429748] x13: 696420656d617320 x12: 656874206e692065
[    1.430060] x11: 6d616e20656d6173 x10: 2065687420687469
[    1.430335] x9 : ffff00000804bd50 x8 : 206e6f7361657220
[    1.430610] x7 : 2c3376756d705f38 x6 : ffff00000954d7ce
[    1.430880] x5 : 0000000000000000 x4 : 0000000000000000
[    1.431226] x3 : 0000000000000000 x2 : ffffffffffffffff
[    1.431554] x1 : 4d151327adc50b00 x0 : 0000000000000000
[    1.431868] Call trace:
[    1.432102]  perf_event_sysfs_init+0x98/0xdc
[    1.432382]  do_one_initcall+0x6c/0x1a8
[    1.432637]  kernel_init_freeable+0x1bc/0x280
[    1.432905]  kernel_init+0x18/0x160
[    1.433115]  ret_from_fork+0x10/0x18
[    1.433297] ---[ end trace 27fd415390eb9883 ]---

Rework to set suppress_bind_attrs flag to avoid removing the device when
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y, since there's no real reason to
remove the armv8_pmuv3 driver.

Cc: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 8e38d5267f22..5ffcb54fde3f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1267,6 +1267,7 @@ static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
 		.name	= ARMV8_PMU_PDEV_NAME,
 		.of_match_table = armv8_pmu_of_device_ids,
+		.suppress_bind_attrs = true,
 	},
 	.probe		= armv8_pmu_device_probe,
 };
-- 
2.19.1

