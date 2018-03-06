Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520331892; cv=none;
        d=google.com; s=arc-20160816;
        b=CFRpqOs8WpQB4+E7a4/eDdlUzveNFZHNsMRn2B/CaEjumohHEHZEJcXTTueKl25q5I
         TeHqTVyD4wepTlgkRVc7VfURg9xL3vGeMwt6X+o4VTAY3nOyfDgpNkj++8JUaoCPcqKR
         p1nt4yUiB7msL40rGJOow8tiNv4HvRf62RFkizAHlQu58buQPEQwVpeWDDshWQFLpewQ
         kSN/yTWeMXIoKM8A66AXVB2hvjOBAJ8KgktfeYsA+knFTt86lRIL1VHVKIuC8BMMN921
         /YQe7PS9CW1gy7zO3I5hh2wE1c5W3lWm35KOfDJi6Y6WXuRcsN7u4uQ0FCPYUhHCV/z3
         eD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xGOW4iHFtfIqmU+lhchF74zOTelJzw8V/YS4G7qbtQI=;
        b=mFAVTmD2XdH7Jo04WxMElbT3rLWp5/7Us/HDOaPZ2UDgQcAeNsPf35/ClqiT5098Z/
         zLFpvurM4u/JlXlP6BX8yUjZHV3eqTXcLBOZqpSipDBJsSHSLnXuqGznuruFK8CM3Vuw
         vvOgVBN6PVq1Bd1AmxLo0U0aWbj7qNPDXipIi6OIm5KcPbIVGgb51OLl5lyjz2K8MprD
         F47VTo/q/DXMFwERXOo7edyIke97PYWngeGR75W9DfyFLhUQhm0m9UR0eBK1lN4s+/o5
         8KJtovk4cz1oGCLX41aL0/B6+Su3J+vkvWDjDbgCnkYHEl9PyGq5fkeg96n8Eh71bwTi
         Ivfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EQUslGW7;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EQUslGW7;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsF/QbK+VBeGEVaMfVWw6Lu6mlvKEN8uPbbAJNFPChb6WMicJwdOwB0pZ/pfCDRe5Xr9+H91Q==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: zbr@ioremap.net,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] w1: use put_device() if device_register() fail
Date: Tue,  6 Mar 2018 15:54:06 +0530
Message-Id: <6d62570e4914054536ac7f62ee385c2887e8f093.1520331702.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594183535061008850?=
X-GMAIL-MSGID: =?utf-8?q?1594183535061008850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If device_register() returned an error! Always use put_device()
to give up the reference initialized in device_register().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/w1/w1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 0c2a5a8..80a778b 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -706,6 +706,7 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 		dev_err(&sl->dev,
 			"Device registration [%s] failed. err=%d\n",
 			dev_name(&sl->dev), err);
+		put_device(&sl->dev);
 		return err;
 	}
 	w1_family_notify(BUS_NOTIFY_ADD_DEVICE, sl);
-- 
1.9.1
