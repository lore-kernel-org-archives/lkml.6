Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256wjHuZnyYV2DhmJdqvU/xRXQd5wJ/pN5y9Rm7OKXvPKiha924VsHrvzq1yPIJqhwlhqo2
ARC-Seal: i=1; a=rsa-sha256; t=1517855212; cv=none;
        d=google.com; s=arc-20160816;
        b=NEuEuAZ0Tt1MUKV+1sMjbjMtwvID2Fk10RtbDtTxM9Ig9pnpy5igoZHINcCfjkS3V+
         nvPlCkTpImEJ660XhCA4GSzuf4PNYbuLv6s1arGo4OBPBYGVMPe6MmsanaG5qBvELZIK
         U/i/5lQ/ufmd26/iaXywgVSRVbHmRpFujYueCBv3BYc9LbzoSb8tgJnjTxfzj6Rk3rpt
         X24f9hPYCgrEK0PTrQBxCo4+TuX3tdoEr0z3L23yUPtMdNznKVOHOyv5HzmJCbKEw3Jw
         4UElAHiR8hEUlQIsMgzDIvBEyzbOZrdtSxmggZL+fw4dnMB/LvQbtsMgbvuPU+miOmwk
         pptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3klMqB/3DRSpGSdRXmSy+dEOfXLqjfWbXlOP0dVlFUA=;
        b=Q+zD0LKTH6iwjPh2+hZ+8y4L1eoU61udUQbb0oQj+XgxZapyDfGkFi0R3JCcz8q7I1
         B1+5tCDJ/2uo4EmQvhzN6G4Z9XWlQ4ETrVuNnZkm1IcToeKGK4IqP7ihHEfwWKl6RltM
         Byv8HPUnmkHCQK6gmzfpZmYQKhAHiRsN945f3Ow0a/Y3Z9n+MM8V/qN/PnQLDv9IzuTz
         9NST6IStwRADAD19v1o3uQCuBg/1MuyjKXzmI/1J9HN7tjxnUC3pDZEua5OyBwowuh7o
         5A7sigdJ8Z9aiX5hHGzdFTJhFekDglzpQCuN7SgWrbg/vvaZChs5+mHpTUyoE2TLIL+a
         yQow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3.18 33/36] usb: uas: unconditionally bring back host after reset
Date: Mon,  5 Feb 2018 10:24:01 -0800
Message-Id: <20180205182353.135559339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586547513078407?=
X-GMAIL-MSGID: =?utf-8?q?1591586547513078407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit cbeef22fd611c4f47c494b821b2b105b8af970bb upstream.

Quoting Hans:

If we return 1 from our post_reset handler, then our disconnect handler
will be called immediately afterwards. Since pre_reset blocks all scsi
requests our disconnect handler will then hang in the scsi_remove_host
call.

This is esp. bad because our disconnect handler hanging for ever also
stops the USB subsys from enumerating any new USB devices, causes commands
like lsusb to hang, etc.

In practice this happens when unplugging some uas devices because the hub
code may see the device as needing a warm-reset and calls usb_reset_device
before seeing the disconnect. In this case uas_configure_endpoints fails
with -ENODEV. We do not want to print an error for this, so this commit
also silences the shost_printk for -ENODEV.

ENDQUOTE

However, if we do that we better drop any unconditional execution
and report to the SCSI subsystem that we have undergone a reset
but we are not operational now.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1067,20 +1067,19 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err) {
+	if (err && err != ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
-		return 1;
-	}
 
+	/* we must unblock the host in every case lest we deadlock */
 	spin_lock_irqsave(shost->host_lock, flags);
 	scsi_report_bus_reset(shost, 0);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 
 	scsi_unblock_requests(shost);
 
-	return 0;
+	return err ? 1 : 0;
 }
 
 static int uas_suspend(struct usb_interface *intf, pm_message_t message)
