Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0607EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD36C2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j844PqUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBLHNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:13:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38243 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:13:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so868186pfi.5;
        Mon, 11 Feb 2019 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MGS6ysqbO9roBadHqoTXrLlj0bVPiXyCskvOIrSBhDo=;
        b=j844PqUA8anT7QgUWbmwsnQ48DXXHyFTzq4/BKbmwKhRofPMbTGRlP4hGT35AYfTWe
         rUJA07Yqc9iWpYKsozz6EUzPnybLbPn0fc1vdYrqSwICiuiaSOp1PzUwCStzWLDDigGp
         AefdVVIPjYCmrzHvgEHleYVaZHZQA5JK51iqv7TbpqAaHHKwnplNN7dbPkouwU7psi4b
         zgnpFXncm60VM8kivuYlfOvrg/+oCbD4jmLTePd+eNIL2CIlJallF0jld0fIla9ZAYar
         mpPOIFAcFQVSvkrlpnJ92LxzH3xs3VaKt+QXCh7oI73KAS34gjofRGZRXUDMjn5Q3jky
         LK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MGS6ysqbO9roBadHqoTXrLlj0bVPiXyCskvOIrSBhDo=;
        b=eygksuh6D59gkk1u9IA8mqfbtZhNKQQAd13Wa/PrYf4hLLzWr+NwfYsBSbRXN+f1M6
         oTFz95Id1Pkq3ucEBWit9M63OowMFG1Hd7nnEuqtx9B0TFJbUHGR2F81WrecBaA9gOVU
         3UzYW3hRICw2PPoDt52JyDGNm2Q3ROPMTt0SmdBqZ1dWkbCr5J+/C9vB2SZANIyxHqHz
         atlt+QGomiwRjDubiiRCCXQYf+hx84eq3NSVLiHBPpgXEa6asRE/cLT5iLiyZ0EubRVS
         P/L0rMA/dUWhgs0Mas82dY1qDQG2ZRKedk2dOZ1WxuGumvYJ3cLhOaztEnjRa5ZmcXA1
         acoQ==
X-Gm-Message-State: AHQUAuaLMN/dQqi7VMIFBFCLuHYsHz7pViaFfYNwu9YsXtbFNpGV9nKM
        XP0GANUmGYlSYzXXH66bjKo=
X-Google-Smtp-Source: AHgI3IY/IqZofWs+ch+7O6wqKPxbu0ogORmQzVRJmKjdhKrSsyu1yAYjN3lAMYoLjZMGXUJLsn+mcg==
X-Received: by 2002:a62:d448:: with SMTP id u8mr2532877pfl.105.1549955610362;
        Mon, 11 Feb 2019 23:13:30 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id y20sm19046955pfd.161.2019.02.11.23.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 23:13:29 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        kumar.gala@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     QianWenfa <qianwenfa@xiaomi.com>, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] rpmsg: virtio_rpmsg_bus: acknowledge the received creation message
Date:   Tue, 12 Feb 2019 15:13:16 +0800
Message-Id: <1549955596-19784-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: QianWenfa <qianwenfa@xiaomi.com>

the two phase handsake make the client could initiate the transfer
immediately without the server side send any dummy message first.

Signed-off-by: Wenfa Qian <qianwenfa@xiaomi.com>
Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957..e323c98 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -71,6 +71,7 @@ struct virtproc_info {
 
 /* The feature bitmap for virtio rpmsg */
 #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+#define VIRTIO_RPMSG_F_ACK	1 /* RP supports name service acknowledge */
 
 /**
  * struct rpmsg_hdr - common header for all rpmsg messages
@@ -115,10 +116,12 @@ struct rpmsg_ns_msg {
  *
  * @RPMSG_NS_CREATE: a new remote service was just created
  * @RPMSG_NS_DESTROY: a known remote service was just destroyed
+ * @RPMSG_NS_ACK: acknowledge the previous creation message
  */
 enum rpmsg_ns_flags {
 	RPMSG_NS_CREATE		= 0,
 	RPMSG_NS_DESTROY	= 1,
+	RPMSG_NS_ACK		= 2,
 };
 
 /**
@@ -330,13 +333,14 @@ static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
 	int err = 0;
 
 	/* need to tell remote processor's name service about this channel ? */
-	if (rpdev->announce && rpdev->ept &&
+	if (rpdev->ept && (rpdev->announce ||
+	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_ACK)) &&
 	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
 		struct rpmsg_ns_msg nsm;
 
 		strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
 		nsm.addr = rpdev->ept->addr;
-		nsm.flags = RPMSG_NS_CREATE;
+		nsm.flags = rpdev->announce ? RPMSG_NS_CREATE : RPMSG_NS_ACK;
 
 		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm), RPMSG_NS_ADDR);
 		if (err)
@@ -820,6 +824,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	struct rpmsg_channel_info chinfo;
 	struct virtproc_info *vrp = priv;
 	struct device *dev = &vrp->vdev->dev;
+	struct device *tmp;
 	int ret;
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
@@ -847,21 +852,30 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 	msg->name[RPMSG_NAME_SIZE - 1] = '\0';
 
 	dev_info(dev, "%sing channel %s addr 0x%x\n",
-		 msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
+		 msg->flags == RPMSG_NS_ACK ? "ack" :
+		 msg->flags == RPMSG_NS_DESTROY ? "destroy" : "creat",
 		 msg->name, msg->addr);
 
 	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = msg->addr;
 
-	if (msg->flags & RPMSG_NS_DESTROY) {
+	if (msg->flags == RPMSG_NS_DESTROY) {
 		ret = rpmsg_unregister_device(&vrp->vdev->dev, &chinfo);
 		if (ret)
 			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
-	} else {
+	} else if (msg->flags == RPMSG_NS_CREATE) {
 		newch = rpmsg_create_channel(vrp, &chinfo);
 		if (!newch)
 			dev_err(dev, "rpmsg_create_channel failed\n");
+	} else if (msg->flags == RPMSG_NS_ACK) {
+		chinfo.dst = RPMSG_ADDR_ANY;
+		tmp = rpmsg_find_device(&vrp->vdev->dev, &chinfo);
+		if (tmp) {
+			newch = to_rpmsg_device(tmp);
+			newch->dst = msg->addr;
+		} else
+			dev_err(dev, "rpmsg_find_device failed\n");
 	}
 
 	return 0;
@@ -1028,6 +1042,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_RPMSG_F_NS,
+	VIRTIO_RPMSG_F_ACK,
 };
 
 static struct virtio_driver virtio_ipc_driver = {
-- 
2.7.4

