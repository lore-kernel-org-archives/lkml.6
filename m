Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227388AF1M9264YPE/2RLP/4sR15akMaCuwHTr2sPHCwadiCuJO+LSaXZZGnLA7k642uBefS
ARC-Seal: i=1; a=rsa-sha256; t=1518709274; cv=none;
        d=google.com; s=arc-20160816;
        b=wM1Euk9eU347dUPoNQPLlAuQX+RClK/7F/+fjEgdBdybnZBt3mJzqMPGYD5nawNMos
         Ug2fXOBi3sPRNpegR+EAtC+i2XllCw9+tvZHVSMe6LPqDZDQwJULQy60l79MtbwRtdIV
         t9qim12Jtn2Y1moj7Xq+coIu/v7WoBHmA/sK6Rtd1emxSLHCPulYyTwNtYCpJ83MnNSP
         NGR9pcfD2mM2LpxfH/9oMBLt540UtUNE5aeXp+4A8vCv6U8F4GgnUrehqVRDHU+QAHmE
         /g4WBTUX+7XqGHDZP14CVM3tjZQK/oXmCksUbhQzt6ODk+SS8ZTvMTK1O0njz1JUAHG3
         ab2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7Cc3kyH1UqD0XeZ8u7JC/0sf/hiqupeU57ZnSrVSIUI=;
        b=Gklz5JYPilG+JbQ7HO139+oS/kuwYA0Zmfy6DGhtjYFlFhXxKUlCfYJfSP2vbS4ZKA
         qiP7CdRSe0IEPNFRFCaj9GCrCNNVlmmOzdVEwKZfe/J6su5fBRRt58k1G6qbauCEqR69
         F+f+iTkWFD2yhJId39M4WUc7dHnq/mg/nyKZxyK2XPkME1d+N2mxDb7fO/3M4co4p3ZF
         hVdQaI47Y4MhOou4U0HmlYOtak2HS9wEUQJF3OneD3j40+Z+Y9c6EmYCGEfPWZjqZNCR
         8fTORm3jYFEDFsvrGMjmaAoSWTj+41fslgTRTvvU5Shds9Ugx5QAurW4PEKg90Ng4XAg
         pdgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 060/202] [Variant 2/Spectre-v2] arm64: cpufeature: Pass capability structure to ->enable callback
Date: Thu, 15 Feb 2018 16:16:00 +0100
Message-Id: <20180215151716.467771666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481549255300629?=
X-GMAIL-MSGID: =?utf-8?q?1592482096490918434?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 0a0d111d40fd upstream.

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1215,7 +1215,7 @@ void __init enable_cpu_capabilities(cons
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1259,7 +1259,7 @@ verify_local_cpu_features(const struct a
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
