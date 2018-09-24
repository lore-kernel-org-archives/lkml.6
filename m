Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CCECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047FE21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047FE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbeIXSka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbeIXSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76242107F;
        Mon, 24 Sep 2018 12:38:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4.18 137/235] xtensa: ISS: dont allocate memory in platform_setup
Date:   Mon, 24 Sep 2018 13:52:03 +0200
Message-Id: <20180924113119.431850381@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit ef439d49e0bfb26cd5f03c88b4cb7cc9073ed30c upstream.

Memory allocator is not initialized at that point yet, use static array
instead.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/xtensa/platforms/iss/setup.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/arch/xtensa/platforms/iss/setup.c
+++ b/arch/xtensa/platforms/iss/setup.c
@@ -78,23 +78,28 @@ static struct notifier_block iss_panic_b
 
 void __init platform_setup(char **p_cmdline)
 {
+	static void *argv[COMMAND_LINE_SIZE / sizeof(void *)] __initdata;
+	static char cmdline[COMMAND_LINE_SIZE] __initdata;
 	int argc = simc_argc();
 	int argv_size = simc_argv_size();
 
 	if (argc > 1) {
-		void **argv = alloc_bootmem(argv_size);
-		char *cmdline = alloc_bootmem(argv_size);
-		int i;
+		if (argv_size > sizeof(argv)) {
+			pr_err("%s: command line too long: argv_size = %d\n",
+			       __func__, argv_size);
+		} else {
+			int i;
 
-		cmdline[0] = 0;
-		simc_argv((void *)argv);
+			cmdline[0] = 0;
+			simc_argv((void *)argv);
 
-		for (i = 1; i < argc; ++i) {
-			if (i > 1)
-				strcat(cmdline, " ");
-			strcat(cmdline, argv[i]);
+			for (i = 1; i < argc; ++i) {
+				if (i > 1)
+					strcat(cmdline, " ");
+				strcat(cmdline, argv[i]);
+			}
+			*p_cmdline = cmdline;
 		}
-		*p_cmdline = cmdline;
 	}
 
 	atomic_notifier_chain_register(&panic_notifier_list, &iss_panic_block);


