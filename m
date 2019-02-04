Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45723C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AE8218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277427;
	bh=rS/ODIebHPZ50/p7l+NdVyx+rBP4cCLrMW2yF50MJG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VKoOzMs5FG4u5jllNwLfEWNTdq05FdSCnC5nRCCwIIAPK9w1RzDSixBfIrGQlI4zw
	 usyOdbsjEaiDinZR1rpeL4WJb85nwLcTo9dCprPioVURvpRXi9TLqMWA87agAku7eo
	 ONH2mG9yy7YHCPAtn3JtIF3WCVoHcBpxWjMycpFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfBDKuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbfBDKuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240622184E;
        Mon,  4 Feb 2019 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277422;
        bh=rS/ODIebHPZ50/p7l+NdVyx+rBP4cCLrMW2yF50MJG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVVQxHwnWxTtQaa7b7pF0kbfUVrjY+kRPF/nj67vKlz143EoIVCAyirKZsyXNog2j
         cLekpY7Egkx33/57gqWISJq/uWgi7nRBA/vwlsdFbNLMbXHuCPi5to7tcc2CMSSUVe
         rD4Cg+QLV9Yl5wSlY8GKDKvSUtSM4p6twfJsTLFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 69/74] of: overlay: add tests to validate kfrees from overlay removal
Date:   Mon,  4 Feb 2019 11:37:22 +0100
Message-Id: <20190204103628.953321528@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Rowand <frank.rowand@sony.com>

commit 144552c786925314c1e7cb8f91a71dae1aca8798 upstream.

Add checks:
  - attempted kfree due to refcount reaching zero before overlay
    is removed
  - properties linked to an overlay node when the node is removed
  - node refcount > one during node removal in a changeset destroy,
    if the node was created by the changeset

After applying this patch, several validation warnings will be
reported from the devicetree unittest during boot due to
pre-existing devicetree bugs. The warnings will be similar to:

  OF: ERROR: of_node_release(), unexpected properties in /testcase-data/overlay-node/test-bus/test-unittest11
  OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node /testcase-data-2/substation@100/
  hvac-medium-2

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/dynamic.c |   29 +++++++++++++++++++++++++++++
 drivers/of/overlay.c |    1 +
 include/linux/of.h   |   15 ++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -333,6 +333,25 @@ void of_node_release(struct kobject *kob
 	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
 
+	if (of_node_check_flag(node, OF_OVERLAY)) {
+
+		if (!of_node_check_flag(node, OF_OVERLAY_FREE_CSET)) {
+			/* premature refcount of zero, do not free memory */
+			pr_err("ERROR: memory leak before free overlay changeset,  %pOF\n",
+			       node);
+			return;
+		}
+
+		/*
+		 * If node->properties non-empty then properties were added
+		 * to this node either by different overlay that has not
+		 * yet been removed, or by a non-overlay mechanism.
+		 */
+		if (node->properties)
+			pr_err("ERROR: %s(), unexpected properties in %pOF\n",
+			       __func__, node);
+	}
+
 	property_list_free(node->properties);
 	property_list_free(node->deadprops);
 
@@ -437,6 +456,16 @@ struct device_node *__of_node_dup(const
 
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
+	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
+	    of_node_check_flag(ce->np, OF_OVERLAY)) {
+		if (kref_read(&ce->np->kobj.kref) > 1) {
+			pr_err("ERROR: memory leak, expected refcount 1 instead of %d, of_node_get()/of_node_put() unbalanced - destroy cset entry: attach overlay node %pOF\n",
+			       kref_read(&ce->np->kobj.kref), ce->np);
+		} else {
+			of_node_set_flag(ce->np, OF_OVERLAY_FREE_CSET);
+		}
+	}
+
 	of_node_put(ce->np);
 	list_del(&ce->node);
 	kfree(ce);
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -373,6 +373,7 @@ static int add_changeset_node(struct ove
 			return -ENOMEM;
 
 		tchild->parent = target_node;
+		of_node_set_flag(tchild, OF_OVERLAY);
 
 		ret = of_changeset_attach_node(&ovcs->cset, tchild);
 		if (ret)
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -138,11 +138,16 @@ extern struct device_node *of_aliases;
 extern struct device_node *of_stdout;
 extern raw_spinlock_t devtree_lock;
 
-/* flag descriptions (need to be visible even when !CONFIG_OF) */
-#define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
-#define OF_DETACHED	2 /* node has been detached from the device tree */
-#define OF_POPULATED	3 /* device already created for the node */
-#define OF_POPULATED_BUS	4 /* of_platform_populate recursed to children of this node */
+/*
+ * struct device_node flag descriptions
+ * (need to be visible even when !CONFIG_OF)
+ */
+#define OF_DYNAMIC		1 /* (and properties) allocated via kmalloc */
+#define OF_DETACHED		2 /* detached from the device tree */
+#define OF_POPULATED		3 /* device already created */
+#define OF_POPULATED_BUS	4 /* platform bus created for children */
+#define OF_OVERLAY		5 /* allocated for an overlay */
+#define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
 
 #define OF_BAD_ADDR	((u64)-1)
 


