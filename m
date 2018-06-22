Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A46C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED023E98
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED023E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeFVIBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:01:24 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:44808 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeFVIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:01:23 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id 1k1N1y0043XaVaC01k1NSJ; Fri, 22 Jun 2018 10:01:22 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWH0T-0008OL-U4; Fri, 22 Jun 2018 10:01:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWH0T-0004QV-Rz; Fri, 22 Jun 2018 10:01:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dm raid: don't use 'const' in function return
Date:   Fri, 22 Jun 2018 10:01:19 +0200
Message-Id: <20180622080119.16970-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A newly introduced function has 'const int' as the return type,
but as "make W=1" reports, that has no meaning:

drivers/md/dm-raid.c:510:18: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]

This changes the return type to plain 'int'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 33e53f06850f ("dm raid: introduce extended superblock and new raid types to support takeover/reshaping")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Fixes: 552aa679f2657431 ("dm raid: use rs_is_raid*()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Cherry-picked from 68c1c4d5eafc65dd ("dm raid: don't use 'const' in
function return") with new Fixes tag, as the issue has been
reintroduced.
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index ab13fcec3fca046c..75df4c9d8b541de4 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -588,7 +588,7 @@ static const char *raid10_md_layout_to_format(int layout)
 }
 
 /* Return md raid10 algorithm for @name */
-static const int raid10_name_to_format(const char *name)
+static int raid10_name_to_format(const char *name)
 {
 	if (!strcasecmp(name, "near"))
 		return ALGORITHM_RAID10_NEAR;
-- 
2.17.1

