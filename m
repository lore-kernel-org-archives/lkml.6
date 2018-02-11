Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225qj+l/3uyHq08p+FBYsIHH5HzvpaUAZra3Yin9AtMmGEiCyfm90pyJKVnG9uPJALTSA5+j
ARC-Seal: i=1; a=rsa-sha256; t=1518323637; cv=none;
        d=google.com; s=arc-20160816;
        b=oHtmOHFU57MQpUOaptZgbnNfBrkyUDSiOA4dY9O+Fo7iVKIuz5CD4YmnFzhsn5ePXc
         Eig4CbP6FCEz1Lr73B+LU3sUhYd792DwkfgjJFzolcgcf4xBKB66GQKLvPumUjYYNbMW
         Nf/NRojDJU3BYsz+4/WhsMfbDMA4BDpQHJcU4kPnYzbmPUiOeqd+zcEilqHyQu8gTx5u
         8Zg1FF97/5xbwkQ1cbvHrbTu4bjiFvg3RoNKgPFWizs3JxML+hdqjwUQppHUIgRrmFIo
         YjxpFKaoM3l6jmJJpgdqlLlguGdShDjmNMztNk3ozm6jNu+dpz0btwPU1483VVBUgh6X
         FmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=fniK61Sv/+03LdZUgSVE8b5i2+fsDjIJMDHX4Uch7bo=;
        b=PI3BMQ6cs+tCtoSu5T+4Cj1uRQQDK3T8dHVzrQfqbm4RYMxD5reEzNPCm+qsd1GWIX
         hXOyZJKHrHfUYlK1hKX28CGH17fvMqEjCgwRtOfAv5MC+NCKbCQyzL8pouu/FME7V2Es
         SPn4ZUkdZ8uvSVCtMenZBKa1HOZAnCkHGeRK5FN1acm67UiPfDUS9r9jgv8MYMUiH4Cj
         MCRrrjBT/pdzWXOZCkKnvJD0yn0XJYjq4ntzq5kFh9nkoybTgl7Tcl9sjIToiNfgN8ob
         r2lC34v4IUUv2ASaxlkvPb4TibSH9waNOvyndu9AwqP3k/Wy/5LsruZK6ywGGpjRVmEz
         mkog==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Secunia Research" <vuln@secunia.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.807965501@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 126/136] usbip: fix stub_send_ret_submit()
 vulnerability to null transfer_buffer
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077713295235600?=
X-GMAIL-MSGID: =?utf-8?q?1592077726424225705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit be6123df1ea8f01ee2f896a16c2b7be3e4557a5a upstream.

stub_send_ret_submit() handles urb with a potential null transfer_buffer,
when it replays a packet with potential malicious data that could contain
a null buffer. Add a check for the condition when actual_length > 0 and
transfer_buffer is null.

Reported-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/stub_tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -178,6 +178,13 @@ static int stub_send_ret_submit(struct s
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
 
+		if (urb->actual_length > 0 && !urb->transfer_buffer) {
+			dev_err(&sdev->udev->dev,
+				"urb: actual_length %d transfer_buffer null\n",
+				urb->actual_length);
+			return -1;
+		}
+
 		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
 			iovnum = 2 + urb->number_of_packets;
 		else
