Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4//+/1FXBb/f8DQQm5/3k2k/txSJuesyMe+rm+u6U5eQ8PoobhBZdB7pDEg31czvQHylR/A
ARC-Seal: i=1; a=rsa-sha256; t=1523981388; cv=none;
        d=google.com; s=arc-20160816;
        b=Mbn6nnclgzKFlSDqSA7YYkNP6SnUziFVGzerKk+jIhW1xeTDVImGPawdFI+eWQkKMd
         mI0maDIBVp4Kxb4oS4OxE6SUjvhTn0VFk4iQH5Bca3k01eo1+t2+hLVS0l/TcUezkJG/
         DMVoz2luknrpjeQMvSbYRK4/vbkZ8JDOy/ctD9gsMEBP9muFRe6m3vrJys790S09IiFP
         zt0zAxoh76/fznQS7LzDS8DJKTVGXNA/xEI0NeiB8vRwHjg8mwtTthlTYgVIgEdbeY+G
         8+dy1jpeA1qFhQZIx5ENltifCV4ToQhiPZsu/kPTyP04aI8lErObYfjiUcaiBL45Z62R
         smcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fo+/9j339oFgl7hAAM9r29QEP/UAj2HwmxAzqxArF4c=;
        b=0FoDckw07AlgvunkKRzbyoHQcumNfHR11eN/rzbwfbXJ/591YVU/+feRseB4P/F51i
         H7V7X2LEtWrlqexnjudlPt/cEL5BQxew8l867cjc4aqIy30uHE4+WVCm3eKBTATot17v
         9tvF82A15QE4AU+A4iv/yvYzvkN2Xx5Tg4qZkVFkNkM/LTxFeMJJzv0cC8N39wDOnuzG
         aHY13N3W0bmU9ca36UoO/43EgK2dQ1sjdHyVMNxpAZ+9fhXWyXdRN/c463Yw6aK1GNgR
         2GgbjQNcaZWtd3uT5DfbFSuAti+Ns0HPazYdE3KMks+eewpXyAA+4e1POWk/tKQZtzh4
         rwpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 47/66] arm/arm64: smccc: Make function identifiers an unsigned quantity
Date: Tue, 17 Apr 2018 17:59:20 +0200
Message-Id: <20180417155647.924667395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010308487688463?=
X-GMAIL-MSGID: =?utf-8?q?1598010308487688463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit ded4c39e93f3b72968fdb79baba27f3b83dad34c upstream.

Function identifiers are a 32bit, unsigned quantity. But we never
tell so to the compiler, resulting in the following:

 4ac:   b26187e0        mov     x0, #0xffffffff80000001

We thus rely on the firmware narrowing it for us, which is not
always a reasonable expectation.

Cc: stable@vger.kernel.org
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/arm-smccc.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -14,14 +14,16 @@
 #ifndef __LINUX_ARM_SMCCC_H
 #define __LINUX_ARM_SMCCC_H
 
+#include <uapi/linux/const.h>
+
 /*
  * This file provides common defines for ARM SMC Calling Convention as
  * specified in
  * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
  */
 
-#define ARM_SMCCC_STD_CALL		0
-#define ARM_SMCCC_FAST_CALL		1
+#define ARM_SMCCC_STD_CALL	        _AC(0,U)
+#define ARM_SMCCC_FAST_CALL	        _AC(1,U)
 #define ARM_SMCCC_TYPE_SHIFT		31
 
 #define ARM_SMCCC_SMC_32		0
