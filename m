Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MNsMDcio3LhGrcm/qC+UdpN5TwCu0yEMeKkpCF/+KmOFOSZ1lodrWKKMMuQcMnQEqnjm7
ARC-Seal: i=1; a=rsa-sha256; t=1517591617; cv=none;
        d=google.com; s=arc-20160816;
        b=N/9e3L2G5kdqzmA0WGHQ2Gsiyip0rmlnBI8aG89OA/r+vXaXf2HU8BDuzEzcyaOmau
         1dZ0O2KHq2SjL4oty9Wqc4Tb3JCOsXdy6SaeUP2Yai6mEL9kHpUijrW0hsNR80eJ4Ti3
         Kqij7xJNtEVHLqgggSzgXSpm8/wKGtFKsCeQxfH5921tyRLrGzowieRcV7uNAjdbef+i
         oUaqGdsKu+I1T0BkumrLfrzQ16j3LgwzS04Eda9sXNaqd5AR+ZtOiMej5B/7H4ssotGz
         TyqIeuDDcj/lM/FHAcefhpRql+k8x0IeHcNr0zH2G0m+phe5Z2HfHuQHmLzCijKz/aWY
         p05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FroMQGlpX0NGg2E/7I6NhA9ydCrlpg6UlkrAD5OvHy8=;
        b=SiWp9MfcOZX6lWp838MzuPQ26hA7pM8rb5+hWnm4BUBbQA5oEp3yW5cvXE8c5s+GZt
         UGjk6HKTkdUmCruydTwN8NArprM8/by4sgdYSCE6UKeFPwZ2m0bw1hL0llDyNENbKefM
         NOvKZSdZ8ASc/Eq3JiiUrfkwKiKGZxcTif8tilelyfx9v/Niga7VhHQPQlrHbTzbwURk
         z2zlOabUTnX+0ebATlc63x+6S198yVqc9+4IgI9FLFpFmedDuvatcGkhFsZ5cMUc9cV2
         qdW/Kk90fE0Uqx0m9C1/aeb/1VyVVif4Bu3PJ35MgcKZGQ6Q8HS9U02SV2aE2m3+D4Jn
         u/JQ==
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
Subject: [PATCH 4.14 142/156] usb: uas: unconditionally bring back host after reset
Date: Fri,  2 Feb 2018 17:58:43 +0100
Message-Id: <20180202140846.795807506@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309454850913215?=
X-GMAIL-MSGID: =?utf-8?q?1591310148115303421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
