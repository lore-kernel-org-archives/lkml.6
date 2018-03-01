Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965235AbeCAKQe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:16:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7066 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934985AbeCAKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:16:32 -0500
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>
Subject: [PATCH] mailbox: return error in mbox_request_channel_byname
Date: Thu, 1 Mar 2018 11:16:14 +0100
Message-ID: <1519899374-21297-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'name' is not found in the "mbox-names" list, return an error

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/mailbox/mailbox.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f..a31970a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -391,11 +391,12 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 
 	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
 		if (!strncmp(name, mbox_name, strlen(name)))
-			break;
+			return mbox_request_channel(cl, index);
 		index++;
 	}
 
-	return mbox_request_channel(cl, index);
+	dev_err(cl->dev, "%s() mbox %s not found\n", __func__, name);
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
-- 
2.7.4
