Return-Path: <wang6495@umn.edu>
X-Google-Smtp-Source: AB8JxZqv0Lq0qe2BxjZ154TLmiM4lXQd7+TbFF9QpoaxrHjVwz3yCvTQ8r+L690grqjSk1pVrsi7
ARC-Seal: i=1; a=rsa-sha256; t=1525577461; cv=none;
        d=google.com; s=arc-20160816;
        b=U/VYYJS+Alp63ykz2M/gs37FWYIcI3OMg7lfGyBdlGnY3Eds09GiKfsC9mSYMpoNF6
         +frsu5DMlzcQEgCJWk9OYU1AzXkQrVYN0QmtZGRl4RayBZXTRpazmyxJN0vs7r7ZWrio
         nGQ2FMX5tR/7I1UTtEF2RwuleUVtkKTOcOk7ExMGQKNyg4cW9sh5BXMQOSk+KKIno+HM
         rNOVDvndrfM2XXi5oLNAcoWv9/dG828HM4+J5GtSkSI+Tir4h0zduh3TzKZflHBQEu4g
         EdwZaFmf1hbS7o7BiEtJ5oeGzuKJ4d9F0+jMSIvcHbVuYtUqpN2SAu7NAio2/IPSpq0/
         ETZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=evrrSeJQ4sykfcq0JHD1ZoeY1zQJNjWnpj7xP0w862o=;
        b=p8XaAekkBvEjQJkEuTtwSVkaWB7GVSEn+4q8EbEy5kV3advquut6tL0fTVX7n6Ef+D
         qp4Ap/0ZpNxzAcX5N2V8bo2srjCxP+O3EsMRlUOmZeQonHaY+C/IpMlrBZWXfWc5gBfe
         HJmJCTktqduFdlBBTqe24DAWMpLixwCV8lvd31zs95u/wsxH7RWnKZSiCDWfmF0Rb4uJ
         b7MyfHMVFJkdKRaoH9GsooBTpmM3Vjz71GGmK0+bIMgTx5Ic2pHwzrI22h3bg85tDii6
         2gEBag+TZHV/zYENmPaiU/v2HaGiEUdC9/1C96E93QnLahfg3tpaZzE/np5zAC7JvqHi
         PXWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=nyYObmF3;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.208 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@umn.edu header.s=google header.b=nyYObmF3;
       spf=pass (google.com: domain of wang6495@umn.edu designates 134.84.196.208 as permitted sender) smtp.mailfrom=wang6495@umn.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=umn.edu
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
	Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virt: vbox: fix a missing-check bug
Date: Sat,  5 May 2018 22:30:48 -0500
Message-Id: <1525577448-16071-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599683912395513650?=
X-GMAIL-MSGID: =?utf-8?q?1599683912395513650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
'version', 'size_in', and 'size_out' fields of 'hdr' are verified. For
example, if 'hdr.version' is not VBG_IOCTL_HDR_VERSION, an error code
-EINVAL will be returned. If 'hdr' can pass all verifications, the whole
structure of the ioctl argument is copied once again from 'arg' and saved
to 'buf'. Then the function vbg_core_ioctl() is invoked to execute the
ioctl command. Given that the 'arg' pointer resides in userspace, a
malicious userspace process can race to change the data pointed to by 'arg'
between the two copies. By doing so, the user can bypass the verifications
on the ioctl argument, which can cause vbg_core_ioctl() to work on unsecure
data because it assumes the 'version', 'size_in', and 'size_out' have been
verified by vbg_misc_device_ioctl(), as mentioned in the comment in
vbg_core_ioctl():

        /*
         * hdr->version and hdr->size_in / hdr->size_out minimum size are
         * already checked by vbg_misc_device_ioctl().
         */

This patch adds checks after the second copy to ensure the consistency
between the data obtained in the two copies. In case an inconsistency is
detected, an error code -EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 398d226..6b525259 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -125,6 +125,12 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 		ret = -EFAULT;
 		goto out;
 	}
+	if (((struct vbg_ioctl_hdr *)buf)->version != hdr.version ||
+	    ((struct vbg_ioctl_hdr *)buf)->size_in != hdr.size_in ||
+	    ((struct vbg_ioctl_hdr *)buf)->size_out != hdr.size_out) {
+		ret = -EINVAL;
+		goto out;
+	}
 	if (hdr.size_in < size)
 		memset(buf + hdr.size_in, 0, size -  hdr.size_in);
 
@@ -133,11 +139,6 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 		goto out;
 
 	returned_size = ((struct vbg_ioctl_hdr *)buf)->size_out;
-	if (returned_size > size) {
-		vbg_debug("%s: too much output data %zu > %zu\n",
-			  __func__, returned_size, size);
-		returned_size = size;
-	}
 	if (copy_to_user((void *)arg, buf, returned_size) != 0)
 		ret = -EFAULT;
 
-- 
2.7.4
