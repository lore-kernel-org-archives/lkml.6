Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F8C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C082082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 02:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OvxtBFTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C082082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLJChX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 21:37:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43191 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLJChW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 21:37:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so4244794pgk.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 18:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2I3FgBsmgwiN9LGZSFfLY9YBknYQAXhTGYoZTcvMOeY=;
        b=OvxtBFTxwTPsjINYGxGsZHKHM9cnzDHKUz+TbNJUWl89598FhUfFxtq0++JmogoZGA
         32kxneoeJOeWhUG8WPKg2omtlYUDP9yYQumWml+zSlo0eZ7kQtiPflL4Tg6yFBuVSu+h
         2zx4wj/1jEZZKFT8DC6jBluowQ0JNrc2tAsOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2I3FgBsmgwiN9LGZSFfLY9YBknYQAXhTGYoZTcvMOeY=;
        b=Cvo82hU4QAfY3qQAMOysrY9BLsL6xKiKa+Igp1duFG8VPidzudUvzFSNxDAWhtkk4O
         UQYhg1UnGNZK6CRzX7uMicjAQD2Y7HT+JwsZCjL7k1kN6B2YZXyGjFzgkklRYGGEXsfW
         bl73Bhzba0FBQRAVrhuPou/C/MccH6H5ns23JarHz+n8Y3Pa+Sv1Wv0UhtTSmm0eYaBO
         numApcxtRgBB+S4Hn3mGvOFU+rzcOFi8cjcsGfHfNMYj3AmyNkm6lbh1DdiJjIJO6tds
         Tyh6HP7+SVjEoSo+3GS+gPrp8Ib1rFYpZ06amxJv4IkhHjIH/TCrYbUmhr0hB9whyZlO
         d8yQ==
X-Gm-Message-State: AA+aEWasE5E0U8ZBXXxrrL8lZ1tHDb+8eJkXSrR8YlGwtS5Bf6TNJ16z
        +iXVpJeN9pnKy/wXU8lggLe4WleEqBo=
X-Google-Smtp-Source: AFSGD/XDUMnHU6xAWigk+/BK+Z/MT1yGo7fcn9wsB0iNbxQCbdxNfiix92W69vXBOh1pqeeDKTwNVg==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr9395032pgh.30.1544409441635;
        Sun, 09 Dec 2018 18:37:21 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id 84sm18400660pfk.134.2018.12.09.18.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 18:37:20 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     briannorris@chromium.org, Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] debug: Allow forcing entering debug mode on panic/exception
Date:   Sun,  9 Dec 2018 18:36:49 -0800
Message-Id: <20181210023649.229271-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since commit 5516fd7b92a7 ("debug: prevent entering debug mode on
panic/exception.") (yes, years ago) my kgdb workflow has been broken.
On Chrome OS we have 'kernel.panic = -1' in
'/etc/sysctl.d/00-sysctl.conf'.  That means that when userspace starts
up it will tell the kernel "please reboot on panic".  ...and so when I
get a panic then the system reboots instead of letting me debug it.

While I could go in an change the 'sysctl.conf' and I could go in and
hack the kernel myself, these things are inconvenient.  I either need
to keep a private kernel patch or or remember to edit a file every
time I install an updated version of Chrome OS.  What is convenient
(for me) is to have a CONFIG option that makes kgdb override the panic
request.  This is because the Chrome OS build system makes it very
easy for me to add some extra CONFIG "fragments" to my debug kernels.

Hopefully having this extra config option is OK and useful to others
who would also prefer to make sure that kgdb is always entered on a
panic no matter what userspace might request.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/debug_core.c |  5 +++--
 lib/Kconfig.kgdb          | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 65c0f1363788..d4a38543fcdd 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -703,7 +703,8 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 	 * reboot on panic. We don't want to get stuck waiting for input
 	 * on such systems, especially if its "just" an oops.
 	 */
-	if (signo != SIGTRAP && panic_timeout)
+	if (!IS_ENABLED(CONFIG_KGDB_ALWAYS_ENTER_ON_PANIC) &&
+	    signo != SIGTRAP && panic_timeout)
 		return 1;
 
 	memset(ks, 0, sizeof(struct kgdb_state));
@@ -843,7 +844,7 @@ static int kgdb_panic_event(struct notifier_block *self,
 	 * panic_timeout indicates the system should automatically
 	 * reboot on panic.
 	 */
-	if (panic_timeout)
+	if (!IS_ENABLED(CONFIG_KGDB_ALWAYS_ENTER_ON_PANIC) && panic_timeout)
 		return NOTIFY_DONE;
 
 	if (dbg_kdb_mode)
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index ab4ff0eea776..f12c6e1394c6 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -67,6 +67,16 @@ config KGDB_LOW_LEVEL_TRAP
          exception handler which will allow kgdb to step through a
          notify handler.
 
+config KGDB_ALWAYS_ENTER_ON_PANIC
+       bool "KGDB: Enter kgdb on panic even if reboot specified"
+       default n
+       help
+         If kgdb is enabled and the system is configured to reboot on
+         panic then there's a question of whether we should drop into
+         kgdb on panic or whether we should reboot on panic.  If you
+         say yes here then we'll enter kgdb.  If you say no here then
+         we'll reboot.
+
 config KGDB_KDB
 	bool "KGDB_KDB: include kdb frontend for kgdb"
 	default n
-- 
2.20.0.rc2.403.gdbc3b29805-goog

