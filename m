Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrCVDdOBFsah7pWMtUeM5XNu/Rkgbr+BXHGp0KBps0hV/JWPF+xl1BG01TCOlYTyDlO/nZr
ARC-Seal: i=1; a=rsa-sha256; t=1525116474; cv=none;
        d=google.com; s=arc-20160816;
        b=KYAvWaXBDW5BwmrltBKcrKztg196cwnZxJDzhbHrLm9yV4aei93ycExjmSH/ZFfErb
         GiAndghYukFlRWMdsCMthEIsKIsdjw8r7o0vPPfRHaSAU2lerZXGJvtkGq7V9IObBGVA
         HBiK4g9OZ0q7ylRCSromWXTDmsPu5IrArh2AWsqlZ9i1EsDvnIF791d4/OAfMObfz0Ym
         vAlS8TaYvGPjMtEh+6X0lMIRj5dIHLhFisOBc0T7wQW6AI8SAv/wEKsXmklnqwjSBqKi
         mZTM/0pI9d2Q8Jey0EVc2LLWJ/8h/ClmrJqeZ1Gn4OnFNX1WbRp30hICajme87Vm54hp
         NdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=taovzLPED0zSuNpqtoMF4KytF0KiM1kNQSXzOfgiwH0=;
        b=xQvzo5icLjdA5/Sy5VaQzjklSimx7cOxJuks18pUjJMqP3B66e+TiYgWM1UWU5PLZH
         U02dui3Yydme/ijZfMZqYMUkkBqCoi7BnmCAEYKBVL+2DI8bskunOaLhaGPWCbjXGzNX
         ApKBZ54zODr8obskYYxYYYyuqs8p+r4b8xg5UDmcHV/DOvyxHvwmkpnYMYXqj82Dre+4
         uaoVuy85NFYgqLQQK5f+4tlN3u4pLS0REPWxSBnaJ+TjMYfFtJwmd61ahWoeFvCqNWfS
         Iu9ZAFFJBPZbf/FK1gZaT5C94l7rPfCa9ZjMAF4W6IMEe4IumeXqMGZNrtHuMudZTaXp
         brVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588922DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.16 011/113] usbip: vhci_hcd: Fix usb device and sockfd leaks
Date: Mon, 30 Apr 2018 12:23:42 -0700
Message-Id: <20180430184015.551728492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200290205217782?=
X-GMAIL-MSGID: =?utf-8?q?1599200531789787264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -243,7 +243,7 @@ enum usbip_side {
 #define	VUDC_EVENT_ERROR_USB	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 #define	VUDC_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
 
-#define	VDEV_EVENT_REMOVED	(USBIP_EH_SHUTDOWN | USBIP_EH_BYE)
+#define	VDEV_EVENT_REMOVED (USBIP_EH_SHUTDOWN | USBIP_EH_RESET | USBIP_EH_BYE)
 #define	VDEV_EVENT_DOWN		(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_TCP	(USBIP_EH_SHUTDOWN | USBIP_EH_RESET)
 #define	VDEV_EVENT_ERROR_MALLOC	(USBIP_EH_SHUTDOWN | USBIP_EH_UNUSABLE)
