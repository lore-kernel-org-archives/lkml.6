Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D5620834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D5620834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLBAEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:04:23 -0500
Received: from www.osadl.org ([62.245.132.105]:39692 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeLBAEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:04:23 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB1ClZS2008991;
        Sat, 1 Dec 2018 13:47:35 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Philippe Ombredanne <pombredanne@nexb.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] Documentation: devres: note checking needs when converting
Date:   Sat,  1 Dec 2018 13:44:29 +0100
Message-Id: <1543668269-27207-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of cases where conversions to devm_* API have been
done but developers forgot that this conversion may imply that return
values need to be checked for failure of internal resource handling
like allocation. While this should be clear, it does seem to be a
relatively common issue with API conversions or maybe "managed" is
being misunderstood ? So add a note to make the scope of "managed" clear.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This popped up due to some API checking coccinelle scripts for devm_* that are
under development are triggering far to often - checking devm_kasprintf flagged
16 of the 132, 14 of which are true-positives (11%) and for the 33 devm_kstrdup  
cases 8 look buggy (missing check for return NULL) thats 24%. Others seem to be
related to simple replacement of previous assignments to devm_* calls - so 
given this high number of incorrect use the root-cause may be a misunderstanding
of "managed", which it seems was not being clearly understood as only addressing
freeing.

Not sure if the wording here is clear enough - but some clarification to this
ends seems needed.

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 Documentation/driver-model/devres.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 48aa1ef..ea2532b 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -132,6 +132,13 @@ devres.  Complexity is shifted from less maintained low level drivers
 to better maintained higher layer.  Also, as init failure path is
 shared with exit path, both can get more testing.
 
+Note though that when converting current calls or assignments to
+managed devm_* versions it is up to you to check if internal operations
+like allocating memory, have failed. Managed resources pertains to the
+freeing of these resources *only* - all other checks needed are still
+on you. In some cases this may mean introducing checks that were not
+necessary before moving to the managed devm_* calls.
+
 
   3. Devres group
   ---------------
-- 
2.1.4

