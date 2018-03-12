Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520854675; cv=none;
        d=google.com; s=arc-20160816;
        b=OYMwqOoidDtzzd49sspG762V+5hLXjd/fS4yZOJkREwA7QKY72W4rgvFvCCT/9K1n0
         kNw7pjB4BgIcf72Tv7YTCVVhXmezp0X9dZAG1ifJuRmzw7xQpeGOF/kGPVF/Vr8L+TBm
         CsyeZRIGPvtBiEstIhLUUl2UPaa8hdRBvAiX3Dp2qLEDNmuCFti8EtjEuQ64OUsw67oT
         A8wYae5STJ0LAoGgkQ9enwFgyw+9lX0qqzh/gx97Wmt+frS6wnhlzleH24JIuOkcGBtM
         7H/8rBOV6C46/vE4aYnfwOnzryfDd4yg09HqHdeLkjyzuVJf+IuYzkqaWJdhs5/qQzhW
         PRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x0uTyMrR7/KPaEECyDw15DJcaNlI19OcCMrvBPxs7+M=;
        b=PCRefEmmNjkZ2qxwRZhCnpKrX1TjKh40dGy3/NLpTO0IHLGRAXHFK0tDQyqNglAAfp
         kBkN6K7WIibWkk9MMuBxxVNk+xItldEbvJVVd5taNjINSaX0HB4Hvl6tQoejnFChHbjK
         aMcKvhtULBY/4fIkuHftkMjq64nSlK0A2pCudVgV7/2u10wTdVkUnPyRIW4Gaklq8khT
         8ggXuAObazLYeFXmWgmnWloNXoQWocSuZiq10RQClJ5XMJY42ZgqlYMOk9Yw7Dz6+af+
         RTwzneaC4HLsFYSzWCrdZFSkB1xyigBUGPc6sHqMvuvfZhFXUZns4xJPPMwia7w0Y4ak
         tcxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nrN1Q/QX;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nrN1Q/QX;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsdmt7zlagZyHKYr2xV2+rPjT3KQk9BUlTNAwwtYltzgUdJ5i7rtHZTJDTUDjj46XeWPSkFNw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com,
	ashutosh.dixit@intel.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	fbarrat@linux.vnet.ibm.com,
	andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] misc: mic: Release reference count and memory for VOP device
Date: Mon, 12 Mar 2018 17:06:52 +0530
Message-Id: <46d6830218c1652a1e06ede169a4bcc8cf0e3b58.1520849284.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594731712250913121?=
X-GMAIL-MSGID: =?utf-8?q?1594731712250913121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Never directly free @dev after calling device_register(),
even if it returned an error! Always use put_device() to
give up the reference initialized.
Release allocated memory for vop device in vop_release_dev().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/misc/mic/bus/vop_bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.c b/drivers/misc/mic/bus/vop_bus.c
index fd7f2a6..e5bb9c7 100644
--- a/drivers/misc/mic/bus/vop_bus.c
+++ b/drivers/misc/mic/bus/vop_bus.c
@@ -135,7 +135,9 @@ void vop_unregister_driver(struct vop_driver *driver)
 
 static void vop_release_dev(struct device *d)
 {
-	put_device(d);
+	struct vop_device *dev = dev_to_vop(d);
+
+	kfree(dev);
 }
 
 struct vop_device *
@@ -174,7 +176,7 @@ struct vop_device *
 		goto free_vdev;
 	return vdev;
 free_vdev:
-	kfree(vdev);
+	put_device(&vdev->dev);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(vop_register_device);
-- 
1.9.1
