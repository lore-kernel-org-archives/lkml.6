Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x225pcVcO0BvuV86UOQi6DbCXXMuiboe6CL0ejWrAR+06aqh0agmttC2Agww4dfUCmv8AXdxt
ARC-Seal: i=1; a=rsa-sha256; t=1518609995; cv=none;
        d=google.com; s=arc-20160816;
        b=HleRpiOYI5xpPeWIxYSXGaaTBMazM2Uo6iUflGAo7LSgvbqBNuwrr6zsu4zz1g47HR
         MvXczkM9NUxsFc+CE6udac4oNuFzn3kXFmFHqsiSFui4v8QTREX31jxOy/qPChjS3Itb
         N35KUujL/0vOwuiz6E7VA1OSDBV3u8w/0ZW3/82clMaTgTJQ5fuwh/mzAYiHY9dIfsHk
         EbSGmxVcJ55MXA1xX59jAWFfZ/BhdAZlaEuSJbOcFVeFemjV9o6XZQ8acZgZ4ePF1/46
         29vq0GcymazbvKd69e2pzqfxCFtoacHef7SWLUT3xbR5lDz5twC3mk4kDWGFqV0aAyEF
         PTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=KK1zVDC5KhNQ43qmrK2zfm9eqxO9h7qt+IFgmtLIIWM=;
        b=Trlup2YZOF7lFptR4kp7PLBKvRKrheLsNR0prvnuAOBW9MWLvPkIkwqgqwWT+Ywe8l
         8HH/sbQuCAhCj5G1Qlh0ptdrMVsaSKNejm0dLHE76d8DooK91x9zjP0mu7gFQ5dRxPvO
         wxWvmCv78U2RcExXk0YjObep/JSlyBnw5MLHfDxFm3UWT5Oxjccvj4XVw/zgONsUWlta
         Fvic4KC5VAA7XRtZdK+UOLjibWYN79EfxkF0yiJAmoKmU/8cQxfuKfNWOiDyxZU1moBz
         cU6k+yNqjrwdQkIDKTp5b7ikmuyljurfDaYxVWYCzNQACdDgEBZ6rs+YWKmeA94yulRD
         yxJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="18354327"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc 4.16] mei: set device client to the disconnected state upon suspend.
Date: Wed, 14 Feb 2018 14:03:29 +0200
Message-Id: <20180214120329.16094-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592377994478941002?=
X-GMAIL-MSGID: =?utf-8?q?1592377994478941002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes regression introduced by
commit 8d52af6795c0 ("mei: speed up the power down flow")

In mei_cldev_disable during device power down flow, such as
suspend or system power off, it jumps over disconnecting function
to speed up the power down process, however, because the client is
unlinked from the file_list (mei_cl_unlink) mei_cl_set_disconnected
is not called from mei_cl_all_disconnect leaving resource leaking.
The most visible is reference counter on underlying HW module is
not decreased preventing to remove modules after suspend/resume cycles.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Fixes: 8d52af6795c0 ("mei: speed up the power down flow")
---
 drivers/misc/mei/bus.c    | 6 ------
 drivers/misc/mei/client.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 3e5eabdae8d9..772d02922529 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -548,12 +548,6 @@ int mei_cldev_disable(struct mei_cl_device *cldev)
 		goto out;
 	}
 
-	if (bus->dev_state == MEI_DEV_POWER_DOWN) {
-		dev_dbg(bus->dev, "Device is powering down, don't bother with disconnection\n");
-		err = 0;
-		goto out;
-	}
-
 	err = mei_cl_disconnect(cl);
 	if (err < 0)
 		dev_err(bus->dev, "Could not disconnect from the ME client\n");
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index be64969d986a..7e60c1817c31 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -945,6 +945,12 @@ int mei_cl_disconnect(struct mei_cl *cl)
 		return 0;
 	}
 
+	if (dev->dev_state == MEI_DEV_POWER_DOWN) {
+		cl_dbg(dev, cl, "Device is powering down, don't bother with disconnection\n");
+		mei_cl_set_disconnected(cl);
+		return 0;
+	}
+
 	rets = pm_runtime_get(dev->dev);
 	if (rets < 0 && rets != -EINPROGRESS) {
 		pm_runtime_put_noidle(dev->dev);
-- 
2.14.3
