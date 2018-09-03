Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC9F20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tHcTILgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC9F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeICOXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:23:01 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:36957 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeICOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:23:01 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w83A2AsY026175;
        Mon, 3 Sep 2018 19:02:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w83A2AsY026175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535968932;
        bh=AXfpxzad3p9nMHosRdYtTF6ipqbKVsh5ibLJLNOL+Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHcTILgsszEG3AWAaNCwF72GVDuN8ZSanaqjiVVyZ9N1XNhQ85eR81X1XaW+I8slx
         K7Fr8LMks4eyoK+PnuOwXVzrZTDCfZhLmE2k2RFnLpINdNwShn+w83sfrghVXbMMI+
         1yAFlJjytYdzISMcD47evojdsqKg2B1ZZViU7JZbmRCykb32u2H+iWnKuZDI/PSZxh
         yWYGz9u5Zk1RM2xoIqEtcGoKsWE4oy1Wh+WQyxDOidXh9dBDVUzjutJaxu3hv8uoKz
         XD3Jq6PXOaZuKg0J7YbZkwlk4pzzSmDkER/8RwhhezvBLOEAmxMxxcBWbxXUNSjokW
         G/L0SliYvWnWA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        =?UTF-8?q?Michal=20Such=8F=AB=A1nek?= <msuchanek@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [RFC PATCH 1/3] kconfig: support an environment variable for non-interactive syncconfig
Date:   Mon,  3 Sep 2018 19:01:54 +0900
Message-Id: <1535968916-9159-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
References: <1535968916-9159-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Kconfig files are updated, or build environments etc. are changed,
'make syncconfig' is invoked, which will show prompts if new config
options are available.  Users must explicitly input values for all
new symbols.  This is the conventional behavior for the kernel build.

However, it would be useful to process this non-interactively in such
cases as package building.

Package maintainers create source packages with the .config configured
on their machines.  Package builders may work on different machine
environments, where different compilers are installed.

With the recent changes in Kconfig, the .config contents depend on
the compiler.  During package building, it is not sensible to show
prompts for new symbols; it would be just annoys script automation.

Add a new switch, KCONFIG_NONINTERACTIVE_UPDATE.  If this environment
variable is set, Kconfig will sync the configuration non-interactively.
All new symbols are silently set to their default values.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/kbuild/kconfig.txt | 6 ++++++
 scripts/kconfig/conf.c           | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/kbuild/kconfig.txt b/Documentation/kbuild/kconfig.txt
index 68c8291..5c29c3f 100644
--- a/Documentation/kbuild/kconfig.txt
+++ b/Documentation/kbuild/kconfig.txt
@@ -129,6 +129,12 @@ KCONFIG_NOSILENTUPDATE
 If this variable has a non-blank value, it prevents silent kernel
 config updates (requires explicit updates).
 
+KCONFIG_NONINTERACTIVE_UPDATE
+--------------------------------------------------
+If this variable has a non-blank value, it prevents user input prompts
+from showing up even when new symbols are available.  All new symbols
+are silently set to their default values.
+
 KCONFIG_AUTOCONFIG
 --------------------------------------------------
 This environment variable can be set to specify the path & name of the
diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 7b2b372..b64bbc0 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -680,6 +680,11 @@ int main(int ac, char **av)
 	case oldconfig:
 	case listnewconfig:
 	case syncconfig:
+		if (input_mode == syncconfig) {
+			name = getenv("KCONFIG_NONINTERACTIVE_UPDATE");
+			if (name && *name)
+				break;
+		}
 		/* Update until a loop caused no more changes */
 		do {
 			conf_cnt = 0;
-- 
2.7.4

