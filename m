Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED54FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94B2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlV8HKMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfALFem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 00:34:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALFem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 00:34:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so17397210wrw.1;
        Fri, 11 Jan 2019 21:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7ShIJq766Qc8Y/A5T5dsWbItZEA7Q8RE8v6LaoGJ1gw=;
        b=YlV8HKMnm/F7wBLC6aCmAmXrM36Ps+o5Sb0jW5P2t5uuoKLyTuG8uOhwswAu4evegb
         mMrORjpbx+fiDXP++ahC0v1O82st3hNNSWI8gkHaj0VHgu/2aWZ0+akn4H7kOg2lZ36W
         i5/Qmz3YWtnXOlGz0VQ1yGd27qK/3IjWQZtIygCzBpmurlHSobFnGLc8b6nOkVdWtq8o
         oIlJnNsuNhIAkRGMipCSHdQtK6BAZ9fRflIhsR81hetOyn0Rui6KZP5wOEv1DAW1qbN6
         lEE/ZU98hw7X8+PPNTFXL7sgLciJeVz27FLIrwmVSiPJa9m5o0Eu+SCMhQDMa80XJBhw
         nMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ShIJq766Qc8Y/A5T5dsWbItZEA7Q8RE8v6LaoGJ1gw=;
        b=Cq3AwsyO71udseyNje3s8on5hfQJRvxOr+2TBlaF+Ycff9Xsg1DUVNCcFSuJ/oLRr2
         NefxGBvTOKngUS9QMnMybUkO7F0A1W/zkqB09m1LRc1gxFIGCxztd9N1HbjzbJvlBdVO
         QToJ4hAPwL95nTLj+5Hd2J01cUUz/VRjSxBE1cGx90uG3hdERWM3oO0KNzvF6HH0FMtY
         BrFbhrIqLh3+flM9opnpIxomH8+1G0TQ/39XZANu3kPenNttwjugJYUsufYHCSAOenrv
         PXEMAZjt8ZJi0HFCAd+UrNhNRKJqk7ghFsdmIFQGXs1QXBaMQiLIw5TLvxAGLq+1VIC+
         FgRA==
X-Gm-Message-State: AJcUukca6qH7A1Bf8G1XGDbZUupB99mATie/mue5VvdOwqjn1GSFOrhn
        Iaypg9fGvXkJAWTU9PzW9Zc3PGdVAMQ=
X-Google-Smtp-Source: ALg8bN7R6QiYdUUIYk4NU9BhGmdIjrTzvHKvp75pRKjCKadTIurNzjWfxYJ8RyhqnqAlxi/shonOjA==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr15690705wrt.43.1547271279218;
        Fri, 11 Jan 2019 21:34:39 -0800 (PST)
Received: from alpaca.bmw-carit.intra ([145.253.130.2])
        by smtp.gmail.com with ESMTPSA id k19sm87681706wre.5.2019.01.11.21.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 21:34:38 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        QLogic-Storage-Upstream@cavium.com, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fcoe: make use of fip_mode enum complete
Date:   Sat, 12 Jan 2019 06:34:27 +0100
Message-Id: <20190112053427.35696-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1917d42d14b7 ("fcoe: use enum for fip_mode") introduces a separate
enum for the fip_mode that shall be used during initialisation handling
until it is passed to fcoe_ctrl_link_up to set the initial fip_state.
That change was incomplete and gcc quietly converted in various places
between the fip_mode and the fip_state enum values with implicit enum
conversions, which fortunately cannot cause any issues in the actual
code's execution.

clang however warns about these implicit enum conversions in the scsi
drivers. This commit consolidates the use of the two enums, guided by
clang's enum-conversion warnings.

This commit now completes the use of the fip_mode:
It expects and uses fip_mode in {bnx2fc,fcoe}_interface_create and
fcoe_ctlr_init, and it explicitly converts from fip_mode to fip_state
only at the single point in fcoe_ctlr_link_up.

