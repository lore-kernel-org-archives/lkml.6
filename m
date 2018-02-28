Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227IHPz1xkX8OpXB+nA6wWIQlkSIZZvGQVyI1emkfF5M2sk2y9pnMu2boXIKp369iFji5uzE
ARC-Seal: i=1; a=rsa-sha256; t=1519831341; cv=none;
        d=google.com; s=arc-20160816;
        b=CWcJoQ0k42UN2nSzxs8ZvL6BekFz0PhDGzRfwpcqwTvvi2+4gbkppdbjuRW1TVemXn
         b73PArL13s09RAFClSancWm4QYNd3yGfIGZundCJTXxgM6jeXnhXdwK54ibetuc3hkJt
         5dMnIgL8hIKzsosM9JMzY+WuIYKjvKzLk+qXc+c7xY/LCvDaJoDEZQh3eaXwNY3k82xf
         gW1x9vxqbtsHslk9ou6pr7mIO6EN7GjTxx5/6/jEj6v/8TpcHtV8Snspdll6TsEbilQG
         TsiWp2QCnF4m5JMAJDh45cECZZDkD1Vb7J9CwrGt7fCYwSbpwR6M13CNbKX2be+d+mXm
         Jwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ggXTt+StUKQfZPPdEw1yCwYGXCEeLEXW9KNPFveyvYo=;
        b=J6/o5bvCjy8kI6tFcvtwnausn3k0FidZlEuisXx46v3+damUVaMa8wbytfEwU6qRke
         Ggswbeh3ptDLwe3Uj3f0+RmvXiJBiw8TXphrB9m+TiSoCtvTl+0dvbuzQYBGVtvzrSfY
         DRTnOYcCbGAuEvfqmVRF8kqxlDWGYmvMS+RA6mFUyDjhQkaOmBdxED7bJ+0LlkT/yY6n
         +m0wX8vI+Rma8yZqWo+cYy0fILwujleFyZQkpI2mA3pwXtNgbSox1kkhXffVnp3ScnYE
         qrbNOPNVNVPTr+GoqGnNfuaKZE3xVTxPjAEptSp/mxGTBWeWgjYBNUJ07TfYwR4WmCSm
         gEYw==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "David Kozub" <zub@linux.fjfi.cvut.cz>,
 "Alan Stern" <stern@rowland.harvard.edu>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.762525108@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 037/140] USB: uas and storage: Add US_FL_BROKEN_FUA
 for another JMicron JMS567 ID
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658669092712757?=
X-GMAIL-MSGID: =?utf-8?q?1593658669092712757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Kozub <zub@linux.fjfi.cvut.cz>

commit 62354454625741f0569c2cbe45b2d192f8fd258e upstream.

There is another JMS567-based USB3 UAS enclosure (152d:0578) that fails
with the following error:

[sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[sda] tag#0 Sense Key : Illegal Request [current]
[sda] tag#0 Add. Sense: Invalid field in cdb

The issue occurs both with UAS (occasionally) and mass storage
(immediately after mounting a FS on a disk in the enclosure).

Enabling US_FL_BROKEN_FUA quirk solves this issue.

This patch adds an UNUSUAL_DEV with US_FL_BROKEN_FUA for the enclosure
for both UAS and mass storage.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2:
 - Drop uas change
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1961,6 +1961,13 @@ UNUSUAL_DEV(  0x152d, 0x0567, 0x0114, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA ),
 
+/* Reported by David Kozub <zub@linux.fjfi.cvut.cz> */
+UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
+		"JMicron",
+		"JMS567",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA),
+
 /* Reported by Alexandre Oliva <oliva@lsd.ic.unicamp.br>
  * JMicron responds to USN and several other SCSI ioctls with a
  * residue that causes subsequent I/O requests to fail.  */
