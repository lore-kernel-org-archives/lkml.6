Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF22C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C512064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C512064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJWPaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:30:14 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45748 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJWPaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:30:14 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 38D8442A858; Tue, 23 Oct 2018 09:08:07 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>, Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spdxcheck: make python3 compliant
Date:   Tue, 23 Oct 2018 09:08:02 +0200
Message-Id: <20181023070802.22558-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change the following happens when using Python3 (3.6.6):

	$ echo "GPL-2.0" | python3 scripts/spdxcheck.py -
	FAIL: 'str' object has no attribute 'decode'
	Traceback (most recent call last):
	  File "scripts/spdxcheck.py", line 253, in <module>
	    parser.parse_lines(sys.stdin, args.maxlines, '-')
	  File "scripts/spdxcheck.py", line 171, in parse_lines
	    line = line.decode(locale.getpreferredencoding(False), errors='ignore')
	AttributeError: 'str' object has no attribute 'decode'

So as the line is already a string, there is no need to decode it and
the line can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 scripts/spdxcheck.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 839e190bbd7a..5056fb3b897d 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -168,7 +168,6 @@ class id_parser(object):
         self.curline = 0
         try:
             for line in fd:
-                line = line.decode(locale.getpreferredencoding(False), errors='ignore')
                 self.curline += 1
                 if self.curline > maxlines:
                     break
-- 
2.19.1

