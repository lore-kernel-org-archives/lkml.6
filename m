Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D17AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0C20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="u2ngKWLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD0C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbeKVPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:07:30 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50047 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbeKVPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:07:30 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAM4SxSQ016430;
        Thu, 22 Nov 2018 13:29:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAM4SxSQ016430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542860940;
        bh=+5qfuMbSreI8HcVk76Obwuij1w4/Gaf/3P00BJPU4cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2ngKWLpQSvocyS5ylHsnIiEKdm+9QxcAD0U9ikQDN3MxYF/eEyEUqWtHznyODWfR
         JnHuK2rrSDf4Fq9u8b1KBVuCmCeNInD+9LqS9vcI7xY5pcrpm2uJy8qIhHTKPyi0gx
         MnMvGw3QIB/L27Qv67AM4oz+M1CZkzxvQL+WYsx2saPCVrMjUptpMJAV+x/vuRG87n
         epHgbtYQSX3Hzs00LpHHGpJys7As3F0l6mdTJd3i7BK4AqHWF9KOtHe96VCyKcN+CZ
         erlGciGViGIlwfA99rbWy8joA19c8UQpwQ1Lxw1Ixwyt3/qRPf7uFUC5Tdzu6O59pb
         EsQW+u77EopBw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Mathieu Malaterre <malat@debian.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] modpost: file2alias: check prototype of handler
Date:   Thu, 22 Nov 2018 13:28:42 +0900
Message-Id: <1542860922-9730-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542860922-9730-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542860922-9730-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use specific prototype instead of an opaque pointer so that the
compiler can catch incompatible pointer type.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/file2alias.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7e4aede..a37af7d 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -47,7 +47,7 @@ typedef struct {
 struct devtable {
 	const char *device_id; /* name of table, __mod_<name>__*_device_table. */
 	unsigned long id_size;
-	void *function;
+	int (*do_entry)(const char *filename, void *symval, char *alias);
 };
 
 /* Define a variable f that holds the value of field f of struct devid
@@ -1299,12 +1299,11 @@ static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 static void do_table(void *symval, unsigned long size,
 		     unsigned long id_size,
 		     const char *device_id,
-		     void *function,
+		     int (*do_entry)(const char *filename, void *symval, char *alias),
 		     struct module *mod)
 {
 	unsigned int i;
 	char alias[500];
-	int (*do_entry)(const char *, void *entry, char *alias) = function;
 
 	device_id_check(mod->name, device_id, size, id_size, symval);
 	/* Leave last one: it's the terminator. */
@@ -1420,7 +1419,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 
 			if (sym_is(name, namelen, p->device_id)) {
 				do_table(symval, sym->st_size, p->id_size,
-					 p->device_id, p->function, mod);
+					 p->device_id, p->do_entry, mod);
 				break;
 			}
 		}
-- 
2.7.4

