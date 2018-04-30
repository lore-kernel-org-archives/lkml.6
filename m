Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqZ3RELJ6tcVX1wKLbj4OFo7GMfhNbor7uE4DhYf2c/O2xljZgtAMYzReGkG2N1v6OeJLst
ARC-Seal: i=1; a=rsa-sha256; t=1525116350; cv=none;
        d=google.com; s=arc-20160816;
        b=TCLYa8Yk6zuTLJXjcrI/X2G6GxxgCPUluM5WRadJmHttqiOBuzo3XlUGcptL1OsIK/
         gmxZunrczUsrLK43/5DPGWMiRRgXYGxRWsGU17Y1g9caaQotPVLe4vvd3AT45VBpo+Ro
         G6/14cKIXeh+mQCJ0AgPP3dm3ke1A5aDRFjFTT84royjYuuaYDuZUNDcB2JL3zOGB1LX
         WAqOA3+Dzt57Y5KJ76ZgowBssbiHS8XOjvEg6tLyyB/RhA0tFvWUJu6H1dJCTIL3npwN
         2g4y4Ho3QJjlsvtuxjMjd7Q/CovbrumuW7KwB7Cca83gDLwd+e5fyBQUDxW7aoR2vaWz
         SQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=WXDj5i0tUWBPa63GLfuevdV2Cdn4xFYKto+kt2AepHs=;
        b=URkD7aQGaOsUtePK5K4KJfwd2GkkyeFhT9gLfbSNSl/23h3mOxTs8ckBZtVkIBcpo2
         smhIH8uPVpowHZDTWutcmEFSiF5BeuWM61oIWVbCW5DR4OVfxI3+s7WWMdZzrHemc4JH
         lcA3q4Tk5yljUU+/+C5wj2o2KODOOK07Dm+IGojKxM+7IA+wamDb1vGtfrTm86GLzz5k
         mXT6x9+ct2CSULvZmqxnBmc0x7003CIQBVHHv82mC2VfqItrp889A+5zj9Rmtv20zFQ+
         HjhswMMn5/LTWEXEt1dVAPpGtMHgw/T+3UE7wwxVxeax8v2XUVzlTtY9QQZT5px1P4xx
         5w5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7562422DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 05/44] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Mon, 30 Apr 2018 12:24:16 -0700
Message-Id: <20180430190946.548163410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200289053392249?=
X-GMAIL-MSGID: =?utf-8?q?1599200402338855090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
