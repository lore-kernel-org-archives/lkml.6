Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeBZNWV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:22:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35544 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeBZNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:47 -0500
X-Google-Smtp-Source: AH8x225LdUjScVWo6Rbk5Umlu8qaHhIJzhL9T/9TJiUCfONLF/i1opEcoJvdh8dsDaH54QWx5hnVvw==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 16/19] lightnvm: define chunk states
Date: Mon, 26 Feb 2018 14:17:15 +0100
Message-Id: <1519651038-16845-17-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define chunk states as given in the 2.0 spec. Also, add an extra chunk
state that signals that the chunk is in use by the host. This allows for
the chunk metadata to be "owned" by a target when active, thus
completing the chunk state machine from the host perspective and
facilitating sanity checks. This state is transparent for the device.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 include/linux/lightnvm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 776ffdc2e137..74830d5dbd6e 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -232,6 +232,20 @@ struct nvm_addr_format {
 	u64	rsv_mask[2];
 };
 
+enum {
+	/* Chunk states */
+	NVM_CHK_ST_FREE =	1 << 0,
+	NVM_CHK_ST_CLOSED =	1 << 1,
+	NVM_CHK_ST_OPEN =	1 << 2,
+	NVM_CHK_ST_OFFLINE =	1 << 3,
+	NVM_CHK_ST_HOST_USE =	1 << 7,
+
+	/* Chunk types */
+	NVM_CHK_TP_W_SEQ =	1 << 0,
+	NVM_CHK_TP_W_RAN =	1 << 1,
+	NVM_CHK_TP_SZ_SPEC =	1 << 4,
+};
+
 /*
  * Note: The structure size is linked to nvme_nvm_chk_meta such that the same
  * buffer can be used when converting from little endian to cpu addressing.
-- 
2.7.4
