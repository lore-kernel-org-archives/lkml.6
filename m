Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrUH8g3/vIJ82h1WgNlaNaaC7IZpO8xia9mjBoP2OlmDlD2+MEstlIVvb07+ykucv2vHRbg
ARC-Seal: i=1; a=rsa-sha256; t=1525116243; cv=none;
        d=google.com; s=arc-20160816;
        b=ABHOpduD5eOpa6myg6gugDZjrk6Z5B/qESZW70Me/OrqFhXUGKhvRP+V/LXOZkE7df
         tAB356V1QskiqCXhFEMP0mdEXHUJmCYlyQB7joChMhusaPfpbCUB9M48rMFNIaOOkmVW
         kPLCwqK+SS8iD7bHvCoDk+WpZjyjTe+ZuAGsi07qNysAF8Db5eFAycGbubNWz/7ykusv
         h6MVqz2t/DSvhhCBc5YsEbpED+HAulSrVf6J7XrlAKqMt19qMCeidYSKVmpX4ZhCx+J7
         0tCEDCGHR/eM2xR/PkzcA0sd66X8nLuMewz16m500L56Juyv+mfjWanJoAW9zZXJkFln
         wzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=12DjyQYx9x6g48zhgN96eTBRO99ERo2LX4wJTSzva44=;
        b=uQQ64lswnyuL8fkB4iOkyUSQq+iBID25nNftWTiuLp32jusLAYuEM6oTQEmiEeOiec
         JDtGe4eBcRriq0nrpOR/+iJLiasYXSXQ1gGH/5j98sHXkd35brY3aKNjP1nzT9bDLlLi
         ltHYI2SOgmG/ONCmH/gxfy9xTiRAYtS3XkM88lduNgrz/Q2gi7OKhEMgNBH1zSPbkCFT
         wXroq3LLMkJtivgcNsSPD7Fa2ZYzFPNb3VE7wgjWNxOja5UptAiyOy2F9E+ixonAMgtq
         cggkhYtz+sF+Ixcu+y38/sn7axI6KbVtbt15jR7yuYMQjpSK6lje2wNWMJS9gJHmEPqn
         gLuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0967822DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 05/25] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon, 30 Apr 2018 12:23:12 -0700
Message-Id: <20180430183911.044320032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290205217782?=
X-GMAIL-MSGID: =?utf-8?q?1599200290205217782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
