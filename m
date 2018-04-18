Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZpG3Danj/C20R8tiyO6E2E+khGrU81vm/gCQG09Nyiv5uWPFEr+3oR+MEHWfcWzfI7+fdqu
ARC-Seal: i=1; a=rsa-sha256; t=1524057896; cv=none;
        d=google.com; s=arc-20160816;
        b=bPpnU+nDzo5VSKaosME/WUVDVFSlFYDfomFHzqjgQ9cB+jjQLW/ZRnXfp00WOtCWDI
         +c33bMylWaxBoNJCCX66KWvGg+2gxvASG7dNkuibaChoiuq0v/8pxVgTZFmAMPP2HMdE
         IKLS8Af6/bErB2cN+goCNAIiarvolLXM5e8Vkg26wIUIUMGqWaxgbaaUN5z2sr6ENrh8
         2t2+q6t6a9AH/mEKeNRELHmKjCIiK8EGc4vJfV1NEDejGMSLe+VvHXavUkFRNTgGuxX4
         LEynrF9BBjE706I6hxGrNgl3bonOskyYodRjGC/LbxeFq1eGLRrE7nTAQM/ax5Opsi9b
         JA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kGamI7fo0Vm2rXkER9nvoiatVxmpp0im3zbmoj3X1Rk=;
        b=cPZE8O5tAEAKbLrLZa3ZcuT5Tc3SiFk1WzneYt8ixKdiqUReaWyvWYWlNT9Xao3ukG
         HN1RHtRPVLGLXYjJGYo8ySZVLjhfppoWioU4lSqhxs5jVezETwWmzISdc9i8yiVLokF/
         NRNS0xMDAdh69Mt8rlSyaz4fzoN2rOHTgtSeNlCXUQOmrkw1BUfpt4uLf38o/TWS9ZT1
         FS34Orx+LiZxrWzIkASgx3wA/otmUZa6MF3jqUGHvas0m2qBwoo+ILq+rDRlOZIVyc0Q
         qM5pDWuvDZQG3j9lery6kgu1hSHPJ2hCV8m/ojoB8SWHJajjleyf7qv82Sv7XvPRWsGs
         t/ZA==
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
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH resend 3/4] virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory
Date: Wed, 18 Apr 2018 15:24:49 +0200
Message-Id: <20180418132450.11663-4-hdegoede@redhat.com>
In-Reply-To: <20180418132450.11663-1-hdegoede@redhat.com>
References: <20180418132450.11663-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598090532362154892?=
X-GMAIL-MSGID: =?utf-8?q?1598090532362154892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is not possible to get DMA32 zone memory through kmalloc, causing
the vboxguest driver to malfunction due to getting memory above
4G which the PCI device cannot handle.

This commit changes the kmalloc calls where the 4G limit matters to
using __get_free_pages() fixing vboxguest not working on x86_64 guests
with more then 4G RAM.

Cc: stable@vger.kernel.org
Reported-by: Eloy Coto Pereiro <eloy.coto@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_linux.c | 19 ++++++++++++++++---
 drivers/virt/vboxguest/vboxguest_utils.c |  5 +++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 82e280d38cc2..398d22693234 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -87,6 +87,7 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 	struct vbg_session *session = filp->private_data;
 	size_t returned_size, size;
 	struct vbg_ioctl_hdr hdr;
+	bool is_vmmdev_req;
 	int ret = 0;
 	void *buf;
 
@@ -106,8 +107,17 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 	if (size > SZ_16M)
 		return -E2BIG;
 
-	/* __GFP_DMA32 because IOCTL_VMMDEV_REQUEST passes this to the host */
-	buf = kmalloc(size, GFP_KERNEL | __GFP_DMA32);
+	/*
+	 * IOCTL_VMMDEV_REQUEST needs the buffer to be below 4G to avoid
+	 * the need for a bounce-buffer and another copy later on.
+	 */
+	is_vmmdev_req = (req & ~IOCSIZE_MASK) == VBG_IOCTL_VMMDEV_REQUEST(0) ||
+			 req == VBG_IOCTL_VMMDEV_REQUEST_BIG;
+
+	if (is_vmmdev_req)
+		buf = vbg_req_alloc(size, VBG_IOCTL_HDR_TYPE_DEFAULT);
+	else
+		buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -132,7 +142,10 @@ static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 		ret = -EFAULT;
 
 out:
-	kfree(buf);
+	if (is_vmmdev_req)
+		vbg_req_free(buf, size);
+	else
+		kfree(buf);
 
 	return ret;
 }
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index bad915463359..bf4474214b4d 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -65,8 +65,9 @@ VBG_LOG(vbg_debug, pr_debug);
 void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type)
 {
 	struct vmmdev_request_header *req;
+	int order = get_order(PAGE_ALIGN(len));
 
-	req = kmalloc(len, GFP_KERNEL | __GFP_DMA32);
+	req = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA32, order);
 	if (!req)
 		return NULL;
 
@@ -87,7 +88,7 @@ void vbg_req_free(void *req, size_t len)
 	if (!req)
 		return;
 
-	kfree(req);
+	free_pages((unsigned long)req, get_order(PAGE_ALIGN(len)));
 }
 
 /* Note this function returns a VBox status code, not a negative errno!! */
-- 
2.17.0
