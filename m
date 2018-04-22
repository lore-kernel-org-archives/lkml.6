Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9L+enD52MlSD8f1cL7j6D8dneuVnaFGDuaX0l2Jof7v42j9Ju7bOORHB5VrcWJI0x/4++
ARC-Seal: i=1; a=rsa-sha256; t=1524405632; cv=none;
        d=google.com; s=arc-20160816;
        b=fGAmmGEQD5XCxzdPbfexh+HCKXy/xSS4PSrIWXlKsdqcoXZwIXWqrRxzpG+TGnuu4H
         b6LGFkjteXW3a7albJ153SLWZ7XBVQaH4Yj5GonWOSPbl/mE+pNelnkvnBs/I/VJ/UzL
         lqD+VMk/9xnotWbmVyPMPRu3N0F3NoZwWuIS5/dPczHqAJvQnvMKME6FEODGmfE8jnua
         kNW8Gq+lPUhXZgVmdscV4uItu64J7IAWQUkDicAsIxKCaiwpA2825dL2S4mKi5ISVUnr
         v/6oSHZS4cnJyAD8ApE0Qt7b1Mc+I4qFKxHzYzSFG+d7oJSNJKzBIMuxS9Ll8G5VO1j1
         Wzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=68wVKAB7f6smCe53j7F5JwTZxHx47MPKd/qaxoCyDdQ=;
        b=trbIkHbKCD3J9Nf8wn/0vH5ECUXl22+YCv9p6/enNXauD+n2ngCzeohdvAVvNKRHLi
         Q+B+F1CSGzZBjrWHO07LEcmFYdRawAy9zdRrp4k1TVU8qTabunZCdWqUnnSLANdmowMV
         rUA1WsN80ODCw7e3NvuD3GOA/ycysY++N8mprfyv3E0BgOIA7yIaFX3V9Z2H1OwyWXxF
         X96CHQFpZOQxsGUxtnOpeyd2MQI37djaPb5d3iBzuaBc2KF2IYkwGFvBQ1ukrQC9BJQH
         MGgVQ3c89UBDPhtQyNMIIxpUOlM/Bi0uDCEhImszQ88GTVyn9po/QzGXy9dq4WlotVlc
         Bflg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 120/196] cxl: Fix possible deadlock when processing page faults from cxllib
Date: Sun, 22 Apr 2018 15:52:20 +0200
Message-Id: <20180422135110.457070372@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455160282165247?=
X-GMAIL-MSGID: =?utf-8?q?1598455160282165247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

commit ad7b4e8022b9864c075fe71e1328b1d25cad82f6 upstream.

cxllib_handle_fault() is called by an external driver when it needs to
have the host resolve page faults for a buffer. The buffer can cover
several pages and VMAs. The function iterates over all the pages used
by the buffer, based on the page size of the VMA.

To ensure some stability while processing the faults, the thread T1
grabs the mm->mmap_sem semaphore with read access (R1). However, when
processing a page fault for a single page, one of the underlying
functions, copro_handle_mm_fault(), also grabs the same semaphore with
read access (R2). So the thread T1 takes the semaphore twice.

If another thread T2 tries to access the semaphore in write mode W1
(say, because it wants to allocate memory and calls 'brk'), then that
thread T2 will have to wait because there's a reader (R1). If the
thread T1 is processing a new page at that time, it won't get an
automatic grant at R2, because there's now a writer thread
waiting (T2). And we have a deadlock.

The timeline is:
1. thread T1 owns the semaphore with read access R1
2. thread T2 requests write access W1 and waits
3. thread T1 requests read access R2 and waits

The fix is for the thread T1 to release the semaphore R1 once it got
the information it needs from the current VMA. The address space/VMAs
could evolve while T1 iterates over the full buffer, but in the
unlikely case where T1 misses a page, the external driver will raise a
new page fault when retrying the memory access.

Fixes: 3ced8d730063 ("cxl: Export library to support IBM XSL")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cxl/cxllib.c |   83 +++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 29 deletions(-)

--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -208,49 +208,74 @@ int cxllib_get_PE_attributes(struct task
 }
 EXPORT_SYMBOL_GPL(cxllib_get_PE_attributes);
 
-int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags)
+static int get_vma_info(struct mm_struct *mm, u64 addr,
+			u64 *vma_start, u64 *vma_end,
+			unsigned long *page_size)
 {
-	int rc;
-	u64 dar;
 	struct vm_area_struct *vma = NULL;
-	unsigned long page_size;
-
-	if (mm == NULL)
-		return -EFAULT;
+	int rc = 0;
 
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, addr);
 	if (!vma) {
-		pr_err("Can't find vma for addr %016llx\n", addr);
 		rc = -EFAULT;
 		goto out;
 	}
-	/* get the size of the pages allocated */
-	page_size = vma_kernel_pagesize(vma);
+	*page_size = vma_kernel_pagesize(vma);
+	*vma_start = vma->vm_start;
+	*vma_end = vma->vm_end;
+out:
+	up_read(&mm->mmap_sem);
+	return rc;
+}
+
+int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags)
+{
+	int rc;
+	u64 dar, vma_start, vma_end;
+	unsigned long page_size;
 
-	for (dar = (addr & ~(page_size - 1)); dar < (addr + size); dar += page_size) {
-		if (dar < vma->vm_start || dar >= vma->vm_end) {
-			vma = find_vma(mm, addr);
-			if (!vma) {
-				pr_err("Can't find vma for addr %016llx\n", addr);
-				rc = -EFAULT;
-				goto out;
-			}
-			/* get the size of the pages allocated */
-			page_size = vma_kernel_pagesize(vma);
+	if (mm == NULL)
+		return -EFAULT;
+
+	/*
+	 * The buffer we have to process can extend over several pages
+	 * and may also cover several VMAs.
+	 * We iterate over all the pages. The page size could vary
+	 * between VMAs.
+	 */
+	rc = get_vma_info(mm, addr, &vma_start, &vma_end, &page_size);
+	if (rc)
+		return rc;
+
+	for (dar = (addr & ~(page_size - 1)); dar < (addr + size);
+	     dar += page_size) {
+		if (dar < vma_start || dar >= vma_end) {
+			/*
+			 * We don't hold the mm->mmap_sem semaphore
+			 * while iterating, since the semaphore is
+			 * required by one of the lower-level page
+			 * fault processing functions and it could
+			 * create a deadlock.
+			 *
+			 * It means the VMAs can be altered between 2
+			 * loop iterations and we could theoretically
+			 * miss a page (however unlikely). But that's
+			 * not really a problem, as the driver will
+			 * retry access, get another page fault on the
+			 * missing page and call us again.
+			 */
+			rc = get_vma_info(mm, dar, &vma_start, &vma_end,
+					&page_size);
+			if (rc)
+				return rc;
 		}
 
 		rc = cxl_handle_mm_fault(mm, flags, dar);
-		if (rc) {
-			pr_err("cxl_handle_mm_fault failed %d", rc);
-			rc = -EFAULT;
-			goto out;
-		}
+		if (rc)
+			return -EFAULT;
 	}
-	rc = 0;
-out:
-	up_read(&mm->mmap_sem);
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cxllib_handle_fault);
