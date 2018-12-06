Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3D420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107630;
	bh=KtJ39nQzn7gSxdWcrfHXYol2rwu992MBYGZxzIaWeDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvoSfifNWz7tCbevAech/1yIO1JoXldce+oSSygbo8Y++wGxMPojWhrtn0z90FXL2
	 KGKo2O+exAPSzapr/Dkdb0OMDs84011ILgowZ0VGPHCFephVFoNgQWLKxlRQ1mJaSC
	 saxxFVpkGrQoPLgzH1115HFAHzt2zyjZHj+g+ZGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3D420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbeLFOrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbeLFOrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C2C20661;
        Thu,  6 Dec 2018 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107624;
        bh=KtJ39nQzn7gSxdWcrfHXYol2rwu992MBYGZxzIaWeDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiz3jGnniPowARoFmxqRvhFxFSg47GjfhAmKHLNgm/u2szE01iFKU+whEk49qzVH6
         yihGG+jKPl11Q3EmIGOO0sAdw/YBJKfhhLSgfw77ZRukU85q/EiW7xtn9gmyKAv/9+
         6K88op9fEqPZGTzrF7kFg+VI5bbXHxAg/cc9d9XM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.9 041/101] reset: add exported __reset_control_get, return NULL if optional
Date:   Thu,  6 Dec 2018 15:38:40 +0100
Message-Id: <20181206143013.888149706@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Zabel <p.zabel@pengutronix.de>

commit 62e24c5775ecb387a3eb33701378ccfa6dbc98ee upstream.

Rename the internal __reset_control_get/put functions to
__reset_control_get/put_internal and add an exported
__reset_control_get equivalent to __of_reset_control_get
that takes a struct device parameter.
This avoids the confusing call to __of_reset_control_get in
the non-DT case and fixes the devm_reset_control_get_optional
function to return NULL if RESET_CONTROLLER is enabled but
dev->of_node == NULL.

Fixes: bb475230b8e5 ("reset: make optional functions really optional")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/reset/core.c  |   22 ++++++++++++++++------
 include/linux/reset.h |   22 ++++++++++++++--------
 2 files changed, 30 insertions(+), 14 deletions(-)

--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -241,7 +241,7 @@ int reset_control_status(struct reset_co
 }
 EXPORT_SYMBOL_GPL(reset_control_status);
 
-static struct reset_control *__reset_control_get(
+static struct reset_control *__reset_control_get_internal(
 				struct reset_controller_dev *rcdev,
 				unsigned int index, int shared)
 {
@@ -274,7 +274,7 @@ static struct reset_control *__reset_con
 	return rstc;
 }
 
-static void __reset_control_put(struct reset_control *rstc)
+static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
@@ -343,7 +343,7 @@ struct reset_control *__of_reset_control
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
-	rstc = __reset_control_get(rcdev, rstc_id, shared);
+	rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
 
 	mutex_unlock(&reset_list_mutex);
 
@@ -351,6 +351,17 @@ struct reset_control *__of_reset_control
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
+struct reset_control *__reset_control_get(struct device *dev, const char *id,
+					  int index, bool shared, bool optional)
+{
+	if (dev->of_node)
+		return __of_reset_control_get(dev->of_node, id, index, shared,
+					      optional);
+
+	return optional ? NULL : ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(__reset_control_get);
+
 /**
  * reset_control_put - free the reset controller
  * @rstc: reset controller
@@ -362,7 +373,7 @@ void reset_control_put(struct reset_cont
 		return;
 
 	mutex_lock(&reset_list_mutex);
-	__reset_control_put(rstc);
+	__reset_control_put_internal(rstc);
 	mutex_unlock(&reset_list_mutex);
 }
 EXPORT_SYMBOL_GPL(reset_control_put);
@@ -383,8 +394,7 @@ struct reset_control *__devm_reset_contr
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = __of_reset_control_get(dev ? dev->of_node : NULL,
-				      id, index, shared, optional);
+	rstc = __reset_control_get(dev, id, index, shared, optional);
 	if (!IS_ERR(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -15,6 +15,9 @@ int reset_control_status(struct reset_co
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
 				     bool optional);
+struct reset_control *__reset_control_get(struct device *dev, const char *id,
+					  int index, bool shared,
+					  bool optional);
 void reset_control_put(struct reset_control *rstc);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
@@ -72,6 +75,13 @@ static inline struct reset_control *__of
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct reset_control *__reset_control_get(
+					struct device *dev, const char *id,
+					int index, bool shared, bool optional)
+{
+	return optional ? NULL : ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
 					int index, bool shared, bool optional)
@@ -102,8 +112,7 @@ __must_check reset_control_get_exclusive
 #ifndef CONFIG_RESET_CONTROLLER
 	WARN_ON(1);
 #endif
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, false,
-									false);
+	return __reset_control_get(dev, id, 0, false, false);
 }
 
 /**
@@ -131,22 +140,19 @@ __must_check reset_control_get_exclusive
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, true,
-									false);
+	return __reset_control_get(dev, id, 0, true, false);
 }
 
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, false,
-									true);
+	return __reset_control_get(dev, id, 0, false, true);
 }
 
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __of_reset_control_get(dev ? dev->of_node : NULL, id, 0, true,
-									true);
+	return __reset_control_get(dev, id, 0, true, true);
 }
 
 /**


