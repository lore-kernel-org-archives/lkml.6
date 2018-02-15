Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227AshmqTHPCm4ndNACEm/2AXzA3kdgfLrqqdfKoluApAP3oTsIC0MBTQA23s/EerCCRy+a9
ARC-Seal: i=1; a=rsa-sha256; t=1518708749; cv=none;
        d=google.com; s=arc-20160816;
        b=xpMRBJXKTB/WHisUbLKUooGL3uBoQ/xElHcWrmJEUu0guQncOKq1sxZ/GTi1msF5PX
         otOcTP5Jt5P/DXgkPVoUZOb+iW5uh9bRr+9vNiKM02CM7cBZ8ooHMbIvkgXQykxgbMm8
         /wX+MalDBzoWzZKcDiRaBG/DJPL07q1b7vIV3Fp4gs5OPGJOhaiMFMGioRznCgVubiOz
         PKZuMfsbeHUXFfSNxgVLRPXf7jnb7Yu2vlQUgP3KdhJc3kitomsXqBuBQF1gt/0zl1e2
         kNTkROEDS4ro37JQH5JpMOWRGcPeLiS5aeF/05TSkh8aoXrYFiIRxs/673nlOA+kkBGF
         b98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WYZG+wRQyE6s1GDTw1uQKiAz13sxT8Yfq2QXqsAXkLg=;
        b=aRugueqNIzckWdxtjUfNVpOXcG69/W91Uad3lbT8xSaFTdaXX/T7R9Chr4bri5j/52
         5uA2Rr6peVq3bMBEsGNkvhe5b/BT1QszGzgwg5/PA6NSCLwhiEFjNSL05oioKmOEV/py
         EjXDhahCeZQdDo8OGnzCM196I0F0mEwDiXm2YHZHUH/rpdCZjp0pdt46oO3+jA4VpjFL
         n5zTpDsW1z2NrrZ3RspaYRJk7dMpYmqYJnXsigu2wJVfCdipnch6F1a8AjN25I0aT9cU
         bARPOArvH5Mp9W7O+rOtxc4DwlsPv2zChsGGDIcZkf6+Td3g5iPJ4FzmuBsa6C5n7v/Y
         T96Q==
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
Subject: [PATCH 4.14 049/195] [Variant 3/Meltdown] arm64: Turn on KPTI only on CPUs that need it
Date: Thu, 15 Feb 2018 16:15:40 +0100
Message-Id: <20180215151708.191962165@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481545594577550?=
X-GMAIL-MSGID: =?utf-8?q?1592481545594577550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


Commit 0ba2e29c7fc1 upstream.

Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
unmap_kernel_at_el0(). These CPUs are not vulnerable to
CVE-2017-5754 and do not need KPTI when KASLR is off.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -816,6 +816,13 @@ static bool unmap_kernel_at_el0(const st
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
+	/* Don't force KPTI for CPUs that are not vulnerable */
+	switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
+	case MIDR_CAVIUM_THUNDERX2:
+	case MIDR_BRCM_VULCAN:
+		return false;
+	}
+
 	/* Defer to CPU feature registers */
 	return !cpuid_feature_extract_unsigned_field(pfr0,
 						     ID_AA64PFR0_CSV3_SHIFT);
