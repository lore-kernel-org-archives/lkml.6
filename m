Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523976721; cv=none;
        d=google.com; s=arc-20160816;
        b=LIdOvSxZ1mRke7+IeeSRg2/wxUYCAJWXuAanOhA4mA5c+VTQ9quAVYSRuBUsPTiW1W
         +LEFf1bTBwL8SDEn3EK29F8CVjtLblWv5aqtw3OLinX0MyE4XGiFuX9um0K2vuWoKPzp
         +xSYOkePJvT9sk1e67oh2yrpYUtlHdskHM/Kdf1K/mGFSia/BGYyj7v4h82ndOPfQkkX
         ENemmnmlwonokNE8AV68HS7O3NIZKSXJKbjmW/JUec8qzI+zsD1Xie+9Dx38hMiAfAUs
         qPDX9uu2owd0o/Kz9aynt7GQfu6nxAfnD/LUe0L4R6Ng0FpThrqBmCmEVXwq5+rtC3sq
         XN+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=OPntlKhMG5e2pg1hTjNfD9IbVlVYA6OG2CjX1eJinaQ=;
        b=byaJUtHBHcF0V5H8Znbp21m+sdqqGp4EnFOaZFAdu1QfEbA2UHua5eyIq/sluSSuJ9
         stA5iUa02dKmIAuCnrSdHPIv+c444W7SKKU1rnnWDpQbdpPn75DON5NRfZk+98E7mYVC
         P7+fC5uLtP4siJf5owBE1FtaSNZM7deWdeOCAotrCrIpwxMot7/dltxLSknppKDEkLpG
         5LP+s026XUXLvKUHSKE1qULXImhUJpomoQmSO97TKVPmbVO3E5WXwOCKaf6VOlTCNVPx
         65X36Gx8y0TZaxglR/L5nKV/T41OI0TsClVhMCa2f+8pPB7vIrmSbKmOUwZuKSldE4WR
         y0aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IHzIJ1S+;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IHzIJ1S+;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/Ajtd7/iOpKkaSinPateJY+vW6QiRTJNpm9biPN2w6rvOIlIMVo7wQmz38My3XMCvvWc9+fQ==
Date: Tue, 17 Apr 2018 20:23:54 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH] misc: cxl: Change return type to vm_fault_t
Message-ID: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598005414798688515?=
X-GMAIL-MSGID: =?utf-8?q?1598005414798688515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Reference id -> 1c8f422059ae ("mm: change return type to
vm_fault_t")

previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
default value irrespective of vm_insert_pfn() return
value. This bug is fixed with new vmf_insert_pfn()
which will return VM_FAULT_ type based on err.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/context.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 7ff315a..c6ec872 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -128,11 +128,12 @@ void cxl_context_set_mapping(struct cxl_context *ctx,
 	mutex_unlock(&ctx->mapping_lock);
 }

-static int cxl_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct cxl_context *ctx = vma->vm_file->private_data;
 	u64 area, offset;
+	vm_fault_t ret;

 	offset = vmf->pgoff << PAGE_SHIFT;

@@ -169,11 +170,11 @@ static int cxl_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}

-	vm_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
+	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);

 	mutex_unlock(&ctx->status_mutex);

-	return VM_FAULT_NOPAGE;
+	return ret;
 }

 static const struct vm_operations_struct cxl_mmap_vmops = {
--
1.9.1
