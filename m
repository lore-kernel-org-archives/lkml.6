Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86559C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D9120869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DobFn6uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D9120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJPK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:27:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42896 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbeJPK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:27:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so10206530plo.9;
        Mon, 15 Oct 2018 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcDpIWwdaGfZQXbuTYh5YTbBTtu4RL7zj10+qvSXPVk=;
        b=DobFn6uA3MYdT1LTnVFyqdbbHDrDprP8bh3jO9x7S6yvxjJ/21xcuNcgB1zLMMMOF3
         NytAVqIUmEe2GJHNjr06qCPnBlymupi3wvSwg10otHltSOfYWUIIJWX/INWMg6gWuX/V
         nAci1GlC+LIAnFxQGS4FNodg+zAnWkNYnNxElMh6txYmbRJqQ9fVHewKOAlRVtMhGpiZ
         5SnZtgXXeOPr4w860xpoHqfgqFWedJ5lUOJsdCaNpXCuf0kwrOB1YAjp1xb368wS2sb4
         a7edgBCYiLJ9O6LDQ98ronte9Pf6dh1rESyYxyj2wNehjQgMc0MMmwStpWCWqOkDFN/T
         nXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcDpIWwdaGfZQXbuTYh5YTbBTtu4RL7zj10+qvSXPVk=;
        b=tssiQCaJEijbQbnI+PP29giS2LZ7KFaJkZVw8tE0dC0UW5OdEGa/rTtw1ur6o/RJ1H
         v9xhXifEruo0M/6lBfQNQN+TyVUkT9KYIxIdCuI6ZLQ6M+9VeLDw42LWF3lzLAddBeql
         7Sml5hqvc+n+j4024z8g4jnt1B0NoqkNII1Euzzp88idg1jWo1TF69U9xHjvclwYzSNv
         AHNmHaeWLyOU3G8atTWlUvg7J5voZaH87Upj4ibLvboeDJcRgxp9YWf032TRprlfvY4x
         13/PISU6d4dECNtc70o2Iq8l5+/gGWBGo8kS1YqWdI6cYIcxpkE7AGBVGEE4rj/HGCYj
         b1aA==
X-Gm-Message-State: ABuFfohnMUKgso9BYr9ndWyzOIj5AppejS1J89kvYipjiyPXml/kamcH
        ZMBpqQIDM0Njj+Eild1ARXQ=
X-Google-Smtp-Source: ACcGV619noATVp+bGXb0SJieo8qnLtAhlORwixdb70nDuESLPsBO5DAhSAeuI00tlYnuTLdaa9mGuA==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2-v6mr19734129plb.193.1539657562632;
        Mon, 15 Oct 2018 19:39:22 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 19:39:22 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v4 09/18] of: overlay: validate overlay properties #address-cells and #size-cells
Date:   Mon, 15 Oct 2018 19:37:29 -0700
Message-Id: <1539657458-24401-10-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

If overlay properties #address-cells or #size-cells are already in
the live devicetree for any given node, then the values in the
overlay must match the values in the live tree.

If the properties are already in the live tree then there is no
need to create a changeset entry to add them since they must
have the same value.  This reduces the memory used by the
changeset and eliminates a possible memory leak.  This is
verified by 12 fewer warnings during the devicetree unittest,
as the possible memory leak warnings about #address-cells and

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
Changes since v3:
  - for errors of an overlay changing the value of #size-cells or
    #address-cells, return -EINVAL so that overlay apply will fail
  - for errors of an overlay changing the value of #size-cells or
    #address-cells, make the message more direct.
    Old message:
      OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
    New message:
      OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed

 drivers/of/overlay.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 272a0d1a5e18..3e1e519c12f0 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
  * @target may be either in the live devicetree or in a new subtree that
  * is contained in the changeset.
  *
- * Some special properties are not updated (no error returned).
+ * Some special properties are not added or updated (no error returned):
+ * "name", "phandle", "linux,phandle".
+ *
+ * Properties "#address-cells" and "#size-cells" are not updated if they
+ * are already in the live tree, but if present in the live tree, the values
+ * in the overlay must match the values in the live tree.
  *
  * Update of property in symbols node is not allowed.
  *
@@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 {
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
+	bool check_for_non_overlay_node = false;
 
 	if (!of_prop_cmp(overlay_prop->name, "name") ||
 	    !of_prop_cmp(overlay_prop->name, "phandle") ||
@@ -322,13 +328,43 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	if (!new_prop)
 		return -ENOMEM;
 
-	if (!prop)
+	if (!prop) {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_add_property(&ovcs->cset, target->np,
 						new_prop);
-	else
+
+	} else if (!of_prop_cmp(prop->name, "#address-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value) {
+			pr_err("ERROR: changing value of %pOF/#address-cells is not allowed\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+
+	} else if (!of_prop_cmp(prop->name, "#size-cells")) {
+
+		if (prop->length != 4 || new_prop->length != 4 ||
+		    *(u32 *)prop->value != *(u32 *)new_prop->value) {
+			pr_err("ERROR: changing value of %pOF/#size-cells is not allowed\n",
+			       target->np);
+			ret = -EINVAL;
+		}
+
+	} else {
+
+		check_for_non_overlay_node = true;
 		ret = of_changeset_update_property(&ovcs->cset, target->np,
 						   new_prop);
 
+	}
+
+	if (check_for_non_overlay_node &&
+	    !of_node_check_flag(target->np, OF_OVERLAY))
+		pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
+		       __func__, target->np, new_prop->name);
+
 	if (ret) {
 		kfree(new_prop->name);
 		kfree(new_prop->value);
-- 
Frank Rowand <frank.rowand@sony.com>

