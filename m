Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeB1AQv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:16:51 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24307 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeB1AQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahl000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] kconfig: do not call check_conf() for olddefconfig
Date: Wed, 28 Feb 2018 09:15:21 +0900
Message-Id: <1519776926-30459-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_conf() traverses the menu tree, but it is completely no-op for
olddefconfig because the following if-else block does nothing.

    if (input_mode == listnewconfig) {
            ...
    } else if (input_mode != olddefconfig) {
            ...
    }

As the help message says, olddefconfig automatically sets new symbols
to their default value.  There is no room for manual intervention.
So, calling check_conf() for olddefconfig is odd in the first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2: None

 scripts/kconfig/conf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 822dc51..4227d3b 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -424,7 +424,7 @@ static void check_conf(struct menu *menu)
 				if (sym->name && !sym_is_choice_value(sym)) {
 					printf("%s%s\n", CONFIG_, sym->name);
 				}
-			} else if (input_mode != olddefconfig) {
+			} else {
 				if (!conf_cnt++)
 					printf(_("*\n* Restart config...\n*\n"));
 				rootEntry = menu_get_parent_menu(menu);
@@ -666,15 +666,15 @@ int main(int ac, char **av)
 		/* fall through */
 	case oldconfig:
 	case listnewconfig:
-	case olddefconfig:
 	case silentoldconfig:
 		/* Update until a loop caused no more changes */
 		do {
 			conf_cnt = 0;
 			check_conf(&rootmenu);
-		} while (conf_cnt &&
-			 (input_mode != listnewconfig &&
-			  input_mode != olddefconfig));
+		} while (conf_cnt && input_mode != listnewconfig);
+		break;
+	case olddefconfig:
+	default:
 		break;
 	}
 
-- 
2.7.4
