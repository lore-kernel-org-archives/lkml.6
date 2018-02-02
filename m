Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226liJ7hQBmbjsie6IzARgUz33FCmgRMrMNSdrWFSfDkrIW6K0Ggg6cNwKaGSPtU802fPWr5
ARC-Seal: i=1; a=rsa-sha256; t=1517591779; cv=none;
        d=google.com; s=arc-20160816;
        b=arSfaIxV1u9M3sD0G40721mToSPfxc8KmicOTO36I0iQ2jpMkBn2kzANsRhC/+d93n
         0m8iH2ZmM11EPTe8jKYfMG7Sugzu6m8VCaR54QDux976AgW+vww0Bn5jwYpR6Wo8xyXr
         bT9X1I+n4dUX30JgssG0ZveFuKJPAbpIdpO7r6pCrx79p54DQ0rnKbBrNllbqW8z7feZ
         xIRAz8C9dY1e8Mdmyj4mIdgC5G3ryiMF0EWsrxAlIpkuuy/G4xf0VJpMNwWsvtuq8jzR
         97etpDCUGH+6zq/dsHNkb/m00mbCzHc/AVuu1WYuDwg2kJmnfwvVbiEvkabWGcFGVybl
         FOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jR8CS7+x9oTMQX927gu1ze5fAAijyaxPse+lX8MTRF0=;
        b=0UUsKXJEHhNmb7Ps9/dT7OlpQDthbwkzF4Xipow9N8FZ0rU+j6CP6Izcc+XG+Q1wj3
         av+ZeFWMySjAZ7wjfYY1gWp6ewq3Go6fx63dhXcmC2gRKbQQiVKxrbB+HuIUUPZ5WlHi
         F5P7RMywr0B52CcJJm81nJTPgv0eqyii/gcPiuDzvQiQ9AdsIaI00ItZOQZ7/BmwXqm0
         dP2SH1691R6Ry4Hhga8/2XnzHgAVtUz1Yamlfx6Jjro9SZEGH801GJRGcC1RT8nDcK4x
         rnluiVYtiWNRDApqP6YaXOemh4QbxvMg0h/ETg0HVZ2kclkPQVwEy5Kx1d8f0L3D9LHH
         uciw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.15 40/55] usb: uas: unconditionally bring back host after reset
Date: Fri,  2 Feb 2018 17:58:58 +0100
Message-Id: <20180202140830.080568661@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309454850913215?=
X-GMAIL-MSGID: =?utf-8?q?1591310318006225882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1076,20 +1076,19 @@ static int uas_post_reset(struct usb_int
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
