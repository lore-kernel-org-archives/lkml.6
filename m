Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78104C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB432081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB432081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeKHAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:07:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35612 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:07:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so14954381otj.2;
        Wed, 07 Nov 2018 06:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VouxqWOT6eWXICQeIhzscdfQgU1z4wiPv+oBxIzj5Dw=;
        b=dg7og95nAxOp0T3kfl3fu8nHHQkhX0AEpoQA4luRkxRjJjorviQBi9awYq/Wl+f338
         6i/iCeSv20Ykad1qkkYuzhJQj7HQJF3Y7RsE90u7LgjIZFLP7O+n3U/bUhtg3XwIigQD
         lH4Y4xAlr3XOyGiYETDWYQFsUoY0Qk8XMzXUs90w/DIaPyfi70mLMfWSbwTs11I8+/9m
         xlbLjuXTxXfc0IdiaNQ3O6RW4ibD3gxn30vHBgwoWhSn8KEOIG0AeJ9+WpbLHIs88bKq
         Xa66Y0VX9j0oH6DDy2NRZBA4Mw5dyFGNoD4JbWmXh6ZfK1irIgHQ2cLCIPoTHuSo4dbC
         EX/w==
X-Gm-Message-State: AGRZ1gI6UplMKKZkDkB0B0Shqq9+W/pkRz2PUp/0thjbUgNB/5TPch9b
        /7sO+KD9h4GhDJaTR8BVQxP18OQ=
X-Google-Smtp-Source: AJdET5cBtZCmDWrdsELvjA2sdm9Gys99HnJTziFCNwcNa5vKgpI/Nfsuo25cscAj0SwDK3ZoH6FEIA==
X-Received: by 2002:a9d:26ec:: with SMTP id i41mr264773otd.29.1541601408740;
        Wed, 07 Nov 2018 06:36:48 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x92sm278265ota.55.2018.11.07.06.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:36:47 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        =?UTF-8?q?Nuno=20Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: [PATCH] builddeb: Fix inclusion of dtbs in debian package
Date:   Wed,  7 Nov 2018 08:36:46 -0600
Message-Id: <20181107143646.27675-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
moved the location of 'dtbs_install' target which caused dtbs to not be
installed when building debian package with 'bindeb-pkg' target. Update
the builddeb script to use the same logic that determines if there's a
'dtbs_install' target which is presence of the arch dts directory. Also,
use CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF as that's a better
indication of whether we are building dtbs.

This commit will also have the side effect of installing dtbs on any
arch that has dts files. Previously, it was dependent on whether the
arch defined 'dtbs_install'.

Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/package/builddeb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 90c9a8ac7adb..594b626d83d6 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -83,9 +83,9 @@ else
 fi
 cp "$($MAKE -s image_name)" "$tmpdir/$installed_image_path"
 
-if grep -q "^CONFIG_OF=y" $KCONFIG_CONFIG ; then
+if grep -q "^CONFIG_OF_EARLY_FLATTREE=y" $KCONFIG_CONFIG ; then
 	# Only some architectures with OF support have this target
-	if grep -q dtbs_install "${srctree}/arch/$SRCARCH/Makefile"; then
+	if [ -d "${srctree}/arch/$SRCARCH/boot/dts" ]; then
 		$MAKE KBUILD_SRC= INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
 	fi
 fi
-- 
2.19.1