To eliminate that adding or removing values from fip_mode or fip_state enum
break the right mapping of values, all fip_mode values are assigned to
their fip_state counterparts.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
resending of this patch:
https://patchwork.kernel.org/patch/10589865/

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c  | 2 +-
 drivers/scsi/fcoe/fcoe.c           | 2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c      | 4 ++--
 drivers/scsi/fcoe/fcoe_transport.c | 2 +-
 drivers/scsi/qedf/qedf_main.c      | 2 +-
 include/scsi/libfcoe.h             | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index f00045813378..83aaab4fdab5 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1445,7 +1445,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cnic_dev *cnic)
 static struct bnx2fc_interface *
 bnx2fc_interface_create(struct bnx2fc_hba *hba,
 			struct net_device *netdev,
-			enum fip_state fip_mode)
+			enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct bnx2fc_interface *interface;
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f46b312d04bc..6768b2e8148a 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -390,7 +390,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
  * Returns: pointer to a struct fcoe_interface or NULL on error
  */
 static struct fcoe_interface *fcoe_interface_create(struct net_device *netdev,
-						    enum fip_state fip_mode)
+						    enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct fcoe_ctlr *ctlr;
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 54da3166da8d..a52d3ad94876 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -147,7 +147,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
  * fcoe_ctlr_init() - Initialize the FCoE Controller instance
  * @fip: The FCoE controller to initialize
  */
-void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_state mode)
+void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
 {
 	fcoe_ctlr_set_state(fip, FIP_ST_LINK_WAIT);
 	fip->mode = mode;
@@ -454,7 +454,7 @@ void fcoe_ctlr_link_up(struct fcoe_ctlr *fip)
 		mutex_unlock(&fip->ctlr_mutex);
 		fc_linkup(fip->lp);
 	} else if (fip->state == FIP_ST_LINK_WAIT) {
-		fcoe_ctlr_set_state(fip, fip->mode);
+		fcoe_ctlr_set_state(fip, (enum fip_state) fip->mode);
 		switch (fip->mode) {
 		default:
 			LIBFCOE_FIP_DBG(fip, "invalid mode %d\n", fip->mode);
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index f4909cd206d3..b381ab066b9c 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -873,7 +873,7 @@ static int fcoe_transport_create(const char *buffer,
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
-	enum fip_state fip_mode = (enum fip_state)(long)kp->arg;
+	enum fip_mode fip_mode = (enum fip_mode)(long)kp->arg;
 
 	mutex_lock(&ft_mutex);
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 0a5dd5595dd3..cd61905ca2f5 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1418,7 +1418,7 @@ static struct libfc_function_template qedf_lport_template = {
 
 static void qedf_fcoe_ctlr_setup(struct qedf_ctx *qedf)
 {
-	fcoe_ctlr_init(&qedf->ctlr, FIP_ST_AUTO);
+	fcoe_ctlr_init(&qedf->ctlr, FIP_MODE_AUTO);
 
 	qedf->ctlr.send = qedf_fip_send;
 	qedf->ctlr.get_src_addr = qedf_get_src_mac;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index cb8a273732cf..f8f1f039a611 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -80,9 +80,9 @@ enum fip_state {
  */
 enum fip_mode {
 	FIP_MODE_AUTO = FIP_ST_AUTO,
-	FIP_MODE_NON_FIP,
-	FIP_MODE_FABRIC,
-	FIP_MODE_VN2VN,
+	FIP_MODE_NON_FIP = FIP_ST_NON_FIP,
+	FIP_MODE_FABRIC = FIP_ST_ENABLED,
+	FIP_MODE_VN2VN = FIP_ST_VNMP_START,
 };
 
 /**
@@ -250,7 +250,7 @@ struct fcoe_rport {
 };
 
 /* FIP API functions */
-void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_state);
+void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode);
 void fcoe_ctlr_destroy(struct fcoe_ctlr *);
 void fcoe_ctlr_link_up(struct fcoe_ctlr *);
 int fcoe_ctlr_link_down(struct fcoe_ctlr *);
-- 
2.17.1

