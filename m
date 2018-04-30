Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqhz6fMv0ylQl9FgOgdTfnPW/EdAhWK9RE8jZtzCBgaBZWaECfp8TtCrrPQWAuSof2LjnUP
ARC-Seal: i=1; a=rsa-sha256; t=1525116351; cv=none;
        d=google.com; s=arc-20160816;
        b=En1x6YJYZzBOLuoRkel441d4qJhySTwVyKS22yJlaWemZ1GySosyosLosd8Us0I/L/
         /pSnJ2hazTdbYD+55fZxu1apj4Vgyat5ZtOVbgemESzCmFrHvo7OSAIJKTHg8oxu2Vnn
         iUI5zMsfW6l5qqn8A05GF9PLJP2OGWzAnkd7MY5Dp/CXeiPseGyFbwLq04QzQlaECvGs
         CffIWVctbdEF/0zp+MggEQtBS1YFxocVt5IVXOR+ctariwjEA3YeJEhIsDxuTUowPvCE
         qkSFp7dlsta+jCmhUfcW9vE67DYFcaE/lgbCL71NNTgrBa8hdaGPFxF/c4UaN+b2eL/E
         yX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YFVMEA8QwcHlambRNaKr0uqghY1VsldL6giY7Q9wnzk=;
        b=cfQv3KIzgyLdQ82UvRDZ8WQ+0xsIGEAqLne2tFPp054OjCMDJZdTFJ2HHHTDZ9N1yn
         t0zaJGGBPlnbxvPc0qeYSAcBWjVGUPPsSNxfXTTQLC1pTqORUSvA19ex0WDV8Mqb98P8
         RhsI8DHbB42ay1j9G+oIwfIB9iuExzgWWDWrD+r0JdqjyrRb5yKbuULYg7GA3PWzSTC/
         FmZNw2NdXIvNTb/0WPPIRNPIxByEA0fM4BCb3jmxQcNHe6ZDVzfwKz7VudsJMzVqUogN
         KJIZR5VHTBAlBsQPagvYF9vEAzzaImujKfivcmfkFlSk04q1fXMLsQmVpXIX+oj5o5EK
         2Nrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8C122DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 06/44] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon, 30 Apr 2018 12:24:17 -0700
Message-Id: <20180430190946.589260457@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290205217782?=
X-GMAIL-MSGID: =?utf-8?q?1599200403597284455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -248,7 +248,7 @@ enum usbip_side {
 #define	SDEV_EVENT_ERROR_SUBMIT	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	SDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
