Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227BLO3uGKvp1PYA9YK0Gwoc1nscnk8LzLpliNPF1s3vx1g2a+g6xmo5tGedV+dd6GQDafPD
ARC-Seal: i=1; a=rsa-sha256; t=1518709363; cv=none;
        d=google.com; s=arc-20160816;
        b=FtUu+iD2LmQJ4QEtSSOzApCmMxxJ/K922TG9eJxx1zx8jy/ESPizMBv57BeIRzFMfS
         oXd3nXkldgSHQoxoeOC3eRjZblkNd9sLhziGBm7zRrPDnirEiC2SfnyE5Yn8OA9lgwP6
         OqqW2eO14NDmNrwyJznML7d37Xpy5T17AqGXekZN0CfaUuaDzlvvoFSbzlb2Rk9kod7t
         o9m1020CLFbXW2Zi0R2SjmyPUqsCUFSsL44r+4BGYdzLW2rkJdVrVtzXE+4kD1K69yo6
         oGtn0uUnx200MMuq/yJRhzDkfr26lHLmvEFkBvWgwBthm4jj57kj656rozsk/Ec+ui4c
         vA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rPWffbwFQlGkxi+AHCWHAVqK/g7ck5daxcHldF8CQOw=;
        b=X3m6E1YnAzTl6StJ6hx94rkR6RrwgFIPrjoUEcKCH0+zeqpIsjWn3C/hWFtECcaPYK
         puBpBYL/E7Doh1hPnYW6LWTInWsEKXyicavbK6dYccq4blf7DhUmXYew/N69p1vYAYIl
         5PftJmlDkNGsAybH6UfygJ+RJOIQCAYAttKxe+hAKd+Fu7OfvcevAx8loCwm5nXdYSnb
         d0+2sCeCylsK5vj1NoSHwKBspjqtAAWxI03dE3oOEm4gGVYJJ63FlYWxCRuoyjguI5XN
         frb3NH5EMkegTlQ8mWlSO2616ZAKe0j81uzqeMEu5j/HER5ZVBPe05HXtgn9P9Wienhk
         Nz3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 045/202] [Variant 3/Meltdown] arm64: Force KPTI to be disabled on Cavium ThunderX
Date: Thu, 15 Feb 2018 16:15:45 +0100
Message-Id: <20180215151715.543034010@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481612339960313?=
X-GMAIL-MSGID: =?utf-8?q?1592482190017565285?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 6dc52b15c4a4 upstream.

Cavium ThunderX's erratum 27456 results in a corruption of icache
entries that are loaded from memory that is mapped as non-global
(i.e. ASID-tagged).

As KPTI is based on memory being mapped non-global, let's prevent
it from kicking in if this erratum is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: Update comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -853,12 +853,23 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	char const *str = "command line option";
 	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
-	/* Forced on command line? */
+	/*
+	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
+	 * ThunderX leads to apparent I-cache corruption of kernel text, which
+	 * ends as well as you might imagine. Don't even try.
+	 */
+	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
+		str = "ARM64_WORKAROUND_CAVIUM_27456";
+		__kpti_forced = -1;
+	}
+
+	/* Forced? */
 	if (__kpti_forced) {
-		pr_info_once("kernel page table isolation forced %s by command line option\n",
-			     __kpti_forced > 0 ? "ON" : "OFF");
+		pr_info_once("kernel page table isolation forced %s by %s\n",
+			     __kpti_forced > 0 ? "ON" : "OFF", str);
 		return __kpti_forced > 0;
 	}
 
