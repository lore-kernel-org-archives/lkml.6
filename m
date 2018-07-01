Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A503250BC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A503250BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGAQRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:17:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbeGAQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:17:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E526C92B;
        Sun,  1 Jul 2018 16:17:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan M Schaeckeler <sschaeck@cisco.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.4 049/105] of: unittest: for strings, account for trailing \0 in property length field
Date:   Sun,  1 Jul 2018 18:01:59 +0200
Message-Id: <20180701153152.927446412@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/unittest.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -156,20 +156,20 @@ static void __init of_unittest_dynamic(v
 	/* Add a new property - should pass*/
 	prop->name = "new-property";
 	prop->value = "new-property-data";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	unittest(of_add_property(np, prop) == 0, "Adding a new property failed\n");
 
 	/* Try to add an existing property - should fail */
 	prop++;
 	prop->name = "new-property";
 	prop->value = "new-property-data-should-fail";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	unittest(of_add_property(np, prop) != 0,
 		 "Adding an existing property should have failed\n");
 
 	/* Try to modify an existing property - should pass */
 	prop->value = "modify-property-data-should-pass";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	unittest(of_update_property(np, prop) == 0,
 		 "Updating an existing property should have passed\n");
 
@@ -177,7 +177,7 @@ static void __init of_unittest_dynamic(v
 	prop++;
 	prop->name = "modify-property";
 	prop->value = "modify-missing-property-data-should-pass";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	unittest(of_update_property(np, prop) == 0,
 		 "Updating a missing property should have passed\n");
 


