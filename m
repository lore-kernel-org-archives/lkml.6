Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524120707; cv=none;
        d=google.com; s=arc-20160816;
        b=A2H5UwLciySGZCeO+DJ6DbNDQeaxBo4Hb453TJ4BAQB28OEHedG2J2MlWC9lB17Fed
         vDFYeed4KVEMXP2+6klhokjAf8brXRS33/W19VOoxlDvoQ7q5zhlPCWQY9q9GN4eHPz0
         Zh5PgVcYyrSZRJO0dDr1+bWGCPaj1Lswkx3KGlEYuY8pNAjyh+/DslCxoNlxoGaqQ1km
         ZLrukCaVgiymsCNsVjZjYd7LhsyfQJkRbQgWeXEeFcSIFevfVMD6naVCMYNT4B9ral7W
         7+Rfg9U7BXm7PrmzG3e464tuHSiZx8bgGrEMBZ06C8YVunyIOJIfJkeEp2yFv2oLBR9h
         Dieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=aElWJpOtrwLEtUogDowdYYjo6Z48Bjs0JSoeUdrjOm4=;
        b=gnNOTDLgtzzGEVW1a4DfDq8DP7freSu0hPvl0wUWHR4gDoP8Mt/mzVAjPC+Vyl9n36
         eTCfhZskanB7JCei/1fanrm8wlAo0cDG8ncLwjDhwRYs3Pmqnn1B6ihgIN+oGdG6IRkB
         c92C7C/IX1CfRMKr+QbhNqC2Fzh3hsfPUjpG6Ng0zWoqeH/4w2whhRhPa7RO8OqhcDdz
         4qPVDOV7B5TqofrHRRxLwy1zDJMCE8HQm2hqH34ita2b0qSkQKdDOgtfdj+xkOdWTYXK
         7NgTff+NIs6uyZzBylvvEGaA0QK07Q9633i5uNbs0pXMc4xD8OxNliOrA7OXcEKauOyu
         DgLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gyiTm2h+;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gyiTm2h+;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/C1H1vmKFdcptYngaKfDRJz2dJLtFOCbVfGWcH1lrrWjj7+tNiI/MZfpVCoHS9PmaYqRtBGA==
From: Baolin Wang <baolin.wang@linaro.org>
To: jejb@parisc-linux.org,
	deller@gmx.de
Cc: alexandre.belloni@bootlin.com,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-parisc@vger.kernel.org,
	arnd@arndb.de,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linaro.org
Subject: [PATCH] parisc: time: Convert read_persistent_clock() to read_persistent_clock64()
Date: Thu, 19 Apr 2018 14:51:03 +0800
Message-Id: <4914b33abd8969906d2db0ae5c3da4f205f0bfe9.1524120572.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598156395055112064?=
X-GMAIL-MSGID: =?utf-8?q?1598156395055112064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The read_persistent_clock() uses a timespec, which is not year 2038 safe
on 32bit systems. On parisc architecture, we have implemented generic RTC
drivers that can be used to compensate the system suspend time, but the
RTC time can not represent the nanosecond resolution, so this patch just
converts to read_persistent_clock64() with timespec64.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/parisc/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
index c383040..a1e772f 100644
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -205,7 +205,7 @@ static int __init rtc_init(void)
 device_initcall(rtc_init);
 #endif
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	static struct pdc_tod tod_data;
 	if (pdc_tod_read(&tod_data) == 0) {
-- 
1.7.9.5
