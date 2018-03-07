Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520418207; cv=none;
        d=google.com; s=arc-20160816;
        b=wAW8RfFb2CX0FHwkrd+Dxb+suRhLHWeNUa4aqy1w1ZFs3ATF20QoDLmcz4O6NL/cUo
         J+na7elCYWt6bVJsctwZ2rv4Uee0aV76cxQZz/ngH+onBl4HsiXe+cpcc1Zas6+1ijo4
         MF8b5QupQkI+VJ6CVOlEO+9SONtu7+UUtCWQoihY2817Fng9J9F0nISQ3LPNyDpyuZIq
         sz1bydN6ryuOPD1KbERV/797mYpw0VgCPVC/psvoeMFFIrk9WQqwW/7mDX3lewzeNSm8
         CYD0V10wkFyWFlirEhXvOKkA02Af8RNgA27DxLSYBMdU0qtlBSTIiZLsWXcLidf9EVIj
         gAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ZNf6kRsK+KqP2l6Gc/Eh83nEdOWztQg1WMpYnIAeEBw=;
        b=pbWyOccYuJKuRZ8XmDga2ICezliJuLOFMvDvPDynXq8dZovlahhA9IUyJ3poc2NcpA
         chmx77vj6EVqemwFepqwGpqFZuRyaplMEbSGGMgM4W9g/rZP91+2wDidQEAzXuP5mIch
         ktcYVALtd3lyw+qoUWm0xuNjjuv9WA+U2g4mbzVWYJ0rKWfrUwJJDyw5cs0c01oyIQ1q
         v/piesiq+2y78i3VdvVLbfdd/9OvGe3Zt5LSO/yZXfHf+HXrsJpNmKx/cH229g4sUSjv
         BS0Hli1xN4nc2/TqZKO5mZ+rhxkHjVAJO4Lb/eqmzob7v9TWnyCrbXWYMNjbmdqNm3S5
         DdXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K3RBit1+;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K3RBit1+;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsgS6MoDuJdyaBy38QByrqwXT5KtUtm+FxtO9ZLEP2FVzAxJf11DSz/tPnPZeb+fY4f7+LdbA==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: srinivas.kandagatla@linaro.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH] slimbus: core: use put_device() instead of kfree()
Date: Wed,  7 Mar 2018 15:52:38 +0530
Message-Id: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594274042806495005?=
X-GMAIL-MSGID: =?utf-8?q?1594274042806495005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/slimbus/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 4988a8f..7ddfc67 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -141,7 +141,7 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
 	sbdev->e_addr = *eaddr;
 	ret = slim_add_device(ctrl, sbdev, node);
 	if (ret) {
-		kfree(sbdev);
+		put_device(&sbdev->dev);
 		return NULL;
 	}
 
-- 
1.9.1
