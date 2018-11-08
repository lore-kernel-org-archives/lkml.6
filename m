Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31592ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF24C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hy12u3UI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF24C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeKIFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:21:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39395 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeKIFVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:21:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so15900994ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWe8TQaPOgOSgWWD5ylzfYwr+d8rXAIn9cFfG0/SFJI=;
        b=hy12u3UIOWODzecjWL7+6vM6YX6lE1PpxoboRa5R7BEL4gcXt3Ue/08q1EgKTnYoBo
         UljA/bEKza0x8piVMJwYrjWGcTePrdz0f5yLSaiSyca3aUv4NxRzlnQdjcdlsWv+IJBn
         fAMKx586jh9nAUd9IH0tyd4OKhANbfcI320FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PWe8TQaPOgOSgWWD5ylzfYwr+d8rXAIn9cFfG0/SFJI=;
        b=sNKCiVvCKR4lqfIjngTO20hQubtiNxuGaUzhvTTW3F1cLijgWGYq8yvS+HTKxnoRje
         skRFcb8c6fAWXiA5pV9Pyce/l7+70nF0kZolYzI6M+9ninNdskCV0zsPVuVGhtlCDhEY
         eZjCQayvkbeQ2sCZxoV5zyCB1fUU/U0EQmfsZl7SkLVbyqZeqYSpEMtBD+SBt8n0r1g3
         wC5sJi6FTATsXa0KXKWsr3F6OFhP7xSzwFifmEl8Nj0X/IP+d2BQJFbuOkXDhqzMly3t
         DHRoQlURH1edZ51CBGujauxjEEELNE7Uo9hZlW44g5DYTzzgnvyf3KlhKvcGakTzjKJK
         ohNQ==
X-Gm-Message-State: AGRZ1gKCraqBBjVXGOEdHPWzR+jO0srgvmhSQgOl87e3X14GUOTrPluI
        sSnYnscVGZjW1AAvWkJKkKMFH+vcMvkyMA==
X-Google-Smtp-Source: AJdET5d8Qe1TK3OrMUTnViaMVz4hD30wCJXFGINDTRsNjJmd+uTxwlaMHcWlBjBv6o+b79IfG1k6kQ==
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr3596829ljt.159.1541706288191;
        Thu, 08 Nov 2018 11:44:48 -0800 (PST)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id k68-v6sm832835ljb.35.2018.11.08.11.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 11:44:47 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     yamada.masahiro@socionext.com, dvhart@infradead.org
Cc:     arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] scripts/kconfig/merge_config: don't redefine 'y' to 'm'
Date:   Thu,  8 Nov 2018 20:44:34 +0100
Message-Id: <20181108194434.16568-1-anders.roxell@linaro.org>
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
 scripts/kconfig/merge_config.sh | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index da66e7742282..fcd18f642fc7 100755
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
@@ -40,6 +42,8 @@ usage() {
 RUNMAKE=true
 ALLTARGET=alldefconfig
 WARNREDUN=false
+BUILTIN=false
+BUILTIN_FLAG=false
 OUTPUT=.
 CONFIG_PREFIX=${CONFIG_-CONFIG_}
 
@@ -64,6 +68,11 @@ while true; do
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
@@ -105,13 +114,15 @@ MERGE_LIST=$*
 SED_CONFIG_EXP="s/^\(# \)\{0,1\}\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)[= ].*/\2/p"
 
 TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
+MERGE_FILE=$(mktemp ./.merge_tmp.config.XXXXXXXXXX)
 
 echo "Using $INITFILE as base"
 cat $INITFILE > $TMP_FILE
 
 # Merge files, printing warnings on overridden values
-for MERGE_FILE in $MERGE_LIST ; do
-	echo "Merging $MERGE_FILE"
+for ORIG_MERGE_FILE in $MERGE_LIST ; do
+	cat $ORIG_MERGE_FILE > $MERGE_FILE
+	echo "Merging $ORIG_MERGE_FILE"
 	if [ ! -r "$MERGE_FILE" ]; then
 		echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
 		exit 1
@@ -122,15 +133,26 @@ for MERGE_FILE in $MERGE_LIST ; do
 		grep -q -w $CFG $TMP_FILE || continue
 		PREV_VAL=$(grep -w $CFG $TMP_FILE)
 		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
-		if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
-			echo Value of $CFG is redefined by fragment $MERGE_FILE:
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
+			BUILTIN_FLAG=false
 		fi
-		sed -i "/$CFG[ =]/d" $TMP_FILE
 	done
 	cat $MERGE_FILE >> $TMP_FILE
 done
-- 
2.19.1

