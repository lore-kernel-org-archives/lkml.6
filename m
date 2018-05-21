Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrruYFn2Oi/9SujlJzWwKFWQCGp9cgTXmqceuyW/qO4uBlk5pN2+A5aQ6xBtCfzWHXWJsD5
ARC-Seal: i=1; a=rsa-sha256; t=1526937253; cv=none;
        d=google.com; s=arc-20160816;
        b=ntm+0dIWQsV7/EPfrPCd3f8gAGuiSNGBjB6guBzqq+RvHLbFBvXSB0NhM6E3LmYLuK
         AN2iWtXBl4zbbiHCobz0Z/JnVnQgti0AiL/x7yq9TLLKZgkKQyoGV21NsYMAneER+5Ls
         tH/88fgoBpHqQCXxwCYbUoMWWSF6vwXotHZBHhvAkKxd497UaH/+NhF7tVrWev2Bq+pZ
         grdFNIkTRl2fjgFZl9sgD2jWP+NSWdz6w1QO51wq1KomYzU4ZEkkAbYXMiq+0VWUajPP
         QQs0bbFHCTLlLu4v6LinEAOqXwk504Jmw9vLAv1hRY5kLhVhBA0MyDX9dRLdZTamLotP
         h4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gUd0CJVTdwJd5cb13v0S4hChwaqlBuhPOrf70ACtojg=;
        b=SdUzM8fawfrjfT5kWEHI/Rl8tqWtTZvl9a/iqsC7sOj5VByQy+lyXdRgDj6FW+3gPT
         gyw3hUzeeT6ycO9xLIJhxZlbeI7L6XA/zbeeVdOWJhyOCFxxfqi4pJFzwm7LjLMrdXYr
         pH5RaCokiT+fAkPI9NkMwNQyEKvVigVhlAVmkJFF2G1PsB18DDQD9qMCX9F3AEhKh+J5
         8owROXUKMeSk3N3pqn283vapxJ0W351PY1roYoSotVVbEmWwNO/HGGOKrxnlmLJ0h0kH
         EE1hMyNXRNzUr42zzz5RbSGfFu/3xzqcWUa0r6IRB4GZ96oPH7EqyvDwh24ULztNMtSh
         6AcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z1S6tzxN;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Z1S6tzxN;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.9 02/87] usbip: usbip_host: delete device from busid_table after rebind
Date: Mon, 21 May 2018 23:10:38 +0200
Message-Id: <20180521210420.407242015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109757512536317?=
X-GMAIL-MSGID: =?utf-8?q?1601109757512536317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 1e180f167d4e413afccbbb4a421b48b2de832549 upstream.

Device is left in the busid_table after unbind and rebind. Rebind
initiates usb bus scan and the original driver claims the device.
After rescan the device should be deleted from the busid_table as
it no longer belongs to usbip_host.

Fix it to delete the device after device_attach() succeeds.

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -201,6 +201,9 @@ static ssize_t rebind_store(struct devic
 	if (!bid)
 		return -ENODEV;
 
+	/* mark the device for deletion so probe ignores it during rescan */
+	bid->status = STUB_BUSID_OTHER;
+
 	/* device_attach() callers should hold parent lock for USB */
 	if (bid->udev->dev.parent)
 		device_lock(bid->udev->dev.parent);
@@ -212,6 +215,9 @@ static ssize_t rebind_store(struct devic
 		return ret;
 	}
 
+	/* delete device from busid_table */
+	del_match_busid((char *) buf);
+
 	return count;
 }
 
