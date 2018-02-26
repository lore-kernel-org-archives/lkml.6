Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226S/ETEyqaGXL54AJYAqE9T060iEnHz/syLor10hhJNKhnLoWm1mLTLd+4PloOEnzTMw7mj
ARC-Seal: i=1; a=rsa-sha256; t=1519676547; cv=none;
        d=google.com; s=arc-20160816;
        b=LsN+u1iHkjw0lNf2+NP33+SXRnvHDD1hWsBRinM2D6Yj2d3czUozgiUsPbZvm+JDI7
         s41Fi6MFsBaMaByzRhG/olg7wgQeAb6Qdx7/6RkA8NYm1MCjzOGfehTPDdA7Ujdy88pi
         hOCTkRfuP/fI7/bx3XjG/QcGSYTNXh1Za3cPdKWq08icGsi/mQfkBHvSsXa0jfZyVusu
         aPC81ZIJVpAjOLJ/QiMVHUGzrI7rOqbDD5/vRfyfYB8RZhQHuh6XS0vgtFMfDMcOwHRo
         llFNIwemM8cCObuuEic1b84T4FhjAWyV63VPDMCwJuZtJR+ifwZ4oA8vH06O5ET5M84a
         q14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zYSTgnnXYxCmWa9lwbYmCnciFanTeDNnMZ+qEifDo4w=;
        b=RdEdDYrk5i7w15NgBVgOJTmZSvf2VOuayJyZgKbLXsIiFOq78q9lJ0cn/4bREKEtYx
         gnTNKgaBwEvUSpHizdmBffpnYnJwPKcqutCIh8RIApe/k9RWIr21Z0a9rU/JKe9zlYU/
         JI6fndWFEJ6NC17iVn29/H1/pSRBFfZeW6qDKuYL34F++sQ7lo52pQpgwvbYH1OSAo85
         nNMb/1w4KbOZNmzWWBTEZDlI8WFWRhUJgmuskFI+zu2i2N8y2YWQNDdrsWhCg8xVLy1G
         bHsE+Qm6JqbpYbm2LlLBEPzHfzVGwj+kNdtjShzw+unyK1mkthhZsdej9v9gimSD9gli
         khFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 32/39] device-dax: implement ->split() to catch invalid munmap attempts
Date: Mon, 26 Feb 2018 21:20:53 +0100
Message-Id: <20180226201645.078680087@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496355512111333?=
X-GMAIL-MSGID: =?utf-8?q?1593496355512111333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 9702cffdbf2129516db679e4467db81e1cd287da upstream.

Similar to how device-dax enforces that the 'address', 'offset', and
'len' parameters to mmap() be aligned to the device's fundamental
alignment, the same constraints apply to munmap().  Implement ->split()
to fail munmap calls that violate the alignment constraint.

Otherwise, we later fail VM_BUG_ON checks in the unmap_page_range() path
with crash signatures of the form:

    vma ffff8800b60c8a88 start 00007f88c0000000 end 00007f88c0e00000
    next           (null) prev           (null) mm ffff8800b61150c0
    prot 8000000000000027 anon_vma           (null) vm_ops ffffffffa0091240
    pgoff 0 file ffff8800b638ef80 private_data           (null)
    flags: 0x380000fb(read|write|shared|mayread|maywrite|mayexec|mayshare|softdirty|mixedmap|hugepage)
    ------------[ cut here ]------------
    kernel BUG at mm/huge_memory.c:2014!
    [..]
    RIP: 0010:__split_huge_pud+0x12a/0x180
    [..]
    Call Trace:
     unmap_page_range+0x245/0xa40
     ? __vma_adjust+0x301/0x990
     unmap_vmas+0x4c/0xa0
     unmap_region+0xae/0x120
     ? __vma_rb_erase+0x11a/0x230
     do_munmap+0x276/0x410
     vm_munmap+0x6a/0xa0
     SyS_munmap+0x1d/0x30

Link: http://lkml.kernel.org/r/151130418681.4029.7118245855057952010.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dax/dax.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/dax/dax.c
+++ b/drivers/dax/dax.c
@@ -453,9 +453,21 @@ static int dax_dev_pmd_fault(struct vm_a
 	return rc;
 }
 
+static int dax_dev_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct file *filp = vma->vm_file;
+	struct dax_dev *dax_dev = filp->private_data;
+	struct dax_region *dax_region = dax_dev->region;
+
+	if (!IS_ALIGNED(addr, dax_region->align))
+		return -EINVAL;
+	return 0;
+}
+
 static const struct vm_operations_struct dax_dev_vm_ops = {
 	.fault = dax_dev_fault,
 	.pmd_fault = dax_dev_pmd_fault,
+	.split = dax_dev_split,
 };
 
 static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
