Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225pgzWi1zaifyq53QSSPrG6eGu5z4L4JzUBBi+xQ5eEKuBxNUGXxsRpy52B0GvbqRJHNyMA
ARC-Seal: i=1; a=rsa-sha256; t=1519831345; cv=none;
        d=google.com; s=arc-20160816;
        b=HEdEjOoCGyFQxKUqcNGJ6IbjJRPTxiI9TcTwnQ2L6HNobcpf2EEl+/uEzOnTKc6x26
         TsmrValh4/LRuyDHj4QJVGdV/kCKB9srNvAOhX4XIG9Wn4JCUdmIn2qq9XeSPCtWc1hc
         rCaSGR9N6ffUUW3U3h9SHW8MknsNug0sLGwOURfChG6lvi6czbvm3PMOYXFpTHRoHkCd
         XNaaGkCAGjh+/o2Hyq2NkhwZsfjgpyty+wpy63lYAsuHcwGWdLpIGUN+YgTf9qe9jJcC
         88qJCIlbZPvgZXIV9boxCYnlieKHkM/vONJord6j/wIQuR6Qr39RFyU/XQr/dWT6TXto
         rO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=HJneUptBhPsn/l0rdaeJIVvXX1ssmBOVJoDq3b+AstY=;
        b=zDHIZIBYY4eiZwM6xcaS85ps8ES+GR+nDD9EDefPgkruYBQ8opXEDmvEetuKzJJIbl
         lNFW12uNq41xYLksuUyIDuU/mF/h0E8n6IWibXrXlVVQsB1PhMB/VTKsdsZ4ZH9+quKF
         iOL3DC14CEdEfrn7ivKfVsAZ8ny/d+GZeQM8DhjiSY2oPtKkptBOc4L8NisEl36qUoAE
         Zx89QbbOOONp4PJdqI1of1UQZ+VYOz7W8XUBoXMyY7otyArMooF6ONBOj2ajrESOHI/J
         MBNRY7e2Q0QmBsT5hgq7EoFn1Z576TsD/VnHEOwz4yQfZNhjroBV5pZWERBDvq7B7G0Q
         Mc/A==
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
 "Alan Stern" <stern@rowland.harvard.edu>,
 "David Kozub" <zub@linux.fjfi.cvut.cz>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.946701501@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 078/254] USB: uas and storage: Add US_FL_BROKEN_FUA
 for another JMicron JMS567 ID
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658669092712757?=
X-GMAIL-MSGID: =?utf-8?q?1593658672406117364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/storage/unusual_devs.h | 7 +++++++
 drivers/usb/storage/unusual_uas.h  | 7 +++++++
 2 files changed, 14 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1981,6 +1981,13 @@ UNUSUAL_DEV(  0x152d, 0x0567, 0x0114, 0x
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
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -131,6 +131,13 @@ UNUSUAL_DEV(0x152d, 0x0567, 0x0000, 0x99
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA | US_FL_NO_REPORT_OPCODES),
 
+/* Reported-by: David Kozub <zub@linux.fjfi.cvut.cz> */
+UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
+		"JMicron",
+		"JMS567",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA),
+
 /* Reported-by: Hans de Goede <hdegoede@redhat.com> */
 UNUSUAL_DEV(0x2109, 0x0711, 0x0000, 0x9999,
 		"VIA",
