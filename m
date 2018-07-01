Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D84CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBA425180
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBA425180
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964789AbeGAQZo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:25:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeGAQZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:25:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3461AAF3;
        Sun,  1 Jul 2018 16:25:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan M Schaeckeler <sschaeck@cisco.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.9 033/101] of: unittest: for strings, account for trailing \0 in property length field
Date:   Sun,  1 Jul 2018 18:21:19 +0200
Message-Id: <20180701160758.492523310@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -155,20 +155,20 @@ static void __init of_unittest_dynamic(v
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
 
@@ -176,7 +176,7 @@ static void __init of_unittest_dynamic(v
 	prop++;
 	prop->name = "modify-property";
 	prop->value = "modify-missing-property-data-should-pass";
-	prop->length = strlen(prop->value);
+	prop->length = strlen(prop->value) + 1;
 	unittest(of_update_property(np, prop) == 0,
 		 "Updating a missing property should have passed\n");
 


