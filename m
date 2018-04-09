Return-Path: <kernel-hardening-return-12935-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48JZmra0sB8HgWB7rJ/QBCQFoyz99Yz4LV3hJv0+1uvxkz55IeL6acg+3kxtl3FNgtJNlZF
ARC-Seal: i=1; a=rsa-sha256; t=1523307990; cv=none;
        d=google.com; s=arc-20160816;
        b=esHGKNX++KHckoUiw2OqH/sKigVDSlylPf0BTczkHnse8m4LR04AEjSjcn/luUWQro
         0Ns8NqKTex1/qVyapiwa+jMb7K8kSlFthdaE27DymhBevnVcoaYAV4aSf8TewOHoLi8n
         0z+Tbay7QA1yP4Xn7YniWyjIXJWP8Izm3TTxYs8ZFS8VRCjSK/Gz+PUt1XcVHGn232Tb
         vRuv8rQCWFEAq/y8zRX67VicEhgFOkDvGL04FSqk5A1uFcFFCD9ZodOgyLNYjyCan5LI
         olDqs2gevBRg/2VribDKX0DXWLb/X3xTgtKcO/UFwV0YLWXDIFHuV/u55Fahl+GgGXEA
         uA/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=oOrV9n4ebDhS1W/G4uF4IMdlLq4fzkwhLWhjwpOaIG8=;
        b=K/LaNlrtHzrrT3ireiIs4CQRVSRbDwMM7tjk5A6BSkqCuK0xFDLzczL6m0QaLgLcGw
         T6oJjPAY+t/OguzupMGPoNrIR8nPHz9czAZJ9v/TR5RPX0OiO9MCONokVZi9Kh1rXbhZ
         PU/CDD83wETSQhIM84r7VY9ZY2CYz2R2kDQUBwmDwQiEPXFjgXt5ZcrePoQwzFnzS5ZB
         jcOMf+RQtotvNjdoByFatQZQfr73WmqI1OycEvjHp2GLKVgzlVhkNGLo7SbeEiLV0skf
         ia13SRwhpDBKJRO8quSMY3csjNsbCxgKCRjvqo86W53yc2YQOrH7Kyn5h4dzLmlWPiAC
         iOLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12935-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12935-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12935-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12935-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Laura Abbott <labbott@redhat.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] dmaengine: dmatest: Remove use of VLAs
Date: Mon,  9 Apr 2018 14:06:03 -0700
Message-Id: <20180409210603.3575-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304199213101990?=
X-GMAIL-MSGID: =?utf-8?q?1597304199213101990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs from the kernel
(https://lkml.org/lkml/2018/3/7/621) to eventually turn on -Wvla.
The uses in dmatest are bounded by a check to make sure they fit
in a u8 so use that as an upper bound.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/dma/dmatest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 80cc2be6483c..dcf787b173e4 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -556,7 +556,8 @@ static int dmatest_func(void *data)
 	       && !(params->iterations && total_tests >= params->iterations)) {
 		struct dma_async_tx_descriptor *tx = NULL;
 		struct dmaengine_unmap_data *um;
-		dma_addr_t srcs[src_cnt];
+		/* total buffer count must fit into u8 */
+		dma_addr_t srcs[255];
 		dma_addr_t *dsts;
 		unsigned int src_off, dst_off, len;
 
@@ -669,7 +670,8 @@ static int dmatest_func(void *data)
 						      srcs, src_cnt,
 						      len, flags);
 		else if (thread->type == DMA_PQ) {
-			dma_addr_t dma_pq[dst_cnt];
+			/* dst_cnt can't be more than u8 */
+			dma_addr_t dma_pq[255];
 
 			for (i = 0; i < dst_cnt; i++)
 				dma_pq[i] = dsts[i] + dst_off;
-- 
2.14.3
