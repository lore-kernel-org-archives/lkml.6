Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpNe8OpTyoEL6eruJaVEgr45pHa4Fxr4/NlRqKeLMmtm5ie8LsHXObXyf4GTTZ/Kkvg3Z6r
ARC-Seal: i=1; a=rsa-sha256; t=1525116415; cv=none;
        d=google.com; s=arc-20160816;
        b=uzkJULqHqSl7YKVZ0QKsz6EgrSgErUUJLIagDU/pEkkTr0w9q0c2AXAhVdpNszcii9
         Vcxa79omEXyQJDqsyIp9qoHl5kKpGbnl/p2LnOdrOOX6FC/rTIDJNH858buKC4WliyfQ
         o8pd2CC/fNRWL1VUWVbtyAg8FZoqgTdjXjmURl8GEhxxKTsq2fIsZgZjqWMk2Q9MUZzj
         Y/G6etNenc/TPGlL8HAPqOJYQvrJWlFBFZdlR3oF3xYzInBJjzqHCwPR+fUOSFJAmGwc
         J88BJNM5gGBXwPyS3SSE4pyEiFFd436zbvDpW4++pN2uXQWrAqPGdxO8Kfsx5G57vFNG
         p7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=lPmJsv3H6V7OawAO64KH1XmvwOtY2gKWBWHM+ZRSMNk=;
        b=DU1GX+JtDSzFFDDw7+QjLGscmk9Bmg4dlrKS+nw53aVhSRMXRcp00U4QP2drFfbiVd
         TxYgrGRTvUwFMo/+ceoRUzU4cRAiXs7lZZKN0VakWWO7rGXbefzp2/DB1hrPvECqxo+D
         HgFPm59mWdiQvoZR4J3OTLf2edUBif+frTGqOEUBbyUmPyKBwKlj96BF9GWSFuhXf+wD
         KDm1jJgTUFOmV9AtsEEJzG412rTCl6uQM5hjjv7+jp6zykkGZAg4eSYsTOGh+xNegIuE
         42l6SqP2c3uCbZywWCmia3O88xpVpD4hcymY8C6c5JJwD6SZxvdDvw3ut6pr9AQHOSuV
         1V0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA8322DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.14 10/91] usbip: usbip_host: fix to hold parent lock for device_attach() calls
Date: Mon, 30 Apr 2018 12:23:52 -0700
Message-Id: <20180430184004.766740270@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200289053392249?=
X-GMAIL-MSGID: =?utf-8?q?1599200470855478361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -200,7 +200,12 @@ static ssize_t rebind_store(struct devic
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
