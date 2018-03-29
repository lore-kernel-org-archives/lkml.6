Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx49zbCT60h6p+VL3elL+IRCUtnq3chQXSCSJqtIGGqiEYi7z85FDya82Hg2N0mCgllWD5Qjt
ARC-Seal: i=1; a=rsa-sha256; t=1522322481; cv=none;
        d=google.com; s=arc-20160816;
        b=kKTBuibJJN4lPzpfrP7uS+rsGe8BVjKFZ3ch5nq3YC+buRP+G+cNx+mxuZKZaev1np
         C6jehRRkX4emIIm9g1VPqjeriRWpWfspOCKVbrCPmmpg76THu/iCM+Uu+CMHWG1qRE88
         Z2WJdt4T+8qBuGOpbiVNEc+bGcm97iubFsDD99JhxvIMS67APNsmnCMdTprdffRL/blg
         Ygz5YyMenyTIaD0ZUIY6Krt7CgBNqUbItgYRbivYSPw5g1ms2ETfJfBjwHElB+4qFOJL
         mCVugaJH5f7nl2RN+2J36KSxHMj9HaMX6O0Ty0DpNoZtLC+cBoLlPMMCLN+H1/nr7Nky
         YgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PTljvnt0UbHR/0aSeRrop9zdt0aZI+tTH4XrcgoC2lU=;
        b=iC0IWFFEc2PP02dgMRFQ7c4ClUZWm8J1FsHKROKs7p8qQEAFvgCwqzegSiS2ovZD2R
         A+CHXpW0W31ywUxCKy/sXLCzodtzo1VSfH+y2iHVDZj023sslmHyqhazoWzUt7o8n0e3
         Ie60yJzNtZIglNrhgOv009DJUHoED9oG7UyTTiW93hYhIMX7VQT7dpoMvA2dC3Tsx1d6
         dKNR7wM81ZFanBjf+xKcJQAY4Za5RYx+wWSP3QSWcinq0punMEBP4O4jPOiXUBI79sbP
         uztYHLq/Cu6xfh7V7js7naLGVWO+v5/4TFXdHa99j1PUw/9ijLulZauhibrr+BLLOS27
         UEUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] virt: vbox: Log an error whenwe fail to get the host version
Date: Thu, 29 Mar 2018 13:21:16 +0200
Message-Id: <20180329112116.26488-3-hdegoede@redhat.com>
In-Reply-To: <20180329112116.26488-1-hdegoede@redhat.com>
References: <20180329112116.26488-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596270817967002344?=
X-GMAIL-MSGID: =?utf-8?q?1596270817967002344?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was the only error path during probe without a message being logged
about what went wrong, this fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 7411a535fda2..2f3856a95856 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -727,8 +727,10 @@ static int vbg_query_host_version(struct vbg_dev *gdev)
 
 	rc = vbg_req_perform(gdev, req);
 	ret = vbg_status_code_to_errno(rc);
-	if (ret)
+	if (ret) {
+		vbg_err("%s error: %d\n", __func__, rc);
 		goto out;
+	}
 
 	snprintf(gdev->host_version, sizeof(gdev->host_version), "%u.%u.%ur%u",
 		 req->major, req->minor, req->build, req->revision);
-- 
2.17.0.rc1
