Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B22C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2101D20823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfBCOE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:04:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52776 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbfBCNtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:43 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003tw-L7; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006of-41; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.220278320@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 021/305] cpupower: remove stringop-truncation waring
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anders Roxell <anders.roxell@linaro.org>

commit 8a7e2d2ea080d10a189a1d611344b0330468ebc3 upstream.

The strncpy doesn't null terminate the string because the size is too
short by one byte.

parse.c: In function ‘prepare_default_config’:
parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
    nul copying 8 bytes from a string of the same length
    [-Wstringop-truncation]
  strncpy(config->governor, "ondemand", 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The normal method of passing the length of the destination buffer works
correctly here.

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -135,7 +135,7 @@ struct config *prepare_default_config()
 	config->cpu = 0;
 	config->prio = SCHED_HIGH;
 	config->verbose = 0;
-	strncpy(config->governor, "ondemand", 8);
+	strncpy(config->governor, "ondemand", sizeof(config->governor));
 
 	config->output = stdout;
 

