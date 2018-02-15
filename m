Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OkH6WCHHKJjuVpRCcQi7b7b/espK4KAe/ZwQCgQUz9iQ2sRpHpaQciRMM3eiGHnzOxO+j
ARC-Seal: i=1; a=rsa-sha256; t=1518708907; cv=none;
        d=google.com; s=arc-20160816;
        b=O64vmgXwwK61QZY2UvJbXzVj47O7/ZAXFSzpRjJS6gKDD4e+TxOt3TMEt9IUWmNm5I
         64lcKA1ch6sVUN/7kFiH4axj4IvXlx8cM0rT/sl5HT52m6oKvAjodIzsxcpVm0Q5U/oa
         VBhXTJLxu4g2mvjXd611b0SYlMQF67NwmWXvAxUcTOZVKV862n9aUxM1UMBi8pnjmESf
         vdMmfu1w21BDthKMcHDSw8r4+rErz+8vEVPhOxFw0iDDc5f4AGPgnldDkwCHogIfE7yD
         CnkPcLOVPQ5ZjHmLYFS+2f/g03joCaQZR/pPvKos4AZIWlM3Yjat3zNQjlXuc0BfyvDE
         maOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zwv7/SNqKMvsivwwD/A1nr6HpQrTAljCrPip0fKmRG4=;
        b=f04Fve+2rYDOU6suD7mPMwqEZbeCDiXS7ExpmeZeCt+MXT6VonV0+FfpvwGv4yCkd3
         srovoYhXVg3tDd3uuMxVrDbhnL3NX2SrA9zwu7CFWzG13bAN+RFeouGNb6eOeEYg5ZYU
         +pulynWUHthoC9dVFb9jmf8lavF02PQe/ePv0JWQVPJmbhnIeQm1gJOWw2qgQW05rGb5
         r7wWrypUAN6Bm6lcUXnZELP/fDdvGuOgjBLMUzujPUw/JEpm5Xe15PjUt3DjOBMKFVOi
         GdMf4fR/LpDSKQBRhrhAioTJMqndpPqFmEZp0IwpiQp+P8dUTDdesMP4T/X01JgIN7Nh
         yn0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 091/195] [Variant 2/Spectre-v2] arm/arm64: smccc: Make function identifiers an unsigned quantity
Date: Thu, 15 Feb 2018 16:16:22 +0100
Message-Id: <20180215151710.259634874@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481711869880811?=
X-GMAIL-MSGID: =?utf-8?q?1592481711869880811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit ded4c39e93f3 upstream.

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
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
