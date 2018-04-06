Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495qLFIoCsV9Y76+kizehxshoaGdKk6pRv26ZhVegXCYmRfkGeocTPwkAs9ad/A2kwWMm53
ARC-Seal: i=1; a=rsa-sha256; t=1523021415; cv=none;
        d=google.com; s=arc-20160816;
        b=RNl/gIy4XjnGQlwAYPHq0Fjo+gi/pUMl9l8Ema+knoT/cBaSmL25jyM+qicxuhrTet
         /qqInW+DvWNtfxfJNT6dU39HV3YyutcaJohJWO9SaBbDZE5wl7+raYcyX7Vw4WhuIrDU
         YWTUVH8U5uMD94GP/8Ekgmuz+3AQRE0ykZYES0HB6e+P4BC3vIlpfqJZ+P7snym9xu94
         sDiXQ397ZCiNsc0XSEsEmIsgTiTEdQRNF5SK5llqtW3C7gPYGskD/GDyU2vrXagKinfg
         SxUT7/sGZ9ZdY6hqrSLjNsSu3+utYFAPD6olXza4SQkVqkDW8doNLykBkvMscqalAQcb
         hqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L9R+YzBbLdXeJN0FzFEdgIpDs+GDqNxw68Q5+8K5cIA=;
        b=Eb/C2/M3Isn+oZWB0WWwYrzoZXbfU6khPRcwFp2bLDAFqgQGW6wOrPgR9qfq1FqEVd
         WWDa4b5PLFH+t12LMyrNxSXTxScZLzXCKNLlhcn4h46RedqqMS65xETYH3eQrOY36pKY
         8FMSWaiwo35CEOtSpxq/RBNL8pBFZwSo7+UKWiOAWJh1t+egceEcZtrgvmmVlYd1gchb
         uUI+UtboXKiyOndAz7NRZPA4oP4ypR/nCEPQ8sotG2KVukvKgCIhmh9Q9lsYVlDwyjnD
         oGfv4l+ySTH3dUhA9IXcdRJOQv8lrW4ZYYGkHulbZh7TfOLuS4dvZyfyFe79r4LIz22u
         RS1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 28/72] arm64: avoid overflow in VA_START and PAGE_OFFSET
Date: Fri,  6 Apr 2018 15:23:29 +0200
Message-Id: <20180406084307.528007339@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003703417188797?=
X-GMAIL-MSGID: =?utf-8?q?1597003703417188797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit 82cd588052815eb4146f9f7c5347ca5e32c56360 upstream.

The bitmask used to define these values produces overflow, as seen by
this compiler warning:

arch/arm64/kernel/head.S:47:8: warning:
      integer overflow in preprocessor expression
  #elif (PAGE_OFFSET & 0x1fffff) != 0
         ^~~~~~~~~~~
arch/arm64/include/asm/memory.h:52:46: note:
      expanded from macro 'PAGE_OFFSET'
  #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS -
1))
                                      ~~~~~~~~~~~~~~~~~~  ^

It would be preferrable to use GENMASK_ULL() instead, but it's not set
up to be used from assembly (the UL() macro token pastes UL suffixes
when not included in assembly sources).

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Suggested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
[natechancellor: KIMAGE_VADDR doesn't exist]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/memory.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -49,8 +49,10 @@
  * and PAGE_OFFSET - it must be within 128MB of the kernel text.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
-#define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
+#define VA_START		(UL(0xffffffffffffffff) - \
+	(UL(1) << VA_BITS) + 1)
+#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
+	(UL(1) << (VA_BITS - 1)) + 1)
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
 #define PCI_IO_END		(MODULES_VADDR - SZ_2M)
