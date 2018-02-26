Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227PG9PR1EyzyQzKp43pNBR8rSgAXKWoUuqbWjSmCuwU9xYmNnZK012iCRPhp3VgE1KrqesT
ARC-Seal: i=1; a=rsa-sha256; t=1519676699; cv=none;
        d=google.com; s=arc-20160816;
        b=OVobsZyVLriJ1vufNgfIqjbEWokdc+isA6uXve8mIg2h/hXc31+Ulr7pT+4zvkMNAc
         sOpfIQ7NgrZLyNvccbZzPndYUSENOybmd2/7doFPha2zrpr5fGwJ8U80mcgG0L1Ngh23
         w7/XrfrLvxNNQf6xBSrNFrE1SX+S0gM4olFfhMzKEOZlZ3vsFjyEfiSePBzvFrSGNIzu
         0OYCmtmnp9XU5zE7KMQkuPE+ft31Hcc5h/Mc9vBBhpE7N4R5fUQYeMNDdRFIf7WsKU6f
         C2/4aHzp3PlgjJuwWDTV+tdk6nhSNhoz+HEcsY9ORCYRCdrrq7SyU8xjclGzPzy18XNM
         1ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wXVW11F2Y0b1awvDAKpi3CRLwWbrIMsiflP8yzvwYhE=;
        b=S2xKNcoVbtY06JztYLNoa11p1X/xbWNsfhVGLcUHrF2KGCBcCrfbZuUIbF4sRiQ9Gr
         OTOCiYHn62HlKn37nnAwPeteYquXSsre+570dPOKRvciFVSl59jbPJ0RzUZ3ixUdMQME
         7YV87LdHIcwe4KwX6POPwIWpSuCkbcBTufbo3UOed5SkWy6EunS/snfIiqCbE26Z015P
         TRb+Wr42pvlgXPLopSC4N8+yhS76L6mxgJAEmiQrCUdehH30uSjJ5CTsMLP3e6InxuSK
         zgI+mdfDo9LvAGq+iXxwIUMykAE7mJJBOZdtzxrpgn2E942aEOHl9pp8q8w+O43DLxXp
         qioQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 35/54] arm64: cpufeature: Fix CTR_EL0 field definitions
Date: Mon, 26 Feb 2018 21:22:12 +0100
Message-Id: <20180226202146.129259164@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496514564207090?=
X-GMAIL-MSGID: =?utf-8?q?1593496514564207090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit be68a8aaf925aaf35574260bf820bb09d2f9e07f upstream.

Our field definitions for CTR_EL0 suffer from a number of problems:

  - The IDC and DIC fields are missing, which causes us to enable CTR
    trapping on CPUs with either of these returning non-zero values.

  - The ERG is FTR_LOWER_SAFE, whereas it should be treated like CWG as
    FTR_HIGHER_SAFE so that applications can use it to avoid false sharing.

  - [nit] A RES1 field is described as "RAO"

This patch updates the CTR_EL0 field definitions to fix these issues.

Cc: <stable@vger.kernel.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpufeature.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -175,9 +175,11 @@ static const struct arm64_ftr_bits ftr_i
 };
 
 static const struct arm64_ftr_bits ftr_ctr[] = {
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),		/* RES1 */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 29, 1, 1),	/* DIC */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 28, 1, 1),	/* IDC */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 20, 4, 0),	/* ERG */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
