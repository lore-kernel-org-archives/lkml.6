Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73212217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLSQwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:52:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeLSQwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:52:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DB7F13268C;
        Wed, 19 Dec 2018 16:52:22 +0000 (UTC)
Received: from dba62.ml3.eng.bos.redhat.com (dba62.ml3.eng.bos.redhat.com [10.19.176.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2549B6B465;
        Wed, 19 Dec 2018 16:52:21 +0000 (UTC)
From:   David Arcari <darcari@redhat.com>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        David Arcari <darcari@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date:   Wed, 19 Dec 2018 11:50:52 -0500
Message-Id: <1545238252-79630-1-git-send-email-darcari@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 19 Dec 2018 16:52:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lenny Szubowicz <lszubowi@redhat.com>

In __ghes_panic() clear the block status in the APEI generic
error status block for that generic hardware error source before
calling panic() to prevent a second panic() in the crash kernel
for exactly the same fatal error.

Otherwise ghes_probe(), running in the crash kernel, would see
an unhandled error in the APEI generic error status block and
panic again, thereby precluding any crash dump.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 02c6fd9..f008ba7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
 {
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
 
+	ghes_clear_estatus(ghes);
+
 	/* reboot to log the error! */
 	if (!panic_timeout)
 		panic_timeout = ghes_panic_timeout;
-- 
1.8.3.1

