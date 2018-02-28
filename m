Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELszkoNwtWDgSCTyDFeF5rM2/Abo3/tPNVk8X4Df5v8URixlm8pwekVuCESokI7scJYzUyP3
ARC-Seal: i=1; a=rsa-sha256; t=1519831340; cv=none;
        d=google.com; s=arc-20160816;
        b=yfYTzUV4Ist6MP+qu68Ni+BE1ojqBrWK3+f8j41A5DVyxmoNwVxGcuCuMf5wjreGqW
         2ecu/iF/SJZKhg7wyxXWL32izzqQVkElXxhjEStMN8Faexf4nqZC3DUkDL2grHbCkLuY
         +BOih1yfO/+55WFD8PIUSOTzJA4/48e+SanEUAIGF4Qthkh1gcvPAXNf1h5Bjg8CW7Qm
         ZkJim5dsMz7R9PKWgb7L1U7IK9odjXntMQXE5iX7EyWdD7mKvKEQFn8yaoSTAVTx4OMy
         Q9jo97OHAtlNjR34/TYTvxAhyC0+FN/RTdRNBSLbiGBDPhcIYI1Brlbp5rttw8V2qYx2
         n6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=o0q9Kl1uJq3UIThopK6aeHuYKn0W+STCrgEitXjNw9A=;
        b=LD9x2t90SOy0cx5RvjRlo86Cd3N9gQV+DXkUjlovLXc50Yi33DQQQJg5XoJcpo0R6C
         OoMjVP4eVRUF9R0RPslsjLxS/NwmhlaQ+eQOwQQTzGqSawg3XMt+j+6fmzcWpYvkfjTg
         nzLCL8esmUjOx87trLP9vBwFOZhdulCEFJ+Zc5rAdOue7NPbpxDxM2DE09by3+Z9WPcA
         5cY3/wvrZNrk72XCL67Gd0uZlAvQDjBLbqPTlfHq16hHQ+12rm1pLTTQw91GF5sigyHA
         HiPHe1G4w20tZxrmxqzFjb/AEXdxcgjidVSKYTZFRGUMxKNWtv2KGoFG7nGKvcj2LjwZ
         BScg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Andrey Konovalov" <andreyknvl@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Oliver Neukum" <oneukum@suse.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.607985530@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 021/254] USB: usbfs: Filter flags passed in from user
 space
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658662467537667?=
X-GMAIL-MSGID: =?utf-8?q?1593658667813075363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 446f666da9f019ce2ffd03800995487e79a91462 upstream.

USBDEVFS_URB_ISO_ASAP must be accepted only for ISO endpoints.
Improve sanity checking.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/devio.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1295,14 +1295,18 @@ static int proc_do_submiturb(struct usb_
 	int number_of_packets = 0;
 	unsigned int stream_id = 0;
 	void *buf;
-
-	if (uurb->flags & ~(USBDEVFS_URB_ISO_ASAP |
-				USBDEVFS_URB_SHORT_NOT_OK |
+	unsigned long mask =	USBDEVFS_URB_SHORT_NOT_OK |
 				USBDEVFS_URB_BULK_CONTINUATION |
 				USBDEVFS_URB_NO_FSBR |
 				USBDEVFS_URB_ZERO_PACKET |
-				USBDEVFS_URB_NO_INTERRUPT))
-		return -EINVAL;
+				USBDEVFS_URB_NO_INTERRUPT;
+	/* USBDEVFS_URB_ISO_ASAP is a special case */
+	if (uurb->type == USBDEVFS_URB_TYPE_ISO)
+		mask |= USBDEVFS_URB_ISO_ASAP;
+
+	if (uurb->flags & ~mask)
+			return -EINVAL;
+
 	if (uurb->buffer_length > 0 && !uurb->buffer)
 		return -EINVAL;
 	if (!(uurb->type == USBDEVFS_URB_TYPE_CONTROL &&
