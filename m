Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AIpwx49+70x/WX7uN0SJUuTaurpe8YzqnTE3/0ngOWzbu9QV/IvtbD97P7rh6DSIRjNAbuN80l+7
ARC-Seal: i=1; a=rsa-sha256; t=1523545077; cv=none;
        d=google.com; s=arc-20160816;
        b=Oq/GN/2XqnPMOMvny72liUVTks+IGjglEznKW+H9NjM4+Al93rtHoU4+Yj9tJ3Wwdl
         QeZKtcPCSuUYd3sjtp73GKLKh6p7jn2NnBUvHfHCmrZRO9kVDkYXDV7j8u+TTU00aWRz
         F02I5UENdPE98AjOqAU9F2AEytQ6T+8/Oc3U+IDOgDqRdAqpHBHRi197lYVi2Ql0v8d2
         x3MA11OiprN9sKUb3gzLYexH6rB52gSD6zewbntJwBqy9Qc4VojYrnbl1HP7v7eXjF14
         5fM/fy1hMwX5hwiU2uGOSq0F2poSivYuFX14kevlTt1Pr6+k3m8hB7yzv0JmotIg5H4Z
         dFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=z8UuuuMyd3XbFPWnI1xfdnwV0/asniBgKvAESzV2Jpo=;
        b=s98X2z3aeJXo1Xsccldgbc4VBBLjC4oW59NQ2t/zdkcWTWt4QZUwd8iKpS44ocFO8p
         1eMwyAhII3F6lP7/LASfpMtPYr+FEgVDAdnYVNUFREXYj2BQYYlQhZUlFm1scOmh//x1
         gVH0MIh6a6c6dHV2QumS/qEOrPWrlcNF2+a1S/a3G+Jo/u2a70Z8VKbgzNjOorTGvAmm
         gmWF58oSCZcC1FyJrw7S8EeO5CevfK6+0U7MH/3X6hXeTaWx3T+aHOCqquF4BUUun50e
         9sJ1WPoWTJ/7CJfNPevsCRU4uUcYm8m9xyNMky5yDc9Yrsj2Kyiy88sJCB2jtX4FGcBA
         E8WA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Tobin C . Harding" <me@tobin.cc>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Quytelda Kahja <quytelda@tamalin.org>,
	devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: ks7010: fix null pointer dereference on priv on error exit
Date: Thu, 12 Apr 2018 15:57:56 +0100
Message-Id: <20180412145756.24949-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552803587566842?=
X-GMAIL-MSGID: =?utf-8?q?1597552803587566842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

In the case where the call to dev_alloc_name fails the current exit
path is via err_free_netdev and this calls free_netdev on a null priv
pointer, hence causing a null pointer dereference.  Fix this by instead
exiting via err_release_irq.

Detected by CoverityScan, CID#1467844 ("Explitic null dereferenced")

Fixes: 13a9930d15b4 ("staging: ks7010: add driver from Nanonote extra-repository")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index b8f55a11ee1c..cb0e11d79e32 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -895,7 +895,7 @@ static int ks7010_sdio_probe(struct sdio_func *func,
 		netdev_err(priv->net_dev,
 			   "ks7010: firmware load failed !! return code = %d\n",
 			   ret);
-		goto err_free_netdev;
+		goto err_release_irq;
 	}
 
 	/* interrupt setting */
-- 
2.17.0
