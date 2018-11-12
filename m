Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8984BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445EF223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR3Rg4kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445EF223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeKLSbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:31:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36018 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:31:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so6834486lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjypBDJ8anHNmrmKCJ+Oif0eoN5UWIkM5fakhOis4p4=;
        b=iR3Rg4kF0o29g3wsDRZ8lHH38b7htlUMra23pzFQ2A6KeMvm7PdutxwIL+bbxTxp4K
         aOrQLgqhqSvacElWGGqd34AUVL5d2g9FjpFJ8hutLC1mNwVOsVM/bKJM/htmKfJlDSxk
         /t5qvTswPoDxKFtsqhx87B9o2siaGIgi4vfHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjypBDJ8anHNmrmKCJ+Oif0eoN5UWIkM5fakhOis4p4=;
        b=rZewKm3rAYunTsMcGRkgvBZKrzc99hipGIRs1IqCzW2b2QKnXcCVogTNzfGKbxcpHq
         iTfTibGXuuHf9DUgQF2zdomwb86K/ba1c0dwr2sDFm0JmHcMZKGGUTTxLoYXPMwSPvzX
         VNrzpuDSYTgrcjYc0+FH+6KwuaJctkDEZ66B1WgEob0hg8aISuUP1Abvmfom5O3rLuCE
         qIrLdO8vKVpLR5p8IpUtQhivpuMkJXCaKoHM/TGqFQ5xYl/Lix3Ol5maSRUOEJCcK0f3
         rIobAjD6YWJkg1fd2vRbi6r535U7ROD2398iRvjQgnrLBBs0m9PyfCZ1/TBo6siNf6Ud
         7sMA==
X-Gm-Message-State: AGRZ1gLKnrDC1j+K92DRCCbpIKO9MfQx3wwf+vssW6+WP8Eif7IITonu
        l3sBlhr7PYn0YeFpWks5nDmGiA==
X-Google-Smtp-Source: AJdET5ceKGJhl8nrT0ZylPswoSVDOaEu8xRc8vMcJkWLnHdXxV1/rEgATgY/kJM5mVM22fYng4r7fA==
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr27434ljt.159.1542011943851;
        Mon, 12 Nov 2018 00:39:03 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id d126-v6sm2911443lfe.75.2018.11.12.00.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 00:39:03 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     yamada.masahiro@socionext.com, dvhart@infradead.org
Cc:     arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
Date:   Mon, 12 Nov 2018 09:38:55 +0100
Message-Id: <20181112083855.27917-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In today's merge_config.sh the order of the config fragment files dictates
the output of a config option. With this approach we will get different
.config files depending on the order of the config fragment files.

So doing something like:
$ ./merge/kconfig/merge_config.sh selftest.config drm.config

Where selftest.config defines DRM=y and drm.config defines DRM=m, the
result will be "DRM=m".

Rework to add a switch to get builtin '=y' precedence over modules '=m',
this will result in "DRM=y". If we do something like this:

$ ./merge/kconfig/merge_config.sh -y selftest.config drm.config

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 scripts/kconfig/merge_config.sh | 37 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 0ef906499646..9b89791b202c 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -22,6 +22,7 @@
 
 clean_up() {
 	rm -f $TMP_FILE
+	rm -f $MERGE_FILE
 	exit
 }
 trap clean_up HUP INT TERM
@@ -32,6 +33,7 @@ usage() {
 	echo "  -m    only merge the fragments, do not execute the make command"
 	echo "  -n    use allnoconfig instead of alldefconfig"
 	echo "  -r    list redundant entries when merging fragments"
+	echo "  -y    make builtin have precedence over modules"
 	echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
 	echo
 	echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
@@ -40,6 +42,7 @@ usage() {
 RUNMAKE=true
 ALLTARGET=alldefconfig
 WARNREDUN=false
+BUILTIN=false
 OUTPUT=.
 CONFIG_PREFIX=${CONFIG_-CONFIG_}
 
@@ -64,6 +67,11 @@ while true; do
 		shift
 		continue
 		;;
+	"-y")
+		BUILTIN=true
+		shift
+		continue
+		;;
 	"-O")
 		if [ -d $2 ];then
 			OUTPUT=$(echo $2 | sed 's/\/*$//')
@@ -106,32 +114,45 @@ SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
 SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
 
 TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
+MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
 
 echo "Using $INITFILE as base"
 cat $INITFILE > $TMP_FILE
 
 # Merge files, printing warnings on overridden values
-for MERGE_FILE in $MERGE_LIST ; do
-	echo "Merging $MERGE_FILE"
-	if [ ! -r "$MERGE_FILE" ]; then
-		echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
+for ORIG_MERGE_FILE in $MERGE_LIST ; do
+	echo "Merging $ORIG_MERGE_FILE"
+	if [ ! -r "$ORIG_MERGE_FILE" ]; then
+		echo "The merge file '$ORIG_MERGE_FILE' does not exist.  Exit." >&2
 		exit 1
 	fi
+	cat $ORIG_MERGE_FILE > $MERGE_FILE
 	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
 
 	for CFG in $CFG_LIST ; do
 		grep -q -w $CFG $TMP_FILE || continue
 		PREV_VAL=$(grep -w $CFG $TMP_FILE)
 		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
-		if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
-			echo Value of $CFG is redefined by fragment $MERGE_FILE:
+		BUILTIN_FLAG=false
+		if [ "$BUILTIN" = "true" ] && [ "${NEW_VAL#CONFIG_*=}" = "m" ] && [ "${PREV_VAL#CONFIG_*=}" = "y" ]; then
+			echo Previous  value: $PREV_VAL
+			echo New value:       $NEW_VAL
+			echo -y passed, will not demote y to m
+			echo
+			BUILTIN_FLAG=true
+		elif [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
+			echo Value of $CFG is redefined by fragment $ORIG_MERGE_FILE:
 			echo Previous  value: $PREV_VAL
 			echo New value:       $NEW_VAL
 			echo
 		elif [ "$WARNREDUN" = "true" ]; then
-			echo Value of $CFG is redundant by fragment $MERGE_FILE:
+			echo Value of $CFG is redundant by fragment $ORIG_MERGE_FILE:
+		fi
+		if [ "$BUILTIN_FLAG" = "false" ]; then
+			sed -i "/$CFG[ =]/d" $TMP_FILE
+		else
+			sed -i "/$CFG[ =]/d" $MERGE_FILE
 		fi
-		sed -i "/$CFG[ =]/d" $TMP_FILE
 	done
 	cat $MERGE_FILE >> $TMP_FILE
 done
-- 
2.19.1

