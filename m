Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELsz+o4LVxj5IFNdBJfFwbzhz3fhRL/Eu09UY4UmMNjwaVqeftjIZQNO7LkuyRAdPYbU+D0s
ARC-Seal: i=1; a=rsa-sha256; t=1520449043; cv=none;
        d=google.com; s=arc-20160816;
        b=Js0Qr6V4S5N3qHe9HRrhSSXWjlE71NH7m6Yqq3TyFQ/S9p9JxcnALe4h8zE8zCL0bb
         o/RZthgYMi3Vv30ryGJa3EgzZ9gxHyc3+cRwH9sI/xWseu5r8pxyZlgHVfvZPeXTM3Hs
         PlyLiq63UxbIBE/BKkW+hsg86ZnOKoRZoUCAQzahWAl+MJzHdInajzCdNgxRr313XAAF
         0nkz++QkeX2GkTA90PhPfI6z3rBOW4WpvgCqpK5fXr/BJUFhgjfUYQ9XPIxlCeOR7cgi
         TaZn0vzJToOnwxOe6wd1bZ5t9NiJx87b4bo8C3O1+OexyVGDu+Wqx4bmeJ9bs47bmcNB
         W56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=mdYJEHbyeHB+QQ3BVoH9RfvZnkUBZOuzpNiCDzpHkkQ=;
        b=B0BvSrERW5Qz4471WD+ocu8jvdxzjGliyShVPIgWytyk1yOUynnxWsxpp2BowwFwFi
         CYopEtY8ViS5MmHZnl4GXUd0SKP/NY8oLoWIfX5XfMJxvYneBZzzRFJ5d7Yn83ReIa9b
         FhN9pwB5vHL+U/dleVNr43qjjVNnjOBUfVcn7DInTvuZVibdoYE2zDIKdFids7aarZKf
         M9flRfbpCrlsbz550pDolt0IxFcx6VOGaYfq/O1G+lokaQERpi4CYbemaLcdsqSXiPEP
         1iXk6dlj+UKQzx44YKWNUGWBNOjF6p6hqSuKuxr7nR7v9oZJTufMJ/0pWdF1LGD6EYMd
         VNzQ==
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
Subject: [PATCH v2 2/6] staging: vc04_services: Add comments describing g_cache_line_size.
Date: Wed,  7 Mar 2018 10:57:12 -0800
Message-Id: <20180307185716.17449-2-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306375745494039?=
X-GMAIL-MSGID: =?utf-8?q?1594306375745494039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's been tempting to replace this with (L1) cache_line_size(), but
that's really not what the value is about.  It's about coordinating
the condition for the pagelist fragment behavior between the two
sides.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: new patch to replace the cache_line_size() patch.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++++++++-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index b59ef14890aa..3aeffa189f64 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -77,7 +77,11 @@ struct vchiq_pagelist_info {
 };
 
 static void __iomem *g_regs;
-static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
+/* This value is the size of the L2 cache lines as understood by the
+ * VPU firmware, which determines the required alignment of the
+ * offsets/sizes in pagelists.
+ */
+static unsigned int g_cache_line_size = 32;
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
@@ -117,6 +121,10 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	if (err < 0)
 		return err;
 
+	/* Get the L2 cache-line-size as set by the VPU.  If the
+	 * property is missing, then the firmware assumes an older
+	 * kernel using a 32-byte cache line size for compatibility.
+	 */
 	err = of_property_read_u32(dev->of_node, "cache-line-size",
 				   &g_cache_line_size);
 
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
