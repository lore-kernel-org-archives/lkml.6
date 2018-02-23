Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006443-1519424097-2-7062392486152592308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519424096; b=KSxhNB1WxJd+2hIJ9g63PAi71rSw2xFY6HSyL4TtNG448c7
    CPUgVP6Re1EGKZt5SR9FJ9VkDOb7ynLFkG1qp61SVKTYVawEy4oIzH+j2/qrx9zK
    rRapRdb4u4ldAX5Ut5I00Z5xgI1/EIQYSFuw1RUocxB4gplW1D1VywygWBOQcKvt
    RVy8cHrYF1x3DxrT5Rxw6+ysCZCVJCFkMeEGyY/zJkaY23fE+4jaN133jVHBxOBI
    8aPQrkT1GY7qhOeemHlL89KgHM81TD8jlKg05IKO2fna7aZzSg+BRDFzbvubG3ff
    QDtZNfzheBWL8o6Vou2YcAIq8g1CrS1u/k7ifiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519424096; bh=gxLtZgh4t2AKz32oYGC1PJdaPsUSp723CQA9ac6YOa8=; b=R
    dlhR+pFC3KbY0KAT9inWom3D4XisZa4hCZrmeQj1Xim13iHBhlWq1SBKqSiahSLt
    GY9+6Ptwg+oahXwuhCAgNBcrfje33oOGVIvoGIbIvnRZ9CopBCqrfIQMFI9Wf1+G
    pR5iBozclQ3GonLAbTnxN7qaFz9MkVG+dgjCu90ehKUzpctXZq7ulZ/ikXo2bvJt
    IEy/IVXIPEO2Syl+jr8Suolb6kv/e6xzbGiB+ZDNY2wh0krdDjk5SuTmso/N6Ho2
    /c2hguqnCeTcvA0sHuZby+dpwAvviBKQjtKDkqz0DcIwEWdlwBk26Aj7NcVWB7d/
    ndCawwomSRXAGesSWredw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeBWWOx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:14:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:44695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbeBWWOu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:14:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="33162583"
Subject: [4.9-stable PATCH 04/11] device-dax: implement ->split() to catch
 invalid munmap attempts
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jeff Moyer <jmoyer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Feb 2018 14:05:43 -0800
Message-ID: <151942354379.21775.5321017414392517094.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/dax/dax.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dax/dax.c b/drivers/dax/dax.c
index 40be3747724d..473b44c008dd 100644
--- a/drivers/dax/dax.c
+++ b/drivers/dax/dax.c
@@ -453,9 +453,21 @@ static int dax_dev_pmd_fault(struct vm_area_struct *vma, unsigned long addr,
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
