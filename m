Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Mm0r9LPRfVVfVppSg96tl+sFaeIhTT7pSt2vTcWaZ2QheQwDn0R4P1CeGAST0NP4a2Ssg
ARC-Seal: i=1; a=rsa-sha256; t=1518708785; cv=none;
        d=google.com; s=arc-20160816;
        b=Mq8UrputjBejErjYcCdpi+49Hsoj3O1TBL4OOE7/QHL/WSNROPwHwxUrEygUdxPhh3
         680uI19QjAepQuwVaT53Wh1bh5YoerFiwhV5vrHUBGbIzf2z8IlHv9n+pdgW0iOfhegq
         S1DQ8e1tSRaXjxElpuOrVaKoxPQIQD0zxvThjrTalx3QHefWGGHLPJViK4QtucAepXij
         NOt0GZf3wuvXSRX96usajwI6ycPM6NEMV6Ub+oXNPaFUJbFCdoYOGwO2AkAuWYv6OUw4
         mv+mBhN1KBVStEpQxzJJbAsDdVZjjzUsWPL5VxlLk6m6j2lOrZ8NK1E0cKIk6MimmMgw
         cI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4wfb56VwqAtZwPU4D9reZjyuceSw4V9xwG7PpQH264w=;
        b=L2t4bApz4vBtLcerdaNafH3oGwlkcESsXlnN0o+57cAXE8BOz9l62f5eXnKgkngkls
         gQFxiM9dh3pcl2eSY2n1PnWr1D/KZpgOtb5aq+yxMM+CVeXVm7xWOJyZNvNOCQnDg3c8
         7unCRIFqr1N5ndmm40M2ONPHvq6lHILexZaKrAe3aspUUx18Utty0IDg565tBgBUEIuQ
         WMsWcp+oVNyo++pDkZlzLHAejBhyEk0Ld41oPoDtNqVoeM57F7Ypw5hu8/Ucl+Dzmma2
         OFo307OxGJ1MqhLLBzmG/pX1tlpm4uW5vgdoxeICuzmtxo4gNd3IJpZ5y52w6OtVUCGD
         /Zxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 078/195] [Variant 2/Spectre-v2] arm64: Branch predictor hardening for Cavium ThunderX2
Date: Thu, 15 Feb 2018 16:16:09 +0100
Message-Id: <20180215151709.595659834@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481582898687532?=
X-GMAIL-MSGID: =?utf-8?q?1592481582898687532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit f3d795d9b360 upstream.

Use PSCI based mitigation for speculative execution attacks targeting
the branch predictor. We use the same mechanism as the one used for
Cortex-A CPUs, we expect the PSCI version call to have a side effect
of clearing the BTBs.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -359,6 +359,16 @@ const struct arm64_cpu_capabilities arm6
 		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
 		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		.enable = enable_psci_bp_hardening,
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
+		.enable = enable_psci_bp_hardening,
+	},
 #endif
 	{
 	}
