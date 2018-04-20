Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524253411; cv=none;
        d=google.com; s=arc-20160816;
        b=z39apVKoTx7b7G3iW8V7hK2MbHebUrcItqIv5zy4wQZri55Bkiee0w7EMbAeT/7nLN
         ULiSZSK7Nxb5uiDdH0kItR3y+YzZZkpIQIUF56APcBGPvFrItmWlsu3NArMLsKHAmMkT
         MB9I2khWIrHebZ/PV02x60uy2tC4tFd88KNxbpma8dsHyZeLzD7MPXZoFy7Q6a2tZTz2
         +6AiWNDVdI6yrocJFtJz5ddifFctQBdipMV0PLfYbTrZQvBW/5QIN8NWMYK5gZqi2N5z
         eMmZ9kVMM9bYq4lHr9h5EXRrkSEBYCNyFvJOBazbI5F4MowzSd/ySrqYOzhysXlWKMXg
         c7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=qFNyOPP0XJoDqC3KeaNaYbq0GW2ThwJV3055EJtXti4=;
        b=rwcwHqaTwhche3HJTGIH6jXMU9XU/rKYtB0uHI9LGZzKDikPUX4D3YeexxxTXW6Sx/
         FvIIHkxZyZBFbgHmSCNxRkBqVe720EO0MBnfDc56Ns29GUANGDo2lWmetokyB+ahHtXD
         pKm1gWNxu9DvjlZWGKnxG2ZBkRCAooWP3KjEJMEwqQMkG4Q0SI0zLNRdBIbW4RQLRfMP
         Cvh6a1Nmtn0x+eHdB1eYL67shtW63vt/7JvbFic/FsOH0AyXzuYXM4SxGXiyzUrrMSUD
         bwNSt+cY8pg9MfJQhYGnGCDv2N4LMDMtOXTZsJiqkdrnkjqIQn9j4kiz3uJf7kV3b5ck
         0uzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U36qM5BB;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U36qM5BB;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49dNb+w0F2HMwQT5bffX9goT0oVjt5AjUH2UiDuvD9r09eveRfMTn3MYByHzXhS13LZrL50NQ==
Date: Sat, 21 Apr 2018 01:15:24 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v3] fs: kernfs: Adding new return type vm_fault_t
Message-ID: <20180420194524.GA27003@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598295545381024757?=
X-GMAIL-MSGID: =?utf-8?q?1598295545381024757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for page_mkwrite and
fault handler. For now, this is just documenting that
the function returns a VM_FAULT value rather than an
errno.  Once all instances are converted, vm_fault_t
will become a distinct type.

Reference id -> 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Modified the change log.

v3: Modified the change log

 fs/kernfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index fd5ce88..2015d8c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -348,11 +348,11 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
 	kernfs_put_active(of->kn);
 }
 
-static int kernfs_vma_fault(struct vm_fault *vmf)
+static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct kernfs_open_file *of = kernfs_of(file);
-	int ret;
+	vm_fault_t ret;
 
 	if (!of->vm_ops)
 		return VM_FAULT_SIGBUS;
@@ -368,11 +368,11 @@ static int kernfs_vma_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static int kernfs_vma_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct kernfs_open_file *of = kernfs_of(file);
-	int ret;
+	vm_fault_t ret;
 
 	if (!of->vm_ops)
 		return VM_FAULT_SIGBUS;
-- 
1.9.1
