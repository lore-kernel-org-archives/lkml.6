Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523889860; cv=none;
        d=google.com; s=arc-20160816;
        b=xbNKkWeBSYcVVEOYRn2YrxoaFnG3u0Ts2QFCf2GIRZ2sujQ9iVYPL4HpWYsLC4toeJ
         AocCXqXBMZeK0EL/UkrCdqslfAW4InyxD8sRuLPltgtMGt89BvydY/ol7EiQQVqc7glT
         9gK3GfS6TM6gV2q4rI3gE+STmi/jF4Pa0YJprI9pEq1qyBXQQl5pyhBsWOpwKL4kqVsV
         S+tUZhdByRrd93YsBbbazYcgsbZ2IXQjmLgxIGMoQfU/jmRt+Boi6zEAfuCEoT+nTaw5
         3/+6kRcILIxYwmqkZZz609PxRu2hn3xDzJXm46B/IzjgavPDZBFLwijWzbq1gH6+fJhP
         EH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=P9AF9fMTia/EJg+/D5+G119jcXDqULhBnJ6DLMWJvTA=;
        b=PnlJr4637rYYhpn8OBAvWLF4mIpbpDR8RzU7uCQqL1tpP2tBRBrykunNWhz/3qC9bw
         0uk3TvGt/pBEx6AGjQgMEVlQYnNS312CMF++EUXteWp0v6cFBzVP9Bj026olaOe38zkf
         a1gwLJ2NMNSdfKFlgjB37sM0KAUhifFsqpMIrJSVZtb33h8GO7dSCGs09y7hn6++IcAH
         fuN09AsAidqc81cj4aXijmfMt+THdKduBIRoY4IEf2y/s2w7r+ZUt0i9LpCwoFZlMAKw
         p3gXdIwMzcYlfSa9wQgirdlf7fx5/ckTChtsrujeYN8A4rtNVC7Seq7aFSBtdzv3u+sy
         DObA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tqJuM0iU;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tqJuM0iU;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+E/yiiF5TUSoT8NtIhGN57kJr8TtHoKxyVHzr/VQyaMa4MC1j6pXV9u0ks46KwDRUMpp3Vng==
Date: Mon, 16 Apr 2018 20:16:13 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: gregkh@linuxfoundation.org, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v2] fs: kernfs: Adding new return type vm_fault_t
Message-ID: <20180416144613.GA26650@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597914334924001991?=
X-GMAIL-MSGID: =?utf-8?q?1597914334924001991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for page_mkwrite
and fault handler. For now, this is just documenting
that the function returns a VM_FAULT value rather
than an errno.  Once all instances are converted,
vm_fault_t will become a distinct type.

Reference commit id->
1c8f422059ae5da07db7406ab916203f9417e396

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Modified the change log.

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
