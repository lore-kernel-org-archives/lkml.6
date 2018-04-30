Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoeuawDhNoB+pKZ5vfqyNVFtfZKHWAKg6nl/divUHz2LB1L/q6/FdiDwJR/s24zDo5VEGgb
ARC-Seal: i=1; a=rsa-sha256; t=1525116398; cv=none;
        d=google.com; s=arc-20160816;
        b=PxXOE24yWOkh8Bym8KxKJS5HwlX9v4pxnZzRSbsybBBlkQPdCDaMoYG41rO7Znrp5s
         fMl+jqtjrm2Dy/exynRkDAS6cjwvxbwniz7uGYjmw+ENSsFci8cNngWOap8Gqzm2lFyu
         DOcE+gvOz/y35JBXa64Y8DUjpI02l3YDKrSbev1QgLxOtrKgSSZt94xTNiNUtkiTP9gr
         soaDNQXqO5NvtkkSdGxwi/PjCZEeTSc+0tX+M7/nDEMceLsJvftD7YntYpmluC7HYTsw
         gaBlIyBDjg+Z7yPeFf3cqXqlmk14cXraUGn8SOmlRJpX35FSusZ1JhnAtw8OBeV92A7f
         aj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ufvHTd9ih/Eat2hB5m1XXSXen6t6xv9+zeCFcWq527k=;
        b=glxqNLYd/Ae+zMC2QpqIZCTFZv5MN0e8mHkB7O2Ld64TlrXBvPVzQaZkpMgDqn65KM
         2CIKRVKMCv6Rp3aRG5pl6+XJSeEeDbdiV0RyRersTstUk8GjUA4C8jCmYPT50KvDHGV7
         Ty+S3pd/7mQoLJ5Tcg0cMJpZITRr20FQj3FKpmVVS120PBTxd76XD8S3wb0HzBH8jsUT
         JTGTjoiF4lU//4EXERbM/aH4MxHvdFLZVOgH9du7BmsrT/NFF0xoUjwpfBBbJIKcLqNx
         +qau3pu3roW1d1GCK/e9M4kdHzTUSOf4QTEmkJRNY6jTd4Z1k0QM9EYb6xXNTnk0tHbx
         pjVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7062122DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 10/61] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon, 30 Apr 2018 12:24:13 -0700
Message-Id: <20180430183952.158517841@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290205217782?=
X-GMAIL-MSGID: =?utf-8?q?1599200453036772031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 9020a7efe537856eb3e826ebebdf38a5d07a7857 upstream.

vhci_hcd fails to do reset to put usb device and sockfd in the
module remove/stop paths. Fix the leak.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/usbip_common.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -258,7 +258,7 @@ enum usbip_side {
 #define	VUDC_EVENT_ERROR_USB	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 #define	VUDC_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
