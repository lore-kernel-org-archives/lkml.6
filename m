Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2377C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0A02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfAGJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:29:57 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:43346 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfAGJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:29:54 -0500
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id MMVt1z00B3XaVaC01MVt1E; Mon, 07 Jan 2019 10:29:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggREH-0003KU-Ax; Mon, 07 Jan 2019 10:29:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ggREH-0003pg-8q; Mon, 07 Jan 2019 10:29:53 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/atari: Avoid VLA use in atari_switches_setup()
Date:   Mon,  7 Jan 2019 10:29:52 +0100
Message-Id: <20190107092952.14691-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 7.3.0:

    arch/m68k/atari/config.c: In function ‘atari_switches_setup’:
    arch/m68k/atari/config.c:151:2: warning: ISO C90 forbids variable length array ‘switches’ [-Wvla]
      char switches[strlen(str) + 1];
      ^~~~

Replace the variable size by the maximum kernel command line size (512
bytes), which is an upper limit for all suboptions.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/atari/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index bd96702a1ad09773..4fcc4b1df1c0f2b4 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -148,7 +148,7 @@ int __init atari_parse_bootinfo(const struct bi_record *record)
 /* Parse the Atari-specific switches= option. */
 static int __init atari_switches_setup(char *str)
 {
-	char switches[strlen(str) + 1];
+	char switches[COMMAND_LINE_SIZE];
 	char *p;
 	int ovsc_shift;
 	char *args = switches;
-- 
2.17.1

