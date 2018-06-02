Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeFBQBo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 12:01:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37102 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFBQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 12:01:42 -0400
X-Google-Smtp-Source: ADUXVKL2zjmuczihMZbv+5+TpwawFmuwYRVeZsq+Q1Ytij8UsrsDMcI64UdmEODO/0o2dJunkOUNpw==
From: Nathan Chancellor <natechancellor@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] kconfig: Avoid format overflow warning from GCC 8.1
Date: Sat,  2 Jun 2018 09:02:09 -0700
Message-Id: <20180602160209.23605-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 scripts/kconfig/confdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 5f87ad561b08..39e20974f4a3 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -720,7 +720,7 @@ int conf_write(const char *name)
 	struct menu *menu;
 	const char *basename;
 	const char *str;
-	char dirname[PATH_MAX+1], tmpname[PATH_MAX+1], newname[PATH_MAX+1];
+	char dirname[PATH_MAX+1], tmpname[PATH_MAX+22], newname[PATH_MAX+8];
 	char *env;
 
 	dirname[0] = 0;
-- 
2.17.1
