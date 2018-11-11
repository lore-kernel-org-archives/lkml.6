Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA41C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7833F2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7833F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeKLFxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51618 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbeKLFxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:35 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt8-0000oO-Ka; Sun, 11 Nov 2018 19:59:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001S4-Sy; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Rob Herring" <robh@kernel.org>,
        "Frank Rowand" <frank.rowand@sony.com>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.430888605@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 075/366] of: unittest: for strings, account for
 trailing \\0 in property length field
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan M Schaeckeler <sschaeck@cisco.com>

commit 3b9cf7905fe3ab35ab437b5072c883e609d3498d upstream.

For strings, account for trailing \0 in property length field:

This is consistent with how dtc builds string properties.

Function __of_prop_dup() would misbehave on such properties as it duplicates
properties based on the property length field creating new string values
without trailing \0s.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Tested-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
[bwh: Backported to 3.16: s/unittest/selftest/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/of/selftest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -97,20 +97,20 @@ static void __init of_selftest_dynamic(v
 	/* Add a new property - should pass*/
 	prop->name = "new-property";
 	prop->value = "new-property-data";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	selftest(of_add_property(np, prop) == 0, "Adding a new property failed\n");
 
 	/* Try to add an existing property - should fail */
 	prop++;
 	prop->name = "new-property";
 	prop->value = "new-property-data-should-fail";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	selftest(of_add_property(np, prop) != 0,
 		 "Adding an existing property should have failed\n");
 
 	/* Try to modify an existing property - should pass */
 	prop->value = "modify-property-data-should-pass";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	selftest(of_update_property(np, prop) == 0,
 		 "Updating an existing property should have passed\n");
 
@@ -118,7 +118,7 @@ static void __init of_selftest_dynamic(v
 	prop++;
 	prop->name = "modify-property";
 	prop->value = "modify-missing-property-data-should-pass";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	selftest(of_update_property(np, prop) == 0,
 		 "Updating a missing property should have passed\n");
 

