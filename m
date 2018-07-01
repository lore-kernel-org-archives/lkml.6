Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E51C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D897925854
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897925854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030288AbeGASE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:04:56 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3225 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030229AbeGASEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 14:04:50 -0400
X-IronPort-AV: E=Sophos;i="5.51,295,1526335200"; 
   d="scan'208";a="271074628"
Received: from palace.rsr.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jul 2018 20:04:45 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Hans Verkuil <hverkuil@xs4all.nl>, joe@perches.com,
        Chengguang Xu <cgxu519@gmx.com>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [media] gspca_kinect: cast sizeof to int for comparison
Date:   Sun,  1 Jul 2018 19:32:05 +0200
Message-Id: <1530466325-1678-4-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.  kinect_read returns the result of
usb_control_msg, which can return a negtive error code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
int x;
expression e,e1;
identifier f;
@@

*x = f(...);
... when != x = e1
    when != if (x < 0 || ...) { ... return ...; }
*x < sizeof(e)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/usb/gspca/kinect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/kinect.c b/drivers/media/usb/gspca/kinect.c
index 0cfdf8a..f993f62 100644
--- a/drivers/media/usb/gspca/kinect.c
+++ b/drivers/media/usb/gspca/kinect.c
@@ -163,7 +163,7 @@ static int send_cmd(struct gspca_dev *gspca_dev, uint16_t cmd, void *cmdbuf,
 		actual_len = kinect_read(udev, ibuf, 0x200);
 	} while (actual_len == 0);
 	gspca_dbg(gspca_dev, D_USBO, "Control reply: %d\n", actual_len);
-	if (actual_len < sizeof(*rhdr)) {
+	if (actual_len < (int)sizeof(*rhdr)) {
 		pr_err("send_cmd: Input control transfer failed (%d)\n",
 		       actual_len);
 		return actual_len < 0 ? actual_len : -EREMOTEIO;

