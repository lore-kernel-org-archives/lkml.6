Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELtHmw60vvfJwhsVtVIapWIRjgcQoN8MUh21/cNt+ac5CX2YVZtpANvV/+BDPSqGMTnSvF+V
ARC-Seal: i=1; a=rsa-sha256; t=1520281692; cv=none;
        d=google.com; s=arc-20160816;
        b=Qf0ieMOZd4oC/9tpYGoobxS2cIDSQWZuzQ+iagT6112du4TZv+pfxVb3FSz37LcqEN
         acNfE9AZPngr7b+tEss8lTS0a0lBjgqRqA9q6QRZdBdgUTw9nzXxR0A3macHCUegGvAb
         e/NwrRqIRFMTmXYYveP4CblI+wXQr4rGDIWS176v+oyvHcU46C3Nq3hNaE5GCSThMewY
         SXK+IZTvTMpcc3trE69R+n9vZBmhe2IwGRXIeJ52mxglQ8mWjMf0rVuZoPGXDB7hPa4b
         t2tuou4zbbpbIvrfO5bB61pLhLsH8vQMbaf/4OAPHy8Vk51Qg01yBqMYeGqMMGCqhNoI
         VQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qvDNmXgXiYXgaBONSmhgiLzVquYvRNkhsrkt4w0mesE=;
        b=vdIgC+E1rxFdvzfLobtVk7y02bLupHlfRfbMkxSvqYLZasdHLW1Wa6CFZcUYWkcX5w
         VqsBIR5QG+N1d2K2zkWXq5QjzGCE1PX900kReBpI+wwGju8FtJUSeg422yX17h8PAiD0
         H2fUVH6Ohf8WcfPvCwMjTD/oVPjbvE7RBEqqqgjYXe0KHgcfPtanLARj7h95KhcZK6nb
         VzGraSTWx7hujj+yFlkIao0MkhPgccdZaRN7/FdOsjvM6NbezEeUTucp2KHk+M3SU/Qn
         b8cY3D3kVHDfFF2K/4vyPXGBaKRWyhAyg5RK6+1fr9e40MW3njUdOwRmHb4u814He3cg
         /V3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/5] staging: vc04_services: Remove cache-line-size property.
Date: Mon,  5 Mar 2018 12:28:03 -0800
Message-Id: <20180305202806.21219-3-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305202806.21219-1-eric@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594130896333791997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This was just a way for the DT-passed value to get out of sync with
what Linux has configured the ARM for.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
 .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
 2 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index b59ef14890aa..e0e01c812036 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
 };
 
 static void __iomem *g_regs;
-static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
@@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	if (err < 0)
 		return err;
 
-	err = of_property_read_u32(dev->of_node, "cache-line-size",
-				   &g_cache_line_size);
-
-	if (err) {
-		dev_err(dev, "Missing cache-line-size property\n");
-		return -ENODEV;
-	}
-
-	g_fragments_size = 2 * g_cache_line_size;
+	g_fragments_size = 2 * cache_line_size();
 
 	/* Allocate space for the channels in coherent memory */
 	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
@@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
 
 	/* Partial cache lines (fragments) require special measures */
 	if ((type == PAGELIST_READ) &&
-		((pagelist->offset & (g_cache_line_size - 1)) ||
+		((pagelist->offset & (cache_line_size() - 1)) ||
 		((pagelist->offset + pagelist->length) &
-		(g_cache_line_size - 1)))) {
+		 (cache_line_size() - 1)))) {
 		char *fragments;
 
 		if (down_interruptible(&g_free_fragments_sema) != 0) {
@@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 			g_fragments_size;
 		int head_bytes, tail_bytes;
 
-		head_bytes = (g_cache_line_size - pagelist->offset) &
-			(g_cache_line_size - 1);
+		head_bytes = (cache_line_size() - pagelist->offset) &
+			(cache_line_size() - 1);
 		tail_bytes = (pagelist->offset + actual) &
-			(g_cache_line_size - 1);
+			(cache_line_size() - 1);
 
 		if ((actual >= 0) && (head_bytes != 0)) {
 			if (head_bytes > actual)
@@ -617,8 +608,8 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
 			(tail_bytes != 0)) {
 			memcpy((char *)kmap(pages[num_pages - 1]) +
 				((pagelist->offset + actual) &
-				(PAGE_SIZE - 1) & ~(g_cache_line_size - 1)),
-				fragments + g_cache_line_size,
+				(PAGE_SIZE - 1) & ~(cache_line_size() - 1)),
+				fragments + cache_line_size(),
 				tail_bytes);
 			kunmap(pages[num_pages - 1]);
 		}
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
index a6c5f7cc78f0..bec411061554 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
@@ -34,7 +34,6 @@
 #ifndef VCHIQ_PAGELIST_H
 #define VCHIQ_PAGELIST_H
 
-#define CACHE_LINE_SIZE 32
 #define PAGELIST_WRITE 0
 #define PAGELIST_READ 1
 #define PAGELIST_READ_WITH_FRAGMENTS 2
-- 
2.16.2
