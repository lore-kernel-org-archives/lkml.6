Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB4AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49C92082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eVPfCaXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49C92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeLKLD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:28 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36641 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeLKLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:42 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5j017210;
        Tue, 11 Dec 2018 20:01:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5j017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526079;
        bh=MlQs798fD3HimILsVIH/RMuv643LnBHtKXQ4IW5SZaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVPfCaXPPe7n1cnw+Knr9Zsq/PwgTsxnsnIO5JAD4eHK/rYj0WDkkaK40Kp0rxyIg
         muVXnZI3Ns4yE5N7y+ntHxoycTkegNmRZz5CTUT94jAAp2yvnGcq5TrcnyzZxCQJcX
         ri7UlEK76wP/224x5G01yaW9VCUadESFBq8+BVTZblzNPtA8h0fqzKVit+IP8Am1pg
         j97Yalx81TBg5Gdy+mDFFVqfCDo5ppNwo3WolTchGo36DFrg09UCYvzzPJ9ZvSWUYV
         9Wngqbp0WRqENMXNSoV+Bw2tyKtPDNoZu6wLNZIDxP+FRXNj1CbY/4Bsz28e9W6aFu
         Lvx8vVgCKILNA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 08/27] kconfig: warn no new line at end of file
Date:   Tue, 11 Dec 2018 20:00:51 +0900
Message-Id: <1544526070-16690-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice to warn if a new line is missing at end of file.

We could do this by checkpatch.pl for arbitrary files, but new line
is rather essential as a statement terminator in Kconfig.

The warning message looks like this:

  kernel/Kconfig.preempt:60:warning: no new line at end of file

Currently, kernel/Kconfig.preempt is the only file with no new line
at end of file. Fix it.

I know there are some false negative cases. For example, no warning
is displayed when the last line contains some whitespaces/comments,
but no new line. Yet, this commit works well for most cases.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 kernel/Kconfig.preempt  |  2 +-
 scripts/kconfig/zconf.l | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index cd16551..0fee5fe 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -57,4 +57,4 @@ config PREEMPT
 endchoice
 
 config PREEMPT_COUNT
-       bool
\ No newline at end of file
+       bool
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
index 9038e97..5046d3c 100644
--- a/scripts/kconfig/zconf.l
+++ b/scripts/kconfig/zconf.l
@@ -78,6 +78,13 @@ static void warn_ignored_character(char chr)
 	        "%s:%d:warning: ignoring unsupported character '%c'\n",
 	        current_file->name, yylineno, chr);
 }
+
+static void warn_no_newline(void)
+{
+	fprintf(stderr, "%s:%d:warning: no new line at end of file\n",
+	        current_file->name, yylineno);
+}
+
 %}
 
 n	[A-Za-z0-9_-]
@@ -261,6 +268,9 @@ n	[A-Za-z0-9_-]
 <<EOF>>	{
 	BEGIN(INITIAL);
 
+	if (prev_token != T_EOL && prev_token != T_HELPTEXT)
+		warn_no_newline();
+
 	if (current_file) {
 		zconf_endfile();
 		return T_EOL;
-- 
2.7.4

