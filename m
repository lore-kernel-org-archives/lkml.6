Return-Path: <geert@linux-m68k.org>
X-Google-Smtp-Source: AG47ELtuP7arAe1KnRwHxizgqeM0cUj6+GamRVvWCfHslmPVd15nbTXi8/esP1v5MbYg9bGgphMm
ARC-Seal: i=1; a=rsa-sha256; t=1521208185; cv=none;
        d=google.com; s=arc-20160816;
        b=zp6ByqHLLw+SyRPc2lshJwjwleniBYMKO0NiDyC1yH/MgFb1u4c3pNUlhytm/X1RAl
         0VhGlDiD+o6Sc9/Fe38oJY2AyBnYQ++B8J42X3gWjJXJ458FVz+Dn6CTOwVy8qCbYbFU
         Ipe7RZwwLlsl9jv9hRfOqZ0wTle/q++dZAe96uL2ig6yJMxZQqj5jVasymedmo+KhFDF
         /nnyS6UoT1loapaSTBDUvYaL9Qx5yVOeC1PtEXBlJVYU2lTFnCPJ8RRpsocN5s375Kdr
         KjtYLncf+WLHYJOJOh1buo0n0rxlyoMjQG/QNUDbMjXEUXis+NsASlJOE4wWjWXsagA8
         KHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GQ6v5VDlf5r+afX3HVW97fUXkYD1lgIlYIIqKsjVFV0=;
        b=opuhD2blMzXPaENEH6gqRPfoCfJSbNuLSJ8/Kwo5yL7TXkKpvmHmGJkesKfdHtBrb1
         JWGN728t/K2ICcjCF6NIAR0a4fXg1rHUDYrcqIxVKZD7DxUtrv3ULc4DOBmYfme5uiWq
         zwBPdhUJrGXn1Ig8Rtsx3K1F/LoomKDNIqihRijq9C/PjuBand09pUpBBG2Y6mhO1jGf
         /hLOLR/u95nDORD84f9CotCPp26DFt5pspWndteYZbRqg2KZ+DECrYbdqhMY60HiP3M4
         selsXqPCnlVa7UBHRjo4PPGsRrhTp0YJwTFHkbv9TS7CjWgCuTO1beL57+HMjppBffzS
         mN+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2a02:1800:120:4::f00:15 is neither permitted nor denied by best guess record for domain of geert@linux-m68k.org) smtp.mailfrom=geert@linux-m68k.org
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 1/5] dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
Date: Fri, 16 Mar 2018 14:25:40 +0100
Message-Id: <1521206744-1504-2-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595102394979971149?=
X-GMAIL-MSGID: =?utf-8?q?1595102394979971149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If NO_DMA=y, get_dma_ops() returns a reference to the
non-existing symbol bad_dma_ops, thus causing a link failure if it is
ever used.

Make get_dma_ops() return NULL instead, to avoid the link failure.
This allows to improve compile-testing, and limits the need to keep on
sprinkling dependencies on HAS_DMA all over the place.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state.
---
 include/linux/dma-mapping.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb9eab4ecd6d7a05..5ea7eec83c0fbb82 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -212,14 +212,14 @@ static inline void set_dma_ops(struct device *dev,
 }
 #else
 /*
- * Define the dma api to allow compilation but not linking of
- * dma dependent code.  Code that depends on the dma-mapping
- * API needs to set 'depends on HAS_DMA' in its Kconfig
+ * Define the dma api to allow compilation of dma dependent code.
+ * Code that depends on the dma-mapping API needs to set 'depends on HAS_DMA'
+ * in its Kconfig, unless it already depends on <something> || COMPILE_TEST,
+ * where <something> guarantuees the availability of the dma-mapping API.
  */
-extern const struct dma_map_ops bad_dma_ops;
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
-	return &bad_dma_ops;
+	return NULL;
 }
 #endif
 
-- 
2.7.4
