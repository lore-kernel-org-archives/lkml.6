Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeBUJ3I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:29:08 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37126 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeBUJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:39 -0500
X-Google-Smtp-Source: AH8x225gHA0kAFGW1VSaYxXnucy8uIlcwfh+6oBpZIIq+Hgs8t3JQXkSOaGH9xa3CTJZdrUJLA3O9w==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 17/20] lightnvm: define chunk states
Date: Wed, 21 Feb 2018 10:26:55 +0100
Message-Id: <1519205218-26994-18-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
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
index bc43700c37ec..4dfb85d08ab5 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -297,6 +297,20 @@ struct nvm_dev_geo {
 	struct nvm_common_geo c;
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
