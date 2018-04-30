Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp30QarR2cjuC8NJPZwnUZKzkyHfJbonwOjPhBHH/uOD84pmGz/Pok+UKgFEUjdq7wWkUux
ARC-Seal: i=1; a=rsa-sha256; t=1525116398; cv=none;
        d=google.com; s=arc-20160816;
        b=Oe2pOJ1et0inbDQk2z2tXu3b+Z3oys2dadM8Hkq+w70NSz4LqZcpWCbixOiytVMl/5
         3Io9jAf3Bh/S50kIAC8n7ziHwOh4NW6o/Dx6uIXrlgJHpD34sRfX/1pWyIH+i8EEsdW8
         lSSXG56YTCZ/q/ae/xIQCNxoaE1HDeppDt3MY8t28hW1aEvN5JzLlp1cLonovjr7ODmG
         eAs34Z3EpZ0Adj76roTsoqjvn+fAIooPfpg58T81NdfBsTMpBfR7wwt7a4jWllf0LqaA
         xcPFnqfbYCl9kcijCfnXgsBc2TeMZ8AnxIuiLfgCkWRKAqaq504PHWBAjErzhNHyWAdp
         D59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kFMEXNfbNbB0rXgUeTnk9/wzyPucnzsWSWonbPxu0CQ=;
        b=fcJy52HtGslfMxxBcYrUJCUiK3e5jzNLTpOS1atc216wnFkbVv6ILWaIEj7d1oinqu
         37ywcBsZ4gDheGOJwyT5DUJTSsMDEVXbQW0OUoWflEvPpPg5YHTovdf6PSWsGThcku4v
         x1wIS4fUwJyMRrCrvs5RHRftXXY4sTKS0K1VW9vQbG9YSyULPfCriUc3Vt9eJR3v62xk
         14vbwid5z3tsJdEzH6zn36Xmz7uC6Dj8uXxGPlliUiFPkq8j1Z6vL6cWxSHNEIAeJrLp
         BGmGxDyuJluYiELaduxNNy5KnzBAztMJieGa5br6gEEjvikUaKPX1sZ0A8FAjD8qoM9D
         0qiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC57B22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.9 09/61] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Mon, 30 Apr 2018 12:24:12 -0700
Message-Id: <20180430183952.083852371@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200289053392249?=
X-GMAIL-MSGID: =?utf-8?q?1599200452557358739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
