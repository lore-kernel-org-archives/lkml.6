Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq6hdqBMvyHkIftIY/GBo4IqzBdYhdP3CwhG4y9OD+uAefW2VvIo1/wA4CXTGkuUd0IO7Hx
ARC-Seal: i=1; a=rsa-sha256; t=1525116416; cv=none;
        d=google.com; s=arc-20160816;
        b=Qwtok6zXBZVtnCXTfiF4+8rCjyThwxnfFI0sqvGYAfMC3RjcjmqMhmS+rEFHEMdxAI
         8E/nfVa98Rg6k/k4gG0PR+rFgOWIMeP62/u/4QOW+w+j6wuXW3VmOM6Gzss6XmSUl0M5
         xOk+0To8fm8JGGbY9FkpivZE90UxZu3K+kyCiwxluCFZ0uX7SmLIu4k6l5PX1k5BWyuF
         4JQzxDsg7fAK/xHcnk68SppIrjzVqefNlDxMAW9Sauli5y7smgvtdM+3JNtQyOjzosmm
         9z7FpaSeVp0ikubzwOHPo65WmC90s69tmzfKzkTukdTiWObDLeBpKMM5QSktjKHm8PdV
         VldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UW+J9pmo31+IUhcBI11lFtF+iDBuOQcsLZsbeXzGvGA=;
        b=XAU0lEgQogp3KnEZ+tnxfPTLfOHD+Ie4cz0m3J623+bXm95mSyZSHG5IOjuyAEV2ka
         2ap+6qjoSbroyIjdumFgZZMKhJ0/8tYQdoOw2phbxftMPJSeB2nY9MDlC3JdT5/V2WPd
         5WT87mG25h3hNXFzOdIukhGiNPb0kUJ0sh8ykvQ2LsWLGbyr+Ikt8IE4elPXuRUseHxC
         SdtdyucpLZPKwWCLImBp9RCuiCLT9B9WNJwhykaj2xK4y+9w73l6I9w06OLNtrspB6gP
         IWVr9qyY6r/DbUyYw5gOMqp3OuI+xYI2ZMgUWhLgZ4r8BxYIN2NcFWviCbp1qjoKS5tH
         cR2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACCE22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 11/91] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon, 30 Apr 2018 12:23:53 -0700
Message-Id: <20180430184004.810934156@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290205217782?=
X-GMAIL-MSGID: =?utf-8?q?1599200471554954002?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -257,7 +257,7 @@ enum usbip_side {
 #define	VUDC_EVENT_ERROR_USB	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 #define	VUDC_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
