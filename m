Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9988C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA2E21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBGMar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:30:47 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:41136 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726769AbfBGMar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:30:47 -0500
Received: from localhost (94.234.45.123) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb 2019 13:30:41
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>
CC:     <2pi@mok.nu>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] modpost: file2alias: define size of alias
Date:   Thu, 7 Feb 2019 13:30:22 +0100
Message-ID: <20190207123022.7961-1-2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.45.123]
X-ClientProxiedBy: PROXY01.HMC.local (192.168.46.51) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of the variable alias provided to do_entry functions are
currently not readily available. Thus hindering do_entry functions to
perform bounds checking.

Define the macro ALIAS_SIZE containing the size of the variable alias.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---

Related discussion: [1] and [2] (around the first answer line)

[1]: https://lore.kernel.org/lkml/20190128150909.4r3tje5l34u5t2xs@mok.nu/
[2]: https://lore.kernel.org/lkml/CAHp75VcLizx+jtMrbc3Ev-HcJVEjH2naFC0sj=7fX5nZSCGc8Q@mail.gmail.com/

---

 scripts/mod/file2alias.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index a37af7d71973..afe22af20d7d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -50,6 +50,9 @@ struct devtable {
 	int (*do_entry)(const char *filename, void *symval, char *alias);
 };
 
+/* Size of alias provided to do_entry functions */
+#define ALIAS_SIZE 500
+
 /* Define a variable f that holds the value of field f of struct devid
  * based at address m.
  */
@@ -1303,7 +1306,7 @@ static void do_table(void *symval, unsigned long size,
 		     struct module *mod)
 {
 	unsigned int i;
-	char alias[500];
+	char alias[ALIAS_SIZE];
 
 	device_id_check(mod->name, device_id, size, id_size, symval);
 	/* Leave last one: it's the terminator. */
-- 
2.20.1

