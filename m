Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELuspCuZ624ljftQIwmOx8AjO1tvrzsWpd0ORl/7wEZJA9a0E8r412XNFgNw2P4qbHqlaJS7
ARC-Seal: i=1; a=rsa-sha256; t=1520621062; cv=none;
        d=google.com; s=arc-20160816;
        b=i0fPh3vHTWORgsiRqu2lyyE8k7pOAmM8Dxzb8WG1O3ceCN1ZKOBFqTyyMQ5HD56Kut
         dc5Gejx7TdEBEe5EZHjMlRiRfzzFWyznZJB+hh6joxg8FetVBVWPdTtfAHfrYi1Nbhdo
         uYdQttI5Oq+TLoJB+xxhPILBZgGAut2cfd90BYYlYT6ItO6MPWmTrTrwRLuArDnzzgBE
         vTETiQQT1bDKm8t/VFznahfX4SMyW6w1uJDSpyjg938CcF7chSMOTm7CVcrDicw2QQmB
         qjr/U5yAXecn0cYMi3+enlIhC6M37qiTHvvOdOvO7tKvUW09CBSw8K1RoW4/cUh+zTK+
         9ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8fuZcb7hjoDKR25XP5J4N/y1shhsqCtch5Nre4O5uUU=;
        b=MLOW5s/cP6Ed2rhipVAfd5VSLs95g411MG1CblmZdgprVE9A9/ZePLEQxqKnXWZtQv
         GNalGDtQHPj2TIQVJgC+Dx4z07Qtc+ovmza0pC29hJybOT7/xzySDNmKgELQgA6NieAZ
         LOT/fEcThYgUA8ZnHNi3k6aOMKWZqXHb69nuUwdgMacxOUlYe/dxNlflevtEp8evZuH/
         Nj5CqUyh8O8QT/JhXJOWbfjkiqCS1Jquj5Y3CmNqzZKqMtJ8BeVLhJeD9vIdoYW9WHir
         9Dqd0vsPsO3gwdJZ08UuG58RacT3vFS/+g6z3qr2JAtUVlQHEm5mCGiCnKsFh9fCfoK8
         rLPA==
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
Subject: [PATCH v3 2/6] staging: vc04_services: Remove cache-line-size property (v3)
Date: Fri,  9 Mar 2018 10:44:13 -0800
Message-Id: <20180309184417.23368-2-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486750981851507?=
X-GMAIL-MSGID: =?utf-8?q?1594486750981851507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It's been tempting to replace this with (L1) cache_line_size(), but
that's really not what the value is about.  It's about coordinating
the condition for the pagelist fragment behavior between the two
sides.  However, the property was not accepted for the upstream DT
binding, so we have to use the firmware's fallback value.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Kept the property but added documentation.
v3: Remove the DT property again, more documentation.

 .../interface/vchiq_arm/vchiq_2835_arm.c             | 20 +++++++++++---------
 .../interface/vchiq_arm/vchiq_pagelist.h             |  1 -
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index b59ef14890aa..afdd3e944f3f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -77,7 +77,17 @@ struct vchiq_pagelist_info {
 };
 
 static void __iomem *g_regs;
-static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
+/* This value is the size of the L2 cache lines as understood by the
+ * VPU firmware, which determines the required alignment of the
+ * offsets/sizes in pagelists.
+ *
+ * Modern VPU firmware looks for a DT "cache-line-size" property in
+ * the VCHIQ node and will overwrite it with the actual L2 cache size,
+ * which the kernel must then respect.  That property was rejected
+ * upstream, so we have to use the VPU firmware's compatibility value
+ * of 32.
+ */
+static unsigned int g_cache_line_size = 32;
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
@@ -117,14 +127,6 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
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
 	g_fragments_size = 2 * g_cache_line_size;
 
 	/* Allocate space for the channels in coherent memory */
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
