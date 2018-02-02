Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226MlybYEin+AyrWubtSarWo+sxi6khcO5SfWTFps5rVeKQtt0xxItl6UC6Xs5mRQhyPNKC8
ARC-Seal: i=1; a=rsa-sha256; t=1517591193; cv=none;
        d=google.com; s=arc-20160816;
        b=XK7Ug6eTnmc6sKsjj8bqFTpWljzCRCmvmScNka1f8vdbQOsDAhE5RND1KyTEphjeHA
         +DasFUCFE8wvFFivI1ITRK6iIX11EDs3Dl+Bp16VMDG2W8sqH73oJf2taINdpUlDpoue
         ghCwsEXxi6GMonJL6gqNZncjYtkbRsW3CYNNhxeKQiVQQi0WesFtcFssXHYdzKgsehLo
         JopE3WOppTKJlFj7ACTRd5aEL7K5CbsWssopjaI1bkJSYRIBbpzyoerZZ890FyNKl208
         DY/A5rBmMr9gmx95+clFUp/hOscEex4abb29P4Ty0ppfK/4GFdoGpweziGv9Qm2uDNcP
         RHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N+nAMH3TkAwTCItJ3g2+CeUCQXWjR/roU2shImTTTjk=;
        b=d5I590yn49FrlYn4HOYqgZsy0TiXKsbWVi1jmr9bq2kQopYt10pJ5h0vfX3kMs+hxR
         2GK/K5h9UkcSBgkXPgpQ3O3qs8p/CfUbbvnmlXCaok6pvgGMP2O+RafJzRxtIIhQC1zi
         SqpyPkAedJK6wIMIZOEWU4Ke0WLzMOHG1nO5Bul6VmHJc7r7MfKvUO5LdDCboIDeWizR
         C5qc8ClWT4rVFOQvPFH+ncJOF0d4DzsK6icC2lM3kD+VQdjhv517/IcJAmchtc6qyKV5
         0wssZO7HtfCwdYbkxtMaUeWLjl5D4/UD4xtLy261cdQ61jYdIFyymT7fIJE6Uwy0x2ee
         NSMQ==
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
Subject: [PATCH 4.9 82/86] usb: uas: unconditionally bring back host after reset
Date: Fri,  2 Feb 2018 17:58:42 +0100
Message-Id: <20180202140830.169784420@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309454850913215?=
X-GMAIL-MSGID: =?utf-8?q?1591309702637372420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
