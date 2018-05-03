Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AB8JxZoaaQ51uBAIIk4DnlYidG+BKswqwt4ZNIGhNJJq+X94IeY8ac7rm9WVpBKZvNfuDV0TEFzX
ARC-Seal: i=1; a=rsa-sha256; t=1525314781; cv=none;
        d=google.com; s=arc-20160816;
        b=oywv4IUezJZce7IiPNrSXYN0lns5Ojl4tRB6gNJKiY28TTJmDLHlg0QF04TZ3h1NBN
         YHX+eZKdC9mprsmGnMMmPBfLgw/VxT+IFI7wambV4D5AGteDxG29LW5AT1ob+yWQrbUA
         x5TaRR8wPEJppaQmgucx8G5ckQNaDfETNgi27BmSniNijdohpDVy889NYoSv1I2jyrLa
         zPqjJnLOHqjYYEN0GRfqjGmJyndYHugSmyMEwUt8NC4Znq6MJeIf67ePBPiFs4RxSy54
         pzSunLUcYPhej5/z6fJKOqGIaEX4nYSyHZWzLtkgB3L+VXVxH2cPTYAdnLvWKB7XYlxg
         Luyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=dLAjyCdFJfqt+MXOirh6ny8g9YZ+bkRAih6M7M70zBM=;
        b=wUWznxLrTVHZQ1y4wxXJy6vzSmlH9ilvh5c3qA7ETJ3+TGS7XK1Oz/p8HUApSYBRlG
         5PvSICKFYI8lLPlKDa+zcjHNLURqtkXmzasD2MKuR5xgqLsSYbeybwVYNxemb+snpt8Q
         NaK/jEfeStLrPVkC39LaqI9k9hLho6DNu0zWOw2X2pP4C2Fdbe8JUD3TwFKYMYR2bnvz
         6z+5uSrak71faB23ASoGJello1maWxTMZxB+QOhNUm7BXsns4Tjufpht2PYm/FkWn0tv
         9/B4YC4feIeqk73WfrOpaQ/sY65QGBRQTISrXJPDd9Orkp9C8zEkvN6WUip9DVw/9Vx4
         6Rhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.148.12.82 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
	<qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>, <lukelin@viacpu.com>,
	<timguo@zhaoxin.com>, David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 2/3] x86/cpu: Include cpu_detect_cache_sizes in init_intel_cacheinfo
Date: Thu, 3 May 2018 10:32:45 +0800
Message-ID: <1525314766-18910-3-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
References: <1525314766-18910-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599408472355997701?=
X-GMAIL-MSGID: =?utf-8?q?1599408472355997701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the silly cpu_detect_cache_sizes() calling by including the
cpu_detect_cache_sizes() inside the init_intel_cacheinfo(). 

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/intel.c           | 8 +-------
 arch/x86/kernel/cpu/intel_cacheinfo.c | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f683f7d..56e3259 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -659,13 +659,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 #endif
 	}
 
-	l2 = init_intel_cacheinfo(c);
-
-	/* Detect legacy cache sizes if init_intel_cacheinfo did not */
-	if (l2 == 0) {
-		cpu_detect_cache_sizes(c);
-		l2 = c->x86_cache_size;
-	}
+	init_intel_cacheinfo(c);
 
 	if (c->cpuid_level > 9) {
 		unsigned eax = cpuid_eax(10);
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/intel_cacheinfo.c
index 54d04d5..2a0597c 100644
--- a/arch/x86/kernel/cpu/intel_cacheinfo.c
+++ b/arch/x86/kernel/cpu/intel_cacheinfo.c
@@ -20,6 +20,8 @@
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
 
+#include "cpu.h"
+
 #define LVL_1_INST	1
 #define LVL_1_DATA	2
 #define LVL_2		3
@@ -802,6 +804,10 @@ unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c)
 
 	c->x86_cache_size = l3 ? l3 : (l2 ? l2 : (l1i+l1d));
 
+	if (!l2) {
+		cpu_detect_cache_sizes(c);
+		l2 = c->x86_cache_size;
+	}
 	return l2;
 }
 
-- 
1.9.1
