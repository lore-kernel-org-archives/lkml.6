Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224Yh5UbjOap/F1IBJr5wkDUJigFcXExZR9VzzHokYTbndoNj8N6Ye57u+SSnt67OSfGwxyh
ARC-Seal: i=1; a=rsa-sha256; t=1518323624; cv=none;
        d=google.com; s=arc-20160816;
        b=cUcRePcltuQnWRbWpiWybBa5dEKqJIaW40n1Fkum8vJ26zlyz3sflo8zYBXMeoOM4J
         nbc/iG6RCc9KQgMdUgSAlFN851Gfh7YW1U6IZRzRV4w28mD1jfLp1fqh27ddFuHShU1s
         W6y/MxN+Zegcw0dA40aHPnmWTySA5jWi6ZGmUyrvkZO19/OLp06sKPfdK7GE1b6RFXWz
         5zCUeJeWkVNmuEEja3uAnvlScqHuC6eHiZKpZlgKRUGjEYJzJmK6jmxwx82hohWmnBFz
         OzOaBzpXIDOLXvvl78oTUhlHR0xhlJOoCCJzjkjqTg10Zx6xL6HWpClecBch6+55ZaYl
         cBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=ILAEFQ0JBBuV79RsDt4ePSSDS2iODlVAhQKYnhH5LYE=;
        b=lzwf0ZKpivWANMYdhrpSiNQfomtn38oc9u2ixoYSMb70SKTP68yiaCiqL0iG1fz8Fa
         nGgxwXcsOKC5ZtXfjkhV1byScEuERojBCUQy9QgLdeKh16IVPCrzK12/6QEuilEyBg0p
         ms/1QuSoi1bC3+8ozpZX0xnAwTIuuaAbNI8O2c6Bec095MkpauFv4I24AN5IEjoXupfK
         najikZiJdDAslWro4P3XpQZosS09z324MTgWUo2vgqSgEjA1qTyG96opS9ksuXGWNwru
         BdH3NZER54L1RreZBdVcDy5NRZ/gQyA3AWrhQeUzUZFjCpY3jlJzFynTc6boky97kox2
         8FJA==
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
 "Secunia Research" <vuln@secunia.com>,
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.310031406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 76/79] usbip: fix stub_send_ret_submit() vulnerability
 to null transfer_buffer
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077713295235600?=
X-GMAIL-MSGID: =?utf-8?q?1592077713295235600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2:
 - Device for logging purposes is &sdev->interface->dev
 - Adjust filename]
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
+			dev_err(&sdev->interface->dev,
+				"urb: actual_length %d transfer_buffer null\n",
+				urb->actual_length);
+			return -1;
+		}
+
 		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS)
 			iovnum = 2 + urb->number_of_packets;
 		else
