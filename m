Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F94C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D001C217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9wikpz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbeLTRUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35272 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733204AbeLTRUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so2413871edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWYGAaBV+lIGk2inVlNOBOzTdmy5vHDBcX/Fnid+RCU=;
        b=f9wikpz23YhXrLgQgEuca2sl9XC/rtK7H+0ZaBpvabppDZj6MbuoVL+euAQZi2JMDZ
         Xna99BCOuTtYHyiVVwZcu18s91+A6pVTSGWAQVgeXMmbx4IlzFl08wZWIeJXUsFCof5Y
         bLqY0n19jtu7rEU0FpvT5c1ZPhSUY+1Nt1nYpM//TDguj+1dEwvj5w1oh2ZhuU0BvJmx
         +jgxGlBzZ/Y7Tg3XUEpOQU3j1XFQac1RhDVpbumLFTlnJkxmBpvArPTha/rwbVadQkkT
         uPGI69CLYfTSwSNMrs4fMbB26BzMKSD0TQ/hfhjq46v991u4B7IvGGCRXvnC3YdMf681
         MbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWYGAaBV+lIGk2inVlNOBOzTdmy5vHDBcX/Fnid+RCU=;
        b=bCp0kRZcdJBoDjkIAMSpy3Vyd0PFaHngOxGP1CxBaDnbQG1d1tiR8DeYyGRSSyWqbb
         S5KG9IUdfKnj8Co6Ccw9q8Ru8a4+euFVsF57gtQ4tSW7EeFCKcbtmvwcel4h28FfSj/z
         iJSYZ7yGDa4SOnsP7D0LyLcM5DEppZQJlZ22ij+i7ZezCbYXjUDBDhaR9P+yptDfXx1g
         gk+cwfLNxEA+QIN0rMfWdnEB3e9QOCo3PbuGJUvfyOsv4wuzkQojp4cZekPPbmNWP7Df
         EqsufG3SCiKmprCPFpDJJLr/aH9uofTDudbun44srSvPL6lHOU9FPDSlSVhbkIdBySOA
         48VA==
X-Gm-Message-State: AA+aEWYHEX3Pi5AS3w6dUwWZ4wMHwfElQ38CCsdpAclbYTCUKOwRUuky
        IU5k09OTw34Z5qO51l2rEF4=
X-Google-Smtp-Source: AFSGD/XJVzzD6QQN8WHywtBZxTL3tUeY+CSHZzAWas20QfiAM8VLo11HP6zGNgkw++Lh089kWtR9WQ==
X-Received: by 2002:a05:6402:121a:: with SMTP id c26mr17368750edw.104.1545326406355;
        Thu, 20 Dec 2018 09:20:06 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id u7-v6sm2302464ejb.65.2018.12.20.09.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:05 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caesar Wang <wxt@rock-chips.com>, CK Hu <ck.hu@mediatek.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Eric Anholt <eric@anholt.net>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Lee Jones <lee.jones@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Ley Foon Tan <lftan@altera.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v3 01/19] mailbox: Add device-managed registration functions
Date:   Thu, 20 Dec 2018 18:19:44 +0100
Message-Id: <20181220172002.9016-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add device-managed equivalents of the mbox_controller_register() and
mbox_controller_unregister() functions that can be used to have the
devres infrastructure automatically unregister mailbox controllers on
driver probe failure or driver removal. This can help remove a lot of
boiler plate code from drivers.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix indirection in device-managed pointer (now runtime-tested)

 drivers/mailbox/mailbox.c          | 70 ++++++++++++++++++++++++++++++
 include/linux/mailbox_controller.h |  5 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..08ce9a1ab53a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -515,3 +515,73 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
 	mutex_unlock(&con_mutex);
 }
 EXPORT_SYMBOL_GPL(mbox_controller_unregister);
+
+static void __devm_mbox_controller_unregister(struct device *dev, void *res)
+{
+	struct mbox_controller **mbox = res;
+
+	mbox_controller_unregister(*mbox);
+}
+
+static int devm_mbox_controller_match(struct device *dev, void *res, void *data)
+{
+	struct mbox_controller **mbox = res;
+
+	if (WARN_ON(!mbox || !*mbox))
+		return 0;
+
+	return *mbox == data;
+}
+
+/**
+ * devm_mbox_controller_register() - managed mbox_controller_register()
+ * @dev: device owning the mailbox controller being registered
+ * @mbox: mailbox controller being registered
+ *
+ * This function adds a device-managed resource that will make sure that the
+ * mailbox controller, which is registered using mbox_controller_register()
+ * as part of this function, will be unregistered along with the rest of
+ * device-managed resources upon driver probe failure or driver removal.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int devm_mbox_controller_register(struct device *dev,
+				  struct mbox_controller *mbox)
+{
+	struct mbox_controller **ptr;
+	int err;
+
+	ptr = devres_alloc(__devm_mbox_controller_unregister, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	err = mbox_controller_register(mbox);
+	if (err < 0) {
+		devres_free(ptr);
+		return err;
+	}
+
+	devres_add(dev, ptr);
+	*ptr = mbox;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_mbox_controller_register);
+
+/**
+ * devm_mbox_controller_unregister() - managed mbox_controller_unregister()
+ * @dev: device owning the mailbox controller being unregistered
+ * @mbox: mailbox controller being unregistered
+ *
+ * This function unregisters the mailbox controller and removes the device-
+ * managed resource that was set up to automatically unregister the mailbox
+ * controller on driver probe failure or driver removal. It's typically not
+ * necessary to call this function.
+ */
+void devm_mbox_controller_unregister(struct device *dev, struct mbox_controller *mbox)
+{
+	WARN_ON(devres_release(dev, __devm_mbox_controller_unregister,
+			       devm_mbox_controller_match, mbox));
+}
+EXPORT_SYMBOL_GPL(devm_mbox_controller_unregister);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb42d76..9b0b21207345 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -131,4 +131,9 @@ void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
 void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
 void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
 
+int devm_mbox_controller_register(struct device *dev,
+				  struct mbox_controller *mbox);
+void devm_mbox_controller_unregister(struct device *dev,
+				     struct mbox_controller *mbox);
+
 #endif /* __MAILBOX_CONTROLLER_H */
-- 
2.19.1

