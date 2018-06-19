Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1912083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1912083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966861AbeFSPr7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:47:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966638AbeFSPr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEF6B87903;
        Tue, 19 Jun 2018 15:47:57 +0000 (UTC)
Received: from treble.redhat.com (ovpn-123-40.rdu2.redhat.com [10.10.123.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE85D1117624;
        Tue, 19 Jun 2018 15:47:57 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] objtool: Add machine_real_restart() to the noreturn list
Date:   Tue, 19 Jun 2018 10:47:50 -0500
Message-Id: <791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:47:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 15:47:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_real_restart() is annotated as '__noreturn", so add it to the
objtool noreturn list.  This fixes the following warning with clang and
CONFIG_CC_OPTIMIZE_FOR_SIZE=y:

  arch/x86/kernel/reboot.o: warning: objtool: native_machine_emergency_restart() falls through to next function machine_power_off()

Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1f226f22ad75..fb63e2ca0ecc 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -164,6 +164,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"fortify_panic",
 		"usercopy_abort",
+		"machine_real_restart",
 	};
 
 	if (func->bind == STB_WEAK)
-- 
2.17.0

