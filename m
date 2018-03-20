Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521544668; cv=none;
        d=google.com; s=arc-20160816;
        b=VgHtN0LLrl5yOBDWjitKvt++8uIVPaTD+nAuEieuNTTBQWCJRsGVHZ/tNj0+pWSLK7
         2FNjHKYldAc2QVhihB2xjHediP7P283UgzDbqGdZsT+0QMyyD+/8S184ny6WDGBrWPH3
         U5z6YuN0hrmN2RHzUmeGTUdqBRHQHKg3L7McucfeFUfPoxwSjElb1F8fIvCiG6jPpB4d
         4gA5OL2wZ95T81j2M6k3FJ8HejTjR8e9wrjbqmqcc2e6iPCStY7lB9sZelQpeOrAkDvr
         w75U0Hw5eZKG+rI6ZWpokW0gwnmWNzK5CSbGwk86BZQpoLOgkBXcMqJaaWpu9xQEt9dy
         d51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=aCdzilcTn5bLdeIBvCsigv0/v7HvLzb1v8wxzMC9AEI=;
        b=hPon3Ox4zqFIBNYC4uci+vpJTU+/pr6sxQ5ppuiVtZEvYTlnsWTMqGJu3UFXapnoMJ
         epEiFiDbsCvNmY6ljvmcSltiFISI/mdnyHI/SJpMNdeXzbd/g/UCt9MevbW9JDnP9mAn
         LNzLKeJ2TJ0Lh+bRHHKIB+AKxLhwrEW8GwHF1CCGef7lFdKh8wkBY3GKNhgAAmmaBUG9
         dSQjGsfkvruN0qjbq6mCf0KKRvjsLQj94QhE6A2Rhyq40P37ENfD409gdBhizNHork5T
         7MaY8Qy4eEqfa9xvVjSo4/Sme4IOVRHZ55F6LL1b8Os7Fv2ONz0QTU7oH5lcwDRQHKyd
         upkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n8yJZ064;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n8yJZ064;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuQcPQVxgLHploWPFUtJE+Iz5HaCwPCMeZefrIGf5Gfd4J9rDJdtbSaxMKy0cSStYFsiFD3cQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org,
	laurent.pinchart@ideasonboard.com,
	sean@mess.org,
	gregkh@linuxfoundation.org,
	andreyknvl@google.com,
	hans.verkuil@cisco.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFT] media: hdpvr: Fix Double kfree() error
Date: Tue, 20 Mar 2018 16:46:39 +0530
Message-Id: <ed0e67f9c56e42827f34d6e2991e6572070f8996.1521544143.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595455222819070559?=
X-GMAIL-MSGID: =?utf-8?q?1595455222819070559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Here, double-free is happening on error path of hdpvr_probe.

error_v4l2_unregister:
  v4l2_device_unregister(&dev->v4l2_dev);
   =>
    v4l2_device_disconnect
    =>
     put_device
     =>
      kobject_put
      =>
       kref_put
       =>
        v4l2_device_release
        =>
         hdpvr_device_release (CALLBACK)
         =>
         kfree(dev)

error_free_dev:
           kfree(dev)

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
reported by:
           Dan Carpenter<dan.carpenter@oracle.com>

 drivers/media/usb/hdpvr/hdpvr-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index 29ac7fc..cab100a0 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -395,6 +395,7 @@ static int hdpvr_probe(struct usb_interface *interface,
 	kfree(dev->usbc_buf);
 error_v4l2_unregister:
 	v4l2_device_unregister(&dev->v4l2_dev);
+	dev = NULL;
 error_free_dev:
 	kfree(dev);
 error:
-- 
1.9.1
