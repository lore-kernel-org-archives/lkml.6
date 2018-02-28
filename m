Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519798925; cv=none;
        d=google.com; s=arc-20160816;
        b=WAmf5EVcDuGn242f3emz+1Wg67uO3Wdz71nyNKJrpiqxv5VTaPau22WlCt9BoCy8w0
         Sn69uG62X/6o0zDq0Kn5ie3/bg+6S4YHKk5+kI+yWP08jwuzNzQM3pXoVt1XO070D47a
         jqrDFcyfMP3RKgx87gJBth9m/hQTakqamVVMGOWslGqwHEOLyGxRzMz2UK1F8tUWeiS9
         AhlCDIgdadFXHcojAhbXxVCRwBcIVKRUQofm/qhJkMB739/s1Ur6uEEiuA5o660E7g9w
         9WrqH3EvYCX0xLV0vCJd95E8j8BsF+dHSi9oK7YsdWPsVj8EbI1pUNTlBYViSqCEk7QA
         yGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=gqVFp9FvVvaKoNpsBt3zSXePlAWW80Lv/EZk0/AzO0I=;
        b=F6KQ4KB5hGDcfpzC4ehaaVMvkA9xMG4dvLBKCBOdZ9XwGmBFXvm0vIj/d4T9T0K6ec
         yNkYFfZzFufVXkwfM3E5XDdkJaLVO+GPvjGcu/vyCnGEDuIHFZvjZ6ICmDLMMIKNgDpy
         f0JgHM+6tzTRpNgK4ZXdGYcWGUZuzG9e1Va3OSSFVwgJmrAjqAnnI32MYYylfq+HFLAW
         lCwP5IesFCxpRhg7jKw3sxym5s6rsJiWKCkQ8d5mMW9sTZu+ZaJmClS74/k30rxOz749
         7IemuREZfN0vYBDIX0ZqAbDf5u5onNz+ziQOBAwa5CCqd/VonOGYAoHyK8h3+V/mo7U0
         DJiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FbvVS8Dr;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FbvVS8Dr;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225cAN1abrh906N0uRYTR8k5xvwbBRsq3/UdU1s6DVs9j3O78ZTNJXxjKxvK0bh/guiQf4kmPg==
From: Baolin Wang <baolin.wang@linaro.org>
To: kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	baolin.wang@linaro.org
Subject: [PATCH] m32r: Use read_persistent_clock64() instead of read_persistent_clock()
Date: Wed, 28 Feb 2018 14:21:24 +0800
Message-Id: <872a6089557b74f6e01bf1399b84a89af2a85ee2.1519798740.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593624678665009389?=
X-GMAIL-MSGID: =?utf-8?q?1593624678665009389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/m32r/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
index 521749f..3ef3123 100644
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -138,7 +138,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 	.name = "MFT2",
 };
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned int epoch, year, mon, day, hour, min, sec;
 
@@ -158,7 +158,7 @@ void read_persistent_clock(struct timespec *ts)
 		epoch = 1952;
 	year += epoch;
 
-	ts->tv_sec = mktime(year, mon, day, hour, min, sec);
+	ts->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	ts->tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 }
 
-- 
1.7.9.5
