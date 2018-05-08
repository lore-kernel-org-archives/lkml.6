Return-Path: <wang6495@umn.edu>
X-Google-Smtp-Source: AB8JxZqkqxbv4ElvAHxo/Sk3d3MEehITpccnpnPGdj5edCUWc2bsLkTelTI0pvEGHYoOYrELJA4h
ARC-Seal: i=1; a=rsa-sha256; t=1525787441; cv=none;
        d=google.com; s=arc-20160816;
        b=vi5C+FKNJGuZw0tjBe/Gc6IFgKfHB/AeebNyMk6qSxIP8kCzuWK/N+B744L/CtXDTk
         hKqnnAPBdVnnE8nOpdjYocr7aIXNFRLthHshS74sGIhjf2tPA4ppRWJUuPDndHvSl0xJ
         /QBJQLNsYTMjhKZsIdf/WHEy7jM0GSiTE8Y55h9jE7SxP/G7YdDyjVtOdsDxqux8zVfQ
         PnPh8nProyFrW50xIBuASQFGI2lef9YHnAbqrHewoqYz42zqcY+wThKtWtot6wfei6su
         5PGspUF0IecivlKTe0h4tdTUfwBjIq4EHruLse9oyEMCQoVhNKAy3ULPQS+sapk/Tf41
         Adzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=kiz8c+ExNsAGbvDZiZj8YkmGnYHW8MAJoa6rB1Az0+Y=;
        b=arrOFebv4BBnHEnh99cx7t6K5tn+oHLmhgQJfglCjHD23XLa9aaMkDb4VCeeLMqAWd
         R42ftgx8b0BQaqfh14BIVLHrGYQ8B5YgZHhw9HprvKBFyN8rL8GnTmelbHw2aGaKZW87
         S/a6oCX+uRwJYhPjHZ/W1TwEl5b8Vv7eICWyuj/RO2hjok0qJB+L3nBTRHhbSsoe0eLa
         Z+CmmQT6Fr6zIjjYDDV4ZRSpLF6X+E2EG6/3/AVA4pBYDT5BtWxEjPLmr8dmtN+jiCh9
         mh4Y2mH2I/J1PJ1SSGItu8x7Z0/nyjI5uy5Usa9HEpErYt8lDjoMLFP+KybiU7NcDKJ2
         hoSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=diB3HwbA;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.208 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=diB3HwbA;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.208 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
	Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] virt: vbox: Only copy_from_user the request-header once
Date: Tue,  8 May 2018 08:50:28 -0500
Message-Id: <1525787428-26702-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599904091917934348?=
X-GMAIL-MSGID: =?utf-8?q?1599904091917934348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
'version', 'size_in', and 'size_out' fields of 'hdr' are verified.

Before this commit, after the checks a buffer for the entire request would
be allocated and then all data including the verified header would be
copied from the userspace 'arg' pointer again.

Given that the 'arg' pointer resides in userspace, a malicious userspace
process can race to change the data pointed to by 'arg' between the two
copies. By doing so, the user can bypass the verifications on the ioctl
argument.

This commit fixes this by using the already checked copy of the header
to fill the header part of the allocated buffer and only copying the
remainder of the data from userspace.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 398d226..6e2a961 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -121,7 +121,9 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 	if (!buf)
 		return -ENOMEM;
 
-	if (copy_from_user(buf, (void *)arg, hdr.size_in)) {
+	*((struct vbg_ioctl_hdr *)buf) = hdr;
+	if (copy_from_user(buf + sizeof(hdr), (void *)arg + sizeof(hdr),
+			   hdr.size_in - sizeof(hdr))) {
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.7.4
