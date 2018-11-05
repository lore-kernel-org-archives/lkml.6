Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE6ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2762085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x6vfM2uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2762085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKERiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:38:51 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:50915 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKERiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:38:51 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wA58JkVF029160;
        Mon, 5 Nov 2018 17:19:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wA58JkVF029160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541405987;
        bh=wMzryw0mLtxTHiqcq3RT11/GwjAwgOC8w0PnRUCWflk=;
        h=From:To:Cc:Subject:Date:From;
        b=x6vfM2uzPte8zLLS/C/E7f35O0yw8Bf3i2s8Xan1wvcgTBeFgPKF8eyevR5PkZWaE
         JA8jmaiiKSu4TjF8msQxdjg172e6ar34csvh43uW1mwU0AlSe4WLQghGZCb1YubL8G
         Od23isZe41AVNCOiWdzfyWVaIyEf2EJlGwLjC4V2b65HgWUv1ciuEitW4CGK4poddQ
         ureosqFjonE5gTTSOvEcyGNDwpE91aWzSc/qq3Hg7bP9NkEZ6DG1qhqrorOILknshe
         PS7c+dQ+wUGr9Nqe7BG7DMYLqrWu3VELeHtMm74Wz/Z94M+n4+k8HAW/QZA0Bkg2wa
         im0W5BpHHRfKw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Nasser <afshin.nasser@gmail.com>,
        Arnout Vandecappelle <arnout@mind.be>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kconfig: merge_config: avoid false positive matches from comment lines
Date:   Mon,  5 Nov 2018 17:19:36 +0900
Message-Id: <1541405976-13747-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SED_CONFIG_EXP could match to comment lines in config
fragment files, especially when CONFIG_PREFIX_ is empty. For example,
Buildroot uses empty prefixing; starting symbols with BR2_ is just
convention.

Make the sed expression more robust against false positives from
comment lines. The new sed expression matches to only valid patterns.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
---

Changes in v2:
  - Another (more precise) implementation approach
    based on the option from Arnout Vandecappelle.
    This is still easier to read, but adds a bit duplication.

 scripts/kconfig/merge_config.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index da66e77..0ef9064 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -102,7 +102,8 @@ if [ ! -r "$INITFILE" ]; then
 fi
 
 MERGE_LIST=$*
-SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
+SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
+SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
 
 TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
 
@@ -116,7 +117,7 @@ for MERGE_FILE in $MERGE_LIST ; do
 		echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
 		exit 1
 	fi
-	CFG_LIST=$(sed -n "$SED_CONFIG_EXP" $MERGE_FILE)
+	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
 
 	for CFG in $CFG_LIST ; do
 		grep -q -w $CFG $TMP_FILE || continue
@@ -159,7 +160,7 @@ make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET
 
 
 # Check all specified config values took (might have missed-dependency issues)
-for CFG in $(sed -n "$SED_CONFIG_EXP" $TMP_FILE); do
+for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_FILE); do
 
 	REQUESTED_VAL=$(grep -w -e "$CFG" $TMP_FILE)
 	ACTUAL_VAL=$(grep -w -e "$CFG" "$KCONFIG_CONFIG")
-- 
2.7.4

