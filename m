Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeB1FD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:03:28 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:43736 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeB1FD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:03:27 -0500
X-Google-Smtp-Source: AG47ELsD8ZMK5+elu0c1cec8tUQxQes5fr/pMtvsRjNwgmO7d4+i5ywJdcj1VV84HEZbqGpoIDTYEA==
From: Leo Yan <leo.yan@linaro.org>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v3] checkpatch: Fix checks for Kconfig help text
Date: Wed, 28 Feb 2018 13:03:10 +0800
Message-Id: <1519794190-21416-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one patch has Kconfig section, the check script variable '$is_start'
will be set by first 'config' line and the variable '$is_end' is to be
set by the second 'config' line. But patches often has only one
'config' line so we have no chance to set '$is_end', as result below
condition is invalid and it skips check for Kconfig description:

	if ($is_start && $is_end && $length < $min_conf_desc_length) {
		......
	}

When script runs to this condition sentence it means the Kconfig
section parsing has been completed, whatever '$is_end' is true
or not. So removes '$is_end' from condition sentence.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d40403..5cbc887 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2828,7 +2828,7 @@ sub process {
 				}
 				$length++;
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($is_start && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
 				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
 			}
-- 
1.9.1
