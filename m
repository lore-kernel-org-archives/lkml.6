Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x2258GAPG6XtUgDbExevVhXl4BHBtMO8jpRWb8lrcqaOoeLI4lBeF7WOhwQvCzIYCqEirlOGZ
ARC-Seal: i=1; a=rsa-sha256; t=1519831335; cv=none;
        d=google.com; s=arc-20160816;
        b=Es+n2rFGnehNvVUAS/ae3TWQCXP46LDwIvnNeV+fJFkmfgoBhMJ95KGQEbEQC9LLUH
         LJuXdZmPFDLbIPV13PVJtt4M4TGynwDhjMCHerOCdRaquAuaEFrC/P0LC9eWVNJnuxUm
         r7Ursx/0uWwWLdqhBzHIiBGMajGhYNPnpAAIP9V7dJ1QAedMphLEAx2ukShaxTYbD4uz
         +JbaejJt3gAiRtJCz0GOrkYy8ALAuvJoXCh0x8L8f3I0yTYZdrnc1+nz7FeWgOqij4sw
         bAxJy0YfU3LzoNsTJc9UcFx6ZIgzHpus14c339nf2RgP+kQLg5gPMFOPPIpHChdBZeea
         fpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=xb4RT++jBagxVA78MDJDTAkxSAE2+u4V9HYLPFSK6/U=;
        b=yjgzaFV9GR+/Ll/8Ke2rx6RL0mcwknPnp1e3s8HFnefpO5+kjrPyxcVVGqD7nmbqm4
         btjoW1tDGaETPm+0D0pNxA8K/0lOD1qhqIrwXnPm1rwXM6dABgWFHYV6Y4TYWk5ED+Cc
         JUwq9/uruOSlkGOJjdTAPl/Wq98BilHH4lbHzNixE+KVMgCqJcoR3I9b42+pwxTe2qBg
         PutRgMoLXrsC2lgqhSCXuKz2xkZhCJHanFbozuSgRMeDkqQQ52uylPfbpu8VMluydfZu
         vfku+32M3Ke1oEj1KYSNAHPZ4bfNuP0y3oxf2ufMUISlfNb4urjqOka2kuO+A3kB8iY3
         2l2Q==
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
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Oliver Neukum" <oneukum@suse.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.852257659@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 014/140] USB: usbfs: Filter flags passed in from user
 space
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658662467537667?=
X-GMAIL-MSGID: =?utf-8?q?1593658662467537667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 446f666da9f019ce2ffd03800995487e79a91462 upstream.

USBDEVFS_URB_ISO_ASAP must be accepted only for ISO endpoints.
Improve sanity checking.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/devio.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1093,14 +1093,18 @@ static int proc_do_submiturb(struct dev_
 	unsigned int u, totlen, isofrmlen;
 	int ret, ifnum = -1;
 	int is_in;
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
