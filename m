Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523416060; cv=none;
        d=google.com; s=arc-20160816;
        b=w3bsNQJU4q78ySJCkvhaC1woYiWQYJJ/ae9LUWT09h9s+4tT5DvhaGkp7Q3rtIhlPl
         DzunVakiYOMmOq2RKjondMQMO/gwYRFhvheiaOYeygq8wMFTfSfQCoqWTvpzMqhpxm+Z
         MtaSh3gemiXaQEAHeJkfkMtmfbFc94Hx+v7UccTyaorwapu4oOIo+TVGA6J2ir09TTOE
         2qHGw/G51OsC1VxsB5fSkltEbMTU0g2fo4IOuFoHPM0AztsxlYrjCTqquHlU+Oc/cn79
         kZ8PeMtFgKnNCy6BVQqo1xt8M+7F5wpsnn7MkVaMGIVGf6K9xgVbsKewzO05z7bPH4xo
         Bvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=wxnf4jRzKtOOd6mszvOFEeF0RMAKDQI5frBAkD+l+kw=;
        b=0FDPvl9sAklkhdJ6RbrnELt9bJ3mky0XpgEnJ8kvOuA78AC6v6FBox77dPoV2DI0pc
         ZJ3284p1u+ycwEKrgZxgNr5/fboZDUyx4i3aCs0vd9qpB6f2bbwHctVctMi0zWGC9dnL
         XG8ed4XfaAzumUrs9JoEYpg7euV/7PpcWmjBHGfMXMcZ7aUhApxzEFA4/MXIjVwmiQLe
         SS7PTZUIs6Q517Rw5v2DY69CIHt7pe+YAYhKVuJEnEyguvNor2R1VZnCWqgV+eujt+oQ
         EcYp68ZDi08mX0w2y4qcM4ondUH8BVxq7Mp9aa/lQqGVPAk9jt6rc0i3lKWTdMjamkPg
         s/GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P4U7QRLv;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P4U7QRLv;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49R5FJhL5mtsbJg7deujR0U/JEyc/RtPZ07j/lLMRidubbR1/BNXq4mWREMfQCsyUeM6LQ5Ig==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: arvind.yadav.cs@gmail.com,
	johannes.berg@intel.com,
	stephen@networkplumber.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] misc: ti-st: Replace GFP_ATOMIC with GFP_KERNEL in kim_probe
Date: Wed, 11 Apr 2018 11:07:32 +0800
Message-Id: <1523416052-2938-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597417519401676795?=
X-GMAIL-MSGID: =?utf-8?q?1597417519401676795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

kim_probe() is never called in atomic context.
This function is only set as ".probe" in struct platform_driver.

Despite never getting called from atomic context,
kim_probe() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/misc/ti-st/st_kim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index b77aaca..5ec3f5a 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -735,7 +735,7 @@ static int kim_probe(struct platform_device *pdev)
 		st_kim_devices[0] = pdev;
 	}
 
-	kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_ATOMIC);
+	kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);
 	if (!kim_gdata) {
 		pr_err("no mem to allocate");
 		return -ENOMEM;
-- 
1.9.1
