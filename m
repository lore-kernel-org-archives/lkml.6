Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC4FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0220854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD0220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeKLGJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:09:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53456 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeKLGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:09:43 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt4-0000l5-39; Sun, 11 Nov 2018 19:59:14 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001W6-8U; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Nathan Chancellor" <natechancellor@gmail.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.899768807@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 115/366] kconfig: Avoid format overflow warning from
 GCC 8.1
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit 2ae89c7a82ea9d81a19b4fc2df23bef4b112f24e upstream.

In file included from scripts/kconfig/zconf.tab.c:2485:
scripts/kconfig/confdata.c: In function ‘conf_write’:
scripts/kconfig/confdata.c:773:22: warning: ‘%s’ directive writing likely 7 or more bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
  sprintf(newname, "%s%s", dirname, basename);
                      ^~
scripts/kconfig/confdata.c:773:19: note: assuming directive output of 7 bytes
  sprintf(newname, "%s%s", dirname, basename);
                   ^~~~~~
scripts/kconfig/confdata.c:773:2: note: ‘sprintf’ output 1 or more bytes (assuming 4104) into a destination of size 4097
  sprintf(newname, "%s%s", dirname, basename);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/kconfig/confdata.c:776:23: warning: ‘.tmpconfig.’ directive writing 11 bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
   sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
                       ^~~~~~~~~~~
scripts/kconfig/confdata.c:776:3: note: ‘sprintf’ output between 13 and 4119 bytes into a destination of size 4097
   sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Increase the size of tmpname and newname to make GCC happy.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 scripts/kconfig/confdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -738,7 +738,7 @@ int conf_write(const char *name)
 	struct menu *menu;
 	const char *basename;
 	const char *str;
-	char dirname[PATH_MAX+1], tmpname[PATH_MAX+1], newname[PATH_MAX+1];
+	char dirname[PATH_MAX+1], tmpname[PATH_MAX+22], newname[PATH_MAX+8];
 	char *env;
 
 	dirname[0] = 0;

