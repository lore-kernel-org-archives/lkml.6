Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqgySkNvGDW8lT5+bNnzxUBYHaNycDKBXeZnQLUY93mr76oNeTlsTL2ZDQfaOql6axHKyTU
ARC-Seal: i=1; a=rsa-sha256; t=1525116469; cv=none;
        d=google.com; s=arc-20160816;
        b=gS1AbII7d0a6E9LOmYGKkiEWArEp3GPXnBUM1iIxdTtUTHDFpGECHNaykfL5BTTPro
         OrCyLaGZfBAt51iwJrHaJqORrm8Esudk7dRmkKKnX64PCteDPnHV0ySB6jy+E80l40iX
         LDm+RTX7oosXMo2kcsN7HvRQEkHY24UgIPIv2fHZIzeBANyDZ6uUI60mGp0xdOTlPrWX
         SAy8U9KuYrNPIQaaA17qq4Id7UbIycyO1jVkHx0OanCASeWjAokWMx1LKc8AArSenHYq
         bIbcx/Dvlf+fQywsIk4d2hCoprEsgR4X5DDOdDqAmZX67ukT7+SrcZgsQykwMC7oeNM8
         3b4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=s6TWoDpvM5j9oOuFexHwETeZGeGSizrvtZoNUHY0I34=;
        b=lVO/gW1vCgmFJjYDNUQJXk6gsnONUW5B1giRAeAZ/81h2k46noTir7gX3+e6Oe3BLf
         b7v/zUXae0c7mLclimIAYnSOIdokepneAGsS9lkFFYvUt1SZi5zk/nkXBA2mSyc6h0nz
         tWGWTbJycqLw7qVP9uQGZOzquaLRQGZptXK/ts70Ddg0nzBpyjr4zDw2bW6PhR4Pleme
         GNaV/gJHvzxnfkXGdTa6qe8bALoG+P6niIDAetMM3h3F0//oPVLVIid5bx7BAXXGP8LI
         H4yHCMY/WUfd1ETMyNhadDWMexuqjvJwe+veEDIeP5BZXv1VDerhIzZ0c+QeFHmOXHfb
         uoew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3218122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alistair Popple <alistair@popple.id.au>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 70/91] powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large address range
Date: Mon, 30 Apr 2018 12:24:52 -0700
Message-Id: <20180430184007.897760550@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200526908319926?=
X-GMAIL-MSGID: =?utf-8?q?1599200526908319926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alistair Popple <alistair@popple.id.au>

commit d0cf9b561ca97d5245bb9e0c4774b7fadd897d67 upstream.

The NPU has a limited number of address translation shootdown (ATSD)
registers and the GPU has limited bandwidth to process ATSDs. This can
result in contention of ATSD registers leading to soft lockups on some
threads, particularly when invalidating a large address range in
pnv_npu2_mn_invalidate_range().

At some threshold it becomes more efficient to flush the entire GPU
TLB for the given MM context (PID) than individually flushing each
address in the range. This patch will result in ranges greater than
2MB being converted from 32+ ATSDs into a single ATSD which will flush
the TLB for the given PID on each GPU.

Fixes: 1ab66d1fbada ("powerpc/powernv: Introduce address translation services for Nvlink2")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Alistair Popple <alistair@popple.id.au>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/npu-dma.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -34,6 +34,13 @@
 #define npu_to_phb(x) container_of(x, struct pnv_phb, npu)
 
 /*
+ * When an address shootdown range exceeds this threshold we invalidate the
+ * entire TLB on the GPU for the given PID rather than each specific address in
+ * the range.
+ */
+#define ATSD_THRESHOLD (2*1024*1024)
+
+/*
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
@@ -621,11 +628,19 @@ static void pnv_npu2_mn_invalidate_range
 	struct npu_context *npu_context = mn_to_npu_context(mn);
 	unsigned long address;
 
-	for (address = start; address < end; address += PAGE_SIZE)
-		mmio_invalidate(npu_context, 1, address, false);
+	if (end - start > ATSD_THRESHOLD) {
+		/*
+		 * Just invalidate the entire PID if the address range is too
+		 * large.
+		 */
+		mmio_invalidate(npu_context, 0, 0, true);
+	} else {
+		for (address = start; address < end; address += PAGE_SIZE)
+			mmio_invalidate(npu_context, 1, address, false);
 
-	/* Do the flush only on the final addess == end */
-	mmio_invalidate(npu_context, 1, address, true);
+		/* Do the flush only on the final addess == end */
+		mmio_invalidate(npu_context, 1, address, true);
+	}
 }
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
