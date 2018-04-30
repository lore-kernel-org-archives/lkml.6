Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpF+n2WpojN3qvHVajRKWmcajPQ7wavnJp1Y9ljlGqxs+qeMJzALzW4AYro/7m5EIIYGbeV
ARC-Seal: i=1; a=rsa-sha256; t=1525116242; cv=none;
        d=google.com; s=arc-20160816;
        b=XEfCgvDOPzqh3PKSCoPJSlfXDuk1Wtpfu++0zdWBVwBtEUoO2EanmCZHDIwQZbY8Oq
         XqPcpkmmOPzBCR9JVndfULsm+efb2nTs+JjSJcOySMzTJSD+phLcYbUKWe+nJdppoh7S
         ToUW3Qi58mTPVhcfphVQ3A7uR32JVF54zojaWktkKmgYdfRgJ7B46ZuNgnvELwxETrMv
         dQGCwCs8DK6BenuV3gF1Oc7tFOM1P4SVl5Nl42U+9qWBd8/LBi/Iy+hAqM/mxrSb3uPA
         OFPXq/gACIbANfgO4dnmwI5xq9MaTPKHOtCF65t2oIz+vznMrNbe9vCGhpg4HwOIkMxM
         dMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Ev9jT9XUAOncqAZcU4nE0r5DcNP0rBQrIJxmll9yjMk=;
        b=NEf3xBXetrSYBYW4MZIW0YPsXZiJWdUE37RNOgGbPEG3ssEnYHRkb3Z+byl9/GA5g9
         0x3QGXGCK5mJ+pMxwfxAe3ywATs8YdvbDqoHWK7GFNN2NjQNsNZ6vobyWLKnoQ2VQWq+
         QvADKncUaaL0aw5nOtp7KD6bcuX08DRczH28ZoU4poKfyRbEvf4pBzO9ebar5GqJl3E8
         oKFCB0z4EGj+XJVCS+mvboQ94xBDqWx8He5/GP5EvbSg3jz386IiLAYQj6rSLy2Qyqno
         4YpdkHr2yjPHxTCh2Aqj+umVXWHd+gmii5jR1ag2nTrnp0vyJRslmhNahHTmaNAys8sY
         D35A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B74722DC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 04/25] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Mon, 30 Apr 2018 12:23:11 -0700
Message-Id: <20180430183910.999165339@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200289053392249?=
X-GMAIL-MSGID: =?utf-8?q?1599200289053392249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 4bfb141bc01312a817d36627cc47c93f801c216d upstream.

usbip_host calls device_attach() without holding dev->parent lock.
Fix it.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -201,7 +201,12 @@ static ssize_t rebind_store(struct devic
 	if (!bid)
 		return -ENODEV;
 
+	/* device_attach() callers should hold parent lock for USB */
+	if (bid->udev->dev.parent)
+		device_lock(bid->udev->dev.parent);
 	ret = device_attach(&bid->udev->dev);
+	if (bid->udev->dev.parent)
+		device_unlock(bid->udev->dev.parent);
 	if (ret < 0) {
 		dev_err(&bid->udev->dev, "rebind failed\n");
 		return ret;
