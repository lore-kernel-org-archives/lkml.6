Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8805DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585F3218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBHUol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:44:41 -0500
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:57386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbfBHUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:44:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CBFED182CF66A;
        Fri,  8 Feb 2019 20:44:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoe03_62cd454966a2f
X-Filterd-Recvd-Size: 2052
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 20:44:38 +0000 (UTC)
Message-ID: <9b74ee87f8c1b8fd310e213fcb4994d58610fcb6.camel@perches.com>
Subject: [PATCH] checkpatch: Add test for SPDX-License-Identifier on wrong
 line #
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Date:   Fri, 08 Feb 2019 12:44:37 -0800
In-Reply-To: <dfd0101f4a596600e2f0f8cf36886cf01c7dcb67.camel@perches.com>
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
         <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
         <dfd0101f4a596600e2f0f8cf36886cf01c7dcb67.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn when any SPDX-License-Identifier: tag is not created
on the proper line number.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 216480ae29d1..d0001fd1112d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3075,6 +3075,14 @@ sub process {
 # check we are in a valid source file if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
 
+# check for using SPDX-License-Identifier on the wrong line number
+		if ($realline != $checklicenseline &&
+		    $rawline =~ /\bSPDX-License-Identifier:/ &&
+		    substr($line, @-, @+ - @-) eq "$;" x (@+ - @-)) {
+			WARN("SPDX_LICENSE_TAG",
+			     "Misplaced SPDX-License-Identifier tag - use line $checklicenseline instead\n" . $herecurr);
+		}
+
 # line length limit (with some exclusions)
 #
 # There are a few types of lines that may extend beyond $max_line_length:

