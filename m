Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZrKqKhfLPgi6a3XvuKuG/jy7gKBSPj/xOHBo1N9NLjuT5kRPQ6FihdTCtqgmW4WZ7Vur3Mx
ARC-Seal: i=1; a=rsa-sha256; t=1525787222; cv=none;
        d=google.com; s=arc-20160816;
        b=bx2tz2EKwR1pHx8pRWAbTDdvQ4W4Ez6H3DrrjuVeKjbpM1OrchAp8SW67IpTmDDNWR
         vwXdnXtQjWiKQip7VF6vUtL91d7XG1Wic1ULvXvW4vCkmj1kigOqn/HIUKztKqUipUlJ
         wJbuBaNmlWwQHQSfBMtiMGwEzN7g71BsY1AOp3Dkh30ce+gJlpD/lkUAjAG62AJkF3ng
         /t9YRrSB93Myd1YBdHAdEveAom/IWOomoJTYW/CTBduBhun4pdWBaiDLsMa7oAeNPtZd
         2JfeeeZZPI46UAFtzcSjZXOMHaGsVzmp1vMWeuJR3ZQya8G3IVu9iiN1/qs+wz2cPN1s
         yXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=fSQOFV6CfcvQelKkfPdzV4ZkOVYhQYu1csGKdeF8MDE=;
        b=sA4927QyKtzSeAYVLmfUOCQsch+vc/Konc+aeY/KVlMANhMX4j9vVgfBNCIsK1c5Xc
         gZIJlMBI8eu7wq3Bz9M00BKqQf4fab4uTFnJzrgTqovYRkKpzOuUM8/R3zaBq7q2SurO
         RDSFOdrLgu/PYcPcsPgi3S4H8ccyN6vnwH4tabFyhoTpu5nmiCmoCQU/Ul+BzmNw6Htw
         Z0zRr0LSHP/1TcPgCkze0roJM01lCAGsPUqYLdIli+emrq/jLiNkC2dFLvhGC4InBl3O
         pWWtimfLEAWbKbC/jnsGoJgchwiH0DG2z8I6TLqJXKc92ynDNl6al2zjAFpAzaVKKKgw
         UHuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virt: vbox: Only copy_from_user the request-header once
Date: Tue,  8 May 2018 15:46:59 +0200
Message-Id: <20180508134659.20429-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599903862223465156?=
X-GMAIL-MSGID: =?utf-8?q?1599903862223465156?=
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

Reported-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 398d22693234..6e2a9619192d 100644
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
2.17.0
