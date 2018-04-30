Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoqLb3fzOW4hg8v4OQDX/1mATT87QHnjL4ExLIRZIosDPQfCY8I1/Ms9shL/OxX3ymZNUTp
ARC-Seal: i=1; a=rsa-sha256; t=1525116473; cv=none;
        d=google.com; s=arc-20160816;
        b=gTvsQgl3/a3VoCGvpfUmFu54OM5qd9TgKolA/YEpTtTiyYqKM31ET6GP0j+pGO0fb5
         Nx2Ie15xWUQFCmzQSPK9vkPj3lfBpb3vmA0PLyFrji2W9Kh04SlNkQT3HcwV5WfPk6H8
         l8Mwk1XmxW+tu0wKKS5VUBjtuDUoHhDua8e3K7FEl+X7LAmHq8rXqwSbKbodmzIlCgOw
         LoeK3XFRh0jNlYpGc3kj+dAt2xTf1P2tG+POJXODJXPAurYE2jSFCGfnT1cRhXz6us6M
         O078sEV1SEfrF6yuRYi2kaGSvALy8dbP9XQgOLpnN9QfndUxxykg0aKOpZ40xODqmMkM
         V+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cGqPPKhBKVK7NSVswG+nsFbL21i9UOc3L5SqAdxv/Bs=;
        b=T/5wsdZsZVTNDIBNJ5rGEcKlnJrsJ3rgPbbYnNQlv/L4YaFA9xvjEgViHwvKZxHUoX
         iqdsZoWF11oaYg3ZLab++Pnc81846YzkU+YpaB4+a3xgfVf9lT+nwYeJtY37ArAkK9C8
         ZrMQ+NU+i4mVFGsOfZLZ/fzk72aX/mijQ62DFdrnuaA4uiOcIBlWjqZLilR3oa/YFW5e
         bAC2Do9xQIG2wyrayo91XTQbU55KXi4b6nVsmwZpIKrR/uLckAnzY1BC6sYXzOss8Ek/
         Tb2Ruwu7XH65lSd9LIeoE6V9hwZWAKoXDAyhCN8/IUk6RPdWayB6PQicxwbC6lLeAHKG
         E45w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E344D22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.16 010/113] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Mon, 30 Apr 2018 12:23:41 -0700
Message-Id: <20180430184015.503533943@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200289053392249?=
X-GMAIL-MSGID: =?utf-8?q?1599200531648182496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -186,7 +186,12 @@ static ssize_t rebind_store(struct devic
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
