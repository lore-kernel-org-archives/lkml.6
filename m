Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E96C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AA20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uhKImOe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AA20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393559AbeKWSk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:40:57 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:55964 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390083AbeKWSk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:40:57 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAN7vWj3021058;
        Fri, 23 Nov 2018 16:57:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAN7vWj3021058
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542959853;
        bh=QiRqh8yetZM167uoY2zCS9SR1gaXHDJe1PX6A2FbUWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhKImOe4cNfkV3//LxJArl7XFi6B2plvMt7ohzt3Wpmko4J19fQfzRL/gnI/qHEwO
         o2j2g6qDmTbfVo5AECwUFQvSeiZI91p2116q6ni15tfuXeORwVgPVk5cVB/koeiqYy
         GzKdVirsASaXzsCt0BtHqu/pQvTaB7dJ1zOvr5/u8z4V6H+KOlhD3NbwseTcZI5J29
         hlaOGKNpfodnKryGTeS88R0VFKU7edCnZdV+BuGCovTdSD3sEGozyZkmBWv4IC1GON
         eMm4y8AYB3SfMfELIMIaVvF18N7NnA0GVy1urLT0lPLlip2W13xdz5/2uzjz4fB5Jn
         AsCpefVMgGWfQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] modpost: merge module iterations
Date:   Fri, 23 Nov 2018 16:57:22 +0900
Message-Id: <1542959843-16145-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542959843-16145-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably, this is just a matter of the order of error/warning
messages. Merge the two for-loops.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/mod/modpost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 39432c2..05e41eb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2484,12 +2484,6 @@ int main(int argc, char **argv)
 	if (files_source)
 		read_symbols_from_files(files_source);
 
-	for (mod = modules; mod; mod = mod->next) {
-		if (mod->skip)
-			continue;
-		check_exports(mod);
-	}
-
 	err = 0;
 
 	for (mod = modules; mod; mod = mod->next) {
@@ -2501,6 +2495,7 @@ int main(int argc, char **argv)
 		buf.pos = 0;
 
 		err |= check_modname_len(mod);
+		check_exports(mod);
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
 		add_retpoline(&buf);
-- 
2.7.4

