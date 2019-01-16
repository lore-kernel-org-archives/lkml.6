Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48442C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8C20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392152AbfAPKna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:43:30 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392138AbfAPKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:43:29 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjifO-0005H2-Np; Wed, 16 Jan 2019 11:43:26 +0100
Message-Id: <20190116104127.698565432@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 16 Jan 2019 11:26:53 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [patch 2/2] scripts/spdxcheck.py: Handle special quotation mark
 comments
References: <20190116102651.489113812@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SuperH boot code files use a magic format for the SPDX identifier
comment:

  LIST "SPDX-License-Identifier: .... "

The trailing quotation mark is not stripped before the token parser is
invoked and causes the scan to fail. Handle it gracefully.

Fixes: 6a0abce4c4cc ("sh: include: convert to SPDX identifiers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 scripts/spdxcheck.py |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -175,7 +175,13 @@ import os
                 self.lines_checked += 1
                 if line.find("SPDX-License-Identifier:") < 0:
                     continue
-                expr = line.split(':')[1].replace('*/', '').strip()
+                expr = line.split(':')[1].strip()
+                # Remove trailing comment closure
+                if line.startswith('/*'):
+                    expr = expr.rstrip('*/').strip()
+                # Special case for SH magic boot code files
+                if line.startswith('LIST \"'):
+                    expr = expr.rstrip('\"').strip()
                 self.parse(expr)
                 self.spdx_valid += 1
                 #


